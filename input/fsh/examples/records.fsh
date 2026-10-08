// 患者プロファイル・バイタル・看護観察・食事摂取・有害事象・診療記録・退院時サマリー・テンプレート・ファイル・画像の例。

Instance: example-blood-type-observation
InstanceOf: FC_BloodTypeObservation
Usage: #example
Title: "血液型(ABO)の例"
Description: "血液型(ABO)の例"
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
Description: "妊娠の例"
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
Description: "感染症(手入力)の例"
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
Description: "バイタル(血圧)の例"
* status = #final
* identifier.system = "http://fhir-client.local/vital-entry"
* identifier.value = "5a4b3c2d-1e0f-4a9b-8c7d-6e5f4a3b2c1d"
* category = $obs-category#vital-signs
* code = $loinc#85354-9 "Blood pressure panel with all children optional"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-01T21:00:00Z"
* component[0].code = $loinc#8480-6 "Systolic blood pressure"
* component[0].valueQuantity = 128 'mm[Hg]' "mmHg"
* component[1].code = $loinc#8462-4 "Diastolic blood pressure"
* component[1].valueQuantity = 78 'mm[Hg]' "mmHg"
* extension[problem].valueReference = Reference(Condition/example-condition)
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderDepartment].valueReference.display = "内科"

Instance: example-nursing-observation
InstanceOf: FC_NursingObservation
Usage: #example
Title: "看護観察 記録の例"
Description: "看護観察 記録の例"
* status = #final
* identifier.system = "http://fhir-client.local/nursing-perform-entry"
* identifier.value = "9d8c7b6a-5f4e-4d3c-8b2a-1f0e9d8c7b6a"
* category = $order-type#nursing "看護指示"
* code.coding[medis] = $medis-nursing-observation#31000525 "努力呼吸"
* code.text = "努力呼吸"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* basedOn = Reference(ServiceRequest/example-nursing-order)
* effectiveDateTime = "2026-04-02T10:00:00+09:00"
* performer = Reference(Practitioner/example-practitioner)
* valueCodeableConcept = http://fhir-client.local/CodeSystem/nursing-observation-result#31000525-01 "なし"
* valueCodeableConcept.text = "なし"

Instance: example-meal-intake-observation
InstanceOf: FC_MealIntakeObservation
Usage: #example
Title: "食事摂取量の例"
Description: "食事摂取量の例"
* status = #final
* category = $order-type#meal "食事"
* code = $medis-nursing-observation#31003419 "食事摂取量（主食）"
* code.text = "食事摂取量（主食）"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-meal-order)
* effectiveDateTime = "2026-04-02T08:00:00+09:00"
* valueQuantity = 80 '%' "%"

Instance: example-adverse-event-observation
InstanceOf: FC_AdverseEventObservation
Usage: #example
Title: "有害事象(CTCAE)の例"
Description: "有害事象(CTCAE)の例"
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
Description: "診療記録の例"
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
Description: "退院時サマリーの例"
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

Instance: example-nursing-clinical-note
InstanceOf: FC_ClinicalNote
Usage: #example
Title: "診療記録の例(看護記録)"
Description: "診療記録の例(看護職が書いた記録。category = clinical-note-category#nursing)"
* status = #final
* type = $loinc#11506-3 "Progress note"
* category = http://fhir-client.local/CodeSystem/clinical-note-category#nursing "看護記録"
* subject = Reference(Patient/example-patient)
* date = "2026-04-03T21:00:00+09:00"
* author = Reference(Practitioner/example-nurse)
* title = "看護記録"
* attester.mode = #legal
* attester.time = "2026-04-03T21:00:00+09:00"
* attester.party = Reference(Practitioner/example-nurse)
* section[0].code = $loinc#77599-9 "Additional documentation"
* section[0].text.status = #additional
* section[0].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>夜間 2 回トイレ歩行。ナースコールあり、付き添いで歩行。</p></div>"

Instance: example-nursing-summary
InstanceOf: FC_NursingSummary
Usage: #example
Title: "看護サマリーの例"
Description: "看護サマリーの例(退院・承認済)"
* status = #final
* type = http://fhir-client.local/CodeSystem/document-type#nursing-summary "看護サマリー"
* type.text = "看護サマリー"
* category = http://fhir-client.local/CodeSystem/nursing-summary-kind#discharge "退院"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* date = "2026-04-20T14:00:00+09:00"
* author = Reference(Practitioner/example-nurse)
* title = "看護サマリー(退院)"
* event.period.start = "2026-04-01"
* event.period.end = "2026-04-20"
* attester[0].mode = #legal
* attester[0].time = "2026-04-20T14:00:00+09:00"
* attester[0].party = Reference(Practitioner/example-nurse)
* attester[1].mode = #official
* attester[1].time = "2026-04-20T16:30:00+09:00"
* attester[1].party = Reference(Practitioner/example-nurse-2)
* section[basic].title = "基本情報"
* section[basic].code = http://fhir-client.local/CodeSystem/nursing-summary-section#basic "Basic information"
* section[basic].text.status = #additional
* section[basic].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>68歳 男性<br/>入院日: 2026-04-01 / 退院日: 2026-04-20<br/>病棟: 東3階病棟<br/>主治医: 山田 一郎<br/>担当看護師: 看護 花子<br/>アレルギー: なし</p></div>"
* section[pastHistory].title = "既往歴"
* section[pastHistory].code = $loinc#11348-0 "History of past illness"
* section[pastHistory].text.status = #additional
* section[pastHistory].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>虫垂炎(手術)(2005-06-01)</p></div>"
* section[conditions].title = "病名"
* section[conditions].code = http://fhir-client.local/CodeSystem/nursing-summary-section#conditions "Conditions"
* section[conditions].text.status = #generated
* section[conditions].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">#1 2型糖尿病</div>"
* section[conditions].entry = Reference(Condition/example-condition)
* section[conditions].entry.display = "#1 2型糖尿病"
* section[nursingProblems].title = "看護問題・計画"
* section[nursingProblems].code = http://fhir-client.local/CodeSystem/nursing-summary-section#nursing-problems "Nursing problems"
* section[nursingProblems].text.status = #generated
* section[nursingProblems].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">#1 転倒転落の危険がある状態<br/>　目標: 移動のときにナースコールを押せる(成果: 転倒を防ぐ行動)(改善)<br/>　OP（観察）: 意識障害の有無<br/>　TP（ケア）: 低床ベッドへ交換する<br/>　評価 2026-04-09: 継続</div>"
* section[nursingProblems].entry = Reference(CarePlan/example-nursing-care-plan)
* section[nursingProblems].entry.display = "#1 転倒転落の危険がある状態\n　目標: 移動のときにナースコールを押せる(成果: 転倒を防ぐ行動)(改善)\n　OP（観察）: 意識障害の有無\n　TP（ケア）: 低床ベッドへ交換する\n　評価 2026-04-09: 継続"
* section[course].title = "看護経過"
* section[course].code = http://fhir-client.local/CodeSystem/nursing-summary-section#nursing-course "Nursing course"
* section[course].text.status = #additional
* section[course].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>入院中の転倒なし。インスリンは血糖スケールで調整し、退院前に自己注射の手技を確認した。</p></div>"
* section[continuingCare].title = "継続看護"
* section[continuingCare].code = http://fhir-client.local/CodeSystem/nursing-summary-section#continuing-care "Continuing nursing care"
* section[continuingCare].text.status = #additional
* section[continuingCare].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>外来で自己注射と低血糖時の対応を再確認する。</p></div>"
* extension[orderWard].valueReference = Reference(Location/example-ward)
* extension[orderWard].valueReference.display = "東3階病棟"

Instance: social-01
InstanceOf: FC_Questionnaire
Usage: #example
Title: "テンプレート(社会歴)の例"
Description: "テンプレート(社会歴)の例"
* url = "http://fhir-client.local/Questionnaire/social-01"
* version = "1.0.0"
* name = "SOCIAL_01"
* title = "社会歴"
* status = #active
* subjectType = #Patient
* description = "同梱テンプレート「社会歴」の抜粋(喫煙歴と記入者だけ)。"
* extension[templateCategory].valueCoding = http://fhir-client.local/CodeSystem/questionnaire-template-category#6f3a9c14-5d02-4e7b-9a83-2c6e1b40d7f5 "基礎データ"
* extension[1].url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-observationExtract"
* extension[1].valueBoolean = true
* extension[2].url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-observation-extract-category"
* extension[2].valueCodeableConcept = $obs-category#social-history
* item[0].linkId = "grp_smoking"
* item[0].text = "喫煙"
* item[0].type = #group
* item[0].item[0].linkId = "smoke_hist"
* item[0].item[0].text = "喫煙歴"
* item[0].item[0].type = #choice
* item[0].item[0].code = $JP_SocialHistoryCode#MD0012870 "喫煙歴.有無"
* item[0].item[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[0].item[0].extension[0].valueCodeableConcept = http://hl7.org/fhir/CodeSystem/questionnaire-item-control#radio-button
* item[0].item[0].extension[1].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
* item[0].item[0].extension[1].valueCode = #horizontal
* item[0].item[0].answerOption[0].valueCoding.code = #01
* item[0].item[0].answerOption[0].valueCoding.display = "無"
* item[0].item[0].answerOption[1].valueCoding.code = #02
* item[0].item[0].answerOption[1].valueCoding.display = "有"
* item[0].item[0].answerOption[2].valueCoding.code = #09
* item[0].item[0].answerOption[2].valueCoding.display = "不明"
* item[1].linkId = "grp_recorder"
* item[1].text = "記入者"
* item[1].type = #group
* item[1].item[0].linkId = "recorder_name"
* item[1].item[0].text = "氏名"
* item[1].item[0].type = #string
* item[1].item[0].extension[0].url = "http://fhir-client.local/StructureDefinition/questionnaire-practitioner-field"
* item[1].item[0].extension[0].valueCode = #name
* item[1].item[0].extension[1].url = "http://fhir-client.local/StructureDefinition/questionnaire-login-autofill"
* item[1].item[0].extension[1].valueBoolean = true

Instance: example-questionnaire-response-practitioner
InstanceOf: Practitioner
Usage: #inline
* id = "practitioner"
* name.text = "山田 一郎"

Instance: example-questionnaire-response
InstanceOf: FC_QuestionnaireResponse
Usage: #example
Title: "テンプレートの記入の例"
Description: "テンプレートの記入の例"
* identifier.value = "1311234567^00000001^b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e"
* questionnaire = "http://fhir-client.local/Questionnaire/social-01|1.0.0"
* status = #completed
* subject = Reference(Patient/example-patient)
* authored = "2026-04-02T10:00:00+09:00"
* contained[0] = example-questionnaire-response-practitioner
* author = Reference(example-questionnaire-response-practitioner)
* item[0].linkId = "grp_smoking"
* item[0].item[0].linkId = "smoke_hist"
* item[0].item[0].answer.valueCoding.code = #01
* item[0].item[0].answer.valueCoding.display = "無"
* item[1].linkId = "grp_recorder"
* item[1].item[0].linkId = "recorder_name"
* item[1].item[0].answer.valueString = "山田 一郎"
* extension[problem].valueReference = Reference(Condition/example-condition)
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderDepartment].valueReference.display = "内科"

Instance: example-extracted-observation
InstanceOf: FC_ExtractedObservation
Usage: #example
Title: "テンプレート記入から抽出した Observation の例"
Description: "テンプレート記入から抽出した Observation の例"
* status = #final
* category = $obs-category#social-history
* code = $JP_SocialHistoryCode#MD0012870 "喫煙歴.有無"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-02T10:00:00+09:00"
* derivedFrom = Reference(QuestionnaireResponse/example-questionnaire-response)
* valueCodeableConcept.coding.code = #01
* valueCodeableConcept.coding.display = "無"

Instance: example-patient-file
InstanceOf: FC_PatientFile
Usage: #example
Title: "患者ファイルの例"
Description: "患者ファイルの例"
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

Instance: example-patient-document
InstanceOf: FC_PatientFile
Usage: #example
Title: "文書作成で作った文書の例"
Description: "文書作成で作った文書の例"
* status = #current
* type = http://fhir-client.local/CodeSystem/document-template#7b0e6a52-3c1d-4f8e-9a2b-5d4c3b2a1f60 "診断書"
* type.text = "診断書"
* subject = Reference(Patient/example-patient)
* date = "2026-04-03T00:00:00+09:00"
* category = http://fhir-client.local/CodeSystem/file-category#5c2d7e1f-8a3b-4d6c-9e0f-1a2b3c4d5e6f "診断書・証明書"
* category.text = "診断書・証明書"
* author = Reference(Practitioner/example-practitioner)
* author.display = "山田 一郎"
* content.attachment.contentType = #application/vnd.openxmlformats-officedocument.wordprocessingml.document
* content.attachment.url = "Binary/example-document-binary"
* content.attachment.title = "診断書.docx"
* content.attachment.size = 23456

Instance: example-dpc-form1-response
InstanceOf: FC_DpcForm1Response
Usage: #example
Title: "DPC 様式1 の例(下書き)"
Description: "DPC 様式1 の例(下書き)"
* identifier.value = "1311234567^00000001^0d6f1c2e-5b4a-4e3d-8c7b-9a0b1c2d3e4f"
* questionnaire = "http://fhir-client.local/Questionnaire/dpc-form1"
* status = #in-progress
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* authored = "2026-04-10T15:00:00+09:00"
* contained[0] = example-questionnaire-response-practitioner
* author = Reference(example-questionnaire-response-practitioner)
* item[0].linkId = "header"
* item[0].item[0].linkId = "header.facility"
* item[0].item[0].answer.valueString = "131234567"
* item[0].item[1].linkId = "header.dataId"
* item[0].item[1].answer.valueString = "0000000001"
* item[0].item[2].linkId = "header.admitDate"
* item[0].item[2].answer.valueString = "20260401"
* item[0].item[3].linkId = "header.count"
* item[0].item[3].answer.valueString = "1"
* item[0].item[4].linkId = "header.summaryNo"
* item[0].item[4].answer.valueString = "0"
* item[0].item[5].linkId = "header.fiscalYear"
* item[0].item[5].answer.valueString = "2025"
* item[1].linkId = "A000010"
* item[1].text = "患者属性"
* item[1].item[0].linkId = "A000010.ver"
* item[1].item[0].answer.valueString = "20140401"
* item[1].item[1].linkId = "A000010.seq"
* item[1].item[1].answer.valueString = "0"
* item[1].item[2].linkId = "A000010.p1"
* item[1].item[2].answer.valueString = "19600101"
* item[1].item[3].linkId = "A000010.p2"
* item[1].item[3].answer.valueString = "1"
* item[2].linkId = "A006010"
* item[2].text = "診断情報/主傷病"
* item[2].item[0].linkId = "A006010.ver"
* item[2].item[0].answer.valueString = "20140401"
* item[2].item[1].linkId = "A006010.seq"
* item[2].item[1].answer.valueString = "0"
* item[2].item[2].linkId = "A006010.p2"
* item[2].item[2].answer.valueString = "E119"
* item[2].item[3].linkId = "A006010.p4"
* item[2].item[3].answer.valueString = "2500015"
* item[2].item[4].linkId = "A006010.p9"
* item[2].item[4].answer.valueString = "2型糖尿病"
* item[2].item[5].linkId = "A006010.ref"
* item[2].item[5].answer.valueReference = Reference(Condition/example-condition)

Instance: example-dpc-coding-practitioner
InstanceOf: Practitioner
Usage: #inline
* id = "practitioner"
* identifier.system = "http://fhir-client.local/Practitioner"
* identifier.value = "example-practitioner"
* name.text = "山田 一郎"

Instance: example-dpc-coding-response
InstanceOf: FC_DpcCodingResponse
Usage: #example
Title: "DPC 診断群分類の決定の例(入院時)"
Description: "DPC 診断群分類の決定の例(入院時)"
* identifier.value = "1311234567^00000001^5e1f0a3b-7c2d-4e8f-9a6b-1c2d3e4f5a6b"
* questionnaire = "http://fhir-client.local/Questionnaire/dpc-coding"
* status = #completed
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* authored = "2026-08-27T10:00:00+09:00"
* contained[0] = example-dpc-coding-practitioner
* author = Reference(example-dpc-coding-practitioner)
* author.display = "山田 一郎"
* item[0].linkId = "dpc-code"
* item[0].answer.valueCoding = http://fhir-client.local/CodeSystem/dpc-code#060330xx02xxxx "胆嚢疾患（胆嚢結石など） / 腹腔鏡下胆嚢摘出術等"
* item[1].linkId = "edition"
* item[1].answer.valueString = "20260601"
* item[2].linkId = "timing"
* item[2].answer.valueCoding = http://fhir-client.local/CodeSystem/dpc-coding-timing#admission "入院時"
* item[3].linkId = "bundled"
* item[3].answer.valueBoolean = true
* item[4].linkId = "days"
* item[4].answer[0].valueInteger = 3
* item[4].answer[1].valueInteger = 6
* item[4].answer[2].valueInteger = 30
* item[5].linkId = "points"
* item[5].answer[0].valueInteger = 3187
* item[5].answer[1].valueInteger = 1973
* item[5].answer[2].valueInteger = 1820
* item[6].linkId = "icd10"
* item[6].answer.valueString = "K802"
* item[7].linkId = "branch"
* item[7].item[0].linkId = "branch.key"
* item[7].item[0].answer.valueString = "surgery"
* item[7].item[1].linkId = "branch.label"
* item[7].item[1].answer.valueString = "手術"
* item[7].item[2].linkId = "branch.value"
* item[7].item[2].answer.valueString = "02"
* item[7].item[3].linkId = "branch.status"
* item[7].item[3].answer.valueString = "自動"
* item[7].item[4].linkId = "branch.evidence"
* item[7].item[4].answer.valueString = "2026-08-28 K672-2 腹腔鏡下胆嚢摘出術"
* item[8].linkId = "branch"
* item[8].item[0].linkId = "branch.key"
* item[8].item[0].answer.valueString = "proc1"
* item[8].item[1].linkId = "branch.label"
* item[8].item[1].answer.valueString = "手術・処置等1"
* item[8].item[2].linkId = "branch.value"
* item[8].item[2].answer.valueString = "0"
* item[8].item[3].linkId = "branch.status"
* item[8].item[3].answer.valueString = "自動"

Instance: example-imaging-study
InstanceOf: FC_ImagingStudy
Usage: #example
Title: "DICOM スタディの例"
Description: "DICOM スタディの例"
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

Instance: example-nursing-profile-response
InstanceOf: FC_QuestionnaireResponse
Usage: #example
Title: "看護プロファイルの記入の例"
Description: "看護プロファイルの区画(入院時の情報)の記入の例。encounter = 入院で、1 入院 1 区画 1 件。"
* identifier.value = "1311234567^00000001^c3d4e5f6-a7b8-4c9d-8e0f-1a2b3c4d5e6f"
* questionnaire = "http://fhir-client.local/Questionnaire/nursing-profile-admission-01|1.0.0"
* status = #completed
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* authored = "2026-04-01T15:00:00+09:00"
* contained[0] = example-nursing-profile-response-practitioner
* author = Reference(example-nursing-profile-response-practitioner)
* item[0].linkId = "grp_admission"
* item[0].item[0].linkId = "adm_route"
* item[0].item[0].answer.valueCoding.code = #01
* item[0].item[0].answer.valueCoding.display = "外来から"
* item[0].item[1].linkId = "adm_arrival"
* item[0].item[1].answer.valueCoding.code = #01
* item[0].item[1].answer.valueCoding.display = "独歩"
* item[1].linkId = "grp_life"
* item[1].item[0].linkId = "key_person"
* item[1].item[0].answer.valueString = "長女"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderDepartment].valueReference.display = "内科"

Instance: example-nursing-profile-response-practitioner
InstanceOf: Practitioner
Usage: #inline
* id = "practitioner"
* name.text = "看護 花子"

Instance: example-countersign-clinical-note
InstanceOf: FC_ClinicalNote
Usage: #example
Title: "診療記録の例(研修医の記録・承認済)"
Description: "研修医が書き、指導医がカウンターサインした診療記録(category = clinical-note-category#countersign、attester に legal と professional)。"
* status = #final
* type = $loinc#11506-3 "Progress note"
* category = http://fhir-client.local/CodeSystem/clinical-note-category#countersign "カウンターサイン対象"
* subject = Reference(Patient/example-patient)
* date = "2026-04-03T10:00:00+09:00"
* author = Reference(Practitioner/example-resident)
* title = "診療記録"
* attester[0].mode = #legal
* attester[0].time = "2026-04-03T10:00:00+09:00"
* attester[0].party = Reference(Practitioner/example-resident)
* attester[1].mode = #professional
* attester[1].time = "2026-04-03T17:30:00+09:00"
* attester[1].party = Reference(Practitioner/example-practitioner)
* attester[1].party.display = "山田 一郎"
* section[0].code = $loinc#61150-9 "Subjective"
* section[0].text.status = #additional
* section[0].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>咳嗽は軽快。夜間の発熱なし。</p></div>"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderDepartment].valueReference.display = "内科"

Instance: example-weight-observation
InstanceOf: FC_VitalObservation
Usage: #example
Title: "バイタル(体重)の例(経過表一括入力)"
Description: "入院患者一覧の経過表一括入力で書いた体重。encounter = 入院、performer = 測定者。同じ identifier の BMI は最新の身長で求める。"
* status = #final
* identifier.system = "http://fhir-client.local/vital-entry"
* identifier.value = "7c6b5a49-3827-4f16-a5e4-d3c2b1a09f8e"
* category = $obs-category#vital-signs
* code = $loinc#29463-7 "Body weight"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* effectiveDateTime = "2026-04-05T06:00:00+09:00"
* performer = Reference(Practitioner/example-nurse)
* valueQuantity = 61.2 'kg' "kg"
