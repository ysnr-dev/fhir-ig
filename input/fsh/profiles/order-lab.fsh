// 検体検査オーダー: ヘッダ + 明細(項目ごと、パネル → 子項目の 2 段)+ contained Specimen。

Profile: FC_LabOrderHeader
Parent: FC_OrderHeader
Id: fc-lab-order-header
Title: "検体検査オーダー ヘッダ"
Description: "検体検査オーダーのヘッダ。code は持たず、項目は明細 ServiceRequest で持つ。occurrenceDateTime は検査日。"
* category[orderType] = $order-type#lab "検体検査"
* priority 1..1 MS
* priority from FCPriorityRoutineUrgentVS (required)
* code 0..0
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "検査日"

Profile: FC_LabOrderItem
Parent: FC_OrderItem
Id: fc-lab-order-item
Title: "検体検査オーダー 明細"
Description: """検査項目ごとの ServiceRequest。パネル(セット)の子項目はパネルの明細を basedOn で指す(2 段)。

- code.coding は院内項目コード(lab-order-item)を必ず持ち、JLAC11 / JLAC10 / 略称を任意で添える。
- 検体は contained Specimen(id = specimen)で持ち、specimen で `#specimen` を参照する。"""
* identifier.system = "http://fhir-client.local/IdSystem/lab-order-item-number"
* basedOn only Reference(FC_LabOrderHeader or FC_LabOrderItem)
* code 1..1 MS
* code.coding 1..*
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    item 1..1 MS and
    jlac11 0..1 and
    jlac10 0..1 and
    abbreviation 0..1
* code.coding[item].system = "http://fhir-client.local/CodeSystem/lab-order-item"
* code.coding[jlac11].system = "http://fhir-client.local/CodeSystem/jlac11"
* code.coding[jlac10].system = "http://fhir-client.local/CodeSystem/jlac10"
* code.coding[abbreviation].system = "http://fhir-client.local/CodeSystem/lab-item-abbreviation"
* specimen 0..1 MS
* specimen only Reference(FC_LabOrderSpecimen)
* specimen ^short = "contained Specimen(#specimen)"
* extension contains
    LabOrderSpecimen named legacySpecimen 0..1 and
    LabOrderContainer named legacyContainer 0..1
* extension[legacySpecimen] ^short = "旧形式(読み取りのみ)"
* extension[legacyContainer] ^short = "旧形式(読み取りのみ)"

Profile: FC_LabOrderSpecimen
Parent: $JP_Specimen_Common
Id: fc-lab-order-specimen
Title: "検体検査オーダーの検体(contained)"
Description: "明細 ServiceRequest に contained で入る検体。status は持たない。type は JLAC11 材料コード、container.type は院内の採血管コード。"
* insert FCMeta
* status 0..0
* subject 1..1
* subject only Reference(FC_Patient)
* type 0..1 MS
* type.coding 1..1
* type.coding.system = "http://fhir-client.local/CodeSystem/jlac11-specimen"
* container 0..1
* container.type 1..1
* container.type.coding 1..1
* container.type.coding.system = "http://fhir-client.local/CodeSystem/lab-container"

Profile: FC_LabLabelSpecimen
Parent: $JP_Specimen_Common
Id: fc-lab-label-specimen
Title: "検体ラベルの検体(採血管ごと)"
Description: """検体ラベル発行時に backend が採血管ごとに作る Specimen。

- accessionIdentifier.system = lab-label-number。value は上流サーバーが採番する(10 桁連番 + M10W3 チェックディジットの 11 桁)。
- request[0] はオーダーのヘッダ ServiceRequest。
- 検体到着確認で status = available、receivedTime、lab-arrival-recorder 拡張が付く。検体検査結果はこの Specimen を参照するだけで変更しない。"""
* insert FCMeta
* accessionIdentifier 1..1 MS
* accessionIdentifier.system 1..1
* accessionIdentifier.system = "http://fhir-client.local/IdSystem/lab-label-number"
* subject 1..1
* subject only Reference(FC_Patient)
* request 1..1
* request only Reference(FC_LabOrderHeader)
* type 0..1 MS
* type.coding.system = "http://fhir-client.local/CodeSystem/jlac11-specimen"
* container.type.coding.system = "http://fhir-client.local/CodeSystem/lab-container"
* receivedTime ^short = "到着確認日時"
* extension contains LabArrivalRecorder named arrivalRecorder 0..1
