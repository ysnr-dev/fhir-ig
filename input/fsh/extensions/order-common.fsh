// オーダー全種別で共有する拡張。

Extension: OrderDepartment
Id: order-department
Title: "依頼科"
Description: "依頼科(診療科 Organization)。オーダーのヘッダ ServiceRequest と MedicationRequest、検査報告 DiagnosticReport、診療記録 Composition に付く。標準要素に診療科を持つ場所が無いため拡張で持つ。"
Context: ServiceRequest, MedicationRequest, DiagnosticReport, Composition
* insert FCMeta
* value[x] only Reference(Organization)
* valueReference only Reference(FC_Department)

Extension: OrderWard
Id: order-ward
Title: "オーダー時の病棟"
Description: "入院オーダーを出した時点の病棟(Location)。外来オーダーには付かない。"
Context: ServiceRequest, MedicationRequest
* insert FCMeta
* value[x] only Reference(Location)
* valueReference only Reference(FC_Ward)

Extension: OrderSet
Id: order-set
Title: "オーダーセットの印"
Description: "どのオーダーセットから出したか。valueCoding.code = セットのコード、display = セット名。同時に identifier(order-set-instance)と requisition に適用 1 回ぶんの uuid が入る。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Coding
* valueCoding.system 1..1
* valueCoding.system = "http://fhir-client.local/CodeSystem/order-set"

Extension: PathwayOrder
Id: pathway-order
Title: "パス適用の印"
Description: "どのクリニカルパスの適用から出したか。valueCoding.code = パスコード、display = パス名。同時に identifier(pathway-instance)に適用 uuid が入り、requisition が空のオーダーには同じ identifier が requisition にも入る。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Coding
* valueCoding.system 1..1
* valueCoding.system = "http://fhir-client.local/CodeSystem/pathway"

Extension: PrescriptionMedicationRequest
Id: prescription-medication-request
Title: "薬剤行への参照"
Description: "処方・注射のヘッダ ServiceRequest.orderDetail の各要素に付き、その行に対応する MedicationRequest を指す。orderDetail.text は \"RP{n}-{m}\"。"
Context: ServiceRequest.orderDetail
* insert FCMeta
* value[x] only Reference(MedicationRequest)
