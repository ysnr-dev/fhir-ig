// 放射線治療処方: 明細を持たない単一の ServiceRequest。コース・標的体積・フェーズは拡張で持つ。

Profile: FC_RadiotherapyOrder
Parent: FC_OrderHeader
Id: fc-radiotherapy-order
Title: "放射線治療処方"
Description: """放射線治療のコース処方。明細 ServiceRequest は無い。

- status は Task と連動して active / on-hold / completed / revoked に変わる(同じ transaction)。
- code = radiotherapy-order#course-prescription。occurrenceDateTime = 治療開始予定日。
- performer[0] = 放射線治療医(任意)。bodySite = 標的部位(jj1017p + 左右、または text)。
- 放射線治療科への他科依頼から作ったときは radiotherapy-consult-request で依頼を指す(basedOn ではない)。
- 照射の実施は Procedure(basedOn = この処方)、コース終了時の要約も Procedure。週次診察は QuestionnaireResponse(basedOn = この処方)。"""
* category[orderType] = $order-type#radiotherapy "放射線治療"
* code 1..1
* code = http://fhir-client.local/CodeSystem/radiotherapy-order#course-prescription "放射線治療処方"
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "治療開始予定日"
* performer only Reference(FC_Practitioner)
* performer ^short = "放射線治療医"
* bodySite.coding ^slicing.discriminator[0].type = #value
* bodySite.coding ^slicing.discriminator[0].path = "system"
* bodySite.coding ^slicing.rules = #open
* bodySite.coding contains
    part 0..1 and
    laterality 0..1
* bodySite.coding[part].system = "http://fhir-client.local/CodeSystem/jj1017p"
* bodySite.coding[laterality].system = "http://fhir-client.local/CodeSystem/jj1017-laterality"
* extension contains
    RadiotherapyCourse named course 1..1 MS and
    RadiotherapyVolume named volume 0..* MS and
    RadiotherapyPhase named phase 0..* MS and
    RadiotherapyConsultRequest named consultRequest 0..1
