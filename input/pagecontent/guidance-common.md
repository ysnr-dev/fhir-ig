### リソースの作り方(全体)

fhir-client は FHIR R4 の JSON をフロントエンドで組み立て、backend のプロキシ(`/fhir/*`)を経由して上流 FHIR サーバーに書き込みます。
書き込みはほぼすべて transaction Bundle で、新規リソースは `urn:uuid:` の fullUrl で参照し、上流サーバーが実 ID に書き換えます。

既存リソースの更新は楽観ロックです。単体の PUT は `If-Match`(読んだ版の ETag)を付け、transaction の PUT エントリは `request.ifMatch` = `W/"{読んだ時点の meta.versionId}"` を持ちます(同じリソースを 1 つの Bundle で 2 回書くときは最初のエントリだけ)。版が進んでいれば上流サーバーは 412 を返し、transaction 全体が取り消されます。予約枠(Slot)は押さえる(busy)ときだけ `ifMatch` を付けて二重予約を防ぎ、空きに戻すときは付けません。

### オーダーの共通構造

オーダーは **ServiceRequest** で表します。部門によって「ヘッダ + 明細」の 2 段構造か、単一の ServiceRequest かが違います。

| 構造 | 部門 |
|---|---|
| ヘッダ + 明細 | 検体検査、細菌検査、放射線検査、内視鏡、生理検査、病理検査、手術、処置、輸血、処方(薬剤行は MedicationRequest)、注射(同左) |
| 単一 ServiceRequest | 放射線治療、リハビリ、他科依頼、看護指示(指示行ごと)、食事、栄養指導、化学療法レジメン適用 |

- **ヘッダ** は `basedOn` を持たない ServiceRequest。**明細** は `basedOn` でヘッダ(またはセット親)を指す。
- 明細は部門ごとの識別子体系(`http://fhir-client.local/IdSystem/<部門>-order-item-number`)に連番(文字列)を持ち、並び順に使う。
- `requisition` は「同時に登録した複数の ServiceRequest を束ねる」用途(看護指示、注射の連日、オーダーセット適用、パス適用、レジメン)にだけ使う。

#### category の順序

`ServiceRequest.category` は次の順で並べます。上流サーバーは ServiceRequest の category をすべての coding で索引しますが、実施記録(Procedure)は先頭しか索引しないため、どちらも種別を先頭に置く順序に揃えています。

1. オーダー種別(`http://fhir-client.local/CodeSystem/order-type`)。処方は `prescription`。
2. 入院・外来区分(`prescription-setting`)。
3. 処方区分(`prescription-category`)、注射区分(`injection-category`)など部門固有の区分。

実施記録の `Procedure.category.coding` も先頭がオーダー種別です。

#### 日付

| 要素 | 意味 |
|---|---|
| `authoredOn` | 登録日時(システム時刻)。更新しても変えない。処方では交付日。 |
| `occurrenceDateTime` | オーダー開始日(実施予定日)。検査日・注射日・投与開始日・開始日など。手術だけ省略可(日付未定)。 |

`occurrencePeriod` は使いません(上流サーバーが索引しないため)。継続型のオーダー(食事・リハビリ・栄養指導・看護指示)の終了日は部門ごとの `*-order-end` 拡張で持ち、上流サーバーはこれを `order-period` 検索パラメータで索引します。

#### 依頼者・依頼科・病棟

- `requester` = 依頼医(Practitioner)。
- 依頼科は `order-department` 拡張(Organization = 診療科)、入院オーダーの病棟は `order-ward` 拡張(Location)。標準要素に診療科を持つ場所が無いため拡張で持ちます。
- `encounter` を持つのは処方(入院)・食事・看護指示だけです。

#### 対象の問題・コメント

- `reasonReference` = プロブレム(Condition)。放射線・内視鏡などの明細では `reasonCode.text` に依頼診断の自由記載も可。
- `note[0].text` = コメント。

### 部門進捗 Task

オーダーの部門側の進捗は **Task** で持ちます([通知 Task と Provenance](notifications.html))。

- `intent = filler-order`、`code` = Task 種別(`task-code`)、`focus` = ヘッダ ServiceRequest、`for` = 患者。
- Task が存在しない = requested。最初の状態変更で作られます(看護指示だけ登録時に作る)。
- `executionPeriod`: accepted / in-progress / on-hold で start、completed で end。
- 細菌検査と食事は Task を持たず、`ServiceRequest.status` で進捗を読みます。

### 実施記録(Procedure ハブ)

検査・処置・手術・与薬・注射などの実施は **Procedure をハブ**にして、子リソースを `partOf` でぶら下げます([実施記録](procedures.html))。

### 来歴と承認

オーダーの登録・変更には **Provenance** が 1 件付きます(target = ヘッダ ServiceRequest。ログイン中のアカウントに紐付く医療従事者が無いとき、またはヘッダに requester が無いときは付きません)。代行入力(enterer ≠ author)では `order-approval` 通知 Task が依頼医宛に作られ、承認で verifier と signature が付きます。研修医・学生が自分を依頼医として入れたオーダーは author.role = `trainee-level` を持ち、通知は指導医宛に作られます。

### meta.profile について

上流サーバーはクライアントが送った `meta.profile` を保存せず、読み出し時にリソース種別ごとに 1 つのプロファイル(JP Core など)を付け直します。
したがって本 IG のプロファイルへの準拠は **要素の内容** で判定してください。アプリが `meta.profile` を付けるのは Condition(JP_Condition)、AllergyIntolerance(JP_AllergyIntolerance)、Procedure(JP_Procedure)、Specimen(JP_Specimen_Common)、検体検査の Observation / DiagnosticReport(JP_*_LabResult)、Questionnaire / QuestionnaireResponse(JASPEHR)だけです。

### 参照先のプロファイル

本 IG のプロファイルは、参照先を本 IG のプロファイル(`FC_Patient`、`FC_Practitioner`、`FC_Department` など)に限定しています。上流サーバーに実際に存在するリソースはこれらのプロファイルの形で作られています。
