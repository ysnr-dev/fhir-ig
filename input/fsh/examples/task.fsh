// 部門進捗 Task と通知 Task の例。

Instance: example-lab-exam-task
InstanceOf: FC_LabExamTask
Usage: #example
Title: "検体検査 進捗 Task の例(受付済)"
Description: "検体検査 進捗 Task の例(受付済)"
* status = #accepted
* intent = #filler-order
* priority = #routine
* code = $task-code#lab-exam "検体検査"
* code.text = "検体検査"
* focus = Reference(ServiceRequest/example-lab-order-header)
* for = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-02T08:30:00+09:00"
* lastModified = "2026-04-02T08:30:00+09:00"
* executionPeriod.start = "2026-04-02T08:30:00+09:00"

Instance: example-rad-exam-task
InstanceOf: FC_RadExamTask
Usage: #example
Title: "放射線検査 進捗 Task の例(実施済)"
Description: "放射線検査 進捗 Task の例(実施済)"
* status = #completed
* intent = #filler-order
* priority = #routine
* code = $task-code#rad-exam "放射線検査"
* code.text = "放射線検査"
* focus = Reference(ServiceRequest/example-rad-order-header)
* for = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-03T09:50:00+09:00"
* lastModified = "2026-04-03T10:20:00+09:00"
* executionPeriod.start = "2026-04-03T09:50:00+09:00"
* executionPeriod.end = "2026-04-03T10:20:00+09:00"

Instance: example-radiotherapy-task
InstanceOf: FC_RadiotherapyTask
Usage: #example
Title: "放射線治療 進捗 Task の例(治療中)"
Description: "放射線治療 進捗 Task の例(治療中)"
* status = #in-progress
* intent = #filler-order
* code = $task-code#radiotherapy "放射線治療"
* code.text = "放射線治療"
* focus = Reference(ServiceRequest/example-radiotherapy-order)
* for = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-02T09:00:00+09:00"
* lastModified = "2026-04-15T09:00:00+09:00"
* executionPeriod.start = "2026-04-02T09:00:00+09:00"

Instance: example-endoscopy-exam-task
InstanceOf: FC_EndoscopyExamTask
Usage: #example
Title: "内視鏡 進捗 Task の例"
Description: "内視鏡 進捗 Task の例"
* status = #accepted
* intent = #filler-order
* priority = #routine
* code = $task-code#endoscopy-exam "内視鏡"
* code.text = "内視鏡"
* focus = Reference(ServiceRequest/example-endoscopy-order-header)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-10T08:40:00+09:00"
* lastModified = "2026-04-10T08:40:00+09:00"
* executionPeriod.start = "2026-04-10T08:40:00+09:00"

Instance: example-physio-exam-task
InstanceOf: FC_PhysioExamTask
Usage: #example
Title: "生理検査 進捗 Task の例"
Description: "生理検査 進捗 Task の例"
* status = #completed
* intent = #filler-order
* priority = #urgent
* code = $task-code#physio-exam "生理検査"
* code.text = "生理検査"
* focus = Reference(ServiceRequest/example-physio-order-header)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-01T11:00:00+09:00"
* lastModified = "2026-04-01T11:20:00+09:00"
* executionPeriod.start = "2026-04-01T11:00:00+09:00"
* executionPeriod.end = "2026-04-01T11:20:00+09:00"

Instance: example-patho-exam-task
InstanceOf: FC_PathoExamTask
Usage: #example
Title: "病理検査 進捗 Task の例"
Description: "病理検査 進捗 Task の例"
* status = #accepted
* intent = #filler-order
* priority = #routine
* code = $task-code#patho-exam "病理検査"
* code.text = "病理検査"
* focus = Reference(ServiceRequest/example-patho-order-header)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-10T13:00:00+09:00"
* lastModified = "2026-04-10T13:00:00+09:00"
* executionPeriod.start = "2026-04-10T13:00:00+09:00"

Instance: example-surgery-task
InstanceOf: FC_SurgeryTask
Usage: #example
Title: "手術 進捗 Task の例(入室中)"
Description: "手術 進捗 Task の例(入室中)"
* status = #in-progress
* intent = #filler-order
* priority = #routine
* code = $task-code#surgery "手術"
* code.text = "手術"
* focus = Reference(ServiceRequest/example-surgery-order-header)
* for = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-02T09:00:00+09:00"
* lastModified = "2026-04-08T08:45:00+09:00"
* executionPeriod.start = "2026-04-08T08:45:00+09:00"

Instance: example-treatment-task
InstanceOf: FC_TreatmentTask
Usage: #example
Title: "処置 進捗 Task の例"
Description: "処置 進捗 Task の例"
* status = #completed
* intent = #filler-order
* code = $task-code#treatment "処置"
* code.text = "処置"
* focus = Reference(ServiceRequest/example-treatment-order-header)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-02T14:00:00+09:00"
* lastModified = "2026-04-02T14:30:00+09:00"
* executionPeriod.start = "2026-04-02T14:00:00+09:00"
* executionPeriod.end = "2026-04-02T14:30:00+09:00"

Instance: example-rehab-task
InstanceOf: FC_RehabTask
Usage: #example
Title: "リハビリ 進捗 Task の例(実施中)"
Description: "リハビリ 進捗 Task の例(実施中)"
* status = #accepted
* intent = #filler-order
* code = $task-code#rehab "リハビリ"
* code.text = "リハビリ"
* focus = Reference(ServiceRequest/example-rehab-order)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-10T09:00:00+09:00"
* lastModified = "2026-04-10T09:00:00+09:00"
* executionPeriod.start = "2026-04-10T09:00:00+09:00"

Instance: example-consult-task
InstanceOf: FC_ConsultTask
Usage: #example
Title: "他科依頼 進捗 Task の例"
Description: "他科依頼 進捗 Task の例"
* status = #accepted
* intent = #filler-order
* priority = #routine
* code = $task-code#consult "他科依頼"
* code.text = "他科依頼"
* focus = Reference(ServiceRequest/example-consult-order)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-02T13:00:00+09:00"
* lastModified = "2026-04-02T13:00:00+09:00"
* executionPeriod.start = "2026-04-02T13:00:00+09:00"

Instance: example-nursing-task
InstanceOf: FC_NursingTask
Usage: #example
Title: "看護指示 Task の例(指示受け済)"
Description: "看護指示 Task の例(指示受け済)"
* status = #accepted
* intent = #filler-order
* code = $task-code#nursing "看護指示"
* code.text = "看護指示"
* focus = Reference(ServiceRequest/example-nursing-order)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T11:00:00+09:00"
* lastModified = "2026-04-01T11:30:00+09:00"
* executionPeriod.start = "2026-04-01T11:30:00+09:00"

Instance: example-transfusion-task
InstanceOf: FC_TransfusionTask
Usage: #example
Title: "輸血 進捗 Task の例(出庫済)"
Description: "輸血 進捗 Task の例(出庫済)"
* status = #in-progress
* intent = #filler-order
* priority = #urgent
* code = $task-code#transfusion "輸血"
* code.text = "輸血"
* focus = Reference(ServiceRequest/example-transfusion-order-header)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-08T12:30:00+09:00"
* lastModified = "2026-04-08T14:30:00+09:00"
* executionPeriod.start = "2026-04-08T12:30:00+09:00"

Instance: example-nutrition-guidance-task
InstanceOf: FC_NutritionGuidanceTask
Usage: #example
Title: "栄養指導 進捗 Task の例"
Description: "栄養指導 進捗 Task の例"
* status = #accepted
* intent = #filler-order
* code = $task-code#nutrition-guidance "栄養指導"
* code.text = "栄養指導"
* focus = Reference(ServiceRequest/example-nutrition-guidance-order)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-05T10:00:00+09:00"
* lastModified = "2026-04-05T10:00:00+09:00"
* executionPeriod.start = "2026-04-05T10:00:00+09:00"

Instance: example-medication-guidance-task
InstanceOf: FC_MedicationGuidanceTask
Usage: #example
Title: "服薬指導 進捗 Task の例"
Description: "服薬指導 進捗 Task の例(受付済 = 実施中、担当薬剤師あり)"
* status = #accepted
* intent = #filler-order
* code = $task-code#medication-guidance "服薬指導"
* code.text = "服薬指導"
* focus = Reference(ServiceRequest/example-medication-guidance-order)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-pharmacist)
* owner.display = "薬剤 花子"
* authoredOn = "2026-04-02T10:00:00+09:00"
* lastModified = "2026-04-02T10:00:00+09:00"
* executionPeriod.start = "2026-04-02T10:00:00+09:00"

Instance: example-rx-dispense-task
InstanceOf: FC_RxDispenseTask
Usage: #example
Title: "調剤 進捗 Task の例(調剤済)"
Description: "調剤 進捗 Task の例(調剤済)"
* status = #in-progress
* intent = #filler-order
* code = $task-code#rx-dispense "調剤"
* code.text = "調剤"
* focus = Reference(ServiceRequest/example-prescription-order)
* for = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T12:00:00+09:00"
* lastModified = "2026-04-01T15:00:00+09:00"
* executionPeriod.start = "2026-04-01T12:00:00+09:00"
* note.time = "2026-04-01T13:00:00+09:00"
* note.text = "用量確認済み"

Instance: example-injection-task
InstanceOf: FC_InjectionTask
Usage: #example
Title: "注射 進捗 Task の例(払出済)"
Description: "注射 進捗 Task の例(払出済)"
* status = #in-progress
* intent = #filler-order
* code = $task-code#injection "注射"
* code.text = "注射"
* focus = Reference(ServiceRequest/example-injection-order)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-02T07:00:00+09:00"
* lastModified = "2026-04-02T08:00:00+09:00"
* executionPeriod.start = "2026-04-02T07:00:00+09:00"

Instance: example-brought-med-review-task
InstanceOf: FC_BroughtMedReviewTask
Usage: #example
Title: "持参薬鑑別 Task の例"
Description: "持参薬鑑別 Task の例"
* status = #in-progress
* intent = #order
* code = $task-code#brought-med-review "持参薬鑑別"
* code.text = "持参薬鑑別"
* focus = Reference(Encounter/example-encounter)
* encounter = Reference(Encounter/example-encounter)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* requester = Reference(Practitioner/example-nurse)
* authoredOn = "2026-04-01T12:00:00+09:00"
* lastModified = "2026-04-01T13:00:00+09:00"
* executionPeriod.start = "2026-04-01T13:00:00+09:00"
* input[ward].type.text = "病棟"
* input[ward].valueString = "東3階病棟"
* input[admissionDate].type.text = "入院日"
* input[admissionDate].valueDate = "2026-04-01"

// ---- 通知 Task ----

Instance: example-order-approval-task
InstanceOf: FC_OrderApprovalTask
Usage: #example
Title: "オーダー承認 通知の例"
Description: "オーダー承認 通知の例"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#order-approval "オーダー承認"
* code.text = "オーダー承認"
* focus = Reference(Provenance/example-order-provenance)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* requester = Reference(Practitioner/example-nurse)
* basedOn = Reference(ServiceRequest/example-lab-order-header)
* authoredOn = "2026-04-01T09:00:00+09:00"
* lastModified = "2026-04-01T09:00:00+09:00"
* description = "検体検査の登録（入力: 看護 花子）"
* input[activity].type.text = "活動"
* input[activity].valueCode = #CREATE
* input[kind][0].type.text = "種別"
* input[kind][0].valueCode = #lab-order
* input[order][0].type.text = "対象オーダー"
* input[order][0].valueReference = Reference(ServiceRequest/example-lab-order-header)
* input[startDate].type.text = "開始日"
* input[startDate].valueString = "2026-04-02"

Instance: example-brought-med-identified-task
InstanceOf: FC_BroughtMedIdentifiedTask
Usage: #example
Title: "持参薬鑑別済 通知の例"
Description: "持参薬鑑別済 通知の例"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#brought-med-identified "持参薬鑑別済"
* code.text = "持参薬鑑別済"
* focus = Reference(Encounter/example-encounter)
* encounter = Reference(Encounter/example-encounter)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T16:00:00+09:00"
* lastModified = "2026-04-01T16:00:00+09:00"
* description = "持参薬 3 剤の鑑別が済みました(判断待ち 3 剤)"
* input[admission].type.text = "入院"
* input[admission].valueReference = Reference(Encounter/example-encounter)
* input[admissionDate].type.text = "入院日"
* input[admissionDate].valueDate = "2026-04-01"
* input[drugCount].type.text = "剤数"
* input[drugCount].valueInteger = 3
* input[pendingCount].type.text = "判断待ち"
* input[pendingCount].valueInteger = 3

Instance: example-document-due-task
InstanceOf: FC_DocumentDueTask
Usage: #example
Title: "文書作成 督促の例"
Description: "文書作成 督促の例"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#document-due "文書作成"
* code.text = "文書作成"
* focus = Reference(Encounter/example-encounter)
* encounter = Reference(Encounter/example-encounter)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-20T09:00:00+09:00"
* lastModified = "2026-04-20T09:00:00+09:00"
* description = "退院時サマリー 未作成(退院 2026-04-20、期限 2026-05-04)"
* restriction.period.end = "2026-05-04"
* input[document].type.text = "文書"
* input[document].valueCode = #discharge-summary
* input[documentName].type.text = "文書名"
* input[documentName].valueString = "退院時サマリー"
* input[admission].type.text = "入院"
* input[admission].valueReference = Reference(Encounter/example-encounter)
* input[dischargeDate].type.text = "退院日"
* input[dischargeDate].valueDate = "2026-04-20"
* input[dueDate].type.text = "期限"
* input[dueDate].valueDate = "2026-05-04"

Instance: example-lab-panic-task
InstanceOf: FC_LabPanicTask
Usage: #example
Title: "緊急異常値 通知の例"
Description: "緊急異常値 通知の例"
* status = #requested
* intent = #filler-order
* priority = #stat
* code = $task-code#lab-panic "緊急異常値"
* code.text = "緊急異常値"
* focus = Reference(DiagnosticReport/example-lab-diagnostic-report)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-02T12:00:00+09:00"
* lastModified = "2026-04-02T12:00:00+09:00"
* description = "2026-04-02 K 6.8 mmol/L(HH)"
* input[collectedDate].type.text = "検体採取日"
* input[collectedDate].valueDate = "2026-04-02"
* input[1].type.coding[0].system = "http://fhir-client.local/CodeSystem/lab-result-item"
* input[1].type.coding[0].display = "K"
* input[1].type.coding[1] = $v3-ObservationInterpretation#HH
* input[1].type.text = "K"
* input[1].valueQuantity.value = 6.8
* input[1].valueQuantity.unit = "mmol/L"
* input[1].valueQuantity.system = $ucum

Instance: example-result-review-task
InstanceOf: FC_ResultReviewTask
Usage: #example
Title: "検査結果確認 通知の例"
Description: "検査結果確認 通知の例"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#result-review "検査結果確認"
* code.text = "検査結果確認"
* focus = Reference(DiagnosticReport/example-lab-diagnostic-report)
* basedOn = Reference(ServiceRequest/example-lab-order-header)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-02T12:00:00+09:00"
* lastModified = "2026-04-02T12:00:00+09:00"
* description = "検体検査 2026-04-02 HbA1c ほか 3 項目"
* input[kind].type.text = "種別"
* input[kind].valueString = "lab"
* input[targetDate].type.text = "対象日"
* input[targetDate].valueDate = "2026-04-02"
* input[content].type.text = "内容"
* input[content].valueString = "HbA1c ほか 3 項目"

Instance: example-rad-critical-finding-task
InstanceOf: FC_RadCriticalFindingTask
Usage: #example
Title: "重要所見 通知の例"
Description: "重要所見 通知の例"
* status = #requested
* intent = #filler-order
* priority = #stat
* code = $task-code#rad-critical-finding "重要所見"
* code.text = "重要所見"
* focus = Reference(DiagnosticReport/example-rad-diagnostic-report)
* basedOn = Reference(ServiceRequest/example-rad-order-header)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-03T15:00:00+09:00"
* lastModified = "2026-04-03T15:00:00+09:00"
* description = "2026-04-03 胸部 CT 右下葉に腫瘤影。精査を要する。"
* input[examDate].type.text = "撮影日"
* input[examDate].valueDate = "2026-04-03"
* input[examContent].type.text = "撮影内容"
* input[examContent].valueString = "胸部 CT"
* input[summary].type.text = "要点"
* input[summary].valueString = "右下葉に腫瘤影。精査を要する。"

Instance: example-physio-critical-finding-task
InstanceOf: FC_PhysioCriticalFindingTask
Usage: #example
Title: "重要所見(生理検査) 通知の例"
Description: "重要所見(生理検査) 通知の例"
* status = #requested
* intent = #filler-order
* priority = #stat
* code = $task-code#physio-critical-finding "重要所見(生理検査)"
* code.text = "重要所見(生理検査)"
* focus = Reference(DiagnosticReport/example-physio-diagnostic-report)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* basedOn = Reference(ServiceRequest/example-physio-order-header)
* authoredOn = "2026-04-01T11:30:00+09:00"
* lastModified = "2026-04-01T11:30:00+09:00"
* description = "2026-04-01 12 誘導心電図 QTc 520 ms。QT 延長をきたす薬剤の確認を要する。"
* input[examDate].type.text = "検査日"
* input[examDate].valueDate = "2026-04-01"
* input[examContent].type.text = "検査内容"
* input[examContent].valueString = "12 誘導心電図"
* input[summary].type.text = "要点"
* input[summary].valueString = "QTc 520 ms。QT 延長をきたす薬剤の確認を要する。"

Instance: example-endoscopy-critical-finding-task
InstanceOf: FC_EndoscopyCriticalFindingTask
Usage: #example
Title: "重要所見(内視鏡) 通知の例"
Description: "重要所見(内視鏡) 通知の例"
* status = #requested
* intent = #filler-order
* priority = #stat
* code = $task-code#endoscopy-critical-finding "重要所見(内視鏡)"
* code.text = "重要所見(内視鏡)"
* focus = Reference(DiagnosticReport/example-endoscopy-diagnostic-report)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* basedOn = Reference(ServiceRequest/example-endoscopy-order-header)
* authoredOn = "2026-04-10T11:00:00+09:00"
* lastModified = "2026-04-10T11:00:00+09:00"
* description = "2026-04-10 上部消化管内視鏡 胃体上部に 3 型進行癌を疑う潰瘍性病変。"
* input[examDate].type.text = "検査日"
* input[examDate].valueDate = "2026-04-10"
* input[examContent].type.text = "検査内容"
* input[examContent].valueString = "上部消化管内視鏡"
* input[summary].type.text = "要点"
* input[summary].valueString = "胃体上部に 3 型進行癌を疑う潰瘍性病変。"

Instance: example-pathway-variance-task
InstanceOf: FC_PathwayVarianceTask
Usage: #example
Title: "パスのバリアンス 通知の例"
Description: "パスのバリアンス 通知の例"
* status = #requested
* intent = #filler-order
* priority = #urgent
* code = $task-code#pathway-variance "パスのバリアンス"
* code.text = "パスのバリアンス"
* focus = Reference(Observation/example-pathway-evaluation-observation)
* basedOn = Reference(CarePlan/example-pathway-unit-care-plan)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* requester = Reference(Practitioner/example-nurse)
* authoredOn = "2026-04-09T17:00:00+09:00"
* lastModified = "2026-04-09T17:00:00+09:00"
* description = "大腿骨頚部骨折 術後 1 日目 疼痛がコントロールされている 未達成"
* input[pathway].type.text = "パス名"
* input[pathway].valueString = "大腿骨頚部骨折"
* input[apply].type.text = "適用"
* input[apply].valueString = "example-pathway-apply-care-plan"
* input[event].type.text = "病日"
* input[event].valueString = "example-pathway-event-care-plan"
* input[eventLabel].type.text = "病日の表示"
* input[eventLabel].valueString = "術後 1 日目"
* input[targetDate].type.text = "対象日"
* input[targetDate].valueDate = "2026-04-09"
* input[outcome].type.text = "アウトカム"
* input[outcome].valueString = "疼痛がコントロールされている"

Instance: example-radiotherapy-review-due-task
InstanceOf: FC_RadiotherapyReviewDueTask
Usage: #example
Title: "放射線治療の診察 通知の例"
Description: "放射線治療の診察 通知の例"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#radiotherapy-review-due "放射線治療の診察"
* code.text = "放射線治療の診察"
* focus = Reference(ServiceRequest/example-radiotherapy-order)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-22T09:00:00+09:00"
* lastModified = "2026-04-22T09:00:00+09:00"
* description = "第1コース 右側 胸部 前回の診察 2026-04-15（7 日、間隔 7 日）"
* input[course].type.text = "治療コース"
* input[course].valueString = "第1コース 右側 胸部"
* input[lastReview].type.text = "前回の診察"
* input[lastReview].valueDate = "2026-04-15"

Instance: example-nursing-summary-returned-task
InstanceOf: FC_NursingSummaryReturnedTask
Usage: #example
Title: "看護サマリー差戻し 通知の例"
Description: "看護サマリー差戻し 通知の例"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#nursing-summary-returned "看護サマリー差戻し"
* code.text = "看護サマリー差戻し"
* focus = Reference(Composition/example-nursing-summary)
* for = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* owner = Reference(Practitioner/example-nurse)
* requester = Reference(Practitioner/example-nurse-2)
* authoredOn = "2026-04-20T15:30:00+09:00"
* lastModified = "2026-04-20T15:30:00+09:00"
* description = "看護サマリー(退院) 差戻し: 継続看護に退院後の連絡先を追記してください"
* input[summary].type.text = "看護サマリ"
* input[summary].valueString = "看護サマリー(退院)"
* input[reason].type.text = "理由"
* input[reason].valueString = "継続看護に退院後の連絡先を追記してください"

Instance: example-trainee-order-approval-task
InstanceOf: FC_OrderApprovalTask
Usage: #example
Title: "オーダー承認 通知の例(研修医の入力)"
Description: "研修医が入れたオーダーの、指導医宛の承認依頼(指導医ごとに 1 件)。"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#order-approval "オーダー承認"
* code.text = "オーダー承認"
* focus = Reference(Provenance/example-trainee-order-provenance)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* owner.display = "山田 一郎"
* requester = Reference(Practitioner/example-resident)
* requester.display = "研修 太郎"
* basedOn = Reference(ServiceRequest/example-lab-order-header)
* authoredOn = "2026-04-01T11:00:00+09:00"
* lastModified = "2026-04-01T11:00:00+09:00"
* description = "検体検査の登録（研修医: 研修 太郎）"
* input[activity].type.text = "活動"
* input[activity].valueCode = #CREATE
* input[kind][0].type.text = "種別"
* input[kind][0].valueCode = #lab-order
* input[order][0].type.text = "対象オーダー"
* input[order][0].valueReference = Reference(ServiceRequest/example-lab-order-header)
* input[startDate].type.text = "開始日"
* input[startDate].valueString = "2026-04-02"
* input[trainee].type.text = "研修医"
* input[trainee].valueString = "研修 太郎"

Instance: example-note-countersign-task
InstanceOf: FC_NoteCountersignTask
Usage: #example
Title: "カルテ承認 通知の例"
Description: "研修医の診療記録のカウンターサイン依頼(承認済で対応済み。指導医のコメントは task-note-comment 付きの note)。"
* status = #completed
* intent = #filler-order
* priority = #routine
* code = $task-code#note-countersign "カルテ承認"
* code.text = "カルテ承認"
* focus = Reference(Composition/example-countersign-clinical-note)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* owner.display = "山田 一郎"
* requester = Reference(Practitioner/example-resident)
* requester.display = "研修 太郎"
* authoredOn = "2026-04-03T10:00:00+09:00"
* lastModified = "2026-04-03T17:30:00+09:00"
* executionPeriod.start = "2026-04-03T10:00:00+09:00"
* executionPeriod.end = "2026-04-03T17:30:00+09:00"
* description = "診療記録（2026-04-03） のカウンターサイン（研修医: 研修 太郎）"
* input[note].type.text = "記録"
* input[note].valueString = "診療記録（2026-04-03）"
* input[trainee].type.text = "研修医"
* input[trainee].valueString = "研修 太郎"
* note[0].extension[comment].valueBoolean = true
* note[0].authorReference = Reference(Practitioner/example-practitioner)
* note[0].authorReference.display = "山田 一郎"
* note[0].time = "2026-04-03T15:00:00+09:00"
* note[0].text = "鑑別に肺炎も挙げておくこと"
* note[1].authorReference = Reference(Practitioner/example-practitioner)
* note[1].authorReference.display = "山田 一郎"
* note[1].time = "2026-04-03T17:30:00+09:00"
* note[1].text = "記録を承認しました。"

Instance: example-note-returned-task
InstanceOf: FC_NoteReturnedTask
Usage: #example
Title: "カルテ差戻し 通知の例"
Description: "指導医が研修医の診療記録を差し戻したときの、研修医宛の通知。"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#note-returned "カルテ差戻し"
* code.text = "カルテ差戻し"
* focus = Reference(Composition/example-countersign-clinical-note)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-resident)
* requester = Reference(Practitioner/example-practitioner)
* requester.display = "山田 一郎"
* authoredOn = "2026-04-03T12:00:00+09:00"
* lastModified = "2026-04-03T12:00:00+09:00"
* description = "診療記録（2026-04-03） 差戻し: 身体所見を追記してください"
* input[note].type.text = "記録"
* input[note].valueString = "診療記録（2026-04-03）"
* input[reason].type.text = "理由"
* input[reason].valueString = "身体所見を追記してください"
