// 手術オーダー(申込): ヘッダ + 術式明細(平坦、1 = 主術式)。

Profile: FC_SurgeryOrderHeader
Parent: FC_OrderHeader
Id: fc-surgery-order-header
Title: "手術オーダー ヘッダ"
Description: """手術申込のヘッダ。

- priority: routine 予定 / urgent 準緊急 / stat 緊急。
- occurrenceDateTime は予定日時。未定なら省略する(「日付未定」)。全種別のうち手術だけが省略できる。
- 手術室・執刀科・体位・スタッフ・麻酔・輸血準備・機器・検体・同意書・術前指示は拡張。
- 日程確定はヘッダの PUT と Task(accepted)を同じ transaction で行う。カレンダー上の移動はヘッダの PUT だけで Task は変えない。日程未定のまま入室すると、入室日時を occurrenceDateTime に入れ、Task を in-progress で作る。いずれも術式明細の occurrenceDateTime を同じ transaction で揃える。Appointment は作らない。"""
* category[orderType] = $order-type#surgery "手術"
* priority 1..1 MS
* priority from FCPrioritySurgeryVS (required)
* code 0..0
* occurrenceDateTime 0..1
* occurrenceDateTime ^short = "予定日時(未定なら無し)"
* extension contains
    SurgeryDuration named duration 0..1 and
    SurgeryRoom named room 0..1 MS and
    SurgeryDepartment named department 0..1 and
    SurgeryPosition named position 0..1 and
    SurgeryEstimatedBloodLoss named estimatedBloodLoss 0..1 and
    SurgeryStaff named staff 0..* and
    SurgeryAnesthesiaMethod named anesthesiaMethod 0..* and
    SurgeryAnesthesiaManagement named anesthesiaManagement 0..1 and
    SurgeryBloodPreparation named bloodPreparation 0..1 and
    SurgeryEquipment named equipment 0..* and
    SurgerySpecimenPlan named specimenPlan 0..* and
    SurgeryConsent named consent 0..* and
    SurgeryPreopInstruction named preopInstruction 0..1 and
    SurgeryPreopInstructionQuestionnaireResponse named preopInstructionResponse 0..1
* extension[room].valueReference only Reference(FC_Room)
* extension[department].valueReference only Reference(FC_Department)

Profile: FC_SurgeryOrderItem
Parent: FC_OrderItem
Id: fc-surgery-order-item
Title: "手術オーダー 術式明細"
Description: "術式ごとの ServiceRequest(平坦、identifier 1 = 主術式)。code = 術式マスタ(surgery-order-item)+ レセプト K コード(surgery-procedure-code)+ 略称。bodySite = 左右 + text。reasonReference / reasonCode = 術前診断。"
* identifier.system = "http://fhir-client.local/IdSystem/surgery-order-item-number"
* basedOn only Reference(FC_SurgeryOrderHeader)
* code 1..1 MS
* code.coding 1..*
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    item 1..1 MS and
    procedureCode 0..1 and
    abbreviation 0..1
* code.coding[item].system = "http://fhir-client.local/CodeSystem/surgery-order-item"
* code.coding[procedureCode].system = "http://fhir-client.local/CodeSystem/surgery-procedure-code"
* code.coding[abbreviation].system = "http://fhir-client.local/CodeSystem/lab-item-abbreviation"
* bodySite 0..1
* bodySite.coding.system = "http://fhir-client.local/CodeSystem/jj1017-laterality"
* reasonReference only Reference(FC_Condition)
* reasonCode.text ^short = "術前診断(自由記載)"
* extension contains SurgeryApproach named approach 0..1
