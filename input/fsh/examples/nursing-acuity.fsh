// 重症度、医療・看護必要度の評価の例。

Instance: example-nursing-acuity-observation
InstanceOf: FC_NursingAcuityObservation
Usage: #example
Title: "看護必要度の評価の例(一般病棟用)"
Description: "看護必要度の評価の例(一般病棟用)。A 4 点(呼吸ケア、麻薬の使用(注射剤のみ))・B 3 点・C 1 点(開腹手術)。"
* extension[orderWard].valueReference = Reference(Location/example-ward)
* extension[orderWard].valueReference.display = "東3階病棟"
* status = #final
* category = $obs-category#survey "Survey"
* code = http://fhir-client.local/CodeSystem/nursing-acuity#general-2026 "一般病棟用 重症度、医療・看護必要度Ⅰ(令和8年度)"
* code.text = "看護必要度"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* effectiveDateTime = "2026-04-05"
* performer = Reference(Practitioner/example-nurse)
* performer.display = "看護 花子"
* component[0].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A1
* component[0].valueBoolean = false
* component[1].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A2
* component[1].valueBoolean = true
* component[2].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A3
* component[2].valueBoolean = false
* component[3].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A4
* component[3].valueBoolean = false
* component[4].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A5
* component[4].valueBoolean = false
* component[5].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-1
* component[5].valueBoolean = false
* component[6].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-2
* component[6].valueBoolean = false
* component[7].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-3
* component[7].valueBoolean = true
* component[8].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-4
* component[8].valueBoolean = false
* component[9].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-5
* component[9].valueBoolean = false
* component[10].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-6
* component[10].valueBoolean = false
* component[11].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-7
* component[11].valueBoolean = false
* component[12].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-8
* component[12].valueBoolean = false
* component[13].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-9
* component[13].valueBoolean = false
* component[14].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-10
* component[14].valueBoolean = false
* component[15].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A6-11
* component[15].valueBoolean = false
* component[16].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A7
* component[16].valueBoolean = false
* component[17].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B8
* component[17].valueInteger = 1
* component[18].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B9
* component[18].valueInteger = 1
* component[19].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B9-assist
* component[19].valueBoolean = true
* component[20].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B10
* component[20].valueInteger = 1
* component[21].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B10-assist
* component[21].valueBoolean = false
* component[22].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B11
* component[22].valueInteger = 0
* component[23].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B11-assist
* component[23].valueBoolean = false
* component[24].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B12
* component[24].valueInteger = 1
* component[25].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B12-assist
* component[25].valueBoolean = true
* component[26].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B13
* component[26].valueInteger = 0
* component[27].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B14
* component[27].valueInteger = 0
* component[28].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#C15
* component[28].valueBoolean = false
* component[29].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#C16
* component[29].valueBoolean = false
* component[30].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#C17
* component[30].valueBoolean = true
* component[31].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#C18
* component[31].valueBoolean = false
* component[32].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#C19
* component[32].valueBoolean = false
* component[33].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#C20
* component[33].valueBoolean = false
* component[34].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#C21
* component[34].valueBoolean = false
* component[35].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#C22
* component[35].valueBoolean = false
* component[36].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#C23
* component[36].valueBoolean = false
* component[37].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#A
* component[37].valueInteger = 4
* component[38].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#B
* component[38].valueInteger = 3
* component[39].code = http://fhir-client.local/CodeSystem/nursing-acuity-item#C
* component[39].valueInteger = 1

Instance: example-nursing-acuity-excluded-observation
InstanceOf: FC_NursingAcuityObservation
Usage: #example
Title: "看護必要度の評価の例(対象外)"
Description: "看護必要度の評価の例(対象外の日)。component を持たず dataAbsentReason に理由を書く。"
* extension[orderWard].valueReference = Reference(Location/example-ward)
* extension[orderWard].valueReference.display = "東3階病棟"
* status = #final
* category = $obs-category#survey "Survey"
* code = http://fhir-client.local/CodeSystem/nursing-acuity#general-2026 "一般病棟用 重症度、医療・看護必要度Ⅰ(令和8年度)"
* code.text = "看護必要度"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* effectiveDateTime = "2026-04-06"
* performer = Reference(Practitioner/example-nurse)
* performer.display = "看護 花子"
* dataAbsentReason = http://terminology.hl7.org/CodeSystem/data-absent-reason#not-applicable "Not Applicable"
* dataAbsentReason.text = "短期滞在手術等基本料の対象"
