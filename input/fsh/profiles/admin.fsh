// 患者・医療従事者・組織・場所・入院/外来・保険・病名・アレルギー・注意情報・来歴。

Profile: FC_Patient
Parent: $JP_Patient
Id: fc-patient
Title: "患者"
Description: """患者。

- identifier[0] は患者番号(system = urn:oid:1.2.392.100495.20.3.51)。空で登録すると上流サーバーが `Patient/$next-identifier` で採番する。
- name は 漢字(iso21090-EN-representation = IDE)→ カナ(SYL)の順。上流サーバーは先頭の name を索引する。旧姓は use = maiden(family のみ)、通称は use = nickname(text のみ)。
- telecom: 固定電話(system = phone、use = home)、携帯電話(phone、mobile)、メール(email)。address[0]: postalCode / state / city / line と、それらを連結した text。
- communication.language は BCP 47(ja / en / zh / ko / pt / es / vi / tl / und)。preferred = true は通訳が必要という意味。
- contact.relationship は v2-0131(C 緊急連絡先 / N 近親者 / BP 支払・保証人 / E 勤務先 / U 不明)。自由記載は text のみ。
- レセプトコンピュータからの取込(backend)は identifier で条件付き PUT する。取込分の name は漢字・カナとも use = official と text(姓 + 全角空白 + 名)を持ち、カナにだけ SYL の拡張が付く(漢字に IDE は付かない)。telecom は phone / use = home、address は use = home。
- 救急受付で仮登録した身元不明の患者は meta.tag = patient-tag#unidentified を持つ(氏名は「不明」+ 性別と来院時刻、カナは「フメイ」)。身元が分かったら氏名などを書き換えて tag を外す。"""
* insert FCMeta
* meta.tag ^short = "身元不明の仮登録は patient-tag#unidentified"
* identifier 1..* MS
* name 0..* MS
* name ^short = "漢字(IDE)→ カナ(SYL)。患者登録画面では氏名なしでも保存できる(新患受付では必須)"
* deceased[x] only dateTime
* generalPractitioner only Reference(FC_Practitioner or FC_Facility)

Profile: FC_Practitioner
Parent: $JP_Practitioner
Id: fc-practitioner
Title: "医療従事者"
Description: "医療従事者。name は漢字(IDE)とカナ(SYL)。医籍登録番号は qualification.identifier(system = medicalRegistrationNumber)、qualification.code = JP_MedicalLicenseCertificate_CS#medical-registration。"
* insert FCMeta
* name 1..* MS

Profile: FC_PractitionerBaseRole
Parent: $JP_PractitionerRole
Id: fc-practitioner-base-role
Title: "職種ロール(基本)"
Description: "1 人につき 1 件。code = 職種(practitioner-role)、organization = 所属の施設。職種と所属の少なくとも一方を入力したときに作られるので、どちらかは無いことがある。"
* insert FCMeta
* practitioner 1..1
* practitioner only Reference(FC_Practitioner)
* organization 0..1 MS
* organization only Reference(FC_Facility)
* code 0..1 MS
* code from PractitionerRoleVS (required)

Profile: FC_PractitionerDepartmentRole
Parent: $JP_PractitionerRole
Id: fc-practitioner-department-role
Title: "診療科ロール"
Description: "所属診療科ごとに 1 件(0 件以上)。organization = 診療科、specialty = SS-MIX2 診療科コード(コードを持たない院内独自の科では無し)。practitioner-role-primary-department 拡張が付いていることが診療科ロールの印で、true が既定の診療科。"
* insert FCMeta
* practitioner 1..1
* practitioner only Reference(FC_Practitioner)
* organization 1..1
* organization only Reference(FC_Department)
* specialty 0..1 MS
* specialty from Ssmix2DepartmentCodeVS (required)
* extension contains PractitionerRolePrimaryDepartment named primaryDepartment 1..1 MS

Profile: FC_Facility
Parent: $JP_Organization
Id: fc-facility
Title: "施設(自院・連携先)"
Description: "医療機関。identifier は保険医療機関番号(10 桁)。自院か連携先かは FHIR には持たず、backend の設定(self_organization_id)で決まる。連携先は partOf を持たない施設 Organization のうち自院以外。"
* insert FCMeta
* identifier[medicalInstitutionCode] MS
* identifier[medicalInstitutionCode] ^short = "保険医療機関番号(10 桁)"
* type from http://hl7.org/fhir/ValueSet/organization-type (extensible)
* name 1..1 MS
* partOf 0..0

Profile: FC_Department
Parent: $JP_Organization
Id: fc-department
Title: "診療科"
Description: "診療科。type = organization-type#dept、partOf = 施設(必須。これが診療科の定義)。identifier.system = SS-MIX2 診療科コード(2 桁または 3 桁)。院内独自の科はコードを持たず、identifier も無い。"
* insert FCMeta
* identifier MS
* identifier ^slicing.discriminator[0].type = #value
* identifier ^slicing.discriminator[0].path = "system"
* identifier ^slicing.rules = #open
* identifier contains departmentCode 0..1 MS
* identifier[departmentCode].system = $ssmix2-department
* type 1..*
* type = $organization-type#dept
* name 1..1 MS
* partOf 1..1 MS
* partOf only Reference(FC_Facility)

Profile: FC_Room
Parent: $JP_Location
Id: fc-room
Title: "部屋(診察室・検査室・手術室など)"
Description: "外来・検査・手術などの部屋。type は v3-RoleCode(OF 診察室 / RADDX 撮影室 / DX 検査・処置室 / ER 救急 / SU 手術室 / RHU リハビリ室)、physicalType = ro。partOf は持たない。病室は FC_HospitalRoom を使う。"
* insert FCMeta
* mode = #instance
* name 1..1 MS
* physicalType 1..1
* physicalType = $location-physical-type#ro
* managingOrganization only Reference(FC_Facility)
* extension contains LocationDisplayOrder named displayOrder 0..1

Profile: FC_Ward
Parent: $JP_Location
Id: fc-ward
Title: "病棟"
Description: "病棟。"
* insert FCMeta
* mode = #instance
* name 1..1 MS
* type 1..*
* type = $v3-RoleCode#HU
* physicalType 1..1
* physicalType = $location-physical-type#wa
* partOf 0..0

Profile: FC_HospitalRoom
Parent: $JP_Location
Id: fc-hospital-room
Title: "病室"
Description: "病室。type = room-class、physicalType = ro、partOf = 病棟。"
* insert FCMeta
* mode = #instance
* name 1..1 MS
* type 1..1
* type from RoomClassVS (required)
* physicalType 1..1
* physicalType = $location-physical-type#ro
* partOf 1..1
* partOf only Reference(FC_Ward)

Profile: FC_Bed
Parent: $JP_Location
Id: fc-bed
Title: "ベッド"
Description: "ベッド。name はベッド番号だけ。physicalType = bd、partOf = 病室。"
* insert FCMeta
* mode = #instance
* name 1..1 MS
* physicalType 1..1
* physicalType = $location-physical-type#bd
* partOf 1..1
* partOf only Reference(FC_HospitalRoom)

Profile: FC_InpatientEncounter
Parent: $JP_Encounter
Id: fc-inpatient-encounter
Title: "入院"
Description: """入院。

- class = v3-ActCode#IMP。status: planned 入院予定 / in-progress 入院中 / finished 退院 / entered-in-error 入院取消 / cancelled 予定取消。
- period.start = 入院日時、period.end = 退院日時。
- location: 入院中は先頭が現在のベッド(status = active)、転床した過去のベッドが status = completed + period.end で続く。入院予定では病棟・病室・ベッドを status = planned で持ち physicalType(wa / ro / bd)で区別する。
- serviceProvider = 診療科。participant は担当医(ATND)と担当看護師(encounter-participant-role#nurse)。
- hospitalization.dischargeDisposition = 退院先(discharge-disposition: home / other-hcf / snf / hosp / aadvice / exp / oth)。退院の実施(退院モーダル)で書き、退院時サマリー確定時にも同じ transaction で PUT する。
- 入院の経緯(任意。入院予定・入院登録・入院実施で入力し、DPC 様式1 の入院情報の初期値になる): hospitalization.admitSource = 入院経路(dpc-admission-route の 1 / 4 / 5 / 8 / 9)、priority = 予定・救急医療入院(dpc-admission-type)、拡張 encounter-referral / encounter-from-outpatient / encounter-ambulance(入院経路が 1 / 4 / 5 のとき 3 つとも持つ)と encounter-prior-home-care。
- 救急外来から作った入院予定は、admitSource に HL7 admit-source#emd の coding を並べ(入院経路の coding とは system で区別する)、encounter-origin-emergency 拡張で元の救急受診を指す。"""
* insert FCMeta
* class = $v3-ActCode#IMP
* subject 1..1
* subject only Reference(FC_Patient)
* serviceProvider only Reference(FC_Department)
* participant.individual only Reference(FC_Practitioner)
* location.location only Reference(FC_Ward or FC_HospitalRoom or FC_Bed)
* location.physicalType ^short = "入院予定のとき wa / ro / bd"
* extension contains
    EncounterNote named note 0..1 and
    EncounterLeave named leave 0..* and
    EncounterTransferPlan named transferPlan 0..1 and
    EncounterDischargePlan named dischargePlan 0..1 and
    EncounterReferral named referral 0..1 and
    EncounterFromOutpatient named fromOutpatient 0..1 and
    EncounterAmbulance named ambulance 0..1 and
    EncounterPriorHomeCare named priorHomeCare 0..1 and
    EncounterOriginEmergency named originEmergency 0..1
* extension[originEmergency].valueReference only Reference(FC_EmergencyEncounter)
* hospitalization.admitSource.coding ^slicing.discriminator[0].type = #value
* hospitalization.admitSource.coding ^slicing.discriminator[0].path = "system"
* hospitalization.admitSource.coding ^slicing.rules = #open
* hospitalization.admitSource.coding contains
    route 0..1 and
    emergency 0..1
* hospitalization.admitSource.coding[route].system = "http://fhir-client.local/CodeSystem/dpc-admission-route"
* hospitalization.admitSource.coding[route] from DpcAdmissionRouteVS (required)
* hospitalization.admitSource.coding[route] ^short = "入院経路(DPC 様式1 のコード)"
* hospitalization.admitSource.coding[emergency].system = $admit-source
* hospitalization.admitSource.coding[emergency].code = #emd
* hospitalization.admitSource.coding[emergency] ^short = "救急外来からの入院"
* priority.coding.system = "http://fhir-client.local/CodeSystem/dpc-admission-type"
* priority from DpcAdmissionTypeVS (required)
* priority ^short = "予定・救急医療入院(DPC 様式1 のコード)"

Profile: FC_OutpatientEncounter
Parent: $JP_Encounter
Id: fc-outpatient-encounter
Title: "外来受診"
Description: "外来の診察。class = v3-ActCode#AMB。status: in-progress / finished / entered-in-error。appointment[0] = 受付の Appointment。location = 診察室。診察終了時に Appointment を fulfilled にする。serviceProvider は持たない。"
* insert FCMeta
* class = $v3-ActCode#AMB
* subject 1..1
* subject only Reference(FC_Patient)
* appointment 1..1
* appointment only Reference(FC_Appointment)
* participant.individual only Reference(FC_Practitioner)
* location.location only Reference(FC_Room)
* serviceProvider 0..0

Profile: FC_EmergencyEncounter
Parent: $JP_Encounter
Id: fc-emergency-encounter
Title: "救急受診"
Description: """救急外来の受診。予約(Appointment)を持たず、来院した時点で 1 件建て、来院から転帰までをこの 1 件の status で追う。

- class = v3-ActCode#EMER。status: arrived 来院 / triaged トリアージ済 / in-progress 診察中 / finished 転帰確定 / entered-in-error 来院登録の取消。
- statusHistory = 過ぎた status とその期間。巻き戻し(診察開始の取消・転帰の取消)は末尾を 1 つ戻す。
- period.start = 来院日時、period.end = 退室日時(転帰確定で入れる)。end が無い間は滞在中。
- hospitalization.admitSource = 来院方法(emergency-arrival-mode)、hospitalization.dischargeDisposition = 転帰(emergency-disposition)。
- reasonCode[0].text = 主訴。location[0] = 救急の処置ベッド(type = v3-RoleCode#ER の部屋。滞在中は status = active、転帰確定で completed)。participant = 担当医(ATND)。
- emergency-triage-level 拡張 = JTAS の現在のレベル。判定のたびに FC_TriageObservation を 1 件作る(受付と同じ transaction、または Encounter の PUT と同じ transaction)。
- 転帰が入院のときは、入院予定(FC_InpatientEncounter、status = planned)を別に作り、encounter-origin-emergency 拡張でこの受診を指す。"""
* insert FCMeta
* class = $v3-ActCode#EMER
* subject 1..1
* subject only Reference(FC_Patient)
* period 1..1
* period.start 1..1
* participant.individual only Reference(FC_Practitioner)
* location.location only Reference(FC_Room)
* reasonCode.text ^short = "主訴"
* hospitalization.admitSource from EmergencyArrivalModeVS (required)
* hospitalization.dischargeDisposition from EmergencyDispositionVS (required)
* appointment 0..0
* serviceProvider 0..0
* extension contains EmergencyTriageLevel named triageLevel 0..1 MS

Profile: FC_Coverage
Parent: $JP_Coverage
Id: fc-coverage
Title: "保険(レセプトコンピュータ取込)"
Description: """レセプトコンピュータから backend が取り込む保険。フロントエンドは読むだけ。

- identifier.system = `http://fhir-client.local/integrations/receipt-computer/coverage`、value = "{患者番号}:{外部キー}"。identifier で条件付き PUT。
- status = active / cancelled。type は `.../integrations/receipt-computer/coverage-type`(ORCA の保険者クラス。動的)。
- payor は Organization を作らず identifier(保険者番号 urn:oid:1.2.392.100495.20.3.61)の論理参照 + display(保険者名)。保険者番号が無いもの(自費など)は display だけ。
- subscriberId = 公費の受給者番号、relationship = subscriber-relationship。type はレセコンの種別コードが無いとき text だけ。
- class: type = `.../integrations/receipt-computer/coverage-class#billing-set`、value = 保険組合せキー、name = 表示名。
- costToBeneficiary: type = coverage-copay-type#copaypct、valueQuantity = 負担割合(%)。order = 1 が主保険。
- 記号・番号・枝番は JP Core の JP_Coverage_InsuredPersonSymbol / Number / SubNumber。"""
* insert FCMeta
* identifier 1..* MS
* beneficiary only Reference(FC_Patient)
* payor.identifier 0..1
* payor.identifier.system = $JP_InsurerNumber

Profile: FC_Condition
Parent: $JP_Condition
Id: fc-condition
Title: "病名(共通)"
Description: """病名の共通形。用途により category が異なる(FC_Problem / FC_EncounterDiagnosis / FC_PastHistory)。

- code.coding は MEDIS 標準病名マスタ(master-disease-keyNumber / master-disease-exCode / masterB-disease / ICD10-2013-full)。自由記載は text のみ。
- 接頭語・接尾語は code.extension の JP_Condition_DiseasePrefixModifier / PostfixModifier(修飾語マスタ: master-disease-modKeyNumber / modExCode / masterZ-disease-modifier)。「の疑い」は 27000001 / 5395 / 8002 固定。
- clinicalStatus: active 継続 / remission 軽快 / resolved 治癒 / inactive 中止。verificationStatus: 「の疑い」があれば provisional、それ以外は confirmed。
- onsetDateTime / abatementDateTime は日付のみ。"""
* insert FCMeta
* ^abstract = true
* subject 1..1
* subject only Reference(FC_Patient)
* clinicalStatus 1..1 MS
* verificationStatus 1..1 MS
* category 1..* MS
* onset[x] only dateTime
* abatement[x] only dateTime

Profile: FC_Problem
Parent: FC_Condition
Id: fc-problem
Title: "プロブレム(問題リスト)"
Description: "POMR のプロブレム。category = condition-category#problem-list-item。番号・親子・後継の拡張を持つ。オーダーの reasonReference はこれを指す。"
* category 1..1
* category = $condition-category#problem-list-item
* extension contains
    ProblemNumber named problemNumber 0..1 MS and
    ProblemParent named problemParent 0..1 and
    ProblemSucceededBy named problemSucceededBy 0..*

Profile: FC_EncounterDiagnosis
Parent: FC_Condition
Id: fc-encounter-diagnosis
Title: "保険病名"
Description: "レセプト用の病名。category = condition-category#encounter-diagnosis。"
* category 1..1
* category = $condition-category#encounter-diagnosis

Profile: FC_PastHistory
Parent: FC_Condition
Id: fc-past-history
Title: "既往歴"
Description: "既往歴。category は problem-list-item と、本 IG の condition-category#past-history の 2 つ。"
* category 2..2
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category contains problem 1..1 and pastHistory 1..1
* category[problem] = $condition-category#problem-list-item
* category[pastHistory] = http://fhir-client.local/CodeSystem/condition-category#past-history

Profile: FC_AllergyIntolerance
Parent: $JP_AllergyIntolerance
Id: fc-allergy-intolerance
Title: "アレルギー・不耐性"
Description: "アレルギー。code は J-FAGY(コード 3 文字目で系を選ぶ: F 食物 JP_JfagyFoodAllergen_CS / M 薬剤 YCM または GCM の JP_JfagyMedicationAllergen_CS / N 非食物非薬剤 JP_JfagyNonFoodNonMedicationAllergen_CS)。reaction[0].manifestation[0].text に症状。"
* insert FCMeta
* patient only Reference(FC_Patient)
* clinicalStatus 1..1 MS
* verificationStatus 1..1 MS

Profile: FC_Flag
Parent: Flag
Id: fc-flag
Title: "患者の注意情報"
Description: "患者の注意情報。JP Core に Flag プロファイルは無い。status: active 有効 / inactive 終了。category = flag-category、code = 注意区分マスタ(patient-caution)+ text 自由記載。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1 MS
* category from FlagCategoryVS (required)
* code MS
* code.coding.system = "http://fhir-client.local/CodeSystem/patient-caution"
* author only Reference(FC_Practitioner)

Profile: FC_OrderProvenance
Parent: Provenance
Id: fc-order-provenance
Title: "オーダーの来歴"
Description: """オーダーの登録・変更・取消などの来歴。オーダーの transaction に必ず 1 件付く。

- target = ヘッダ ServiceRequest(同じ Bundle の MedicationRequest も含む。明細 ServiceRequest は含めない)。パス適用では根の CarePlan(フェーズ単位の追加適用では、そのフェーズ最初の病日の CarePlan)。
- ログイン中のアカウントに紐付く Practitioner が無いとき、またはヘッダに requester が無いときは来歴を作らない。中止・完了・休止・再開の来歴は、オーダーの更新とは別の transaction で `ServiceRequest/{id}` を target にして作ることがある。
- activity = v3-DataOperation(CREATE / UPDATE / CANCEL / REACTIVATE / COMPLETE / SUSPEND / RESUME)。
- agent: author(依頼医)、enterer(ログイン中の職員。onBehalfOf = 依頼医)。enterer ≠ author が代行入力で、オーダー承認の通知 Task が作られる(パス適用の来歴には作らない)。承認時に verifier が加わる。
- signature は承認時のみ(type = urn:iso-astm:E1762-95:2013#1.2.840.10065.1.12.1.5 Verification Signature、when、who。data は無し)。"""
* insert FCMeta
* activity 1..1 MS
* activity.coding.system = $v3-DataOperation
* agent 1..* MS
* agent.type 1..1
* agent.type.coding.system = $provenance-participant-type
* agent.who only Reference(FC_Practitioner)
* agent.onBehalfOf only Reference(FC_Practitioner)
* signature.type.system = $signature-type

Profile: FC_ReviewProvenance
Parent: Provenance
Id: fc-review-provenance
Title: "結果確認の来歴"
Description: "検査結果などを確認したことの来歴。verifier の agent と signature だけを持ち activity は持たない。"
* insert FCMeta
* activity 0..0
* agent 1..1
* agent.type 1..1
* agent.type = $provenance-participant-type#verifier
* agent.who only Reference(FC_Practitioner)
* signature 1..1
* signature.type.system = $signature-type
