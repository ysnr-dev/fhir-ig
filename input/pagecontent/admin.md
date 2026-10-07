### 患者

[FC_Patient](StructureDefinition-fc-patient.html)(JP_Patient から派生)。

- `identifier[0]` = 患者番号(`urn:oid:1.2.392.100495.20.3.51`)。空で登録すると上流の `Patient/$next-identifier` が採番します。
- `name` は漢字(iso21090-EN-representation = IDE)→ カナ(SYL)の順。上流サーバーは先頭の name を索引します。旧姓は `use = maiden`(family のみ)、通称は `use = nickname`(text のみ)。
- `communication.language` は BCP 47(ja / en / zh / ko / pt / es / vi / tl / und)、`preferred = true` は通訳が必要という意味。
- `contact.relationship` は v2-0131(C 緊急連絡先 / N 近親者(キーパーソン)/ BP 支払・保証人 / E 勤務先 / U 不明)。
- `telecom`: 固定電話(phone / home)、携帯電話(phone / mobile)、メール(email)。`address[0]`: postalCode / state / city / line と、連結した text。氏名は患者登録画面では無くても保存できます(新患受付では必須)。
- レセプトコンピュータからの取込(backend)は identifier で条件付き PUT します。取込分の name は漢字・カナとも `use = official` と text を持ち、カナにだけ SYL の拡張が付きます(漢字に IDE は付かない)。telecom は phone / home、address は `use = home`。
- 救急受付で仮登録した身元不明の患者は `meta.tag` = `patient-tag#unidentified` を持ちます(氏名は「不明」+ 性別と来院時刻)。身元が分かったら氏名などを書き換えて tag を外します。

### 医療従事者

- [FC_Practitioner](StructureDefinition-fc-practitioner.html): 漢字・カナの name、医籍登録番号(`qualification.identifier`、code = JP_MedicalLicenseCertificate_CS#medical-registration)。研修医・学生は `trainee-level` 拡張(valueCode = resident / student)を持ちます。職種は医師などのままで、この人が書いた診療記録とオーダーは指導医のカウンターサインの対象になります([診療記録](records.html)・[通知](notifications.html))。指導医グループ(研修医と指導医の組)は backend のマスタで、FHIR には持ちません。
- [FC_PractitionerBaseRole](StructureDefinition-fc-practitioner-base-role.html): 1 人 1 件。`code` = 職種(`practitioner-role`: HPKI 27 資格 + 事務職員 + 医師事務作業補助者)、`organization` = 所属の施設。職種と所属の少なくとも一方があれば作られます。
- [FC_PractitionerDepartmentRole](StructureDefinition-fc-practitioner-department-role.html): 所属診療科ごと。`organization` = 診療科、`specialty` = SS-MIX2 診療科コード(コードを持たない院内独自の科では無し)、`practitioner-role-primary-department` 拡張(true = 既定の診療科)。

### 組織

- [FC_Facility](StructureDefinition-fc-facility.html): 医療機関。`identifier` = 保険医療機関番号。自院か連携先かは FHIR には持たず、backend の設定(`self_organization_id`)で決まります。連携先は `partOf` を持たない施設 Organization のうち自院以外(`_id:not`、`partof:missing=true`)。
- [FC_Department](StructureDefinition-fc-department.html): 診療科。`type` = organization-type#dept、`partOf` = 施設(必須。これが診療科の定義)、`identifier.system` = `ssmix2-department-code`(院内独自の科は identifier 無し)。

### 場所

| プロファイル | type | physicalType | partOf |
|---|---|---|---|
| [FC_Room](StructureDefinition-fc-room.html) 診察室・検査室・手術室など | v3-RoleCode(OF / RADDX / DX / ER / SU / RHU) | ro | 無し |
| [FC_Ward](StructureDefinition-fc-ward.html) 病棟 | v3-RoleCode#HU | wa | 無し |
| [FC_HospitalRoom](StructureDefinition-fc-hospital-room.html) 病室 | `room-class`(一般室 / 個室 / 特別室 / ICU / HCU / CCU / SCU。display は「ICU(集中治療室)」など) | ro | 病棟 |
| [FC_Bed](StructureDefinition-fc-bed.html) ベッド | 無し(name = 番号) | bd | 病室 |

部屋の表示順は `location-display-order`。上流サーバーの Location は type / partof 検索と comma-OR に対応し、physical-type 検索はありません。

### 入院・外来・救急

- [FC_InpatientEncounter](StructureDefinition-fc-inpatient-encounter.html): class = IMP。status planned(入院予定)/ in-progress / finished / entered-in-error / cancelled。`location` は現在のベッド(active)と過去のベッド(completed)、入院予定では病棟・病室・ベッド(planned + physicalType)。`serviceProvider` = 診療科、`participant` = 担当医(ATND)と担当看護師(`encounter-participant-role#nurse`)。拡張: `encounter-note`、`encounter-leave`(外出・外泊、0..*)、`encounter-transfer-plan`、`encounter-discharge-plan`。退院先は `hospitalization.dischargeDisposition`(退院の実施と退院時サマリーの確定で書く)。
- [FC_OutpatientEncounter](StructureDefinition-fc-outpatient-encounter.html): class = AMB。`appointment[0]` = 受付の Appointment、`location` = 診察室。診察終了で Appointment を fulfilled にします。
- [FC_EmergencyEncounter](StructureDefinition-fc-emergency-encounter.html): class = EMER。予約(Appointment)を持たず、来院した時点で 1 件建てます。入院・外来とは class で分かれるので、それぞれの一覧には混ざりません。

#### 入院の経緯(入院経路など)

入院予定・入院登録・入院実施で入力する任意の項目で、DPC 様式1 の入院情報の初期値になります。値は様式1 のコードのまま持ちます。

| 項目 | 要素 | 値 |
|---|---|---|
| 入院経路 | `hospitalization.admitSource.coding` | `dpc-admission-route`(1 家庭 / 4 他院から転院 / 5 介護施設 / 8 院内出生 / 9 その他) |
| 予定・救急医療入院 | `priority` | `dpc-admission-type`(100 / 101 / 200 / 3**) |
| 他院よりの紹介 | `encounter-referral` 拡張 | valueBoolean |
| 自院の外来からの入院 | `encounter-from-outpatient` 拡張 | valueBoolean |
| 救急車による搬送 | `encounter-ambulance` 拡張 | valueBoolean |
| 入院前の在宅医療 | `encounter-prior-home-care` 拡張 | valueCode(0 無 / 1 当院 / 2 他施設 / 9 不明) |

紹介・外来・救急車の 3 つは、入院経路が 1 / 4 / 5 のときだけ 3 つ揃えて持ちます(それ以外の経路では持たない)。未入力の項目は要素ごと持ちません。

#### 救急受診

| 要素 | 内容 |
|---|---|
| `status` | arrived 来院 → triaged トリアージ済 → in-progress 診察中 → finished 転帰確定。来院登録の取消は entered-in-error |
| `statusHistory` | 過ぎた status とその期間。診察開始の取消・転帰の取消は末尾を 1 つ戻す |
| `period` | start = 来院日時、end = 退室日時(転帰確定で入れる)。end が無い間は滞在中 |
| `hospitalization.admitSource` | 来院方法(`emergency-arrival-mode`: 救急車 / ドクターヘリ / ドクターカー / 自力来院 / 紹介 / 転院搬送) |
| `hospitalization.dischargeDisposition` | 転帰(`emergency-disposition`: 帰宅 / 入院 / 転院 / 死亡 / 診察前離院 / その他) |
| `reasonCode[0].text` | 主訴 |
| `location[0]` | 救急の処置ベッド(FC_Room、type = ER)。滞在中は active、転帰確定で completed |
| `participant` | 担当医(ATND) |
| `emergency-triage-level` 拡張 | JTAS の現在のレベル(1〜5)。一覧の表示・並べ替え用 |

- トリアージは判定のたびに [FC_TriageObservation](StructureDefinition-fc-triage-observation.html)(code = `emergency-observation#jtas`、valueCodeableConcept = `jtas-level`)を 1 件作ります。受付と同時の判定は Encounter の POST と同じ transaction(Encounter は urn:uuid で参照)、再判定は Encounter の PUT と同じ transaction です。来院(arrived)のまま判定すると triaged に進みます。
- 一覧は「滞在中(status = arrived, triaged, in-progress。日付を問わない)」と「指定日に重なる受診(date の ge / le)」の 2 本の検索を突き合わせます。
- 転帰が入院のときは、入院予定(FC_InpatientEncounter、status = planned)を別に作ります。入院予定は `encounter-origin-emergency` 拡張で元の救急受診を指し、`hospitalization.admitSource` に HL7 `admit-source#emd` の coding を並べます(入院経路の coding とは system で区別)。来院方法が救急車・ドクターヘリ・ドクターカーなら `encounter-ambulance` = true を引き継ぎます。

### 保険

[FC_Coverage](StructureDefinition-fc-coverage.html)(JP_Coverage から派生)は backend がレセプトコンピュータから取り込みます。`identifier` = `integrations/receipt-computer/coverage`、`type` = ORCA の保険者クラス、`payor` = 保険者番号の論理参照(保険者番号が無い自費などは display のみ)、`subscriberId` = 公費の受給者番号、`class` = 保険組合せ、`costToBeneficiary` = 負担割合、記号・番号・枝番は JP Core の拡張。受付 Appointment の `reception-coverage-set` 拡張が保険組合せキーを持ちます。

### 病名

[FC_Condition](StructureDefinition-fc-condition.html)(JP_Condition から派生)の共通形と、用途ごとのプロファイル:

| プロファイル | category | 備考 |
|---|---|---|
| [FC_Problem](StructureDefinition-fc-problem.html) プロブレム | problem-list-item | `problem-number`(#n)、`problem-parent`、`problem-succeeded-by`。オーダーの reasonReference はこれ |
| [FC_EncounterDiagnosis](StructureDefinition-fc-encounter-diagnosis.html) 保険病名 | encounter-diagnosis | |
| [FC_PastHistory](StructureDefinition-fc-past-history.html) 既往歴 | problem-list-item + `condition-category#past-history` | |
| [FC_NursingProblem](StructureDefinition-fc-nursing-problem.html) 看護問題 | problem-list-item + `condition-category#nursing-problem` | 看護計画の対象([看護計画・看護サマリー](nursing-care-plan.html))。病名・プロブレムの一覧とレセコン送信から外す |

`code.coding` は MEDIS 標準病名マスタ(keyNumber / exCode / masterB / ICD10)、接頭語・接尾語は JP Core の DiseasePrefixModifier / PostfixModifier。「の疑い」で verificationStatus = provisional。

### アレルギー・注意情報

- [FC_AllergyIntolerance](StructureDefinition-fc-allergy-intolerance.html)(JP_AllergyIntolerance): J-FAGY のアレルゲンコード(食物 / 薬剤 YCM・GCM / 非食物非薬剤)。
- [FC_Flag](StructureDefinition-fc-flag.html): 注意情報。JP Core に Flag プロファイルは無い(上流は HL7 基本定義で登録)。`category` = `flag-category`、`code` = 注意区分マスタ(`patient-caution`)+ text。

### 例

- [患者](Patient-example-patient.html) / [医師](Practitioner-example-practitioner.html) / [研修医](Practitioner-example-resident.html) / [薬剤師](Practitioner-example-pharmacist.html) / [職種ロール](PractitionerRole-example-practitioner-base-role.html) / [診療科ロール](PractitionerRole-example-practitioner-department-role.html)
- [施設](Organization-example-organization.html) / [診療科](Organization-example-department.html)
- [病棟](Location-example-ward.html) / [病室](Location-example-room.html) / [ベッド](Location-example-bed.html) / [診察室](Location-example-outpatient-room.html)
- [入院](Encounter-example-encounter.html) / [外来受診](Encounter-example-outpatient-encounter.html) / [保険](Coverage-example-coverage.html)
- [救急受診](Encounter-example-emergency-encounter.html) / [トリアージ](Observation-example-triage-observation.html) / [救急の処置ベッド](Location-example-emergency-bed.html) / [救急からの入院予定](Encounter-example-planned-admission-from-emergency.html) / [身元不明の患者](Patient-example-patient-unidentified.html)
- [プロブレム](Condition-example-condition.html) / [保険病名](Condition-example-encounter-diagnosis.html) / [既往歴](Condition-example-past-history.html) / [アレルギー](AllergyIntolerance-example-allergy-intolerance.html) / [注意情報](Flag-example-flag.html)
