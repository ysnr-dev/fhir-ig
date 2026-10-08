### DPC 様式1

DPC 退院患者調査の様式1 は、入院 1 件につき 1 つの **QuestionnaireResponse**([FC_DpcForm1Response](StructureDefinition-fc-dpc-form1-response.html))に保存します。提出ファイル(FF1)は backend がこの QuestionnaireResponse を機械的に行へ展開して作ります。

- `questionnaire` = `http://fhir-client.local/Questionnaire/dpc-form1`(固定。バージョン無し)。対応する Questionnaire リソースは上流に置きません。項目の定義(レコードごとのペイロードの意味・必須条件)はアプリが実施説明資料の版ごとに持つ定義表にあります。
- `encounter` = 入院(FC_InpatientEncounter)。その入院の様式1 は `questionnaire` + `encounter` で検索します。
- `status`: in-progress(下書き)→ completed(確定)→ 確定後の保存は amended(修正済み)。必須の検証は画面側だけが持つので「確定 = 検証を通ったもの」とし、提出ファイルには completed と amended だけを出します。
- 新規作成は「その入院の様式1 がまだ無いこと」を条件にした transaction(`ifNoneExist` = questionnaire + encounter)、更新は ETag(If-Match)で他者の更新を検出します。
- `identifier` / contained Practitioner(`author`)/ `meta.profile` はテンプレートの記入([FC_QuestionnaireResponse](StructureDefinition-fc-questionnaire-response.html))と同じです。カルテの時系列には出しません(`questionnaire:not` で除く)。

### item の構造

提出ファイルは「ヘッダ部 + コード + バージョン + 連番 + ペイロード 1〜9」の縦持ちで、1 行が 1 レコードです。item はその行と 1 対 1 に対応します。値はすべて提出ファイルに書く文字列のまま `valueString` で持ちます(日付は YYYYMMDD、選択肢はコード)。

| linkId | 内容 |
|---|---|
| `header` | ヘッダ部のグループ(1 件)。子は下の 6 つ(値のあるものだけ) |
| `header.facility` | 施設コード(自院の保険医療機関番号 10 桁から点数表の桁を除いた 9 桁) |
| `header.dataId` | データ識別番号(患者番号の 10 桁前ゼロ埋め) |
| `header.admitDate` | 入院年月日 |
| `header.count` | 回数管理番号 |
| `header.summaryNo` | 統括診療情報番号(親様式1 の 0 だけを扱う) |
| `header.fiscalYear` | 使った定義表の版の年度(作成時の退院日、未退院なら作成日に適用される版。2026 年度版は 2026-06-01 から、それより前は 2025 年度版) |
| `{コード}`(A000010 など) | 1 レコードのグループ。`text` = レコード名。連番のあるレコードは同じ linkId のグループを行の数だけ並べる |
| `{コード}.ver` | バージョン(例: 20140401) |
| `{コード}.seq` | 連番(連番のあるレコードは 1 から、無いレコードは 0) |
| `{コード}.p1` 〜 `{コード}.p9` | ペイロード(値のあるものだけ) |
| `{コード}.ref` | 値の元になったリソース(`valueReference`。登録病名から選んだ Condition など) |

### 初期値の元

入院情報(入院経路・予定/救急の区分・紹介の有無・救急車搬送・入院前の在宅医療)は入院 Encounter の [入院の経緯](admin.html) から、そのほかは Patient・バイタル・妊娠の Observation・社会歴テンプレートの抽出 Observation・退院時サマリーの退院時診断・手術の実施記録から集めます。手術のレコードの手術基幹コード(STEM7)は、点数表コードから backend の STEM7 対応表で 1 つに決まるときだけ初期値に入ります。

### 診断群分類の決定

入院の診断群分類(14 桁)は、backend が様式1 の値と実施記録から判定した候補を職員が確かめて決め、その記録を **QuestionnaireResponse**([FC_DpcCodingResponse](StructureDefinition-fc-dpc-coding-response.html))に追記します。

- `questionnaire` = `http://fhir-client.local/Questionnaire/dpc-coding`(固定。バージョン無し)、`encounter` = 入院。様式1 と同じく Questionnaire リソースは上流に置かず、カルテの時系列には出しません。
- 入院 1 件に何件でも作ります。`status` = completed のうち `authored` が最新のものが今の分類で、取消(entered-in-error)も含めた全件が DPC 歴です。決め直しは書き換えずに新しい記録を足します。
- 決めた時点(`timing`、[dpc-coding-timing](CodeSystem-dpc-coding-timing.html)): 入院時 / 転棟時 / 月末 / 退院時 / その他。
- 分類は `dpc-code`(valueCoding、[dpc-code](CodeSystem-dpc-code.html))で、display に傷病名と手術・処置等などの名称を持ちます。あわせて点数表の版(`edition`)、包括対象か(`bundled`)、入院期間Ⅰ〜Ⅲの日数(`days`)と 1 日あたり点数(`points`)、医療資源を最も投入した傷病の ICD-10(`icd10`)を写します。
- 判定の分岐(手術・処置等1・処置等2・定義副傷病など)は `branch` グループに、選んだ値・判定の状態(自動 / 上書き / 未確定)・根拠(日付・コード・名称)を文字列で残します。
- 決定者は contained Practitioner で、職員としてログインしていれば `identifier`(system = `http://fhir-client.local/Practitioner`、value = 上流の Practitioner の id)を持ちます。

#### 転棟時の再判定の督促

転科・転棟の実施で病棟が変わると、同じ transaction で入院の主治医宛の通知 Task([FC_DpcRecodingDueTask](StructureDefinition-fc-dpc-recoding-due-task.html)、code = `dpc-recoding-due`)を作ります(その入院に未対応の督促があれば作りません)。転棟時・退院時の決定を保存すると同じ transaction で completed になり、入院取消で cancelled になります。月末の再判定は通知を作らず、患者一覧の表示で知らせます。

### 例

- [DPC 様式1(下書き)](QuestionnaireResponse-example-dpc-form1-response.html)
- [診断群分類の決定(入院時)](QuestionnaireResponse-example-dpc-coding-response.html) / [再判定の督促](Task-example-dpc-recoding-due-task.html)
