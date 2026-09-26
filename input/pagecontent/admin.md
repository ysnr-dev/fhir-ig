### 患者

[FC_Patient](StructureDefinition-fc-patient.html)(JP_Patient から派生)。

- `identifier[0]` = 患者番号(`urn:oid:1.2.392.100495.20.3.51`)。空で登録すると上流の `Patient/$next-identifier` が採番します。
- `name` は漢字(iso21090-EN-representation = IDE)→ カナ(SYL)の順。上流サーバーは先頭の name を索引します。旧姓は `use = maiden`(family のみ)、通称は `use = nickname`(text のみ)。
- `communication.language` は BCP 47(ja / en / zh / ko / pt / es / vi / tl / und)、`preferred = true` は通訳が必要という意味。
- `contact.relationship` は v2-0131(C 緊急連絡先 / N 近親者(キーパーソン)/ BP 支払・保証人 / E 勤務先 / U 不明)。
- レセプトコンピュータからの取込(backend)は `name.use = official`、`address.use = home` を付け、identifier で条件付き PUT します。

### 医療従事者

- [FC_Practitioner](StructureDefinition-fc-practitioner.html): 漢字・カナの name、医籍登録番号(`qualification.identifier`、code = JP_MedicalLicenseCertificate_CS#medical-registration)。
- [FC_PractitionerBaseRole](StructureDefinition-fc-practitioner-base-role.html): 1 人 1 件。`code` = 職種(`practitioner-role`: HPKI 27 資格 + 事務職員 + 医師事務作業補助者)、`organization` = 施設。
- [FC_PractitionerDepartmentRole](StructureDefinition-fc-practitioner-department-role.html): 所属診療科ごと。`organization` = 診療科、`specialty` = SS-MIX2 診療科コード、`practitioner-role-primary-department` 拡張(true = 既定の診療科)。

### 組織

- [FC_Facility](StructureDefinition-fc-facility.html): 医療機関。`identifier` = 保険医療機関番号。自院か連携先かは FHIR には持たず、backend の設定(`self_organization_id`)で決まります。連携先は `partOf` を持たない施設 Organization のうち自院以外(`_id:not`、`partof:missing=true`)。
- [FC_Department](StructureDefinition-fc-department.html): 診療科。`type` = organization-type#dept、`partOf` = 施設(必須。これが診療科の定義)、`identifier.system` = `ssmix2-department-code`。

### 場所

| プロファイル | type | physicalType | partOf |
|---|---|---|---|
| [FC_Room](StructureDefinition-fc-room.html) 診察室・検査室・手術室など | v3-RoleCode(OF / RADDX / DX / ER / SU / RHU) | ro | 無し |
| [FC_Ward](StructureDefinition-fc-ward.html) 病棟 | v3-RoleCode#HU | wa | 無し |
| [FC_HospitalRoom](StructureDefinition-fc-hospital-room.html) 病室 | `room-class`(一般室 / 個室 / 特別室 / ICU / HCU / CCU / SCU) | ro | 病棟 |
| [FC_Bed](StructureDefinition-fc-bed.html) ベッド | 無し(name = 番号) | bd | 病室 |

部屋の表示順は `location-display-order`。上流サーバーの Location は type / partof 検索と comma-OR に対応し、physical-type 検索はありません。

### 入院・外来

- [FC_InpatientEncounter](StructureDefinition-fc-inpatient-encounter.html): class = IMP。status planned(入院予定)/ in-progress / finished / entered-in-error / cancelled。`location` は現在のベッド(active)と過去のベッド(completed)、入院予定では病棟・病室・ベッド(planned + physicalType)。`serviceProvider` = 診療科、`participant` = 担当医(ATND)と担当看護師(`encounter-participant-role#nurse`)。拡張: `encounter-note`、`encounter-leave`(外出・外泊、0..*)、`encounter-transfer-plan`、`encounter-discharge-plan`。退院先は `hospitalization.dischargeDisposition`。
- [FC_OutpatientEncounter](StructureDefinition-fc-outpatient-encounter.html): class = AMB。`appointment[0]` = 受付の Appointment、`location` = 診察室。診察終了で Appointment を fulfilled にします。

### 保険

[FC_Coverage](StructureDefinition-fc-coverage.html)(JP_Coverage から派生)は backend がレセプトコンピュータから取り込みます。`identifier` = `integrations/receipt-computer/coverage`、`type` = ORCA の保険者クラス、`payor` = 保険者番号の論理参照、`class` = 保険組合せ、`costToBeneficiary` = 負担割合、記号・番号・枝番は JP Core の拡張。受付 Appointment の `reception-coverage-set` 拡張が保険組合せキーを持ちます。

### 病名

[FC_Condition](StructureDefinition-fc-condition.html)(JP_Condition から派生)の共通形と、用途ごとのプロファイル:

| プロファイル | category | 備考 |
|---|---|---|
| [FC_Problem](StructureDefinition-fc-problem.html) プロブレム | problem-list-item | `problem-number`(#n)、`problem-parent`、`problem-succeeded-by`。オーダーの reasonReference はこれ |
| [FC_EncounterDiagnosis](StructureDefinition-fc-encounter-diagnosis.html) 保険病名 | encounter-diagnosis | |
| [FC_PastHistory](StructureDefinition-fc-past-history.html) 既往歴 | problem-list-item + `condition-category#past-history` | |

`code.coding` は MEDIS 標準病名マスタ(keyNumber / exCode / masterB / ICD10)、接頭語・接尾語は JP Core の DiseasePrefixModifier / PostfixModifier。「の疑い」で verificationStatus = provisional。

### アレルギー・注意情報

- [FC_AllergyIntolerance](StructureDefinition-fc-allergy-intolerance.html)(JP_AllergyIntolerance): J-FAGY のアレルゲンコード(食物 / 薬剤 YCM・GCM / 非食物非薬剤)。
- [FC_Flag](StructureDefinition-fc-flag.html): 注意情報。JP Core に Flag プロファイルは無い(上流は HL7 基本定義で登録)。`category` = `flag-category`、`code` = 注意区分マスタ(`patient-caution`)+ text。

### 例

- [患者](Patient-example-patient.html) / [医師](Practitioner-example-practitioner.html) / [職種ロール](PractitionerRole-example-practitioner-base-role.html) / [診療科ロール](PractitionerRole-example-practitioner-department-role.html)
- [施設](Organization-example-organization.html) / [診療科](Organization-example-department.html)
- [病棟](Location-example-ward.html) / [病室](Location-example-room.html) / [ベッド](Location-example-bed.html) / [診察室](Location-example-outpatient-room.html)
- [入院](Encounter-example-encounter.html) / [外来受診](Encounter-example-outpatient-encounter.html) / [保険](Coverage-example-coverage.html)
- [プロブレム](Condition-example-condition.html) / [保険病名](Condition-example-encounter-diagnosis.html) / [既往歴](Condition-example-past-history.html) / [アレルギー](AllergyIntolerance-example-allergy-intolerance.html) / [注意情報](Flag-example-flag.html)
