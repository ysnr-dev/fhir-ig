// 処方・注射・調剤・投与・持参薬・レジメンの例。

Instance: example-prescription-order
InstanceOf: FC_PrescriptionOrder
Usage: #example
Title: "処方オーダー ヘッダの例"
* status = #active
* intent = #order
* category[setting] = $prescription-setting#inpatient "入院"
* category[prescriptionCategory] = $prescription-category#regular "定期"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T12:00:00+09:00"
* occurrenceDateTime = "2026-04-02"
* reasonReference = Reference(Condition/example-condition)
* orderDetail[0].text = "RP1-1"
* orderDetail[0].extension[medicationRequest].valueReference = Reference(MedicationRequest/example-prescription-medication-request)
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderWard].valueReference = Reference(Location/example-ward)

Instance: example-prescription-medication-request
InstanceOf: FC_PrescriptionMedicationRequest
Usage: #example
Title: "処方の薬剤行の例"
* status = #active
* intent = #order
* identifier[rpNumber].system = $mhlw-RPGroupNumber
* identifier[rpNumber].value = "1"
* identifier[orderInRp].system = $mhlw-MedicationAdministrationIndex
* identifier[orderInRp].value = "1"
* basedOn = Reference(ServiceRequest/example-prescription-order)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-01T12:00:00+09:00"
* requester = Reference(Practitioner/example-practitioner)
* medicationCodeableConcept.coding[receiptCode] = $medicine-code#622000000 "メトホルミン塩酸塩錠250mg"
* medicationCodeableConcept.coding[yjCode] = $YJ-code#3962002F1029
* medicationCodeableConcept.text = "メトホルミン塩酸塩錠250mg"
* dosageInstruction.timing.code.coding[usage] = $medicine-usage#1013044400000000 "1日3回朝昼夕食後"
* dosageInstruction.timing.code.coding[basicCategory] = $medicine-usage-basic-category#1 "内服"
* dosageInstruction.timing.code.text = "1日3回朝昼夕食後"
* dosageInstruction.doseAndRate.doseQuantity.value = 3
* dosageInstruction.doseAndRate.doseQuantity.unit = "錠"
* dispenseRequest.expectedSupplyDuration = 14 'd' "日"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderWard].valueReference = Reference(Location/example-ward)

Instance: example-injection-order
InstanceOf: FC_InjectionOrder
Usage: #example
Title: "注射オーダー(1 日分)の例"
* status = #active
* intent = #order
* category[orderType] = $order-type#injection "注射"
* category[setting] = $prescription-setting#inpatient "入院"
* category[injectionCategory] = http://fhir-client.local/CodeSystem/injection-category#regular "定時"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* requisition.system = "http://fhir-client.local/Identifier/injection-series"
* requisition.value = "7c1c1a8e-2d1f-4d0c-9c7a-1b2c3d4e5f60"
* authoredOn = "2026-04-01T12:10:00+09:00"
* occurrenceDateTime = "2026-04-02"
* orderDetail[0].text = "RP1-1"
* orderDetail[0].extension[medicationRequest].valueReference = Reference(MedicationRequest/example-injection-medication-request)
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderWard].valueReference = Reference(Location/example-ward)
* extension[seriesStart].valueDate = "2026-04-02"
* extension[seriesSchedule].valueTiming.repeat.boundsPeriod.start = "2026-04-02"
* extension[seriesSchedule].valueTiming.repeat.boundsPeriod.end = "2026-04-04"
* extension[seriesSchedule].valueTiming.repeat.period = 1
* extension[seriesSchedule].valueTiming.repeat.periodUnit = #d

Instance: example-injection-medication-request
InstanceOf: FC_InjectionMedicationRequest
Usage: #example
Title: "注射の薬剤行の例"
* status = #active
* intent = #order
* identifier[rpNumber].system = $mhlw-RPGroupNumber
* identifier[rpNumber].value = "1"
* identifier[orderInRp].system = $mhlw-MedicationAdministrationIndex
* identifier[orderInRp].value = "1"
* basedOn = Reference(ServiceRequest/example-injection-order)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-01T12:10:00+09:00"
* requester = Reference(Practitioner/example-practitioner)
* medicationCodeableConcept.coding[receiptCode] = $medicine-code#620009999 "生理食塩液 500mL"
* medicationCodeableConcept.coding[yjCode] = $YJ-code#3311401A4064
* medicationCodeableConcept.text = "生理食塩液 500mL"
* dosageInstruction.text = "点滴静注 1日1回 10:00 60mL/h"
* dosageInstruction.extension[usageType].valueCodeableConcept = http://fhir-client.local/CodeSystem/injection-usage-type#drip "点滴"
* dosageInstruction.extension[line].valueCodeableConcept = http://fhir-client.local/CodeSystem/injection-line#peripheral "末梢ルート"
* dosageInstruction.extension[scheduledPeriod][0].extension[start].valueDateTime = "2026-04-02T10:00:00+09:00"
* dosageInstruction.extension[scheduledPeriod][0].extension[end].valueDateTime = "2026-04-02T18:20:00+09:00"
* dosageInstruction.timing.event = "2026-04-02T10:00:00+09:00"
* dosageInstruction.route = $JP_route-codes#IV "静脈内"
* dosageInstruction.doseAndRate.doseQuantity.value = 500
* dosageInstruction.doseAndRate.doseQuantity.unit = "mL"
* dosageInstruction.doseAndRate.rateQuantity = 60 'mL/h' "mL/h"

Instance: example-medication-dispense
InstanceOf: FC_MedicationDispense
Usage: #example
Title: "調剤の例"
* status = #completed
* subject = Reference(Patient/example-patient)
* authorizingPrescription = Reference(MedicationRequest/example-prescription-medication-request)
* medicationCodeableConcept.coding[0] = $medicine-code#622000000 "メトホルミン塩酸塩錠250mg"
* medicationCodeableConcept.coding[1] = $YJ-code#3962002F1029
* medicationCodeableConcept.text = "メトホルミン塩酸塩錠250mg"
* quantity.value = 42
* quantity.unit = "錠"
* daysSupply = 14 'd' "日"
* whenHandedOver = "2026-04-01T15:00:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)
* substitution.wasSubstituted = false

Instance: example-oral-administration-procedure
InstanceOf: FC_OralAdministrationProcedure
Usage: #example
Title: "与薬記録の例"
* status = #completed
* category.coding[orderType] = $order-type#prescription "処方"
* code.text = "与薬"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* basedOn = Reference(ServiceRequest/example-prescription-order)
* performedDateTime = "2026-04-02T08:05:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)
* extension[scheduleSlot].valueDateTime = "2026-04-02T08:00:00+09:00"

Instance: example-medication-administration
InstanceOf: FC_MedicationAdministration
Usage: #example
Title: "薬剤投与(与薬)の例"
* status = #completed
* subject = Reference(Patient/example-patient)
* partOf = Reference(Procedure/example-oral-administration-procedure)
* request = Reference(MedicationRequest/example-prescription-medication-request)
* medicationCodeableConcept.coding[0] = $medicine-code#622000000 "メトホルミン塩酸塩錠250mg"
* medicationCodeableConcept.coding[1] = $YJ-code#3962002F1029
* medicationCodeableConcept.text = "メトホルミン塩酸塩錠250mg"
* effectiveDateTime = "2026-04-02T08:05:00+09:00"
* dosage.dose.value = 1
* dosage.dose.unit = "錠"
* performer.actor = Reference(Practitioner/example-practitioner)

Instance: example-injection-procedure
InstanceOf: FC_InjectionProcedure
Usage: #example
Title: "注射 実施記録の例"
* status = #completed
* category.coding[orderType] = $order-type#injection "注射"
* code.text = "注射"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-injection-order)
* performedPeriod.start = "2026-04-02T10:05:00+09:00"
* performedPeriod.end = "2026-04-02T18:30:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)

Instance: example-brought-medication
InstanceOf: FC_BroughtMedication
Usage: #example
Title: "持参薬の例(鑑別済・継続)"
* status = #active
* category = $medication-statement-category#community
* medicationCodeableConcept.coding[0] = $medicine-code#620004321 "アムロジピン錠5mg"
* medicationCodeableConcept.coding[1] = $YJ-code#2171022F2010
* medicationCodeableConcept.text = "アムロジピン錠5mg"
* subject = Reference(Patient/example-patient)
* context = Reference(Encounter/example-encounter)
* informationSource = Reference(Practitioner/example-practitioner)
* dateAsserted = "2026-04-01T12:00:00+09:00"
* dosage.timing.code.text = "1日1回朝食後"
* dosage.doseAndRate.doseQuantity.value = 1
* dosage.doseAndRate.doseQuantity.unit = "錠"
* statusReason = http://fhir-client.local/CodeSystem/brought-medication-decision#continue "継続"
* extension[info].extension[source].valueString = "お薬手帳"
* extension[info].extension[prescriber].valueString = "○○クリニック"
* extension[info].extension[broughtQuantity].valueQuantity.value = 14
* extension[info].extension[broughtQuantity].valueQuantity.unit = "錠"
* extension[identification].extension[identifiedBy].valueReference = Reference(Practitioner/example-practitioner)
* extension[identification].extension[identifiedAt].valueDateTime = "2026-04-01T15:00:00+09:00"
* extension[identification].extension[remainingDays].valueQuantity = 14 'd' "日"
* extension[identification].extension[substitution].valueCode = #same
* extension[decision].extension[decidedBy].valueReference = Reference(Practitioner/example-practitioner)
* extension[decision].extension[decidedAt].valueDateTime = "2026-04-01T17:00:00+09:00"
* extension[decision].extension[convertedOrder].valueReference = Reference(ServiceRequest/example-prescription-order)

Instance: example-regimen-order
InstanceOf: FC_RegimenOrder
Usage: #example
Title: "化学療法レジメン適用の例"
* status = #active
* intent = #plan
* identifier[regimenInstance].system = "http://fhir-client.local/Identifier/regimen-instance"
* identifier[regimenInstance].value = "0a1b2c3d-4e5f-4a6b-8c7d-9e0f1a2b3c4d"
* instantiatesUri = "http://fhir-client.local/regimen/mFOLFOX6"
* category[orderType] = $order-type#chemo-regimen "化学療法"
* category[setting] = $prescription-setting#outpatient "外来"
* code = http://fhir-client.local/CodeSystem/regimen#mFOLFOX6 "mFOLFOX6"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T14:00:00+09:00"
* occurrenceDateTime = "2026-04-08"
* reasonReference = Reference(Condition/example-condition)
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[regimen].extension[cycleDays].valueInteger = 14
* extension[regimen].extension[treatmentDays].valueInteger = 2
* extension[regimen].extension[plannedCycles].valueInteger = 12
* extension[regimen].extension[bsa].valueDecimal = 1.65
* extension[regimen].extension[height].valueDecimal = 168.0
* extension[regimen].extension[weight].valueDecimal = 60.0
