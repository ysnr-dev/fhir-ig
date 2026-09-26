// 細菌検査・放射線・内視鏡・生理検査・処置・病理のオーダーの例。

// ---- 細菌検査 ----

Instance: example-micro-order-header
InstanceOf: FC_MicroOrderHeader
Usage: #example
Title: "細菌検査オーダー ヘッダの例"
* status = #active
* intent = #order
* priority = #routine
* category[orderType] = $order-type#micro "細菌検査"
* category[setting] = $prescription-setting#inpatient "入院"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T09:00:00+09:00"
* occurrenceDateTime = "2026-04-01"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderWard].valueReference = Reference(Location/example-ward)
* extension[priorAntimicrobial].valueString = "CTRX 2g/日(3 日間)"
* extension[examPurpose].valueCode = #diagnostic

Instance: example-micro-order-specimen
InstanceOf: FC_MicroOrderSpecimen
Usage: #inline
* id = "specimen"
* subject = Reference(Patient/example-patient)
* type = http://fhir-client.local/CodeSystem/janis-specimen-type#SPT "喀痰"
* collection.bodySite.coding[site] = http://fhir-client.local/CodeSystem/micro-collection-site#LUNG "肺"
* collection.method = http://fhir-client.local/CodeSystem/micro-collection-method#EXP "喀出"

Instance: example-micro-order-specimen-group
InstanceOf: FC_MicroOrderSpecimenGroup
Usage: #example
Title: "細菌検査オーダー 検体グループの例"
* status = #active
* intent = #order
* identifier.system = "http://fhir-client.local/IdSystem/micro-order-item-number"
* identifier.value = "1"
* basedOn = Reference(ServiceRequest/example-micro-order-header)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-01T09:00:00+09:00"
* occurrenceDateTime = "2026-04-01T10:00:00+09:00"
* code.text = "喀痰"
* orderDetail = http://fhir-client.local/CodeSystem/janis-organism#PAE "Pseudomonas aeruginosa"
* reasonCode.text = "肺炎"
* contained[0] = example-micro-order-specimen
* specimen = Reference(example-micro-order-specimen)

Instance: example-micro-order-item
InstanceOf: FC_MicroOrderItem
Usage: #example
Title: "細菌検査オーダー 検査項目の例"
* status = #active
* intent = #order
* identifier.system = "http://fhir-client.local/IdSystem/micro-order-item-number"
* identifier.value = "2"
* basedOn = Reference(ServiceRequest/example-micro-order-specimen-group)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-01T09:00:00+09:00"
* occurrenceDateTime = "2026-04-01"
* code = http://fhir-client.local/CodeSystem/micro-order-item#CULT "一般細菌培養同定"

// ---- 放射線検査 ----

Instance: example-rad-order-header
InstanceOf: FC_RadOrderHeader
Usage: #example
Title: "放射線検査オーダー ヘッダの例"
* status = #active
* intent = #order
* priority = #routine
* category[orderType] = $order-type#rad "放射線検査"
* category[setting] = $prescription-setting#outpatient "外来"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T09:30:00+09:00"
* occurrenceDateTime = "2026-04-03T10:00:00+09:00"
* reasonReference = Reference(Condition/example-condition)
* extension[orderDepartment].valueReference = Reference(Organization/example-department)

Instance: example-rad-order-item
InstanceOf: FC_RadOrderItem
Usage: #example
Title: "放射線検査オーダー 明細の例"
* status = #active
* intent = #order
* identifier.system = "http://fhir-client.local/IdSystem/rad-order-item-number"
* identifier.value = "1"
* basedOn = Reference(ServiceRequest/example-rad-order-header)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-01T09:30:00+09:00"
* occurrenceDateTime = "2026-04-03T10:00:00+09:00"
* code.coding[item] = http://fhir-client.local/CodeSystem/rad-order-item#CT-CHEST "胸部 CT"
* code.coding[jj1017-32] = http://fhir-client.local/CodeSystem/jj1017-32#10201030000000000000000000000000
* code.coding[jj1017-16m] = http://fhir-client.local/CodeSystem/jj1017-16m#1020103000000000
* code.coding[jj1017-16s] = http://fhir-client.local/CodeSystem/jj1017-16s#0000000000000000
* code.coding[abbreviation] = $lab-item-abbreviation#CT "CT"
* code.text = "胸部 CT"
* category = http://fhir-client.local/CodeSystem/jj1017-modality#CT "CT"
* bodySite.coding[part] = http://fhir-client.local/CodeSystem/jj1017p#CHEST "胸部"
* reasonCode.text = "肺炎疑い"
* note.text = "呼吸停止困難"
* extension[examPurpose].valueString = "肺炎の評価"

// ---- 放射線治療 ----

Instance: example-radiotherapy-order
InstanceOf: FC_RadiotherapyOrder
Usage: #example
Title: "放射線治療処方の例"
* status = #active
* intent = #order
* category[orderType] = $order-type#radiotherapy "放射線治療"
* category[setting] = $prescription-setting#outpatient "外来"
* code = http://fhir-client.local/CodeSystem/radiotherapy-order#course-prescription "放射線治療処方"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* performer = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T11:00:00+09:00"
* occurrenceDateTime = "2026-04-15"
* bodySite.coding[part] = http://fhir-client.local/CodeSystem/jj1017p#CHEST "胸部"
* bodySite.coding[laterality] = $jj1017-laterality#R "右側"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[course].extension[courseNumber].valueInteger = 1
* extension[course].extension[intent].valueCoding = http://fhir-client.local/CodeSystem/radiotherapy-intent#curative "根治"
* extension[course].extension[concurrentTherapy].valueCoding = http://fhir-client.local/CodeSystem/radiotherapy-concurrent-therapy#concurrent-chemo "同時化学療法"
* extension[volume][0].extension[volumeId].valueString = "v1"
* extension[volume][0].extension[label].valueString = "PTV-lung"
* extension[volume][0].extension[type].valueCoding = http://fhir-client.local/CodeSystem/radiotherapy-volume-type#PTV "PTV"
* extension[phase][0].extension[phaseId].valueString = "p1"
* extension[phase][0].extension[number].valueInteger = 1
* extension[phase][0].extension[label].valueString = "初期照射"
* extension[phase][0].extension[status].valueCode = #active
* extension[phase][0].extension[modalityAndTechnique].extension[modality].valueCodeableConcept = http://fhir-client.local/CodeSystem/radiotherapy-modality#photon "光子線"
* extension[phase][0].extension[modalityAndTechnique].extension[technique].valueCodeableConcept = http://fhir-client.local/CodeSystem/radiotherapy-technique#3DCRT "3D-CRT"
* extension[phase][0].extension[fractionsPrescribed].valueUnsignedInt = 30
* extension[phase][0].extension[device].valueCodeableConcept = http://fhir-client.local/CodeSystem/radiotherapy-device#LINAC1 "リニアック 1 号機"
* extension[phase][0].extension[fractionsPerWeek].valueInteger = 5
* extension[phase][0].extension[dosePrescribedToVolume][0].extension[volume].valueString = "v1"
* extension[phase][0].extension[dosePrescribedToVolume][0].extension[fractionDose].valueQuantity = 2 'Gy' "Gy"
* extension[phase][0].extension[dosePrescribedToVolume][0].extension[totalDose].valueQuantity = 60 'Gy' "Gy"

// ---- 内視鏡 ----

Instance: example-endoscopy-order-header
InstanceOf: FC_EndoscopyOrderHeader
Usage: #example
Title: "内視鏡オーダー ヘッダの例"
* status = #active
* intent = #order
* priority = #routine
* category[orderType] = $order-type#endoscopy "内視鏡"
* category[setting] = $prescription-setting#outpatient "外来"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T09:40:00+09:00"
* occurrenceDateTime = "2026-04-10T09:00:00+09:00"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)

Instance: example-endoscopy-order-item
InstanceOf: FC_EndoscopyOrderItem
Usage: #example
Title: "内視鏡オーダー 明細の例"
* status = #active
* intent = #order
* identifier.system = "http://fhir-client.local/IdSystem/endoscopy-order-item-number"
* identifier.value = "1"
* basedOn = Reference(ServiceRequest/example-endoscopy-order-header)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-01T09:40:00+09:00"
* occurrenceDateTime = "2026-04-10T09:00:00+09:00"
* code.coding[item] = http://fhir-client.local/CodeSystem/endoscopy-order-item#EGD "上部消化管内視鏡"
* code.coding[abbreviation] = $lab-item-abbreviation#EGD "EGD"
* category = http://fhir-client.local/CodeSystem/endoscopy-exam-type#UPPER "上部"
* extension[examPurpose].valueString = "心窩部痛の精査"

// ---- 生理検査 ----

Instance: example-physio-order-header
InstanceOf: FC_PhysioOrderHeader
Usage: #example
Title: "生理検査オーダー ヘッダの例"
* status = #active
* intent = #order
* priority = #urgent
* category[orderType] = $order-type#physio "生理検査"
* category[setting] = $prescription-setting#outpatient "外来"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T09:45:00+09:00"
* occurrenceDateTime = "2026-04-01T11:00:00+09:00"

Instance: example-physio-order-item
InstanceOf: FC_PhysioOrderItem
Usage: #example
Title: "生理検査オーダー 明細の例"
* status = #active
* intent = #order
* identifier.system = "http://fhir-client.local/IdSystem/physio-order-item-number"
* identifier.value = "1"
* basedOn = Reference(ServiceRequest/example-physio-order-header)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-01T09:45:00+09:00"
* occurrenceDateTime = "2026-04-01T11:00:00+09:00"
* code.coding[item] = http://fhir-client.local/CodeSystem/physio-order-item#ECG12 "12 誘導心電図"
* code.coding[abbreviation] = $lab-item-abbreviation#ECG "ECG"
* category = http://fhir-client.local/CodeSystem/physio-exam-type#ECG "心電図"

// ---- 処置 ----

Instance: example-treatment-order-header
InstanceOf: FC_TreatmentOrderHeader
Usage: #example
Title: "処置オーダー ヘッダの例"
* status = #active
* intent = #order
* category[orderType] = $order-type#treatment "処置"
* category[setting] = $prescription-setting#inpatient "入院"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-02T08:00:00+09:00"
* occurrenceDateTime = "2026-04-02T14:00:00+09:00"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderWard].valueReference = Reference(Location/example-ward)

Instance: example-treatment-order-item
InstanceOf: FC_TreatmentOrderItem
Usage: #example
Title: "処置オーダー 明細の例"
* status = #active
* intent = #order
* identifier.system = "http://fhir-client.local/IdSystem/treatment-order-item-number"
* identifier.value = "1"
* basedOn = Reference(ServiceRequest/example-treatment-order-header)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-02T08:00:00+09:00"
* occurrenceDateTime = "2026-04-02T14:00:00+09:00"
* code.coding[item] = http://fhir-client.local/CodeSystem/treatment-order-item#WOUND "創傷処置"

// ---- 病理 ----

Instance: example-patho-order-header
InstanceOf: FC_PathoOrderHeader
Usage: #example
Title: "病理検査オーダー ヘッダの例"
* status = #active
* intent = #order
* priority = #routine
* category[orderType] = $order-type#pathology "病理検査"
* category[setting] = $prescription-setting#outpatient "外来"
* code = http://fhir-client.local/CodeSystem/jahis-patho-exam-category#N000 "組織診"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-10T10:30:00+09:00"
* occurrenceDateTime = "2026-04-10T10:15:00+09:00"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[clinicalInfo].valueString = "胃体部に隆起性病変。生検 2 個。"
* extension[reportDue].valueDate = "2026-04-17"

Instance: example-patho-order-specimen
InstanceOf: FC_PathoOrderSpecimen
Usage: #inline
* id = "specimen"
* subject = Reference(Patient/example-patient)
* type = http://fhir-client.local/CodeSystem/jahis-patho-specimen-type#201 "生検"
* collection.bodySite.coding[organ] = http://fhir-client.local/CodeSystem/jahis-patho-organ#C16 "胃"
* collection.method = http://fhir-client.local/CodeSystem/jahis-patho-collection-method#01 "内視鏡下生検"

Instance: example-patho-order-item
InstanceOf: FC_PathoOrderItem
Usage: #example
Title: "病理検査オーダー 検体明細の例"
* status = #active
* intent = #order
* identifier.system = "http://fhir-client.local/IdSystem/patho-order-item-number"
* identifier.value = "1"
* basedOn = Reference(ServiceRequest/example-patho-order-header)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-10T10:30:00+09:00"
* occurrenceDateTime = "2026-04-10T10:15:00+09:00"
* code.text = "胃体部 生検"
* contained[0] = example-patho-order-specimen
* specimen = Reference(example-patho-order-specimen)
