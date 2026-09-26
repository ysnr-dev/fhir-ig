Instance: example-lab-order-header
InstanceOf: FC_LabOrderHeader
Usage: #example
Title: "検体検査オーダー ヘッダの例"
* status = #active
* intent = #order
* priority = #routine
* category[orderType] = $order-type#lab "検体検査"
* category[setting] = $prescription-setting#inpatient "入院"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* requester.display = "山田 一郎"
* authoredOn = "2026-04-01T09:00:00+09:00"
* occurrenceDateTime = "2026-04-02"
* reasonReference = Reference(Condition/example-condition)
* reasonReference.display = "#1 2型糖尿病"
* note.text = "空腹時採血"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderDepartment].valueReference.display = "内科"
* extension[orderWard].valueReference = Reference(Location/example-ward)
* extension[orderWard].valueReference.display = "東3階病棟"

Instance: example-lab-order-specimen
InstanceOf: FC_LabOrderSpecimen
Usage: #inline
* id = "specimen"
* subject = Reference(Patient/example-patient)
* type = http://fhir-client.local/CodeSystem/jlac11-specimen#023 "血清"
* container.type = http://fhir-client.local/CodeSystem/lab-container#SST "分離剤入り"

Instance: example-lab-order-item
InstanceOf: FC_LabOrderItem
Usage: #example
Title: "検体検査オーダー 明細の例"
* status = #active
* intent = #order
* identifier.system = "http://fhir-client.local/IdSystem/lab-order-item-number"
* identifier.value = "1"
* basedOn = Reference(ServiceRequest/example-lab-order-header)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-01T09:00:00+09:00"
* occurrenceDateTime = "2026-04-02"
* code.coding[item] = http://fhir-client.local/CodeSystem/lab-order-item#0301 "HbA1c"
* code.coding[jlac11] = http://fhir-client.local/CodeSystem/jlac11#3D0460000023220000
* code.coding[abbreviation] = $lab-item-abbreviation#HbA1c "HbA1c"
* code.text = "HbA1c"
* contained[0] = example-lab-order-specimen
* specimen = Reference(example-lab-order-specimen)

Instance: example-lab-label-specimen
InstanceOf: FC_LabLabelSpecimen
Usage: #example
Title: "検体ラベルの検体の例"
* accessionIdentifier.system = "http://fhir-client.local/IdSystem/lab-label-number"
* accessionIdentifier.value = "00000001231"
* status = #available
* subject = Reference(Patient/example-patient)
* request = Reference(ServiceRequest/example-lab-order-header)
* type = http://fhir-client.local/CodeSystem/jlac11-specimen#023 "血清"
* container.type = http://fhir-client.local/CodeSystem/lab-container#SST "分離剤入り"
* receivedTime = "2026-04-02T08:30:00+09:00"
* extension[arrivalRecorder].valueReference = Reference(Practitioner/example-practitioner)
