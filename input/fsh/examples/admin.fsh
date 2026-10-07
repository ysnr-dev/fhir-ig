// 管理リソース(shared.fsh に無いもの)と予約の例。

Instance: example-practitioner-base-role
InstanceOf: FC_PractitionerBaseRole
Usage: #example
Title: "職種ロール(基本)の例"
Description: "職種ロール(基本)の例"
* active = true
* practitioner = Reference(Practitioner/example-practitioner)
* organization = Reference(Organization/example-organization)
* code = http://fhir-client.local/CodeSystem/practitioner-role#doctor "医師"

Instance: example-practitioner-department-role
InstanceOf: FC_PractitionerDepartmentRole
Usage: #example
Title: "診療科ロールの例"
Description: "診療科ロールの例"
* active = true
* practitioner = Reference(Practitioner/example-practitioner)
* organization = Reference(Organization/example-department)
* specialty = $ssmix2-department#01 "内科"
* extension[primaryDepartment].valueBoolean = true

Instance: example-hospital-room
InstanceOf: FC_HospitalRoom
Usage: #example
Title: "病室の例(個室)"
Description: "病室の例(個室)"
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
Description: "診察室の例"
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
Description: "予約枠の定義の例"
* active = true
* serviceType = http://fhir-client.local/CodeSystem/schedule-service-type#consultation "診察予約"
* serviceType.text = "内科 午前"
* specialty = $ssmix2-department#01 "内科"
* actor[0] = Reference(Practitioner/example-practitioner)
* actor[1] = Reference(Location/example-outpatient-room)
* planningHorizon.start = "2026-04-01T00:00:00+09:00"
* planningHorizon.end = "2026-06-30T23:59:00+09:00"
* extension[slotPattern].valueString = "{\"weekdays\":[1,2,3,4,5],\"blocks\":[{\"start\":\"09:00\",\"end\":\"12:00\"}],\"durationMinutes\":15,\"capacity\":1}"

Instance: example-slot
InstanceOf: FC_Slot
Usage: #example
Title: "予約枠の例"
Description: "予約枠の例"
* schedule = Reference(Schedule/example-schedule)
* status = #busy
* start = "2026-04-03T09:00:00+09:00"
* end = "2026-04-03T09:15:00+09:00"
* appointmentType = $v2-0276#ROUTINE

Instance: example-appointment
InstanceOf: FC_Appointment
Usage: #example
Title: "予約の例(診察終了)"
Description: "予約の例(診察終了)"
* status = #fulfilled
* appointmentType = $v2-0276#ROUTINE "通常"
* serviceType = http://fhir-client.local/CodeSystem/schedule-service-type#consultation "診察予約"
* serviceType.text = "内科 午前"
* specialty = $ssmix2-department#01 "内科"
* description = "内科 午前"
* start = "2026-04-03T09:00:00+09:00"
* end = "2026-04-03T09:15:00+09:00"
* minutesDuration = 15
* slot = Reference(Slot/example-slot)
* participant[0].actor = Reference(Patient/example-patient)
* participant[0].required = #required
* participant[0].status = #accepted
* participant[+].actor = Reference(Practitioner/example-practitioner)
* participant[=].required = #required
* participant[=].status = #accepted
* participant[+].actor = Reference(Location/example-outpatient-room)
* participant[=].required = #required
* participant[=].status = #accepted
* reasonReference = Reference(Condition/example-condition)
* extension[checkedInAt].valueDateTime = "2026-04-03T08:50:00+09:00"
* extension[visitKind].valueCode = #revisit

Instance: example-outpatient-encounter
InstanceOf: FC_OutpatientEncounter
Usage: #example
Title: "外来受診の例"
Description: "外来受診の例"
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
Description: "保険(レセコン取込)の例"
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
Description: "保険病名の例"
* clinicalStatus = $condition-clinical#active "継続"
* verificationStatus = $condition-ver-status#confirmed
* category = $condition-category#encounter-diagnosis
* code.coding[0] = $medis-disease-keyNumber#20050020
* code.coding[1] = $medis-disease-exCode#U23V
* code.coding[2] = $mhlw-masterB-disease#2500015
* code.coding[3] = $mhlw-ICD10#E119
* code.text = "2型糖尿病"
* subject = Reference(Patient/example-patient)
* onsetDateTime = "2024-04-01"

Instance: example-past-history
InstanceOf: FC_PastHistory
Usage: #example
Title: "既往歴の例"
Description: "既往歴の例"
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
Description: "アレルギーの例"
* clinicalStatus = $allergy-clinical#active
* verificationStatus = $allergy-verification#confirmed
* type = #allergy
* category = #food
* criticality = #high
* code = http://jpfhir.jp/fhir/core/CodeSystem/JP_JfagyFoodAllergen_CS#00F "食品"
* code.text = "そば"
* patient = Reference(Patient/example-patient)
* recordedDate = "2026-04-01"
* reaction.manifestation.text = "蕁麻疹"

Instance: example-flag
InstanceOf: FC_Flag
Usage: #example
Title: "患者の注意情報の例"
Description: "患者の注意情報の例"
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
Description: "オーダーの来歴の例(代行入力)"
* target = Reference(ServiceRequest/example-lab-order-header)
* recorded = "2026-04-01T09:00:00+09:00"
* activity = $v3-DataOperation#CREATE
* agent[0].type = $provenance-participant-type#author
* agent[0].who = Reference(Practitioner/example-practitioner)
* agent[1].type = $provenance-participant-type#enterer
* agent[1].who = Reference(Practitioner/example-nurse)
* agent[1].onBehalfOf = Reference(Practitioner/example-practitioner)

Instance: example-trainee-order-provenance
InstanceOf: FC_OrderProvenance
Usage: #example
Title: "オーダーの来歴の例(研修医の入力)"
Description: "研修医が自分を依頼医として入れたオーダーの来歴。author.role = trainee-level#resident で、指導医の承認待ちになる。"
* target = Reference(ServiceRequest/example-lab-order-header)
* recorded = "2026-04-01T11:00:00+09:00"
* activity = $v3-DataOperation#CREATE
* agent[0].type = $provenance-participant-type#author
* agent[0].role = http://fhir-client.local/CodeSystem/trainee-level#resident
* agent[0].who = Reference(Practitioner/example-resident)
* agent[1].type = $provenance-participant-type#enterer
* agent[1].who = Reference(Practitioner/example-resident)
* agent[1].who.display = "研修 太郎"
* agent[1].onBehalfOf = Reference(Practitioner/example-resident)

Instance: example-review-provenance
InstanceOf: FC_ReviewProvenance
Usage: #example
Title: "結果確認の来歴の例"
Description: "結果確認の来歴の例"
* target = Reference(DiagnosticReport/example-lab-diagnostic-report)
* recorded = "2026-04-02T13:00:00+09:00"
* agent[0].type = $provenance-participant-type#verifier
* agent[0].who = Reference(Practitioner/example-practitioner)
* signature.type = $signature-type#1.2.840.10065.1.12.1.5 "Verification Signature"
* signature.when = "2026-04-02T13:00:00+09:00"
* signature.who = Reference(Practitioner/example-practitioner)

Instance: example-patient-unidentified
InstanceOf: FC_Patient
Usage: #example
Title: "身元不明で仮登録した患者の例"
Description: "身元不明で仮登録した患者の例"
* meta.tag = http://fhir-client.local/CodeSystem/patient-tag#unidentified "身元不明"
* identifier.system = $JP_MRN
* identifier.value = "00000099"
* name[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-representation"
* name[0].extension[0].valueCode = #IDE
* name[0].family = "不明"
* name[0].given = "男0403-2140"
* name[1].extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-EN-representation"
* name[1].extension[0].valueCode = #SYL
* name[1].family = "フメイ"
* gender = #male
* active = true

Instance: example-emergency-bed
InstanceOf: FC_Room
Usage: #example
Title: "救急の処置ベッドの例"
Description: "救急の処置ベッドの例"
* status = #active
* name = "ER 処置ベッド 1"
* mode = #instance
* type = $v3-RoleCode#ER "救急"
* physicalType = $location-physical-type#ro
* managingOrganization = Reference(Organization/example-organization)
* extension[displayOrder].valueInteger = 1

Instance: example-emergency-encounter
InstanceOf: FC_EmergencyEncounter
Usage: #example
Title: "救急受診の例(診察中)"
Description: "救急受診の例(診察中)"
* status = #in-progress
* statusHistory[0].status = #arrived
* statusHistory[0].period.start = "2026-04-03T21:40:00+09:00"
* statusHistory[0].period.end = "2026-04-03T21:45:00+09:00"
* statusHistory[1].status = #triaged
* statusHistory[1].period.start = "2026-04-03T21:45:00+09:00"
* statusHistory[1].period.end = "2026-04-03T21:55:00+09:00"
* class = $v3-ActCode#EMER "emergency"
* subject = Reference(Patient/example-patient)
* subject.display = "テスト 太郎"
* period.start = "2026-04-03T21:40:00+09:00"
* hospitalization.admitSource = http://fhir-client.local/CodeSystem/emergency-arrival-mode#ambulance "救急車"
* reasonCode.text = "胸痛"
* participant[0].type = $v3-ParticipationType#ATND "attender"
* participant[0].individual = Reference(Practitioner/example-practitioner)
* participant[0].individual.display = "山田 一郎"
* location[0].location = Reference(Location/example-emergency-bed)
* location[0].location.display = "ER 処置ベッド 1"
* location[0].status = #active
* extension[triageLevel].valueInteger = 2

Instance: example-triage-observation
InstanceOf: FC_TriageObservation
Usage: #example
Title: "トリアージ(JTAS)の判定記録の例"
Description: "トリアージ(JTAS)の判定記録の例"
* status = #final
* category = $obs-category#survey
* code = http://fhir-client.local/CodeSystem/emergency-observation#jtas "JTAS 緊急度判定"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-emergency-encounter)
* effectiveDateTime = "2026-04-03T21:45:00+09:00"
* valueCodeableConcept = http://fhir-client.local/CodeSystem/jtas-level#2 "緊急"
* performer = Reference(Practitioner/example-practitioner)
* performer.display = "山田 一郎"

Instance: example-planned-admission-from-emergency
InstanceOf: FC_InpatientEncounter
Usage: #example
Title: "入院予定の例(救急外来から)"
Description: "入院予定の例(救急外来から)"
* status = #planned
* class = $v3-ActCode#IMP "inpatient encounter"
* subject = Reference(Patient/example-patient)
* subject.display = "テスト 太郎"
* period.start = "2026-04-03"
* location[0].location = Reference(Location/example-ward)
* location[0].location.display = "東3階病棟"
* location[0].status = #planned
* location[0].physicalType = $location-physical-type#wa "Ward"
* serviceProvider = Reference(Organization/example-department)
* serviceProvider.display = "内科"
* participant[0].type = $v3-ParticipationType#ATND "attender"
* participant[0].individual = Reference(Practitioner/example-practitioner)
* hospitalization.admitSource.coding[route] = http://fhir-client.local/CodeSystem/dpc-admission-route#1 "家庭からの入院"
* hospitalization.admitSource.coding[emergency] = $admit-source#emd "救急外来から"
* priority = http://fhir-client.local/CodeSystem/dpc-admission-type#334 "救急医療入院: 心不全で重篤な状態"
* extension[referral].valueBoolean = false
* extension[fromOutpatient].valueBoolean = false
* extension[ambulance].valueBoolean = true
* extension[priorHomeCare].valueCode = #0
* extension[originEmergency].valueReference = Reference(Encounter/example-emergency-encounter)
