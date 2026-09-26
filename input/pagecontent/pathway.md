### ePath との関係

クリニカルパスは [ePath R4 実装ガイド](https://e-path.jp/fhir/ePath/) に倣った CarePlan の木で表します。ePath の拡張・CodeSystem・IdSystem は本 IG のパッケージ依存にせず、URL で参照します(ePath のパッケージは JP Core 1.1.2 に依存しており、本 IG の JP Core 1.2.0 と衝突するため)。

### 木の構造

```
CarePlan(適用 = 根、FC_PathwayApplyCarePlan)   partOf 無し(part-of:missing = true)
 ├ CarePlan(病日、FC_PathwayEventCarePlan)   partOf = [適用]
 │   ├ CarePlan(OAT 単位、FC_PathwayUnitCarePlan)   partOf = [適用, 病日]   goal → アウトカム Goal
 │   │   ├ CarePlan(アセスメント、FC_PathwayAssessmentCarePlan)   partOf = [適用, 病日, 単位]   goal → アセスメント Goal
 │   │   │   ├ Procedure(タスク、FC_PathwayTaskProcedure)   basedOn = [アセスメント, 出したオーダーのヘッダ]
 │   │   │   └ Observation(実測値、FC_PathwayResultObservation)   basedOn → アセスメント
 │   │   └ Observation(アウトカム評価、FC_PathwayEvaluationObservation)   basedOn → 単位
 │   │       └ Task(pathway-variance 通知)   focus → 評価、basedOn → 単位   ※ 未達成のとき
 └ Goal(適用の終了、FC_PathwayApplyGoal)   ※ 終了 / 中止のとき
```

- `partOf` は根から自分の親までの祖先すべてを持ちます(上流の `part-of` 検索で木を引くため)。
- `category[0]` = `care-plan-type#clinical-pathway`、`category[1]` = 階層(`pathway-level`: apply / event / oat-unit / assessment)。OAT 単位とアセスメントは ePath の分類 coding を追加で持ちます。
- `pathway-display-order` で定義どおりの並びを保ちます(上流の id は uuid で並びを持たない)。

### 識別子(ePath IdSystem)

| 階層 | system | value |
|---|---|---|
| 適用 | `.../IdSystem/apply-id` | `{施設番号}.{uuid}` |
| 病日 | `.../IdSystem/event-id` | `.{経過日数}[-{pathStep}]` |
| OAT 単位 | `.../IdSystem/oat-unit-id` | `.{unitKey}[-{repeatNo}]` |
| アセスメント | `.../IdSystem/assessment-id` | `.{assessmentKey}`(無ければ `ZZZZZZZZZZ`) |
| タスク | `.../IdSystem/task-id` | `.{taskKey}` |
| Goal / Observation | `assessment-goal-id` / `outcome-goal-id` / `apply-goal-id` / `observation-evaluation-id` / `observation-result-id` | |

### ePath の拡張・CodeSystem

- 拡張(`http://e-path.jp/fhir/ePath/StructureDefinition/`): EPathCarePlanAdaptiveCriteriaConfirmation、AdaptiveCriteriaText、ScheduledDays、EventElapsedDays、PathStep、PathStepName、PathStepInpatientOutpatientType、StatusTypeWhenOccured(常に 12)、CriticalIndicator(Y / N)、UnplannedKind(Y / N)、RepeatNo、EPathProcedureTaskPlannedDateTime、EPathGoalStatusReason。
- CodeSystem(`http://e-path.jp/fhir/ePath/CodeSystem/`): アウトカム分類(BOM / Local OutcomeCategoryCS、OutcomeCodeCS: G / H)、アセスメント分類(BOM / Local AssessmentCategoryCS、AssessmentCodeCS、AssessmentCodeEmptyCS#ZZZZZZZZZZ)、タスク分類(TaskCategoryLv1CS: TP / EX / ML / NO / NC / EG / AL / MD、TaskCategoryLv2CS、LocalTaskCodeCS)、EPathPathClosingTypeCS(1 終了 / 2 中止)、EPathEvaluationItemCS(judgement / S / O / A / P / comp-assessment)、EPathStateOfAchievementCS(1 達成 / 2 未達成 / 3 未評価)。

### 本 IG の拡張

- `pathway-phase`(病日がどのフェーズか、code = phase_key)と `pathway-phase-note`(分岐を選んだ記録)。フェーズ分岐のあるパスはフェーズ単位で段階的に適用します。
- `pathway-evaluation-template`(評価の S / O / A / P をテンプレートで記入したときの QuestionnaireResponse、Observation.component 上)。
- パスから出したオーダーのヘッダには `pathway-instance` identifier と `pathway-order` 拡張([オーダーセット・パス適用の印](order-set-pathway.html))。

### 例

- [適用](CarePlan-example-pathway-apply-care-plan.html) / [病日](CarePlan-example-pathway-event-care-plan.html) / [OAT 単位](CarePlan-example-pathway-unit-care-plan.html) / [アセスメント](CarePlan-example-pathway-assessment-care-plan.html)
- [アウトカム Goal](Goal-example-pathway-outcome-goal.html) / [アセスメント Goal](Goal-example-pathway-assessment-goal.html) / [適用の終了](Goal-example-pathway-apply-goal.html)
- [タスク](Procedure-example-pathway-task-procedure.html) / [評価](Observation-example-pathway-evaluation-observation.html) / [実測値](Observation-example-pathway-result-observation.html) / [バリアンス通知](Task-example-pathway-variance-task.html)
