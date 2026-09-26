// 実施記録(Procedure ハブ)の例。

Instance: example-rad-procedure
InstanceOf: FC_RadProcedure
Usage: #example
Title: "放射線検査 実施記録の例"
* status = #completed
* category.coding[orderType] = $order-type#rad "放射線検査"
* code = http://fhir-client.local/CodeSystem/rad-procedure-code#170020410 "CT撮影(64列以上のマルチスライス型)"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-rad-order-header)
* performedDateTime = "2026-04-03T10:10:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)
* usedCode[0].coding[material] = http://fhir-client.local/CodeSystem/rad-material#SYR20 "シリンジ 20mL"
* usedCode[0].coding[medicalMaterial] = http://fhir-client.local/CodeSystem/medical-material#700010000
* usedCode[0].text = "シリンジ 20mL"
* usedCode[0].extension[quantity].valueQuantity.value = 1
* usedCode[0].extension[quantity].valueQuantity.unit = "本"

Instance: example-rad-dose-observation
InstanceOf: FC_RadDoseObservation
Usage: #example
Title: "被ばく線量の例"
* status = #final
* code = http://fhir-client.local/CodeSystem/rad-dose#ctdivol "CTDIvol"
* subject = Reference(Patient/example-patient)
* partOf = Reference(Procedure/example-rad-procedure)
* valueQuantity = 12.5 'mGy' "mGy"

Instance: example-endoscopy-procedure
InstanceOf: FC_EndoscopyProcedure
Usage: #example
Title: "内視鏡 実施記録の例"
* status = #completed
* category.coding[orderType] = $order-type#endoscopy "内視鏡"
* code = http://fhir-client.local/CodeSystem/endoscopy-procedure-code#160093810 "胃・十二指腸ファイバースコピー"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-endoscopy-order-header)
* performedDateTime = "2026-04-10T09:10:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)
* usedCode[0].text = "生検鉗子"

Instance: example-physio-procedure
InstanceOf: FC_PhysioProcedure
Usage: #example
Title: "生理検査 実施記録の例"
* status = #completed
* category.coding[orderType] = $order-type#physio "生理検査"
* code = http://fhir-client.local/CodeSystem/physio-procedure-code#160005110 "心電図検査(12誘導)"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-physio-order-header)
* performedDateTime = "2026-04-01T11:05:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)

Instance: example-treatment-procedure
InstanceOf: FC_TreatmentProcedure
Usage: #example
Title: "処置 実施記録の例"
* status = #completed
* category.coding[orderType] = $order-type#treatment "処置"
* code = http://fhir-client.local/CodeSystem/treatment-procedure-code#140000610 "創傷処置(100cm2未満)"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-treatment-order-header)
* performedDateTime = "2026-04-02T14:10:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)
* usedCode[0].coding = http://fhir-client.local/CodeSystem/medical-material#700020000
* usedCode[0].text = "ガーゼ"
* usedCode[0].extension[quantity].valueQuantity.value = 2
* usedCode[0].extension[quantity].valueQuantity.unit = "枚"

Instance: example-surgery-procedure
InstanceOf: FC_SurgeryProcedure
Usage: #example
Title: "手術 実施記録の例"
* status = #completed
* category.coding[orderType] = $order-type#surgery "手術"
* code.coding[0] = http://fhir-client.local/CodeSystem/surgery-order-item#K6551 "腹腔鏡下胃切除術"
* code.coding[1] = http://fhir-client.local/CodeSystem/surgery-procedure-code#K6551
* code.text = "腹腔鏡下胃切除術"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-surgery-order-header)
* performedPeriod.start = "2026-04-08T08:45:00+09:00"
* performedPeriod.end = "2026-04-08T12:30:00+09:00"
* performer[0].function = http://fhir-client.local/CodeSystem/surgery-staff-role#surgeon "執刀医"
* performer[0].actor = Reference(Practitioner/example-practitioner)
* outcome = http://fhir-client.local/CodeSystem/surgery-outcome#good "良好"
* extension[performTimes].extension[anesthesia-start].valueDateTime = "2026-04-08T09:00:00+09:00"
* extension[performTimes].extension[incision-start].valueDateTime = "2026-04-08T09:30:00+09:00"
* extension[performTimes].extension[incision-end].valueDateTime = "2026-04-08T11:50:00+09:00"
* extension[performTimes].extension[anesthesia-end].valueDateTime = "2026-04-08T12:15:00+09:00"
* extension[woundClass].valueCoding = http://fhir-client.local/CodeSystem/surgery-wound-class#clean-contaminated "準清潔"
* extension[countCheck].valueCoding = http://fhir-client.local/CodeSystem/surgery-count-check#verified "合致"

Instance: example-surgery-observation
InstanceOf: FC_SurgeryObservation
Usage: #example
Title: "出血量の例"
* status = #final
* code = http://fhir-client.local/CodeSystem/surgery-observation#blood-loss "出血量"
* subject = Reference(Patient/example-patient)
* partOf = Reference(Procedure/example-surgery-procedure)
* valueQuantity = 80 'mL' "mL"

Instance: example-rehab-procedure
InstanceOf: FC_RehabProcedure
Usage: #example
Title: "リハビリ 実施記録の例"
* status = #completed
* category.coding[orderType] = $order-type#rehab "リハビリ"
* code = http://fhir-client.local/CodeSystem/rehab-therapy-type#pt "理学療法(PT)"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-rehab-order)
* performedDateTime = "2026-04-10T14:00:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)
* extension[performedUnits].valueInteger = 2

Instance: example-nutrition-guidance-procedure
InstanceOf: FC_NutritionGuidanceProcedure
Usage: #example
Title: "栄養指導 実施記録の例"
* status = #completed
* category.coding[orderType] = $order-type#nutrition-guidance "栄養指導"
* code = http://fhir-client.local/CodeSystem/nutrition-guidance-session-type#initial "初回指導"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-nutrition-guidance-order)
* performedDateTime = "2026-04-05T10:30:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)
* extension[performedMinutes].valueInteger = 30

Instance: example-radiotherapy-fraction-procedure
InstanceOf: FC_RadiotherapyFractionProcedure
Usage: #example
Title: "放射線治療 照射記録の例"
* status = #completed
* category.coding[orderType] = $order-type#radiotherapy "放射線治療"
* category.coding[kind] = http://fhir-client.local/CodeSystem/radiotherapy-procedure#fraction "照射"
* code = http://fhir-client.local/CodeSystem/radiotherapy-technique#3DCRT "3D-CRT"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-radiotherapy-order)
* performedDateTime = "2026-04-15T10:00:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)
* usedCode = http://fhir-client.local/CodeSystem/radiotherapy-device#LINAC1 "リニアック 1 号機"
* extension[fraction].extension[phaseId].valueString = "p1"
* extension[fraction].extension[fractionNumber].valueInteger = 1
* extension[fraction].extension[imageGuidance].valueCoding = http://fhir-client.local/CodeSystem/radiotherapy-image-guidance#cbct "CBCT"
* extension[fraction].extension[doseDeliveredToVolume][0].extension[volume].valueString = "v1"
* extension[fraction].extension[doseDeliveredToVolume][0].extension[dose].valueQuantity = 2 'Gy' "Gy"

Instance: example-radiotherapy-course-summary-procedure
InstanceOf: FC_RadiotherapyCourseSummaryProcedure
Usage: #example
Title: "放射線治療 コース要約の例"
* status = #completed
* category.coding[orderType] = $order-type#radiotherapy "放射線治療"
* category.coding[kind] = http://fhir-client.local/CodeSystem/radiotherapy-procedure#course-summary "コース要約"
* code.text = "コース要約"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-radiotherapy-order)
* performedPeriod.start = "2026-04-15"
* performedPeriod.end = "2026-05-26"
* outcome = http://fhir-client.local/CodeSystem/radiotherapy-course-outcome#completed "完遂"
* extension[courseSummary].extension[fractionsDelivered].valueInteger = 30
* extension[courseSummary].extension[fractionsPrescribed].valueInteger = 30
* extension[courseSummary].extension[doseDeliveredToVolume][0].extension[volume].valueString = "v1"
* extension[courseSummary].extension[doseDeliveredToVolume][0].extension[dose].valueQuantity = 60 'Gy' "Gy"
* extension[courseSummary].extension[doseDeliveredToVolume][0].extension[fractions].valueInteger = 30
* extension[courseSummary].extension[progressNote].valueString = "予定どおり完遂。Grade 1 の放射線皮膚炎。"

Instance: example-transfusion-procedure
InstanceOf: FC_TransfusionProcedure
Usage: #example
Title: "輸血 実施記録の例"
* status = #completed
* category.coding[orderType] = $order-type#transfusion "輸血"
* code.text = "輸血"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-transfusion-order-header)
* performedPeriod.start = "2026-04-08T15:00:00+09:00"
* performedPeriod.end = "2026-04-08T17:00:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)

Instance: example-transfusion-medication-administration
InstanceOf: FC_MedicationAdministration
Usage: #example
Title: "輸血製剤の投与の例"
* status = #completed
* subject = Reference(Patient/example-patient)
* partOf = Reference(Procedure/example-transfusion-procedure)
* medicationCodeableConcept = http://fhir-client.local/CodeSystem/transfusion-product#RBC-LR-2 "照射赤血球液-LR 2 単位"
* effectivePeriod.start = "2026-04-08T15:00:00+09:00"
* effectivePeriod.end = "2026-04-08T16:00:00+09:00"
* extension[0].url = "http://fhir-client.local/StructureDefinition/transfusion-lot-number"
* extension[0].valueString = "26040800123"

Instance: example-transfusion-reaction-observation
InstanceOf: FC_TransfusionReactionObservation
Usage: #example
Title: "輸血反応の例"
* status = #final
* category = $order-type#transfusion "輸血"
* code = http://fhir-client.local/CodeSystem/transfusion-observation#reaction "輸血反応"
* subject = Reference(Patient/example-patient)
* partOf = Reference(Procedure/example-transfusion-procedure)
* valueCodeableConcept = http://fhir-client.local/CodeSystem/transfusion-reaction#none "なし"

Instance: example-nursing-action-procedure
InstanceOf: FC_NursingActionProcedure
Usage: #example
Title: "看護行為 実施記録の例"
* status = #completed
* identifier.system = "http://fhir-client.local/nursing-perform-entry"
* identifier.value = "9d8c7b6a-5f4e-4d3c-8b2a-1f0e9d8c7b6a"
* category.coding[orderType] = $order-type#nursing "看護指示"
* code = $medis-nursing-action#3300000000000001 "清拭"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* basedOn = Reference(ServiceRequest/example-nursing-order)
* performedDateTime = "2026-04-02T10:00:00+09:00"
* performer.actor = Reference(Practitioner/example-practitioner)

Instance: example-anesthesia-chart-procedure
InstanceOf: FC_AnesthesiaChartProcedure
Usage: #example
Title: "麻酔チャートの例"
* status = #completed
* category.coding[orderType] = $order-type#anesthesia-chart "麻酔チャート"
* code.text = "全身麻酔"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(ServiceRequest/example-surgery-order-header)
* performedPeriod.start = "2026-04-08T09:00:00+09:00"
* performedPeriod.end = "2026-04-08T12:15:00+09:00"
* performer[0].function = http://fhir-client.local/CodeSystem/surgery-staff-role#anesthetist "麻酔科医"
* performer[0].actor = Reference(Practitioner/example-practitioner)

Instance: example-anesthesia-vital-observation
InstanceOf: FC_AnesthesiaVitalObservation
Usage: #example
Title: "麻酔チャートのバイタルの例"
* status = #final
* code = $loinc#8867-4 "Heart rate"
* subject = Reference(Patient/example-patient)
* partOf = Reference(Procedure/example-anesthesia-chart-procedure)
* effectiveDateTime = "2026-04-08T09:05:00+09:00"
* valueQuantity = 72 '/min' "/min"

Instance: example-anesthesia-event-observation
InstanceOf: FC_AnesthesiaEventObservation
Usage: #example
Title: "麻酔チャートのイベントの例"
* status = #final
* code = http://fhir-client.local/CodeSystem/anesthesia-event#intubation "挿管"
* subject = Reference(Patient/example-patient)
* partOf = Reference(Procedure/example-anesthesia-chart-procedure)
* effectiveDateTime = "2026-04-08T09:10:00+09:00"
