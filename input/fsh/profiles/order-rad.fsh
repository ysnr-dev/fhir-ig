// 放射線検査オーダー: ヘッダ + 明細(単項目、またはセット親 → 子)。

Profile: FC_RadOrderHeader
Parent: FC_OrderHeader
Id: fc-rad-order-header
Title: "放射線検査オーダー ヘッダ"
Description: "放射線検査オーダーのヘッダ。occurrenceDateTime は撮影日(時刻を指定したときは時刻付き)。グループ化できない項目(単純撮影以外など)は項目ごとにヘッダ + 明細に分割し、1 つの transaction で登録する。予約が必要な項目は Appointment / Slot を同じ transaction に含める。"
* category[orderType] = $order-type#rad "放射線検査"
* category[setting] 1..1
* priority 1..1 MS
* priority from FCPriorityExamVS (required)
* code 0..0
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "撮影日(時)"

Profile: FC_RadOrderItem
Parent: FC_OrderItem
Id: fc-rad-order-item
Title: "放射線検査オーダー 明細"
Description: """撮影項目ごとの ServiceRequest。セット項目は親の明細(セット)→ 子項目の 2 段。

- code.coding: 院内項目コード(rad-order-item)を必ず持ち、JJ1017 の 32 桁 / 前半 16 桁 / 後半 16 桁と略称を添える(32 桁が全 0 なら JJ1017 は省略)。
- category = モダリティ(jj1017-modality)。
- bodySite[0] = 部位(jj1017p)+ 左右(jj1017-laterality)。
- 依頼診断は reasonReference(Condition)または reasonCode.text、特別指示は note。"""
* identifier.system = "http://fhir-client.local/IdSystem/rad-order-item-number"
* basedOn only Reference(FC_RadOrderHeader or FC_RadOrderItem)
* code 1..1 MS
* code.coding 1..*
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    item 1..1 MS and
    jj1017-32 0..1 and
    jj1017-16m 0..1 and
    jj1017-16s 0..1 and
    abbreviation 0..1
* code.coding[item].system = "http://fhir-client.local/CodeSystem/rad-order-item"
* code.coding[jj1017-32].system = "http://fhir-client.local/CodeSystem/jj1017-32"
* code.coding[jj1017-16m].system = "http://fhir-client.local/CodeSystem/jj1017-16m"
* code.coding[jj1017-16s].system = "http://fhir-client.local/CodeSystem/jj1017-16s"
* code.coding[abbreviation].system = "http://fhir-client.local/CodeSystem/lab-item-abbreviation"
* category 0..1
* category ^short = "モダリティ"
* category.coding.system = "http://fhir-client.local/CodeSystem/jj1017-modality"
* bodySite 0..1
* bodySite.coding ^slicing.discriminator[0].type = #value
* bodySite.coding ^slicing.discriminator[0].path = "system"
* bodySite.coding ^slicing.rules = #open
* bodySite.coding contains
    part 0..1 and
    laterality 0..1
* bodySite.coding[part].system = "http://fhir-client.local/CodeSystem/jj1017p"
* bodySite.coding[laterality].system = "http://fhir-client.local/CodeSystem/jj1017-laterality"
* reasonReference only Reference(FC_Condition)
* reasonCode.text ^short = "依頼診断(自由記載)"
* note ^short = "特別指示"
* extension contains
    RadExamPurpose named examPurpose 0..1 and
    RadExamPurposeQuestionnaireResponse named examPurposeResponse 0..1 and
    RadRemarksQuestionnaireResponse named remarksResponse 0..1
