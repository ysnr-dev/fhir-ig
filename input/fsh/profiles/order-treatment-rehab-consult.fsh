// 処置・リハビリ・他科依頼のオーダー。

Profile: FC_TreatmentOrderHeader
Parent: FC_OrderHeader
Id: fc-treatment-order-header
Title: "処置オーダー ヘッダ"
Description: "処置オーダーのヘッダ。priority は持たない。分割・予約は放射線検査と同じ。"
* category[orderType] = $order-type#treatment "処置"
* category[setting] 1..1
* priority 0..0
* code 0..0
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "実施日(時)"

Profile: FC_TreatmentOrderItem
Parent: FC_OrderItem
Id: fc-treatment-order-item
Title: "処置オーダー 明細"
Description: "処置項目ごとの ServiceRequest。code = 院内項目コード(treatment-order-item)+ 略称。category / reason / note / 拡張は持たない。"
* identifier.system = "http://fhir-client.local/IdSystem/treatment-order-item-number"
* basedOn only Reference(FC_TreatmentOrderHeader or FC_TreatmentOrderItem)
* code 1..1 MS
* code.coding 1..*
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    item 1..1 MS and
    abbreviation 0..1
* code.coding[item].system = "http://fhir-client.local/CodeSystem/treatment-order-item"
* code.coding[abbreviation].system = "http://fhir-client.local/CodeSystem/lab-item-abbreviation"
* category 0..0

Profile: FC_RehabOrder
Parent: FC_OrderHeader
Id: fc-rehab-order
Title: "リハビリオーダー"
Description: """リハビリテーションの処方。明細 ServiceRequest は無い。

- code = 疾患別区分(rehab-disease-category)、orderDetail = 療法種別(PT / OT / ST、複数可)、quantityQuantity = 1 回の単位数(unit \"単位\")。
- occurrenceDateTime = 開始日、rehab-order-end = 終了日(上流の order-period で検索)。
- Task は期間中 accepted のまま。各回の実施は Procedure(basedOn = このオーダー)。"""
* category[orderType] = $order-type#rehab "リハビリ"
* code 1..1 MS
* code from RehabDiseaseCategoryVS (required)
* orderDetail 1..* MS
* orderDetail from RehabTherapyTypeVS (required)
* quantity[x] only Quantity
* quantity[x] ^short = "1 回の単位数"
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "開始日"
* extension contains
    RehabOrderEnd named orderEnd 0..1 MS and
    RehabOnsetDate named onsetDate 0..1 and
    RehabTargetDisease named targetDisease 0..1 and
    RehabFrequencyPerWeek named frequencyPerWeek 0..1

Profile: FC_ConsultOrder
Parent: FC_OrderHeader
Id: fc-consult-order
Title: "他科依頼"
Description: """他科への依頼。明細 ServiceRequest は無い。

- status は Task と連動して active → completed / revoked。
- code = 依頼の種類(consult-request-type)。occurrenceDateTime = 希望日。
- performer[0] = 依頼先の診療科(Organization、必須)、performer[1] = 依頼先の医師(任意)。
- reasonCode[0].text = 依頼目的。テンプレートで書いたときは consult-purpose-questionnaire-response。
- 回答は Composition(LOINC 11488-4 Consult note、event = consult-note-event#reply)で、consult-reply 拡張がそれを指す。"""
* category[orderType] = $order-type#consult "他科依頼"
* category[setting] 1..1
* priority 1..1 MS
* priority from FCPriorityRoutineUrgentVS (required)
* code 1..1 MS
* code from ConsultRequestTypeVS (required)
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "希望日"
* performer 1..2 MS
* performer ^slicing.discriminator[0].type = #type
* performer ^slicing.discriminator[0].path = "resolve()"
* performer ^slicing.rules = #open
* performer ^slicing.ordered = true
* performer contains
    department 1..1 MS and
    practitioner 0..1
* performer[department] only Reference(FC_Department)
* performer[practitioner] only Reference(FC_Practitioner)
* reasonCode 0..1
* reasonCode.text 1..1
* reasonCode.text ^short = "依頼目的"
* extension contains
    ConsultPurposeQuestionnaireResponse named purposeResponse 0..1 and
    ConsultReply named reply 0..1 MS
