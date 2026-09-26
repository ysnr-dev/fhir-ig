// 細菌検査オーダー: ヘッダ + 検体グループ明細(1 件、contained Specimen)+ 検査項目明細(検体グループにぶら下がる)。Task は無い。

Profile: FC_MicroOrderHeader
Parent: FC_OrderHeader
Id: fc-micro-order-header
Title: "細菌検査オーダー ヘッダ"
Description: """細菌検査オーダーのヘッダ。code は持たない。進捗の Task は無く、ServiceRequest.status で読む。

既知の不具合: 現行のアプリは micro-prior-antimicrobial / micro-exam-purpose を書くときに order-department / order-ward を上書きしてしまう(microOrderHelpers.ts)。本プロファイルは本来の形(両方を持つ)を定義する。"""
* category[orderType] = $order-type#micro "細菌検査"
* category[setting] 1..1
* priority 1..1 MS
* priority from FCPriorityRoutineUrgentVS (required)
* code 0..0
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "検査日"
* extension contains
    MicroPriorAntimicrobial named priorAntimicrobial 0..1 and
    MicroExamPurpose named examPurpose 0..1 MS

Profile: FC_MicroOrderSpecimenGroup
Parent: FC_OrderItem
Id: fc-micro-order-specimen-group
Title: "細菌検査オーダー 検体グループ"
Description: "検体 1 つに対する明細(identifier = 1)。code は text のみ。occurrenceDateTime は採取予定(無ければヘッダの日付)。contained Specimen に検体種別・採取部位・採取方法を持ち、orderDetail に目的菌を並べる。"
* identifier.system = "http://fhir-client.local/IdSystem/micro-order-item-number"
* basedOn only Reference(FC_MicroOrderHeader)
* code 1..1
* code.text 1..1
* code.coding 0..0
* specimen 1..1 MS
* specimen only Reference(FC_MicroOrderSpecimen)
* orderDetail ^short = "目的菌(janis-organism)"
* orderDetail.coding.system = "http://fhir-client.local/CodeSystem/janis-organism"
* reasonReference only Reference(FC_Condition)
* reasonCode.text ^short = "臨床診断(自由記載)"

Profile: FC_MicroOrderItem
Parent: FC_OrderItem
Id: fc-micro-order-item
Title: "細菌検査オーダー 検査項目"
Description: "検査項目(培養・同定・感受性・塗抹など)の明細。basedOn は検体グループを指す。identifier は 2 以降。"
* identifier.system = "http://fhir-client.local/IdSystem/micro-order-item-number"
* basedOn only Reference(FC_MicroOrderSpecimenGroup)
* code 1..1 MS
* code.coding 1..1
* code.coding.system = "http://fhir-client.local/CodeSystem/micro-order-item"

Profile: FC_MicroOrderSpecimen
Parent: $JP_Specimen_Common
Id: fc-micro-order-specimen
Title: "細菌検査オーダーの検体(contained)"
Description: "検体グループ明細に contained で入る検体。type = JANIS 検体種別、collection.bodySite = 採取部位 + 左右、collection.method = 採取方法。"
* insert FCMeta
* status 0..0
* subject 1..1
* subject only Reference(FC_Patient)
* type 1..1 MS
* type.coding 1..1
* type.coding.system = "http://fhir-client.local/CodeSystem/janis-specimen-type"
* collection.bodySite.coding ^slicing.discriminator[0].type = #value
* collection.bodySite.coding ^slicing.discriminator[0].path = "system"
* collection.bodySite.coding ^slicing.rules = #open
* collection.bodySite.coding contains
    site 0..1 and
    laterality 0..1
* collection.bodySite.coding[site].system = "http://fhir-client.local/CodeSystem/micro-collection-site"
* collection.bodySite.coding[laterality] from MicroLateralityVS (required)
* collection.bodySite.coding[laterality].system = "http://fhir-client.local/CodeSystem/micro-laterality"
* collection.method.coding.system = "http://fhir-client.local/CodeSystem/micro-collection-method"
