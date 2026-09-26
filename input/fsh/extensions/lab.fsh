// 検体検査の拡張。

Extension: LabOrderSpecimen
Id: lab-order-specimen
Title: "検体材料(旧形式)"
Description: "旧形式。検体は contained Specimen で持つのが現行形で、この拡張は読み取りのみ(新規には書かない)。"
Context: ServiceRequest, ServiceRequest.orderDetail
* insert FCMeta
* value[x] only CodeableConcept
* valueCodeableConcept.coding.system = "http://fhir-client.local/CodeSystem/jlac11-specimen"

Extension: LabOrderContainer
Id: lab-order-container
Title: "採血管(旧形式)"
Description: "旧形式。読み取りのみ。"
Context: ServiceRequest, ServiceRequest.orderDetail
* insert FCMeta
* value[x] only CodeableConcept
* valueCodeableConcept.coding.system = "http://fhir-client.local/CodeSystem/lab-container"

Extension: LabArrivalRecorder
Id: lab-arrival-recorder
Title: "検体到着の記録者"
Description: "検体到着確認をした職員。到着時に Specimen.status = available、receivedTime と一緒に付く。"
Context: Specimen
* insert FCMeta
* value[x] only Reference(Practitioner)
