// 検査結果・報告の例。

Instance: example-lab-diagnostic-report
InstanceOf: FC_LabDiagnosticReport
Usage: #example
Title: "検体検査 報告の例"
Description: "検体検査 報告の例"
* status = #final
* category[kind] = $v2-0074#LAB "Laboratory"
* category[setting] = $lab-result-setting#inpatient "入院"
* code = $loinc#11502-2 "Laboratory report"
* code.text = "臨床検査結果"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-02"
* issued = "2026-04-02T11:30:00+09:00"
* performer[0] = Reference(Organization/example-organization)
* performer[1] = Reference(Practitioner/example-practitioner)
* basedOn = Reference(ServiceRequest/example-lab-order-header)
* specimen = Reference(Specimen/example-lab-label-specimen)
* result = Reference(Observation/example-lab-result-observation)
* extension[orderDepartment].valueReference = Reference(Organization/example-department)

Instance: example-lab-result-observation
InstanceOf: FC_LabResultObservation
Usage: #example
Title: "検体検査 結果項目の例"
Description: "検体検査 結果項目の例"
* status = #final
* category = $obs-category#laboratory
* code.coding[item] = http://fhir-client.local/CodeSystem/lab-result-item#0301 "HbA1c"
* code.coding[jlac11] = http://fhir-client.local/CodeSystem/jlac11#3D046000001906202
* code.coding[abbreviation] = $lab-item-abbreviation#0301 "HbA1c"
* code.text = "HbA1c"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-02"
* valueQuantity = 7.2 '%' "%"
* interpretation = $v3-ObservationInterpretation#H
* referenceRange.low = 4.6 '%' "%"
* referenceRange.high = 6.2 '%' "%"
* referenceRange.type = $referencerange-meaning#normal
* specimen = Reference(Specimen/example-lab-label-specimen)

Instance: example-lab-result-specimen
InstanceOf: FC_LabResultSpecimen
Usage: #example
Title: "検体検査結果の検体の例"
Description: "検体検査結果の検体の例"
* status = #available
* subject = Reference(Patient/example-patient)
* type = http://fhir-client.local/CodeSystem/jlac11-specimen#023 "血清"
* collection.collectedDateTime = "2026-04-02"

// ---- 細菌検査 ----

Instance: example-micro-result-specimen
InstanceOf: FC_MicroResultSpecimen
Usage: #example
Title: "細菌検査結果の検体の例"
Description: "細菌検査結果の検体の例"
* status = #available
* subject = Reference(Patient/example-patient)
* type = http://fhir-client.local/CodeSystem/janis-specimen-type#SPT "喀痰"
* collection.collectedDateTime = "2026-04-03"

Instance: example-micro-diagnostic-report
InstanceOf: FC_MicroDiagnosticReport
Usage: #example
Title: "細菌検査 報告の例"
Description: "細菌検査 報告の例"
* status = #final
* category[kind] = $v2-0074#MB "Microbiology"
* category[setting] = $lab-result-setting#inpatient "入院"
* code = $loinc#18725-2 "Microbiology studies (set)"
* code.text = "細菌検査結果"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-03"
* basedOn = Reference(ServiceRequest/example-micro-order-header)
* specimen = Reference(Specimen/example-micro-result-specimen)
* result[0] = Reference(Observation/example-micro-finding-observation)
* result[1] = Reference(Observation/example-micro-isolate-observation)
* result[2] = Reference(Observation/example-micro-susceptibility-observation)
* extension[orderDepartment].valueReference = Reference(Organization/example-department)

Instance: example-micro-finding-observation
InstanceOf: FC_MicroFindingObservation
Usage: #example
Title: "細菌検査 所見(培養)の例"
Description: "細菌検査 所見(培養)の例"
* status = #final
* category = $obs-category#laboratory
* code = http://fhir-client.local/CodeSystem/micro-result-item#culture "培養結果"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-03"
* valueCodeableConcept = http://fhir-client.local/CodeSystem/micro-culture-result#positive "陽性"
* specimen = Reference(Specimen/example-micro-result-specimen)

Instance: example-micro-isolate-observation
InstanceOf: FC_MicroIsolateObservation
Usage: #example
Title: "細菌検査 分離菌の例"
Description: "細菌検査 分離菌の例"
* status = #final
* category = $obs-category#laboratory
* code = http://fhir-client.local/CodeSystem/micro-result-item#isolate "分離菌"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-03"
* valueCodeableConcept = http://fhir-client.local/CodeSystem/janis-organism#4001 "Pseudomonas aeruginosa"
* component[quantityType].code = http://fhir-client.local/CodeSystem/micro-result-item#colony-quantity-type "菌量"
* component[quantityType].valueCodeableConcept = http://fhir-client.local/CodeSystem/micro-colony-quantity-type#1 "半定量"
* component[colonyCount].code = http://fhir-client.local/CodeSystem/micro-result-item#colony-count "菌数"
* component[colonyCount].valueCodeableConcept = http://fhir-client.local/CodeSystem/micro-colony-count#5 "10^6/ml"
* component[causative].code = http://fhir-client.local/CodeSystem/micro-result-item#causative "起炎性"
* component[causative].valueCodeableConcept = http://fhir-client.local/CodeSystem/micro-causative#present "あり"
* specimen = Reference(Specimen/example-micro-result-specimen)

Instance: example-micro-susceptibility-observation
InstanceOf: FC_MicroSusceptibilityObservation
Usage: #example
Title: "細菌検査 薬剤感受性の例"
Description: "細菌検査 薬剤感受性の例"
* status = #final
* category = $obs-category#laboratory
* code.coding[antimicrobial] = http://fhir-client.local/CodeSystem/janis-antimicrobial#1411 "メロペネム三水和物"
* code.coding[abbreviation] = http://fhir-client.local/CodeSystem/micro-antimicrobial-abbreviation#1411 "MEPM"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-03"
* derivedFrom = Reference(Observation/example-micro-isolate-observation)
* method = http://fhir-client.local/CodeSystem/janis-susceptibility-method#MIC "微量液体希釈法"
* valueQuantity.value = 1
* valueQuantity.comparator = #<=
* valueQuantity.unit = "µg/mL"
* valueQuantity.system = $ucum
* valueQuantity.code = #ug/mL
* interpretation = $v3-ObservationInterpretation#S
* specimen = Reference(Specimen/example-micro-result-specimen)

// ---- 放射線 読影 ----

Instance: example-rad-findings-observation
InstanceOf: FC_RadFindingsObservation
Usage: #example
Title: "読影 所見の例"
Description: "読影 所見の例"
* status = #final
* category = $obs-category#imaging
* code = http://fhir-client.local/CodeSystem/rad-report-item#findings "所見"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-03T10:00:00+09:00"
* valueString = "右下葉 S6 に 25 mm 大の結節影。辺縁は不整。"

Instance: example-rad-diagnostic-report
InstanceOf: FC_RadDiagnosticReport
Usage: #example
Title: "放射線 読影レポートの例"
Description: "放射線 読影レポートの例"
* status = #final
* category[loinc] = $loinc#LP29684-5 "Radiology"
* category[kind] = $v2-0074#RAD "Radiology"
* category[setting] = $lab-result-setting#outpatient "外来"
* code.coding = $JP_DocumentCodes#18748-4 "画像検査報告書"
* code.text = "胸部 CT"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-03T10:00:00+09:00"
* issued = "2026-04-03T15:00:00+09:00"
* performer = Reference(Organization/example-organization)
* resultsInterpreter = Reference(Practitioner/example-practitioner)
* basedOn = Reference(ServiceRequest/example-rad-order-header)
* result = Reference(Observation/example-rad-findings-observation)
* conclusion = "右下葉結節。肺癌の可能性があり精査を推奨。"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[criticalFinding].valueString = "右下葉に腫瘤影。精査を要する。"

// ---- 生理検査 所見 ----

Instance: example-physio-findings-observation
InstanceOf: FC_PhysioFindingsObservation
Usage: #example
Title: "生理検査 所見の例"
Description: "生理検査 所見の例"
* status = #final
* category = $obs-category#procedure
* code = http://fhir-client.local/CodeSystem/physio-report-item#findings "所見"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-01T11:10:00+09:00"
* valueString = "洞調律、HR 52/分。QTc 520 ms と著明に延長。ST-T 変化なし。"

Instance: example-physio-diagnostic-report
InstanceOf: FC_PhysioDiagnosticReport
Usage: #example
Title: "生理検査 所見レポートの例"
Description: "生理検査 所見レポートの例"
* status = #final
* category[orderType] = $order-type#physio "生理検査"
* category[kind] = $v2-0074#OTH "Other"
* category[setting] = $lab-result-setting#outpatient "外来"
* code.coding = http://fhir-client.local/CodeSystem/exam-report#physio "生理検査報告書"
* code.text = "12 誘導心電図"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-01T11:10:00+09:00"
* issued = "2026-04-01T11:30:00+09:00"
* performer = Reference(Organization/example-organization)
* resultsInterpreter = Reference(Practitioner/example-practitioner)
* basedOn = Reference(ServiceRequest/example-physio-order-header)
* result = Reference(Observation/example-physio-findings-observation)
* conclusion = "QT 延長"
* extension[criticalFinding].valueString = "QTc 520 ms。QT 延長をきたす薬剤の確認を要する。"

// ---- 内視鏡 所見 ----

Instance: example-endoscopy-findings-observation
InstanceOf: FC_EndoscopyFindingsObservation
Usage: #example
Title: "内視鏡 所見の例"
Description: "内視鏡 所見の例"
* status = #final
* category = $obs-category#procedure
* code = http://fhir-client.local/CodeSystem/endoscopy-report-item#findings "所見"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-10T09:30:00+09:00"
* valueString = "胃体上部後壁に周堤を伴う 30 mm 大の潰瘍性病変。生検 2 個。食道・十二指腸に異常なし。"

Instance: example-endoscopy-diagnostic-report
InstanceOf: FC_EndoscopyDiagnosticReport
Usage: #example
Title: "内視鏡 所見レポートの例"
Description: "内視鏡 所見レポートの例"
* status = #final
* category[orderType] = $order-type#endoscopy "内視鏡"
* category[kind] = $v2-0074#OTH "Other"
* category[setting] = $lab-result-setting#outpatient "外来"
* code.coding = $loinc#18751-8 "Endoscopy study"
* code.text = "上部消化管内視鏡"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-10T09:30:00+09:00"
* issued = "2026-04-10T11:00:00+09:00"
* performer = Reference(Organization/example-organization)
* resultsInterpreter = Reference(Practitioner/example-practitioner)
* basedOn = Reference(ServiceRequest/example-endoscopy-order-header)
* result = Reference(Observation/example-endoscopy-findings-observation)
* conclusion = "胃体上部 進行胃癌疑い(3 型)。生検結果待ち。"
* extension[criticalFinding].valueString = "胃体上部に 3 型進行癌を疑う潰瘍性病変。"

// ---- 病理 ----

Instance: example-patho-result-specimen
InstanceOf: FC_PathoResultSpecimen
Usage: #example
Title: "病理レポートの検体の例"
Description: "病理レポートの検体の例"
* status = #available
* subject = Reference(Patient/example-patient)
* type = http://fhir-client.local/CodeSystem/jahis-patho-specimen-type#201 "生検"
* collection.bodySite = http://fhir-client.local/CodeSystem/jahis-patho-organ#C16 "胃"
* collection.collectedDateTime = "2026-04-10"

Instance: example-patho-finding-observation
InstanceOf: FC_PathoFindingObservation
Usage: #example
Title: "病理レポートのセクション(診断)の例"
Description: "病理レポートのセクション(診断)の例"
* status = #final
* category = $obs-category#laboratory
* code = $loinc#22637-3 "診断"
* code.text = "診断"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-10"
* valueString = "Adenocarcinoma, well differentiated, tub1"
* specimen = Reference(Specimen/example-patho-result-specimen)

Instance: example-patho-diagnostic-report
InstanceOf: FC_PathoDiagnosticReport
Usage: #example
Title: "病理診断レポートの例"
Description: "病理診断レポートの例"
* status = #final
* category[kind] = $v2-0074#SP "Surgical Pathology"
* category[setting] = $lab-result-setting#outpatient "外来"
* code = $loinc#11526-1 "Pathology study"
* code.text = "病理診断レポート"
* subject = Reference(Patient/example-patient)
* effectiveDateTime = "2026-04-10"
* basedOn = Reference(ServiceRequest/example-patho-order-header)
* specimen = Reference(Specimen/example-patho-result-specimen)
* result = Reference(Observation/example-patho-finding-observation)
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
