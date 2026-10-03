// 病理検査オーダー: ヘッダ + 検体明細(contained Specimen)。

Profile: FC_PathoOrderHeader
Parent: FC_OrderHeader
Id: fc-patho-order-header
Title: "病理検査オーダー ヘッダ"
Description: "病理検査オーダーのヘッダ。code = 検査区分(JAHIS LPATHO001: 組織診 / 細胞診 / 術中迅速)。occurrenceDateTime = 採取日時。臨床情報・報告希望日・手術室・シェーマ画像は拡張。シェーマ画像の Binary とテンプレート記入の QuestionnaireResponse は同じ transaction で登録する。"
* category[orderType] = $order-type#pathology "病理検査"
* priority 1..1 MS
* priority from FCPriorityRoutineUrgentVS (required)
* code 1..1 MS
* code from JahisPathoExamCategoryVS (required)
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "採取日時"
* extension contains
    PathoClinicalInfo named clinicalInfo 0..1 and
    PathoClinicalInfoQuestionnaireResponse named clinicalInfoResponse 0..1 and
    PathoReportDue named reportDue 0..1 and
    PathoOperatingRoom named operatingRoom 0..1 and
    PathoSchemaImage named schemaImage 0..*

Profile: FC_PathoOrderItem
Parent: FC_OrderItem
Id: fc-patho-order-item
Title: "病理検査オーダー 検体明細"
Description: "検体ごとの ServiceRequest(identifier = 検体番号)。code は text のみ。contained Specimen に検体タイプ・臓器・左右・採取方法を持つ。"
* identifier.system = "http://fhir-client.local/IdSystem/patho-order-item-number"
* basedOn only Reference(FC_PathoOrderHeader)
* code 1..1
* code.text 1..1
* code.coding 0..0
* specimen 1..1 MS
* specimen only Reference(FC_PathoOrderSpecimen)
* note ^short = "検体のコメント"

Profile: FC_PathoOrderSpecimen
Parent: $JP_Specimen_Common
Id: fc-patho-order-specimen
Title: "病理検査オーダーの検体(contained)"
Description: "検体明細に contained で入る検体。type = JAHIS 検体タイプ(LPATHO002)、collection.bodySite = 臓器(JAHIS)+ 左右、collection.method = 採取方法(JAHIS)。"
* insert FCMeta
* status 0..0
* subject 1..1
* subject only Reference(FC_Patient)
* type 1..1 MS
* type from JahisPathoSpecimenTypeVS (required)
* collection.bodySite.coding ^slicing.discriminator[0].type = #value
* collection.bodySite.coding ^slicing.discriminator[0].path = "system"
* collection.bodySite.coding ^slicing.rules = #open
* collection.bodySite.coding contains
    organ 0..1 and
    laterality 0..1
* collection.bodySite.coding[organ].system = "http://fhir-client.local/CodeSystem/jahis-patho-organ"
* collection.bodySite.coding[laterality] from PathoLateralityVS (required)
* collection.bodySite.coding[laterality].system = "http://fhir-client.local/CodeSystem/patho-laterality"
* collection.method.coding.system = "http://fhir-client.local/CodeSystem/jahis-patho-collection-method"
