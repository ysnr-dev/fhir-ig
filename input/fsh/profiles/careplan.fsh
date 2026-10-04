// クリニカルパス: ePath R4 実装ガイドに倣った CarePlan 木(適用 → 病日 → OAT 単位 → アセスメント)と Goal / Observation。
// ePath の拡張・CodeSystem・IdSystem はパッケージ依存にせず URL で参照する(pathway.md を参照)。

Profile: FC_PathwayCarePlan
Parent: CarePlan
Id: fc-pathway-care-plan
Title: "パスの CarePlan(共通)"
Description: """クリニカルパスの CarePlan 木の共通形。

- intent = plan。category[0] は 1 つの CodeableConcept に coding を 2 つ持つ: care-plan-type#clinical-pathway(パスの印)と pathway-level(階層: apply / event / oat-unit / assessment)。どちらも display は付けない。
- partOf は根から自分の親までの祖先すべてを持つ(上流の part-of 検索で木を引くため)。根は partOf を持たない(part-of:missing = true)。
- identifier = ePath の IdSystem(apply-id / event-id / oat-unit-id / assessment-id)。
- pathway-display-order で定義どおりの並びを保つ(OAT 単位とアセスメントに付く。適用と病日には付かない)。"""
* insert FCMeta
* ^abstract = true
* intent = #plan
* subject only Reference(FC_Patient)
* category 1..*
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category ^slicing.ordered = true
* category contains marker 1..1
* category[marker] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway
* category[marker] ^short = "パスの印と階層(coding 2 つ)"
* category[marker].coding 2..2
* identifier 1..1
* partOf only Reference(FC_PathwayCarePlan)
* extension contains PathwayDisplayOrder named displayOrder 0..1

Profile: FC_PathwayApplyCarePlan
Parent: FC_PathwayCarePlan
Id: fc-pathway-apply-care-plan
Title: "パス適用(根)"
Description: "パスの適用 1 回を表す根の CarePlan。status: active → completed / revoked。period = 適用期間、encounter、addresses = 対象の病名、instantiatesUri = `http://fhir-client.local/pathway/{code}`。identifier = ePath apply-id(値 = {施設番号}.{uuid})。終了時は apply Goal(lifecycleStatus completed / cancelled、EPathGoalStatusReason)を作る。フェーズ分岐のあるパスはフェーズ単位で段階的に適用し、病日に pathway-phase / pathway-phase-note を付ける。"
* category[marker] ^patternCodeableConcept.coding[1].system = "http://fhir-client.local/CodeSystem/pathway-level"
* category[marker] ^patternCodeableConcept.coding[1].code = #apply
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/apply-id"
* partOf 0..0
* instantiatesUri 1..1
* period 1..1
* encounter only Reference(FC_InpatientEncounter or FC_OutpatientEncounter)
* addresses only Reference(FC_Condition)

Profile: FC_PathwayEventCarePlan
Parent: FC_PathwayCarePlan
Id: fc-pathway-event-care-plan
Title: "パスの病日"
Description: "病日(イベント)の CarePlan。partOf = [適用]。period.start = period.end = その日。identifier = ePath event-id(値は適用の値に「.{経過日数}[-{pathStep}]」を連結したもの)。ePath の EventElapsedDays / PathStep / PathStepName / PathStepInpatientOutpatientType / ScheduledDays 拡張を持つ。pathway-phase = フェーズ。"
* category[marker] ^patternCodeableConcept.coding[1].system = "http://fhir-client.local/CodeSystem/pathway-level"
* category[marker] ^patternCodeableConcept.coding[1].code = #event
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/event-id"
* partOf 1..1
* partOf only Reference(FC_PathwayApplyCarePlan)
* period 1..1
* extension contains
    PathwayPhase named phase 0..1 and
    PathwayPhaseNote named phaseNote 0..1

Profile: FC_PathwayUnitCarePlan
Parent: FC_PathwayCarePlan
Id: fc-pathway-unit-care-plan
Title: "パスの OAT 単位"
Description: "OAT(アウトカム・アセスメント・タスク)単位の CarePlan。partOf = [適用, 病日]。category の 2 番目以降に ePath のアウトカム分類を追加で持つ(区分 G 患者目標 / H 患者状態 = EPathBOMOutcomeCategoryCS、コード = EPathBOMOutcomeCodeCS または EPathLocalOutcomeCodeCS、コード体系だけ選んだときは EPathLocalOutcomeCategoryCS)。重要アウトカムは EPathCarePlanCriticalIndicator、予定外に足した単位は EPathCarePlanUnplannedKind 拡張を持つ。goal = アウトカム Goal。identifier = ePath oat-unit-id(値は病日の値に「.{unitKey}」を連結したもの)。評価 Observation が basedOn でこれを指す。"
* category[marker] ^patternCodeableConcept.coding[1].system = "http://fhir-client.local/CodeSystem/pathway-level"
* category[marker] ^patternCodeableConcept.coding[1].code = #oat-unit
* category ^short = "2 番目以降に ePath のアウトカム分類を持つ"
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/oat-unit-id"
* partOf 2..2
* goal only Reference(FC_PathwayOutcomeGoal)

Profile: FC_PathwayAssessmentCarePlan
Parent: FC_PathwayCarePlan
Id: fc-pathway-assessment-care-plan
Title: "パスのアセスメント"
Description: "アセスメントの CarePlan。partOf = [適用, 病日, OAT 単位]。category の 2 番目以降に ePath のアセスメント分類(EPathBOMAssessmentCategoryCS / EPathBOMAssessmentCodeCS または EPathLocalAssessmentCategoryCS / EPathLocalAssessmentCodeCS、コードが無ければ EPathAssessmentCodeEmptyCS#ZZZZZZZZZZ)と MEDIS 看護観察の coding を追加で持つことがある。goal = アセスメント Goal(target.detailString = 目標値)。identifier = ePath assessment-id(値は OAT 単位の値に連結)。タスク Procedure と実測 Observation が basedOn でこれを指す。"
* category[marker] ^patternCodeableConcept.coding[1].system = "http://fhir-client.local/CodeSystem/pathway-level"
* category[marker] ^patternCodeableConcept.coding[1].code = #assessment
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/assessment-id"
* partOf 3..3
* goal only Reference(FC_PathwayAssessmentGoal)

Profile: FC_PathwayAssessmentGoal
Parent: Goal
Id: fc-pathway-assessment-goal
Title: "パスのアセスメント目標"
Description: "アセスメントの目標値。target.detailString = 目標値。identifier = ePath assessment-goal-id。"
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/assessment-goal-id"
* target.detail[x] only string

Profile: FC_PathwayOutcomeGoal
Parent: Goal
Id: fc-pathway-outcome-goal
Title: "パスのアウトカム目標"
Description: "OAT 単位のアウトカム。評価を記録すると lifecycleStatus = completed、achievementStatus = 達成状況(EPathStateOfAchievementCS)、statusDate、outcomeReference = 評価 Observation になる。identifier = ePath outcome-goal-id(値は OAT 単位の identifier と同じ)。"
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/outcome-goal-id"
* outcomeReference only Reference(FC_PathwayEvaluationObservation)

Profile: FC_PathwayApplyGoal
Parent: Goal
Id: fc-pathway-apply-goal
Title: "パス適用の終了"
Description: "パス適用の終了(終了 / 中止)を表す Goal。description.text = パス名。lifecycleStatus = completed / cancelled、statusDate、ePath の EPathGoalStatusReason 拡張(EPathPathClosingTypeCS: 1 終了 / 2 中止)、note。identifier = ePath apply-goal-id。"
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/apply-goal-id"
* statusDate 1..1

Profile: FC_PathwayEvaluationObservation
Parent: Observation
Id: fc-pathway-evaluation-observation
Title: "パスのアウトカム評価"
Description: "OAT 単位のアウトカム評価。category[0] = care-plan-type#clinical-pathway。code = ePath EPathEvaluationItemCS#judgement(display = 評価、text = アウトカム名)。valueCodeableConcept = 達成状況(ePath EPathStateOfAchievementCS: 1 達成 / 2 未達成 / 3 未評価)。component = S / O / A / P と自由記載の comp-assessment(code = EPathEvaluationItemCS、valueString。テンプレートで書いたときは pathway-evaluation-template)。note[0] = コメント。basedOn = OAT 単位の CarePlan。identifier = ePath observation-evaluation-id(値は OAT 単位の identifier と同じ)。order-department = 記録した診療科(初回の評価で付け、評価し直しても書き換えない)。重要アウトカム(EPathCarePlanCriticalIndicator = Y)を未達成にしたときだけ pathway-variance 通知が作られ、未達成でなくなれば通知は cancelled になる。"
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/observation-evaluation-id"
* category 1..*
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category ^slicing.ordered = true
* category contains type 1..1
* category[type] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway
* code.coding.system = "http://e-path.jp/fhir/ePath/CodeSystem/EPathEvaluationItemCS"
* value[x] only CodeableConcept
* basedOn 1..1
* basedOn only Reference(FC_PathwayUnitCarePlan)
* component.code.coding.system = "http://e-path.jp/fhir/ePath/CodeSystem/EPathEvaluationItemCS"
* component.extension contains PathwayEvaluationTemplate named template 0..1
* extension contains OrderDepartment named orderDepartment 0..1

Profile: FC_PathwayResultObservation
Parent: Observation
Id: fc-pathway-result-observation
Title: "パスのアセスメント実測値"
Description: "アセスメント項目の実測値。category[0] = care-plan-type#clinical-pathway。code = アセスメントの coding(あれば)+ text = 項目名。値は項目の表現タイプに応じて valueQuantity(unit は文字列のみ)/ valueCodeableConcept(text + nursing-observation-result)/ valueString / component(2 値・血圧)のどれか。basedOn = アセスメントの CarePlan。identifier = ePath observation-result-id(値は OAT 単位の値に「.{assessmentKey}」を連結したもの)。"
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/observation-result-id"
* category 1..*
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category ^slicing.ordered = true
* category contains type 1..1
* category[type] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway
* value[x] only Quantity or CodeableConcept or string
* basedOn 1..1
* basedOn only Reference(FC_PathwayAssessmentCarePlan)

// ---- 看護計画 ----
// 看護問題 1 件を Condition(FC_NursingProblem)・CarePlan・Goal で持ち、評価を Observation で残す(nursing-care-plan.md)。

Profile: FC_NursingCarePlan
Parent: CarePlan
Id: fc-nursing-care-plan
Title: "看護計画"
Description: """看護問題 1 件の看護計画。Condition・Goal と 1 transaction で書く。

- status: active → completed(解決)/ entered-in-error(取消)。intent = plan。category = care-plan-type#nursing。title = 看護問題名。
- period.start = 立案日、解決・取消で period.end。addresses = 看護問題、goal = 目標(外した目標は goal から外して Goal を cancelled にする)。
- activity = OP / TP / EP の行、または看護介入の行動。id は行の uuid(展開した看護指示が nursing-care-plan-activity で指す)。nursing-plan-activity-type = 区分(看護介入の行動には無い)、nursing-intervention = 看護介入。detail.status = in-progress / stopped(中止した行)、detail.code = 看護指示と同じ形(MEDIS 看護行為・看護観察の coding + text、または text のみ)、detail.description = 行の文言。行が無ければ activity を持たない。
- nursing-care-plan-entry = 立案の入口。instantiatesUri = `http://fhir-client.local/master/nursing-standard-plans/{標準看護計画のコード}`(標準看護計画から立てたとき)。
- 新規のときだけ encounter(入院)・author・created を付ける。"""
* insert FCMeta
* intent = #plan
* category 1..1
* category = http://fhir-client.local/CodeSystem/care-plan-type#nursing
* title 1..1
* subject only Reference(FC_Patient)
* period.start 1..1
* addresses 1..1
* addresses only Reference(FC_NursingProblem)
* goal 1..*
* goal only Reference(FC_NursingGoal)
* encounter only Reference(FC_InpatientEncounter)
* author only Reference(FC_Practitioner)
* activity.id 1..1
* activity.extension contains
    NursingPlanActivityType named type 0..1 and
    NursingIntervention named intervention 0..1
* activity.detail 1..1
* activity.detail.status from NursingPlanActivityStatusVS (required)
* activity.detail.code 1..1
* activity.detail.code.text 1..1
* activity.detail.description 1..1
* instantiatesUri 0..1
* extension contains NursingCarePlanEntry named entry 1..1 MS

ValueSet: NursingPlanActivityStatusVS
Id: nursing-plan-activity-status-vs
Title: "看護計画の行の状態"
Description: "看護計画の行(CarePlan.activity.detail.status)の取りうる値。"
* insert FCMeta
* http://hl7.org/fhir/care-plan-activity-status#in-progress
* http://hl7.org/fhir/care-plan-activity-status#stopped

Profile: FC_NursingGoal
Parent: Goal
Id: fc-nursing-goal
Title: "看護計画の目標"
Description: """看護計画の目標。

- lifecycleStatus: active → completed(達成、または看護問題の解決)/ cancelled(計画から外した)/ entered-in-error(看護問題の取消)。category = care-plan-type#nursing。
- description = 看護成果(nursing-outcome、結びついているときだけ)+ text = 目標の文言。startDate = 立案日。addresses = 看護問題。target[0].dueDate = 評価予定日(無ければ target を持たない)。
- 評価を記録すると statusDate = 評価日、achievementStatus = 達成度(HL7 goal-achievement、display は日本語)、outcomeReference に評価 Observation を足す。"""
* insert FCMeta
* category 1..1
* category = http://fhir-client.local/CodeSystem/care-plan-type#nursing
* description.coding.system = "http://fhir-client.local/CodeSystem/nursing-outcome"
* description.text 1..1
* subject only Reference(FC_Patient)
* addresses 1..1
* addresses only Reference(FC_NursingProblem)
* target 0..1
* target.due[x] only date
* outcomeReference only Reference(FC_NursingEvaluationObservation)

Profile: FC_NursingEvaluationObservation
Parent: Observation
Id: fc-nursing-evaluation-observation
Title: "看護計画の評価"
Description: """看護計画の評価。1 回の評価で、評価した目標ごとの Observation(code = nursing-evaluation#goal)と、看護問題単位の判定の Observation(#problem)を 1 transaction で書く。

- category = care-plan-type#nursing。code.text = 目標の文言 / 看護問題名。basedOn = 看護計画、observation-problem = 看護問題。
- 目標の評価: focus = Goal、valueCodeableConcept = 達成度(HL7 goal-achievement、display は日本語。未選択なら値なし)、note = 評価の内容。達成度か内容のどちらかがある目標だけ作る。
- 看護問題の評価: focus = Condition、valueCodeableConcept = 判定(nursing-evaluation-decision)、note = 全体の評価。
- effectiveDateTime = 評価日(今日なら時刻付き)。performer = 評価した職員。encounter = 入院。"""
* insert FCMeta
* status = #final
* category 1..1
* category = http://fhir-client.local/CodeSystem/care-plan-type#nursing
* code.coding 1..1
* code.coding.system = "http://fhir-client.local/CodeSystem/nursing-evaluation"
* subject only Reference(FC_Patient)
* focus 1..1
* focus only Reference(FC_NursingGoal or FC_NursingProblem)
* basedOn 1..1
* basedOn only Reference(FC_NursingCarePlan)
* encounter only Reference(FC_InpatientEncounter)
* performer only Reference(FC_Practitioner)
* effective[x] only dateTime
* value[x] only CodeableConcept
* extension contains ObservationProblem named problem 1..1
