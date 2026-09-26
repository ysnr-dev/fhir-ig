// 患者プロファイル・バイタル・看護観察・食事摂取・有害事象・診療記録・退院時サマリー・テンプレート・ファイル・画像の例。

Instance: example-blood-type-observation
InstanceOf: FC_BloodTypeObservation
Usage: #example
Title: "血液型(ABO)の例"
* status = #final
* category = $obs-category#laboratory
* code = $loinc#883-9 "ABO group [Type] in Blood"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-01"
* valueCodeableConcept = http://fhir-client.local/CodeSystem/transfusion-abo#A "A"
* method = http://fhir-client.local/CodeSystem/blood-type-source#tested "検査確定"

Instance: example-pregnancy-observation
InstanceOf: FC_PregnancyObservation
Usage: #example
Title: "妊娠の例"
* status = #final
* category = $obs-category#survey
* code = $loinc#82810-3 "Pregnancy status"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-01"
* valueCodeableConcept = $sct#60001007 "妊娠していない"

Instance: example-infection-observation
InstanceOf: FC_InfectionObservation
Usage: #example
Title: "感染症(手入力)の例"
* status = #final
* category = $obs-category#exam
* code.coding[type] = http://fhir-client.local/CodeSystem/infection-type#hbs "HBs 抗原"
* code.coding[loinc] = $loinc#5195-3
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-01"
* valueCodeableConcept = http://fhir-client.local/CodeSystem/infection-result#negative "陰性"
* method = http://fhir-client.local/CodeSystem/infection-source#referred "他院からの情報"

Instance: example-vital-observation
InstanceOf: FC_VitalObservation
Usage: #example
Title: "バイタル(血圧)の例"
* status = #final
* identifier.system = "http://fhir-client.local/vital-entry"
* identifier.value = "5a4b3c2d-1e0f-4a9b-8c7d-6e5f4a3b2c1d"
* category = $obs-category#vital-signs
* code = $loinc#85354-9 "Blood pressure panel with all children optional"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-02T06:00:00+09:00"
* performer = Reference(Practitioner/example-practitioner)
* component[0].code = $loinc#8480-6 "Systolic blood pressure"
* component[0].valueQuantity = 128 'mm[Hg]' "mmHg"
* component[1].code = $loinc#8462-4 "Diastolic blood pressure"
* component[1].valueQuantity = 78 'mm[Hg]' "mmHg"
* extension[problem].valueReference = Reference(Condition/example-condition)

Instance: example-nursing-observation
InstanceOf: FC_NursingObservation
Usage: #example
Title: "看護観察 記録(体温)の例"
* status = #final
* identifier.system = "http://fhir-client.local/nursing-perform-entry"
* identifier.value = "9d8c7b6a-5f4e-4d3c-8b2a-1f0e9d8c7b6a"
* category = $order-type#nursing "看護指示"
* code.coding[medis] = $medis-nursing-observation#31001368 "体温"
* code.coding[loinc] = $loinc#8310-5 "Body temperature"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* basedOn = Reference(ServiceRequest/example-nursing-order)
* effectiveDateTime = "2026-04-02T10:00:00+09:00"
* performer = Reference(Practitioner/example-practitioner)
* valueQuantity = 36.8 'Cel' "℃"

Instance: example-meal-intake-observation
InstanceOf: FC_MealIntakeObservation
Usage: #example
Title: "食事摂取量の例"
* status = #final
* category = $order-type#meal "食事"
* code = $medis-nursing-observation#31003419 "主食摂取量"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-meal-order)
* effectiveDateTime = "2026-04-02T08:00:00+09:00"
* valueQuantity = 80 '%' "%"

Instance: example-adverse-event-observation
InstanceOf: FC_AdverseEventObservation
Usage: #example
Title: "有害事象(CTCAE)の例"
* status = #final
* category = http://fhir-client.local/CodeSystem/observation-category#adverse-event "有害事象"
* code.text = "末梢性感覚ニューロパチー"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-regimen-order)
* effectivePeriod.start = "2026-04-20"
* valueInteger = 2
* performer = Reference(Practitioner/example-practitioner)
* extension[treatmentContext].extension[type].valueCode = #chemo-regimen
* extension[treatmentContext].extension[name].valueString = "mFOLFOX6"
* extension[treatmentContext].extension[cycle].valueInteger = 2

Instance: example-clinical-note
InstanceOf: FC_ClinicalNote
Usage: #example
Title: "診療記録の例"
* status = #final
* type = $loinc#11506-3 "Progress note"
* subject = Reference(Patient/example-patient)
* date = "2026-04-02T10:00:00+09:00"
* author = Reference(Practitioner/example-practitioner)
* title = "診療記録"
* attester.mode = #legal
* attester.time = "2026-04-02T10:05:00+09:00"
* attester.party = Reference(Practitioner/example-practitioner)
* section[0].code = $loinc#11450-4 "Problem list"
* section[0].text.status = #generated
* section[0].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">#1 2型糖尿病</div>"
* section[0].entry = Reference(Condition/example-condition)
* section[1].code = $loinc#61150-9 "Subjective"
* section[1].text.status = #additional
* section[1].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>口渇なし。</p></div>"
* section[2].code = $loinc#18776-5 "Plan"
* section[2].text.status = #additional
* section[2].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>メトホルミン継続。</p></div>"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)

Instance: example-discharge-summary
InstanceOf: FC_DischargeSummary
Usage: #example
Title: "退院時サマリーの例"
* status = #final
* type = $loinc#18842-5 "Discharge summary"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* date = "2026-04-20T15:00:00+09:00"
* author = Reference(Practitioner/example-practitioner)
* title = "退院時サマリー"
* attester.mode = #legal
* attester.time = "2026-04-20T15:00:00+09:00"
* attester.party = Reference(Practitioner/example-practitioner)
* section[diagnosis].code = $loinc#11535-2 "Hospital discharge Dx"
* section[diagnosis].text.status = #generated
* section[diagnosis].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">2型糖尿病</div>"
* section[diagnosis].entry = Reference(Condition/example-condition)
* section[course].code = $loinc#8648-8 "Hospital course"
* section[course].text.status = #additional
* section[course].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>血糖コントロール目的に入院。</p></div>"
* section[plan].code = $loinc#18776-5 "Plan"
* section[plan].text.status = #additional
* section[plan].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>外来で経過観察。</p></div>"

Instance: social-01
InstanceOf: FC_Questionnaire
Usage: #example
Title: "テンプレート(社会歴)の例"
* url = "http://fhir-client.local/Questionnaire/social-01"
* version = "1"
* name = "SOCIAL01"
* title = "社会歴"
* status = #active
* subjectType = #Patient
* extension[templateCategory].valueCoding = http://fhir-client.local/CodeSystem/questionnaire-template-category#6f3a9c14-5d02-4e7b-9a83-2c6e1b40d7f5 "基礎データ"
* item[0].linkId = "smoking"
* item[0].text = "喫煙"
* item[0].type = #choice
* item[0].code = $JP_SocialHistoryCode#MD0012870 "喫煙"
* item[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[0].extension[0].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#radio-button
* item[0].answerOption[0].valueCoding.code = #never
* item[0].answerOption[0].valueCoding.display = "なし"
* item[0].answerOption[1].valueCoding.code = #current
* item[0].answerOption[1].valueCoding.display = "現在あり"
* item[1].linkId = "recorder"
* item[1].text = "記入者"
* item[1].type = #string
* item[1].extension[loginAutofill].valueBoolean = true

Instance: example-questionnaire-response-practitioner
InstanceOf: Practitioner
Usage: #inline
* id = "practitioner"
* name.family = "山田"
* name.given = "一郎"

Instance: example-questionnaire-response
InstanceOf: FC_QuestionnaireResponse
Usage: #example
Title: "テンプレートの記入の例"
* identifier.value = "1311234567^00000001^b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e"
* questionnaire = "http://fhir-client.local/Questionnaire/social-01|1"
* status = #completed
* subject = Reference(Patient/example-patient)
* authored = "2026-04-02T10:00:00+09:00"
* contained[0] = example-questionnaire-response-practitioner
* author = Reference(example-questionnaire-response-practitioner)
* item[0].linkId = "smoking"
* item[0].answer.valueCoding.code = #never
* item[0].answer.valueCoding.display = "なし"
* extension[problem].valueReference = Reference(Condition/example-condition)

Instance: example-extracted-observation
InstanceOf: FC_ExtractedObservation
Usage: #example
Title: "テンプレート記入から抽出した Observation の例"
* status = #final
* category = $obs-category#social-history
* code = $JP_SocialHistoryCode#MD0012870 "喫煙"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-02T10:00:00+09:00"
* derivedFrom = Reference(QuestionnaireResponse/example-questionnaire-response)
* valueCodeableConcept.coding.code = #never
* valueCodeableConcept.coding.display = "なし"

Instance: example-patient-file
InstanceOf: FC_PatientFile
Usage: #example
Title: "患者ファイルの例"
* status = #current
* subject = Reference(Patient/example-patient)
* date = "2026-04-01T00:00:00+09:00"
* category = http://fhir-client.local/CodeSystem/file-category#2f7c1b3a-9d4e-4c5b-8a6f-1e2d3c4b5a69 "紹介状"
* category.text = "紹介状"
* author = Reference(Practitioner/example-practitioner)
* content.attachment.contentType = #application/pdf
* content.attachment.url = "Binary/example-binary"
* content.attachment.title = "紹介状.pdf"
* content.attachment.size = 123456

Instance: example-imaging-study
InstanceOf: FC_ImagingStudy
Usage: #example
Title: "DICOM スタディの例"
* identifier[0].system = "urn:dicom:uid"
* identifier[0].value = "urn:oid:1.2.392.200036.9116.2.6.1.48.1214245490.1712100000.123456"
* identifier[1].type = $v2-0203#ACSN
* identifier[1].value = "A20260403001"
* status = #available
* subject = Reference(Patient/example-patient)
* started = "2026-04-03T10:10:00+09:00"
* modality = $dicom#CT
* numberOfSeries = 1
* numberOfInstances = 120
* series[0].uid = "1.2.392.200036.9116.2.6.1.48.1214245490.1712100000.123457"
* series[0].number = 1
* series[0].modality = $dicom#CT
* series[0].numberOfInstances = 120
* extension[source].extension[institutionName].valueString = "テスト病院"
* extension[source].extension[patientId].valueString = "00000001"
