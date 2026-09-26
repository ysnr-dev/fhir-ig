// クリニカルパス: ePath R4 実装ガイドに倣った CarePlan 木(適用 → 病日 → OAT 単位 → アセスメント)と Goal / Observation。
// ePath の拡張・CodeSystem・IdSystem はパッケージ依存にせず URL で参照する(pathway.md を参照)。

Profile: FC_PathwayCarePlan
Parent: CarePlan
Id: fc-pathway-care-plan
Title: "パスの CarePlan(共通)"
Description: """クリニカルパスの CarePlan 木の共通形。

- intent = plan。category[0] = care-plan-type#clinical-pathway、category[1] = 階層(pathway-level: apply / event / oat-unit / assessment)。
- partOf は根から自分の親までの祖先すべてを持つ(上流の part-of 検索で木を引くため)。根は partOf を持たない(part-of:missing = true)。
- identifier = ePath の IdSystem(apply-id / event-id / oat-unit-id / assessment-id)。
- pathway-display-order で定義どおりの並びを保つ。"""
* insert FCMeta
* ^abstract = true
* intent = #plan
* subject only Reference(FC_Patient)
* category 2..*
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category ^slicing.ordered = true
* category contains
    type 1..1 and
    level 1..1
* category[type] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway
* category[level] from PathwayLevelVS (required)
* identifier 1..1
* partOf only Reference(FC_PathwayCarePlan)
* extension contains PathwayDisplayOrder named displayOrder 0..1

Profile: FC_PathwayApplyCarePlan
Parent: FC_PathwayCarePlan
Id: fc-pathway-apply-care-plan
Title: "パス適用(根)"
Description: "パスの適用 1 回を表す根の CarePlan。status: active → completed / revoked。period = 適用期間、encounter、addresses = 対象の病名、instantiatesUri = `http://fhir-client.local/pathway/{code}`。identifier = ePath apply-id(値 = {施設番号}.{uuid})。終了時は apply Goal(lifecycleStatus completed / cancelled、EPathGoalStatusReason)を作る。フェーズ分岐のあるパスはフェーズ単位で段階的に適用し、病日に pathway-phase / pathway-phase-note を付ける。"
* category[level] = http://fhir-client.local/CodeSystem/pathway-level#apply
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
Description: "病日(イベント)の CarePlan。partOf = [適用]。period.start = period.end = その日。identifier = ePath event-id(.{経過日数}[-{pathStep}])。ePath の EventElapsedDays / PathStep / PathStepName / PathStepInpatientOutpatientType / ScheduledDays 拡張を持つ。pathway-phase = フェーズ。"
* category[level] = http://fhir-client.local/CodeSystem/pathway-level#event
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
Description: "OAT(アウトカム・アセスメント・タスク)単位の CarePlan。partOf = [適用, 病日]。category に ePath のアウトカム分類(BOM / Local OutcomeCategoryCS、OutcomeCodeCS)を追加で持つ。goal = アウトカム Goal。identifier = ePath oat-unit-id(.{unitKey}[-{repeatNo}])。評価 Observation が basedOn でこれを指す。"
* category[level] = http://fhir-client.local/CodeSystem/pathway-level#oat-unit
* category contains outcomeCategory 0..*
* category[outcomeCategory] ^short = "ePath のアウトカム分類(BOM / Local OutcomeCategoryCS)"
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/oat-unit-id"
* partOf 2..2
* goal only Reference(FC_PathwayOutcomeGoal)

Profile: FC_PathwayAssessmentCarePlan
Parent: FC_PathwayCarePlan
Id: fc-pathway-assessment-care-plan
Title: "パスのアセスメント"
Description: "アセスメントの CarePlan。partOf = [適用, 病日, OAT 単位]。category に ePath のアセスメント分類(BOM / Local AssessmentCategoryCS、AssessmentCodeCS、空は AssessmentCodeEmptyCS#ZZZZZZZZZZ)と MEDIS 看護観察の coding を追加で持つことがある。goal = アセスメント Goal(target.detailString = 目標値)。identifier = ePath assessment-id。タスク Procedure と実測 Observation が basedOn でこれを指す。"
* category[level] = http://fhir-client.local/CodeSystem/pathway-level#assessment
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
Description: "OAT 単位のアウトカム。achievementStatus = 達成状況、outcomeReference = 評価 Observation。identifier = ePath outcome-goal-id。"
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/outcome-goal-id"
* outcomeReference only Reference(FC_PathwayEvaluationObservation)

Profile: FC_PathwayApplyGoal
Parent: Goal
Id: fc-pathway-apply-goal
Title: "パス適用の終了"
Description: "パス適用の終了(終了 / 中止)を表す Goal。lifecycleStatus = completed / cancelled、statusDate、ePath の EPathGoalStatusReason 拡張(EPathPathClosingTypeCS: 1 終了 / 2 中止)、note。identifier = ePath apply-goal-id。"
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/apply-goal-id"
* statusDate 1..1

Profile: FC_PathwayEvaluationObservation
Parent: Observation
Id: fc-pathway-evaluation-observation
Title: "パスのアウトカム評価"
Description: "OAT 単位のアウトカム評価。category[0] = care-plan-type#clinical-pathway。code = ePath EPathEvaluationItemCS#judgement。valueCodeableConcept = 達成状況(ePath EPathStateOfAchievementCS: 1 達成 / 2 未達成 / 3 未評価)。component = S / O / A / P(code = EPathEvaluationItemCS、valueString。テンプレートで書いたときは pathway-evaluation-template)。basedOn = OAT 単位の CarePlan。identifier = ePath observation-evaluation-id。未達成で pathway-variance 通知が作られる。"
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

Profile: FC_PathwayResultObservation
Parent: Observation
Id: fc-pathway-result-observation
Title: "パスのアセスメント実測値"
Description: "アセスメント項目の実測値。basedOn = アセスメントの CarePlan。identifier = ePath observation-result-id。"
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/observation-result-id"
* basedOn 1..1
* basedOn only Reference(FC_PathwayAssessmentCarePlan)
