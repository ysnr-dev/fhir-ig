// Task: 部門進捗 Task(オーダーの部門側の進捗)と通知 Task(担当者宛の通知)。

// ---- status の部分集合 ----

ValueSet: FCTaskStatusBasicVS
Id: fc-task-status-basic-vs
Title: "部門 Task の状態(基本 4 状態)"
Description: "requested 依頼済 / accepted 受付済 / completed 実施済 / cancelled 中止"
* insert FCMeta
* $task-status#requested
* $task-status#accepted
* $task-status#completed
* $task-status#cancelled

ValueSet: FCTaskStatusInProgressVS
Id: fc-task-status-in-progress-vs
Title: "部門 Task の状態(作業中あり)"
Description: "requested / accepted / in-progress / completed / cancelled。in-progress の意味は種別ごと(手術: 入室中、輸血: 出庫済、調剤: 調剤済、注射: 払出済)。"
* insert FCMeta
* $task-status#requested
* $task-status#accepted
* $task-status#in-progress
* $task-status#completed
* $task-status#cancelled

ValueSet: FCTaskStatusRadiotherapyVS
Id: fc-task-status-radiotherapy-vs
Title: "放射線治療 Task の状態"
Description: "requested 処方済 / accepted 計画中 / in-progress 治療中 / on-hold 休止 / completed 終了 / cancelled 中止"
* insert FCMeta
* $task-status#requested
* $task-status#accepted
* $task-status#in-progress
* $task-status#on-hold
* $task-status#completed
* $task-status#cancelled

ValueSet: FCTaskStatusNursingVS
Id: fc-task-status-nursing-vs
Title: "看護指示 Task の状態"
Description: "requested 指示受け待ち / accepted 指示受け済 / cancelled 中止"
* insert FCMeta
* $task-status#requested
* $task-status#accepted
* $task-status#cancelled

ValueSet: FCTaskStatusNotificationVS
Id: fc-task-status-notification-vs
Title: "通知 Task の状態"
Description: "requested 未対応 / completed 対応済 / cancelled 取消"
* insert FCMeta
* $task-status#requested
* $task-status#completed
* $task-status#cancelled

ValueSet: FCTaskStatusReviewVS
Id: fc-task-status-review-vs
Title: "持参薬鑑別 Task の状態"
Description: "requested / in-progress 鑑別中 / completed / cancelled"
* insert FCMeta
* $task-status#requested
* $task-status#in-progress
* $task-status#completed
* $task-status#cancelled

// ---- 部門進捗 Task ----

Profile: FC_DepartmentTask
Parent: Task
Id: fc-department-task
Title: "部門進捗 Task(共通)"
Description: """オーダー(focus)の部門側の進捗。

- Task が存在しない = requested。最初の状態変更で作られる(看護指示だけは登録時に作る)。
- intent = filler-order。code = Task 種別(task-code)。focus = ヘッダ ServiceRequest(同じ Bundle で登録するときは urn:uuid)。for = 患者。
- priority / requester はオーダーから複製。authoredOn / lastModified を持つ。
- executionPeriod: accepted / in-progress / on-hold で start、completed で end。requested / cancelled では持たない。
- owner は看護指示以外は持たない。businessStatus / input / 拡張は持たない。"""
* insert FCMeta
* ^abstract = true
* intent = #filler-order
* code 1..1 MS
* code from TaskCodeVS (required)
* code.coding 1..1
* focus 1..1 MS
* focus only Reference(ServiceRequest)
* for 1..1 MS
* for only Reference(FC_Patient)
* authoredOn 1..1
* lastModified 1..1
* requester only Reference(FC_Practitioner)
* owner only Reference(FC_Practitioner)
* executionPeriod MS
* input 0..0
* businessStatus 0..0

Profile: FC_LabExamTask
Parent: FC_DepartmentTask
Id: fc-lab-exam-task
Title: "検体検査 進捗 Task"
* code = $task-code#lab-exam "検体検査"
* status from FCTaskStatusBasicVS (required)
* focus only Reference(FC_LabOrderHeader)

Profile: FC_RadExamTask
Parent: FC_DepartmentTask
Id: fc-rad-exam-task
Title: "放射線検査 進捗 Task"
Description: "放射線検査の進捗。実施登録と同時に completed になる。「即時実施」(検査を実施してから登録)では completed の Task がオーダーと同じ transaction で作られ、focus は urn:uuid。"
* code = $task-code#rad-exam "放射線検査"
* status from FCTaskStatusBasicVS (required)
* focus only Reference(FC_RadOrderHeader)

Profile: FC_RadiotherapyTask
Parent: FC_DepartmentTask
Id: fc-radiotherapy-task
Title: "放射線治療 進捗 Task"
Description: "放射線治療の進捗。状態変更は処方 ServiceRequest.status(active / on-hold / completed / revoked)と同じ transaction で行う。"
* code = $task-code#radiotherapy "放射線治療"
* status from FCTaskStatusRadiotherapyVS (required)
* focus only Reference(FC_RadiotherapyOrder)

Profile: FC_EndoscopyExamTask
Parent: FC_DepartmentTask
Id: fc-endoscopy-exam-task
Title: "内視鏡 進捗 Task"
* code = $task-code#endoscopy-exam "内視鏡"
* status from FCTaskStatusBasicVS (required)
* focus only Reference(FC_EndoscopyOrderHeader)

Profile: FC_PhysioExamTask
Parent: FC_DepartmentTask
Id: fc-physio-exam-task
Title: "生理検査 進捗 Task"
* code = $task-code#physio-exam "生理検査"
* status from FCTaskStatusBasicVS (required)
* focus only Reference(FC_PhysioOrderHeader)

Profile: FC_PathoExamTask
Parent: FC_DepartmentTask
Id: fc-patho-exam-task
Title: "病理検査 進捗 Task"
Description: "completed の表示は「検査済」。"
* code = $task-code#patho-exam "病理検査"
* status from FCTaskStatusBasicVS (required)
* focus only Reference(FC_PathoOrderHeader)

Profile: FC_SurgeryTask
Parent: FC_DepartmentTask
Id: fc-surgery-task
Title: "手術 進捗 Task"
Description: "requested 申込済 / accepted 受付済 / in-progress 入室中 / completed 実施済 / cancelled 中止。"
* code = $task-code#surgery "手術"
* status from FCTaskStatusInProgressVS (required)
* focus only Reference(FC_SurgeryOrderHeader)

Profile: FC_TreatmentTask
Parent: FC_DepartmentTask
Id: fc-treatment-task
Title: "処置 進捗 Task"
* code = $task-code#treatment "処置"
* status from FCTaskStatusBasicVS (required)
* focus only Reference(FC_TreatmentOrderHeader)

Profile: FC_RehabTask
Parent: FC_DepartmentTask
Id: fc-rehab-task
Title: "リハビリ 進捗 Task"
Description: "requested 依頼済 / accepted 実施中(期間中はこのまま)/ completed 終了 / cancelled 中止。"
* code = $task-code#rehab "リハビリ"
* status from FCTaskStatusBasicVS (required)
* focus only Reference(FC_RehabOrder)

Profile: FC_ConsultTask
Parent: FC_DepartmentTask
Id: fc-consult-task
Title: "他科依頼 進捗 Task"
Description: "requested 依頼済 / accepted 対応中 / completed 回答済 / cancelled 取消。他科依頼 ServiceRequest.status と連動する。"
* code = $task-code#consult "他科依頼"
* status from FCTaskStatusBasicVS (required)
* focus only Reference(FC_ConsultOrder)

Profile: FC_NursingTask
Parent: FC_DepartmentTask
Id: fc-nursing-task
Title: "看護指示 Task(指示受け)"
Description: "看護指示の指示受け。登録時に requested で作られ、指示受けで accepted。owner = 指示受けした看護師。"
* code = $task-code#nursing "看護指示"
* status from FCTaskStatusNursingVS (required)
* focus only Reference(FC_NursingOrder)
* owner MS

Profile: FC_TransfusionTask
Parent: FC_DepartmentTask
Id: fc-transfusion-task
Title: "輸血 進捗 Task"
Description: "requested 依頼済 / accepted 受付済 / in-progress 出庫済 / completed 実施済 / cancelled 中止。"
* code = $task-code#transfusion "輸血"
* status from FCTaskStatusInProgressVS (required)
* focus only Reference(FC_TransfusionOrderHeader)

Profile: FC_NutritionGuidanceTask
Parent: FC_DepartmentTask
Id: fc-nutrition-guidance-task
Title: "栄養指導 進捗 Task"
Description: "requested 依頼済 / accepted 実施中 / completed 終了 / cancelled 中止。"
* code = $task-code#nutrition-guidance "栄養指導"
* status from FCTaskStatusBasicVS (required)
* focus only Reference(FC_NutritionGuidanceOrder)

Profile: FC_RxDispenseTask
Parent: FC_DepartmentTask
Id: fc-rx-dispense-task
Title: "調剤 進捗 Task"
Description: "処方の調剤進捗。requested 依頼済 / accepted 受付済(処方箋発行)/ in-progress 調剤済 / completed 実施済 / cancelled 中止。note[] に疑義照会(時刻付き)。executionPeriod.start は受付、end は調剤(preserveEnd)。"
* code = $task-code#rx-dispense "調剤"
* status from FCTaskStatusInProgressVS (required)
* focus only Reference(FC_PrescriptionOrder)
* note ^short = "疑義照会"

Profile: FC_InjectionTask
Parent: FC_DepartmentTask
Id: fc-injection-task
Title: "注射 進捗 Task"
Description: "注射(1 日分の ServiceRequest)の進捗。requested 依頼済 / accepted 受付済 / in-progress 払出済 / completed 実施済 / cancelled 中止。実施記録の数が timing.event の数に達したら completed。"
* code = $task-code#injection "注射"
* status from FCTaskStatusInProgressVS (required)
* focus only Reference(FC_InjectionOrder)

Profile: FC_BroughtMedReviewTask
Parent: Task
Id: fc-brought-med-review-task
Title: "持参薬鑑別 Task"
Description: "薬剤部の持参薬鑑別の作業 Task。intent = order。focus と encounter = 入院 Encounter。input: 病棟(valueString)、入院日(valueDate)。owner = 薬剤師。入院中に持参薬を登録すると作られる。"
* insert FCMeta
* intent = #order
* code 1..1
* code = $task-code#brought-med-review "持参薬鑑別"
* status from FCTaskStatusReviewVS (required)
* focus 1..1
* focus only Reference(FC_InpatientEncounter)
* encounter 1..1
* encounter only Reference(FC_InpatientEncounter)
* for 1..1
* for only Reference(FC_Patient)
* owner only Reference(FC_Practitioner)
* input ^slicing.discriminator[0].type = #value
* input ^slicing.discriminator[0].path = "type.text"
* input ^slicing.rules = #open
* input contains
    ward 0..1 and
    admissionDate 0..1
* input[ward].type.text = "病棟"
* input[ward].value[x] only string
* input[admissionDate].type.text = "入院日"
* input[admissionDate].value[x] only date

// ---- 通知 Task ----

Profile: FC_NotificationTask
Parent: Task
Id: fc-notification-task
Title: "通知 Task(共通)"
Description: """担当者宛の通知。

- status: requested 未対応 / completed 対応済 / cancelled 取消。intent = filler-order。
- priority は重要度(alert → stat、caution → urgent、info → routine)。
- code = 通知種別(task-code)。focus = 通知の対象、for = 患者、owner = 宛先の職員、requester = 発生させた職員、basedOn = 関連するオーダー。
- input[] は type.text をキーにした付帯情報(種別ごとに定義)。restriction.period.end = 期限。
- 対応済みにするとき executionPeriod と note(authorReference / time / text)が付く。"""
* insert FCMeta
* ^abstract = true
* intent = #filler-order
* status from FCTaskStatusNotificationVS (required)
* priority 1..1 MS
* code 1..1 MS
* code from TaskCodeVS (required)
* code.coding 1..1
* focus 1..1 MS
* for 1..1 MS
* for only Reference(FC_Patient)
* owner 0..1 MS
* owner only Reference(FC_Practitioner)
* owner ^short = "宛先の職員。宛先が決まらない緊急異常値だけ無し"
* requester only Reference(FC_Practitioner)
* authoredOn 1..1
* description MS
* restriction.period.end ^short = "期限"
* input ^slicing.discriminator[0].type = #value
* input ^slicing.discriminator[0].path = "type.text"
* input ^slicing.rules = #open

Profile: FC_OrderApprovalTask
Parent: FC_NotificationTask
Id: fc-order-approval-task
Title: "オーダー承認 通知"
Description: "代行入力されたオーダーの承認依頼。focus = オーダーの Provenance、owner = 依頼医(承認者)、requester = 入力者、basedOn = ヘッダ ServiceRequest。input: 活動(valueCode = Provenance.activity)、種別(valueCode、複数)、対象オーダー(valueReference、複数)、開始日 / 依頼 / セット(valueString)。backend の backfill(notifications.rake)も同じ形で作る。"
* code = $task-code#order-approval "オーダー承認"
* focus only Reference(FC_OrderProvenance)
* basedOn only Reference(ServiceRequest)
* input contains
    activity 0..1 and
    kind 0..* and
    order 0..* and
    startDate 0..1 and
    request 0..1 and
    orderSet 0..1
* input[activity].type.text = "活動"
* input[activity].value[x] only code
* input[kind].type.text = "種別"
* input[kind].value[x] only code
* input[order].type.text = "対象オーダー"
* input[order].value[x] only Reference(ServiceRequest)
* input[startDate].type.text = "開始日"
* input[startDate].value[x] only string
* input[request].type.text = "依頼"
* input[request].value[x] only string
* input[orderSet].type.text = "セット"
* input[orderSet].value[x] only string

Profile: FC_BroughtMedIdentifiedTask
Parent: FC_NotificationTask
Id: fc-brought-med-identified-task
Title: "持参薬鑑別済 通知"
Description: "薬剤部の鑑別が終わったことを担当医に知らせる。focus と encounter = 入院。input: 入院(valueReference)、入院日(valueDate)、剤数(valueInteger)、判断待ち(valueInteger)。"
* code = $task-code#brought-med-identified "持参薬鑑別済"
* focus only Reference(FC_InpatientEncounter)
* encounter only Reference(FC_InpatientEncounter)
* input contains
    admission 0..1 and
    admissionDate 0..1 and
    drugCount 0..1 and
    pendingCount 0..1
* input[admission].type.text = "入院"
* input[admission].value[x] only Reference(Encounter)
* input[admissionDate].type.text = "入院日"
* input[admissionDate].value[x] only date
* input[drugCount].type.text = "剤数"
* input[drugCount].value[x] only integer
* input[pendingCount].type.text = "判断待ち"
* input[pendingCount].value[x] only integer

Profile: FC_DocumentDueTask
Parent: FC_NotificationTask
Id: fc-document-due-task
Title: "文書作成 督促"
Description: "退院時サマリーなどの文書作成の督促。focus と encounter = 入院。restriction.period.end = 期限。input: 文書(valueCode = discharge-summary)、文書名 / 退院日 / 期限(valueString)、入院(valueReference)。"
* code = $task-code#document-due "文書作成"
* focus only Reference(FC_InpatientEncounter)
* encounter only Reference(FC_InpatientEncounter)
* input contains
    document 1..1 and
    documentName 0..1 and
    admission 0..1 and
    dischargeDate 0..1 and
    dueDate 0..1
* input[document].type.text = "文書"
* input[document].value[x] only code
* input[documentName].type.text = "文書名"
* input[documentName].value[x] only string
* input[admission].type.text = "入院"
* input[admission].value[x] only Reference(Encounter)
* input[dischargeDate].type.text = "退院日"
* input[dischargeDate].value[x] only string
* input[dueDate].type.text = "期限"
* input[dueDate].value[x] only string

Profile: FC_LabPanicTask
Parent: FC_NotificationTask
Id: fc-lab-panic-task
Title: "緊急異常値 通知"
Description: "検体検査結果のパニック値。priority = stat。focus = DiagnosticReport。input: 検体採取日(valueDate)と、パニック値の項目ごとに type.coding = [lab-result-item(display のみ), v3-ObservationInterpretation の HH / LL] + valueQuantity。宛先が決まらない(依頼医が居ない)ときは owner を持たない。"
* code = $task-code#lab-panic "緊急異常値"
* priority = #stat
* focus only Reference(FC_LabDiagnosticReport)
* input contains collectedDate 0..1
* input[collectedDate].type.text = "検体採取日"
* input[collectedDate].value[x] only date

Profile: FC_ResultReviewTask
Parent: FC_NotificationTask
Id: fc-result-review-task
Title: "検査結果確認 通知"
Description: "検査結果が届いたことを依頼医に知らせる。preliminary でない報告で作られる。focus = DiagnosticReport。input: 種別(valueString、例 lab)、対象日、内容。確認すると結果確認の Provenance(verifier + signature)が付く。"
* code = $task-code#result-review "検査結果確認"
* focus only Reference(DiagnosticReport)
* input contains
    kind 0..1 and
    targetDate 0..1 and
    content 0..1
* input[kind].type.text = "種別"
* input[kind].value[x] only string
* input[targetDate].type.text = "対象日"
* input[targetDate].value[x] only string
* input[content].type.text = "内容"
* input[content].value[x] only string

Profile: FC_RadCriticalFindingTask
Parent: FC_NotificationTask
Id: fc-rad-critical-finding-task
Title: "重要所見 通知"
Description: "読影レポートの重要所見。priority = stat。focus = 読影 DiagnosticReport。input: 撮影日 / 撮影内容 / 要点(valueString)。"
* code = $task-code#rad-critical-finding "重要所見"
* priority = #stat
* focus only Reference(FC_RadDiagnosticReport)
* input contains
    examDate 0..1 and
    examContent 0..1 and
    summary 0..1
* input[examDate].type.text = "撮影日"
* input[examDate].value[x] only string
* input[examContent].type.text = "撮影内容"
* input[examContent].value[x] only string
* input[summary].type.text = "要点"
* input[summary].value[x] only string

Profile: FC_PathwayVarianceTask
Parent: FC_NotificationTask
Id: fc-pathway-variance-task
Title: "パスのバリアンス 通知"
Description: "クリニカルパスの評価で未達成が出たことの通知。priority = urgent。focus = 評価 Observation、basedOn = OAT 単位の CarePlan。"
* code = $task-code#pathway-variance "パスのバリアンス"
* priority = #urgent
* focus only Reference(FC_PathwayEvaluationObservation)
* basedOn only Reference(FC_PathwayUnitCarePlan)

Profile: FC_RadiotherapyReviewDueTask
Parent: FC_NotificationTask
Id: fc-radiotherapy-review-due-task
Title: "放射線治療の診察 通知"
Description: "治療中の週次診察が期限を迎えたことの通知。focus = 放射線治療処方。input: 治療コース / 前回の診察(valueString)。"
* code = $task-code#radiotherapy-review-due "放射線治療の診察"
* focus only Reference(FC_RadiotherapyOrder)
* input contains
    course 0..1 and
    lastReview 0..1
* input[course].type.text = "治療コース"
* input[course].value[x] only string
* input[lastReview].type.text = "前回の診察"
* input[lastReview].value[x] only string
