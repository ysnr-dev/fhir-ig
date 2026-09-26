// 部門進捗 Task と通知 Task の例。

Instance: example-lab-exam-task
InstanceOf: FC_LabExamTask
Usage: #example
Title: "検体検査 進捗 Task の例(受付済)"
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
* status = #completed
* intent = #filler-order
* priority = #routine
* code = $task-code#rad-exam "放射線検査"
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
* status = #in-progress
* intent = #filler-order
* code = $task-code#radiotherapy "放射線治療"
* focus = Reference(ServiceRequest/example-radiotherapy-order)
* for = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-02T09:00:00+09:00"
* lastModified = "2026-04-15T09:00:00+09:00"
* executionPeriod.start = "2026-04-15T09:00:00+09:00"

Instance: example-endoscopy-exam-task
InstanceOf: FC_EndoscopyExamTask
Usage: #example
Title: "内視鏡 進捗 Task の例"
* status = #accepted
* intent = #filler-order
* priority = #routine
* code = $task-code#endoscopy-exam "内視鏡"
* focus = Reference(ServiceRequest/example-endoscopy-order-header)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-10T08:40:00+09:00"
* lastModified = "2026-04-10T08:40:00+09:00"
* executionPeriod.start = "2026-04-10T08:40:00+09:00"

Instance: example-physio-exam-task
InstanceOf: FC_PhysioExamTask
Usage: #example
Title: "生理検査 進捗 Task の例"
* status = #completed
* intent = #filler-order
* priority = #urgent
* code = $task-code#physio-exam "生理検査"
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
* status = #accepted
* intent = #filler-order
* priority = #routine
* code = $task-code#patho-exam "病理検査"
* focus = Reference(ServiceRequest/example-patho-order-header)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-10T13:00:00+09:00"
* lastModified = "2026-04-10T13:00:00+09:00"
* executionPeriod.start = "2026-04-10T13:00:00+09:00"

Instance: example-surgery-task
InstanceOf: FC_SurgeryTask
Usage: #example
Title: "手術 進捗 Task の例(入室中)"
* status = #in-progress
* intent = #filler-order
* priority = #routine
* code = $task-code#surgery "手術"
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
* status = #completed
* intent = #filler-order
* code = $task-code#treatment "処置"
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
* status = #accepted
* intent = #filler-order
* code = $task-code#rehab "リハビリ"
* focus = Reference(ServiceRequest/example-rehab-order)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-10T09:00:00+09:00"
* lastModified = "2026-04-10T09:00:00+09:00"
* executionPeriod.start = "2026-04-10T09:00:00+09:00"

Instance: example-consult-task
InstanceOf: FC_ConsultTask
Usage: #example
Title: "他科依頼 進捗 Task の例"
* status = #accepted
* intent = #filler-order
* priority = #routine
* code = $task-code#consult "他科依頼"
* focus = Reference(ServiceRequest/example-consult-order)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-02T13:00:00+09:00"
* lastModified = "2026-04-02T13:00:00+09:00"
* executionPeriod.start = "2026-04-02T13:00:00+09:00"

Instance: example-nursing-task
InstanceOf: FC_NursingTask
Usage: #example
Title: "看護指示 Task の例(指示受け済)"
* status = #accepted
* intent = #filler-order
* code = $task-code#nursing "看護指示"
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
* status = #in-progress
* intent = #filler-order
* priority = #urgent
* code = $task-code#transfusion "輸血"
* focus = Reference(ServiceRequest/example-transfusion-order-header)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-08T12:30:00+09:00"
* lastModified = "2026-04-08T14:30:00+09:00"
* executionPeriod.start = "2026-04-08T12:30:00+09:00"

Instance: example-nutrition-guidance-task
InstanceOf: FC_NutritionGuidanceTask
Usage: #example
Title: "栄養指導 進捗 Task の例"
* status = #accepted
* intent = #filler-order
* code = $task-code#nutrition-guidance "栄養指導"
* focus = Reference(ServiceRequest/example-nutrition-guidance-order)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-05T10:00:00+09:00"
* lastModified = "2026-04-05T10:00:00+09:00"
* executionPeriod.start = "2026-04-05T10:00:00+09:00"

Instance: example-rx-dispense-task
InstanceOf: FC_RxDispenseTask
Usage: #example
Title: "調剤 進捗 Task の例(調剤済)"
* status = #in-progress
* intent = #filler-order
* code = $task-code#rx-dispense "調剤"
* focus = Reference(ServiceRequest/example-prescription-order)
* for = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T12:00:00+09:00"
* lastModified = "2026-04-01T15:00:00+09:00"
* executionPeriod.start = "2026-04-01T12:00:00+09:00"
* executionPeriod.end = "2026-04-01T15:00:00+09:00"
* note.time = "2026-04-01T13:00:00+09:00"
* note.text = "用量確認済み"

Instance: example-injection-task
InstanceOf: FC_InjectionTask
Usage: #example
Title: "注射 進捗 Task の例(払出済)"
* status = #in-progress
* intent = #filler-order
* code = $task-code#injection "注射"
* focus = Reference(ServiceRequest/example-injection-order)
* for = Reference(Patient/example-patient)
* authoredOn = "2026-04-02T07:00:00+09:00"
* lastModified = "2026-04-02T08:00:00+09:00"
* executionPeriod.start = "2026-04-02T07:00:00+09:00"

Instance: example-brought-med-review-task
InstanceOf: FC_BroughtMedReviewTask
Usage: #example
Title: "持参薬鑑別 Task の例"
* status = #in-progress
* intent = #order
* code = $task-code#brought-med-review "持参薬鑑別"
* focus = Reference(Encounter/example-encounter)
* encounter = Reference(Encounter/example-encounter)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T12:00:00+09:00"
* input[ward].type.text = "病棟"
* input[ward].valueString = "東3階病棟"
* input[admissionDate].type.text = "入院日"
* input[admissionDate].valueDate = "2026-04-01"

// ---- 通知 Task ----

Instance: example-order-approval-task
InstanceOf: FC_OrderApprovalTask
Usage: #example
Title: "オーダー承認 通知の例"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#order-approval "オーダー承認"
* focus = Reference(Provenance/example-order-provenance)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* requester = Reference(Practitioner/example-practitioner)
* basedOn = Reference(ServiceRequest/example-lab-order-header)
* authoredOn = "2026-04-01T09:00:00+09:00"
* description = "検体検査オーダーの代行入力を承認してください"
* input[activity].type.text = "活動"
* input[activity].valueCode = #CREATE
* input[kind][0].type.text = "種別"
* input[kind][0].valueCode = #lab
* input[order][0].type.text = "対象オーダー"
* input[order][0].valueReference = Reference(ServiceRequest/example-lab-order-header)
* input[startDate].type.text = "開始日"
* input[startDate].valueString = "2026-04-02"

Instance: example-brought-med-identified-task
InstanceOf: FC_BroughtMedIdentifiedTask
Usage: #example
Title: "持参薬鑑別済 通知の例"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#brought-med-identified "持参薬鑑別済"
* focus = Reference(Encounter/example-encounter)
* encounter = Reference(Encounter/example-encounter)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T16:00:00+09:00"
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
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#document-due "文書作成"
* focus = Reference(Encounter/example-encounter)
* encounter = Reference(Encounter/example-encounter)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-20T09:00:00+09:00"
* restriction.period.end = "2026-05-04T00:00:00+09:00"
* input[document].type.text = "文書"
* input[document].valueCode = #discharge-summary
* input[documentName].type.text = "文書名"
* input[documentName].valueString = "退院時サマリー"
* input[admission].type.text = "入院"
* input[admission].valueReference = Reference(Encounter/example-encounter)
* input[dischargeDate].type.text = "退院日"
* input[dischargeDate].valueString = "2026-04-20"
* input[dueDate].type.text = "期限"
* input[dueDate].valueString = "2026-05-04"

Instance: example-lab-panic-task
InstanceOf: FC_LabPanicTask
Usage: #example
Title: "緊急異常値 通知の例"
* status = #requested
* intent = #filler-order
* priority = #stat
* code = $task-code#lab-panic "緊急異常値"
* focus = Reference(DiagnosticReport/example-lab-diagnostic-report)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-02T12:00:00+09:00"
* description = "K 6.8 mmol/L"
* input[collectedDate].type.text = "検体採取日"
* input[collectedDate].valueDate = "2026-04-02"
* input[1].type.coding[0] = http://fhir-client.local/CodeSystem/lab-result-item#0402 "K"
* input[1].type.coding[1] = $v3-ObservationInterpretation#HH
* input[1].valueQuantity = 6.8 'mmol/L' "mmol/L"

Instance: example-result-review-task
InstanceOf: FC_ResultReviewTask
Usage: #example
Title: "検査結果確認 通知の例"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#result-review "検査結果確認"
* focus = Reference(DiagnosticReport/example-lab-diagnostic-report)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-02T12:00:00+09:00"
* input[kind].type.text = "種別"
* input[kind].valueString = "lab"
* input[targetDate].type.text = "対象日"
* input[targetDate].valueString = "2026-04-02"
* input[content].type.text = "内容"
* input[content].valueString = "HbA1c ほか 3 項目"

Instance: example-rad-critical-finding-task
InstanceOf: FC_RadCriticalFindingTask
Usage: #example
Title: "重要所見 通知の例"
* status = #requested
* intent = #filler-order
* priority = #stat
* code = $task-code#rad-critical-finding "重要所見"
* focus = Reference(DiagnosticReport/example-rad-diagnostic-report)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-03T15:00:00+09:00"
* input[examDate].type.text = "撮影日"
* input[examDate].valueString = "2026-04-03"
* input[examContent].type.text = "撮影内容"
* input[examContent].valueString = "胸部 CT"
* input[summary].type.text = "要点"
* input[summary].valueString = "右下葉に腫瘤影。精査を要する。"

Instance: example-pathway-variance-task
InstanceOf: FC_PathwayVarianceTask
Usage: #example
Title: "パスのバリアンス 通知の例"
* status = #requested
* intent = #filler-order
* priority = #urgent
* code = $task-code#pathway-variance "パスのバリアンス"
* focus = Reference(Observation/example-pathway-evaluation-observation)
* basedOn = Reference(CarePlan/example-pathway-unit-care-plan)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-09T17:00:00+09:00"

Instance: example-radiotherapy-review-due-task
InstanceOf: FC_RadiotherapyReviewDueTask
Usage: #example
Title: "放射線治療の診察 通知の例"
* status = #requested
* intent = #filler-order
* priority = #routine
* code = $task-code#radiotherapy-review-due "放射線治療の診察"
* focus = Reference(ServiceRequest/example-radiotherapy-order)
* for = Reference(Patient/example-patient)
* owner = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-22T09:00:00+09:00"
* input[course].type.text = "治療コース"
* input[course].valueString = "第 1 コース"
* input[lastReview].type.text = "前回の診察"
* input[lastReview].valueString = "2026-04-15"
