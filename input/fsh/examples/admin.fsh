// 管理リソース(shared.fsh に無いもの)と予約の例。

Instance: example-practitioner-base-role
InstanceOf: FC_PractitionerBaseRole
Usage: #example
Title: "職種ロール(基本)の例"
* active = true
* practitioner = Reference(Practitioner/example-practitioner)
* organization = Reference(Organization/example-organization)
* code = http://fhir-client.local/CodeSystem/practitioner-role#doctor "医師"

Instance: example-practitioner-department-role
InstanceOf: FC_PractitionerDepartmentRole
Usage: #example
Title: "診療科ロールの例"
* active = true
* practitioner = Reference(Practitioner/example-practitioner)
* organization = Reference(Organization/example-department)
* specialty = $ssmix2-department#01 "内科"
* extension[primaryDepartment].valueBoolean = true

Instance: example-hospital-room
InstanceOf: FC_HospitalRoom
Usage: #example
Title: "病室の例(個室)"
* status = #active
* name = "302"
* mode = #instance
* type = http://fhir-client.local/CodeSystem/room-class#private "個室"
* physicalType = $location-physical-type#ro
* partOf = Reference(Location/example-ward)

Instance: example-outpatient-room
InstanceOf: FC_Room
Usage: #example
Title: "診察室の例"
* status = #active
* name = "内科 1 診"
* mode = #instance
* type = $v3-RoleCode#OF "外来(診察室)"
* physicalType = $location-physical-type#ro
* managingOrganization = Reference(Organization/example-organization)
* extension[displayOrder].valueInteger = 1

Instance: example-schedule
InstanceOf: FC_Schedule
Usage: #example
Title: "予約枠の定義の例"
* active = true
* serviceType = http://fhir-client.local/CodeSystem/schedule-service-type#consultation "診察予約"
* serviceType.text = "内科 午前"
* specialty = $ssmix2-department#01 "内科"
* actor[0] = Reference(Practitioner/example-practitioner)
* actor[1] = Reference(Location/example-outpatient-room)
* planningHorizon.start = "2026-04-01"
* planningHorizon.end = "2026-06-30"
* extension[slotPattern].valueString = "{\"weekdays\":[1,2,3,4,5],\"blocks\":[{\"start\":\"09:00\",\"end\":\"12:00\"}],\"durationMinutes\":15,\"capacity\":1}"

Instance: example-slot
InstanceOf: FC_Slot
Usage: #example
Title: "予約枠の例"
* schedule = Reference(Schedule/example-schedule)
* status = #busy
* start = "2026-04-03T09:00:00+09:00"
* end = "2026-04-03T09:15:00+09:00"
* appointmentType = $v2-0276#ROUTINE

Instance: example-appointment
InstanceOf: FC_Appointment
Usage: #example
Title: "予約の例"
* status = #booked
* appointmentType = $v2-0276#ROUTINE "通常"
* serviceType = http://fhir-client.local/CodeSystem/schedule-service-type#consultation "診察予約"
* specialty = $ssmix2-department#01 "内科"
* start = "2026-04-03T09:00:00+09:00"
* end = "2026-04-03T09:15:00+09:00"
* minutesDuration = 15
* slot = Reference(Slot/example-slot)
* participant[patient].actor = Reference(Patient/example-patient)
* participant[patient].required = #required
* participant[patient].status = #accepted
* participant[+].actor = Reference(Practitioner/example-practitioner)
* participant[=].required = #required
* participant[=].status = #accepted
* participant[+].actor = Reference(Location/example-outpatient-room)
* participant[=].required = #required
* participant[=].status = #accepted
* reasonReference = Reference(Condition/example-condition)
* extension[checkedInAt].valueDateTime = "2026-04-03T08:50:00+09:00"

Instance: example-outpatient-encounter
InstanceOf: FC_OutpatientEncounter
Usage: #example
Title: "外来受診の例"
* status = #finished
* class = $v3-ActCode#AMB "ambulatory"
* subject = Reference(Patient/example-patient)
* appointment = Reference(Appointment/example-appointment)
* period.start = "2026-04-03T09:05:00+09:00"
* period.end = "2026-04-03T09:20:00+09:00"
* participant[0].type = $v3-ParticipationType#ATND "attender"
* participant[0].individual = Reference(Practitioner/example-practitioner)
* location[0].location = Reference(Location/example-outpatient-room)
* location[0].status = #completed

Instance: example-coverage
InstanceOf: FC_Coverage
Usage: #example
Title: "保険(レセコン取込)の例"
* identifier[0].system = "http://fhir-client.local/integrations/receipt-computer/coverage"
* identifier[0].value = "00000001:0001"
* status = #active
* type = http://fhir-client.local/integrations/receipt-computer/coverage-type#060 "国民健康保険"
* beneficiary = Reference(Patient/example-patient)
* relationship = $subscriber-relationship#self
* period.start = "2025-04-01"
* payor.identifier.system = $JP_InsurerNumber
* payor.identifier.value = "131011"
* payor.display = "千代田区"
* class[0].type = http://fhir-client.local/integrations/receipt-computer/coverage-class#billing-set
* class[0].value = "0001"
* class[0].name = "国保 3 割"
* costToBeneficiary[0].type = $coverage-copay-type#copaypct
* costToBeneficiary[0].valueQuantity = 30 '%' "%"
* order = 1
* extension[0].url = $JP_Coverage_InsuredPersonSymbol
* extension[0].valueString = "千代田"
* extension[1].url = $JP_Coverage_InsuredPersonNumber
* extension[1].valueString = "123456"

Instance: example-encounter-diagnosis
InstanceOf: FC_EncounterDiagnosis
Usage: #example
Title: "保険病名の例"
* clinicalStatus = $condition-clinical#active "継続"
* verificationStatus = $condition-ver-status#confirmed
* category = $condition-category#encounter-diagnosis
* code.coding[0] = $medis-disease-keyNumber#20064990
* code.coding[1] = $medis-disease-exCode#8843955
* code.coding[2] = $mhlw-masterB-disease#8843955
* code.coding[3] = $mhlw-ICD10#E119
* code.text = "2型糖尿病"
* subject = Reference(Patient/example-patient)
* onsetDateTime = "2024-04-01"

Instance: example-past-history
InstanceOf: FC_PastHistory
Usage: #example
Title: "既往歴の例"
* clinicalStatus = $condition-clinical#resolved "治癒"
* verificationStatus = $condition-ver-status#confirmed
* category[problem] = $condition-category#problem-list-item
* category[pastHistory] = http://fhir-client.local/CodeSystem/condition-category#past-history "既往歴"
* code.text = "虫垂炎(手術)"
* subject = Reference(Patient/example-patient)
* onsetDateTime = "2005-06-01"
* abatementDateTime = "2005-06-15"

Instance: example-allergy-intolerance
InstanceOf: FC_AllergyIntolerance
Usage: #example
Title: "アレルギーの例"
* clinicalStatus = $allergy-clinical#active
* verificationStatus = $allergy-verification#confirmed
* type = #allergy
* category = #food
* criticality = #high
* code = http://jpfhir.jp/fhir/core/CodeSystem/JP_JfagyFoodAllergen_CS#F0100000 "そば"
* patient = Reference(Patient/example-patient)
* recordedDate = "2026-04-01"
* reaction.manifestation.text = "蕁麻疹"

Instance: example-flag
InstanceOf: FC_Flag
Usage: #example
Title: "患者の注意情報の例"
* status = #active
* category = http://fhir-client.local/CodeSystem/flag-category#safety "安全"
* code = http://fhir-client.local/CodeSystem/patient-caution#FALL "転倒リスク"
* code.text = "夜間の歩行に付き添いが必要"
* subject = Reference(Patient/example-patient)
* author = Reference(Practitioner/example-practitioner)
* period.start = "2026-04-01"

Instance: example-order-provenance
InstanceOf: FC_OrderProvenance
Usage: #example
Title: "オーダーの来歴の例(代行入力)"
* target = Reference(ServiceRequest/example-lab-order-header)
* recorded = "2026-04-01T09:00:00+09:00"
* activity = $v3-DataOperation#CREATE
* agent[0].type = $provenance-participant-type#author
* agent[0].who = Reference(Practitioner/example-practitioner)
* agent[1].type = $provenance-participant-type#enterer
* agent[1].who = Reference(Practitioner/example-practitioner)
* agent[1].onBehalfOf = Reference(Practitioner/example-practitioner)

Instance: example-review-provenance
InstanceOf: FC_ReviewProvenance
Usage: #example
Title: "結果確認の来歴の例"
* target = Reference(DiagnosticReport/example-lab-diagnostic-report)
* recorded = "2026-04-02T13:00:00+09:00"
* agent[0].type = $provenance-participant-type#verifier
* agent[0].who = Reference(Practitioner/example-practitioner)
* signature.type = $signature-type#1.2.840.10065.1.12.1.5 "Verification Signature"
* signature.when = "2026-04-02T13:00:00+09:00"
* signature.who = Reference(Practitioner/example-practitioner)
