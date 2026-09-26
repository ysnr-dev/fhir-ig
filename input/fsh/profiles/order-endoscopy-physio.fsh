// 内視鏡・生理検査オーダー: 放射線と同形(JJ1017 / bodySite は無い)。

Profile: FC_EndoscopyOrderHeader
Parent: FC_OrderHeader
Id: fc-endoscopy-order-header
Title: "内視鏡オーダー ヘッダ"
Description: "内視鏡オーダーのヘッダ。分割・予約は放射線検査と同じ。"
* category[orderType] = $order-type#endoscopy "内視鏡"
* category[setting] 1..1
* priority 1..1 MS
* priority from FCPriorityExamVS (required)
* code 0..0
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "実施日(時)"

Profile: FC_EndoscopyOrderItem
Parent: FC_OrderItem
Id: fc-endoscopy-order-item
Title: "内視鏡オーダー 明細"
Description: "検査項目ごとの ServiceRequest。code = 院内項目コード(endoscopy-order-item)+ 略称、category = 検査種別(endoscopy-exam-type)。"
* identifier.system = "http://fhir-client.local/IdSystem/endoscopy-order-item-number"
* basedOn only Reference(FC_EndoscopyOrderHeader or FC_EndoscopyOrderItem)
* code 1..1 MS
* code.coding 1..*
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    item 1..1 MS and
    abbreviation 0..1
* code.coding[item].system = "http://fhir-client.local/CodeSystem/endoscopy-order-item"
* code.coding[abbreviation].system = "http://fhir-client.local/CodeSystem/lab-item-abbreviation"
* category 0..1
* category.coding.system = "http://fhir-client.local/CodeSystem/endoscopy-exam-type"
* reasonReference only Reference(FC_Condition)
* extension contains
    EndoscopyExamPurpose named examPurpose 0..1 and
    EndoscopyExamPurposeQuestionnaireResponse named examPurposeResponse 0..1 and
    EndoscopyRemarksQuestionnaireResponse named remarksResponse 0..1

Profile: FC_PhysioOrderHeader
Parent: FC_OrderHeader
Id: fc-physio-order-header
Title: "生理検査オーダー ヘッダ"
Description: "生理検査オーダーのヘッダ。分割・予約は放射線検査と同じ。"
* category[orderType] = $order-type#physio "生理検査"
* category[setting] 1..1
* priority 1..1 MS
* priority from FCPriorityExamVS (required)
* code 0..0
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "実施日(時)"

Profile: FC_PhysioOrderItem
Parent: FC_OrderItem
Id: fc-physio-order-item
Title: "生理検査オーダー 明細"
Description: "検査項目ごとの ServiceRequest。code = 院内項目コード(physio-order-item)+ 略称、category = 検査種別(physio-exam-type)。"
* identifier.system = "http://fhir-client.local/IdSystem/physio-order-item-number"
* basedOn only Reference(FC_PhysioOrderHeader or FC_PhysioOrderItem)
* code 1..1 MS
* code.coding 1..*
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    item 1..1 MS and
    abbreviation 0..1
* code.coding[item].system = "http://fhir-client.local/CodeSystem/physio-order-item"
* code.coding[abbreviation].system = "http://fhir-client.local/CodeSystem/lab-item-abbreviation"
* category 0..1
* category.coding.system = "http://fhir-client.local/CodeSystem/physio-exam-type"
* reasonReference only Reference(FC_Condition)
* extension contains
    PhysioExamPurpose named examPurpose 0..1 and
    PhysioExamPurposeQuestionnaireResponse named examPurposeResponse 0..1 and
    PhysioRemarksQuestionnaireResponse named remarksResponse 0..1
