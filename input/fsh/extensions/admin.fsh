// 患者・管理リソースの拡張。

Extension: ProblemNumber
Id: problem-number
Title: "プロブレム番号"
Description: "プロブレムリスト上の番号(#n)。表示の \"#n 病名\" に使う。"
Context: Condition
* insert FCMeta
* value[x] only positiveInt

Extension: ProblemParent
Id: problem-parent
Title: "親プロブレム"
Description: "このプロブレムがぶら下がる親のプロブレム。"
Context: Condition
* insert FCMeta
* value[x] only Reference(Condition)

Extension: ProblemSucceededBy
Id: problem-succeeded-by
Title: "後継プロブレム"
Description: "プロブレムの統合・分割で、このプロブレムを引き継いだ後継プロブレム。複数可。"
Context: Condition
* insert FCMeta
* value[x] only Reference(Condition)

Extension: EncounterNote
Id: encounter-note
Title: "入院の特記事項"
Description: "入院の特記事項。"
Context: Encounter
* insert FCMeta
* value[x] only string

Extension: EncounterLeave
Id: encounter-leave
Title: "外出・外泊"
Description: "入院中の外出・外泊。1 件ごとに繰り返す。id は食事オーダーの欠食(meal-order-link / meal-order-end-reason の leave)から参照される。"
Context: Encounter
* insert FCMeta
* extension contains
    id 1..1 and
    start 1..1 and
    end 0..1 and
    reason 0..1
* extension[id].value[x] only string
* extension[id] ^short = "uuid"
* extension[start].value[x] only dateTime
* extension[end].value[x] only dateTime
* extension[reason].value[x] only string

Extension: EncounterTransferPlan
Id: encounter-transfer-plan
Title: "転棟・転科の予定"
Description: "転棟・転科の予定。"
Context: Encounter
* insert FCMeta
* extension contains
    date 1..1 and
    ward 0..1 and
    room 0..1 and
    bed 0..1 and
    department 0..1
* extension[date].value[x] only date
* extension[ward].value[x] only Reference(Location)
* extension[room].value[x] only Reference(Location)
* extension[bed].value[x] only Reference(Location)
* extension[department].value[x] only Reference(Organization)

Extension: EncounterDischargePlan
Id: encounter-discharge-plan
Title: "退院の予定"
Description: "退院の予定。"
Context: Encounter
* insert FCMeta
* extension contains
    date 1..1 and
    reason 0..1
* extension[date].value[x] only dateTime
* extension[reason].value[x] only string

Extension: LocationDisplayOrder
Id: location-display-order
Title: "部屋の表示順"
Description: "部屋の表示順。"
Context: Location
* insert FCMeta
* value[x] only integer

Extension: PractitionerRolePrimaryDepartment
Id: practitioner-role-primary-department
Title: "主たる診療科"
Description: "この拡張が付いている PractitionerRole は診療科ロール(organization = 診療科)。true なら既定の診療科。"
Context: PractitionerRole
* insert FCMeta
* value[x] only boolean

Extension: AppointmentCheckedInAt
Id: appointment-checked-in-at
Title: "受付日時"
Description: "実際に受付した日時。レセプトコンピュータからの受付取込でも付く。"
Context: Appointment
* insert FCMeta
* value[x] only dateTime

Extension: ScheduleSlotPattern
Id: schedule-slot-pattern
Title: "予約枠の生成パターン"
Description: "Slot を生成するためのパターン。JSON 文字列 `{\"weekdays\": [..], \"blocks\": [{\"start\": \"09:00\", \"end\": \"12:00\"}], \"durationMinutes\": 15, \"capacity\": 1}` を valueString に入れる(既知の非準拠パターン)。"
Context: Schedule
* insert FCMeta
* value[x] only string

Extension: ObservationProblem
Id: observation-problem
Title: "バイタルの対象プロブレム"
Description: "バイタルの対象プロブレム。"
Context: Observation
* insert FCMeta
* value[x] only Reference(Condition)

Extension: ImagingSource
Id: imaging-source
Title: "DICOM の取込元"
Description: "取り込んだ DICOM のタグから転記した元施設と元患者。"
Context: ImagingStudy
* insert FCMeta
* extension contains
    institutionName 0..1 and
    patientId 0..1 and
    patientName 0..1
* extension[institutionName].value[x] only string
* extension[patientId].value[x] only string
* extension[patientName].value[x] only string

Extension: ReceptionCoverageSet
Id: reception-coverage-set
Title: "受付の保険組合せ"
Description: "レセプトコンピュータから取り込んだ受付(Appointment)の保険組合せキー。backend だけが書く。URL は integrations/receipt-computer 配下。"
Context: Appointment
* insert FCMeta
* ^url = "http://fhir-client.local/integrations/receipt-computer/StructureDefinition/reception-coverage-set"
* value[x] only string

Extension: AppointmentVisitKind
Id: appointment-visit-kind
Title: "初再診"
Description: "受付で指定した初診(first)・再診(revisit)。未指定は判定をレセプトコンピュータに任せる意味で、拡張ごと持たない。"
Context: Appointment
* insert FCMeta
* value[x] only code
* valueCode from AppointmentVisitKindVS (required)

Extension: EmergencyTriageLevel
Id: emergency-triage-level
Title: "JTAS の現在のレベル"
Description: "救急受診の現在の JTAS レベル(1 蘇生〜5 非緊急)。一覧の表示・並べ替え用で、判定の履歴はトリアージの Observation(FC_TriageObservation)が持つ。"
Context: Encounter
* insert FCMeta
* value[x] only integer
* valueInteger ^minValueInteger = 1
* valueInteger ^maxValueInteger = 5

Extension: EncounterOriginEmergency
Id: encounter-origin-emergency
Title: "元の救急受診"
Description: "救急外来から入院したときの、元の救急受診(Encounter、class = EMER)。入院 Encounter に付く。"
Context: Encounter
* insert FCMeta
* value[x] only Reference(Encounter)

Extension: EncounterReferral
Id: encounter-referral
Title: "他院よりの紹介の有無"
Description: "他院よりの紹介の有無(DPC 様式1 の入院情報)。入院経路が家庭(1)・他院からの転院(4)・介護施設(5)のときだけ持つ。"
Context: Encounter
* insert FCMeta
* value[x] only boolean

Extension: EncounterFromOutpatient
Id: encounter-from-outpatient
Title: "自院の外来からの入院"
Description: "自院の外来からの入院か(DPC 様式1 の入院情報)。入院経路が家庭(1)・他院からの転院(4)・介護施設(5)のときだけ持つ。"
Context: Encounter
* insert FCMeta
* value[x] only boolean

Extension: EncounterAmbulance
Id: encounter-ambulance
Title: "救急車による搬送の有無"
Description: "救急車による搬送の有無(DPC 様式1 の入院情報)。入院経路が家庭(1)・他院からの転院(4)・介護施設(5)のときに持つ。救急外来から入院予定を作ったときは、来院方法が救急車・ドクターヘリ・ドクターカーなら入院経路が未入力でも true で引き継ぐ。"
Context: Encounter
* insert FCMeta
* value[x] only boolean

Extension: EncounterPriorHomeCare
Id: encounter-prior-home-care
Title: "入院前の在宅医療の有無"
Description: "入院前の在宅医療の有無(DPC 様式1 の入院情報。0 無 / 1 当院が提供 / 2 他施設が提供 / 9 不明)。入院経路が家庭(1)・他院からの転院(4)・介護施設(5)で、入力されたときだけ持つ。"
Context: Encounter
* insert FCMeta
* value[x] only code
* valueCode from EncounterPriorHomeCareVS (required)
