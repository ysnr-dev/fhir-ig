### ePath との関係

クリニカルパスは [ePath R4 実装ガイド](https://e-path.jp/fhir/ePath/) に倣った CarePlan の木で表します。ePath の拡張・CodeSystem・IdSystem は本 IG のパッケージ依存にせず、URL で参照します(ePath のパッケージは JP Core 1.1.2 に依存しており、本 IG の JP Core 1.2.0 と衝突するため)。

### 木の構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>CarePlan</b> 適用 = 根</td><td><a href="StructureDefinition-fc-pathway-apply-care-plan.html">FC_PathwayApplyCarePlan</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;無し(part-of:missing&nbsp;= true)</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>CarePlan</b> 病日</td><td><a href="StructureDefinition-fc-pathway-event-care-plan.html">FC_PathwayEventCarePlan</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;=&nbsp;[適用]</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ ├ </span><b>CarePlan</b> OAT 単位</td><td><a href="StructureDefinition-fc-pathway-unit-care-plan.html">FC_PathwayUnitCarePlan</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;=&nbsp;[適用, 病日]</span><br><span style="white-space: nowrap;"><code>goal</code>&nbsp;→&nbsp;アウトカム Goal</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ │ ├ </span><b>CarePlan</b> アセスメント</td><td><a href="StructureDefinition-fc-pathway-assessment-care-plan.html">FC_PathwayAssessmentCarePlan</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;=&nbsp;[適用, 病日, 単位]</span><br><span style="white-space: nowrap;"><code>goal</code>&nbsp;→&nbsp;アセスメント Goal</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ │ │ ├ </span><b>Procedure</b> タスク</td><td><a href="StructureDefinition-fc-pathway-task-procedure.html">FC_PathwayTaskProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;=&nbsp;[アセスメント, 出したオーダーのヘッダ]</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ │ │ └ </span><b>Observation</b> 実測値</td><td><a href="StructureDefinition-fc-pathway-result-observation.html">FC_PathwayResultObservation</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;アセスメント</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ │ └ </span><b>Observation</b> アウトカム評価</td><td><a href="StructureDefinition-fc-pathway-evaluation-observation.html">FC_PathwayEvaluationObservation</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;単位</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ │   └ </span><b>Task</b> pathway-variance 通知</td><td><a href="StructureDefinition-fc-pathway-variance-task.html">FC_PathwayVarianceTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;評価</span><br><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;単位</span></td><td>重要アウトカムが未達成のとき</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Goal</b> 適用の終了</td><td><a href="StructureDefinition-fc-pathway-apply-goal.html">FC_PathwayApplyGoal</a></td><td></td><td>終了 / 中止のとき</td></tr>
</tbody>
</table>

- `partOf` は根から自分の親までの祖先すべてを持ちます(上流の `part-of` 検索で木を引くため)。
- `category[0]` は 1 つの CodeableConcept に coding を 2 つ持ちます: `care-plan-type#clinical-pathway`(パスの印)と階層(`pathway-level`: apply / event / oat-unit / assessment)。display は付けません。OAT 単位とアセスメントは `category[1]` 以降に ePath の分類を追加で持ちます。
- `pathway-display-order` で定義どおりの並びを保ちます(上流の id は uuid で並びを持たない)。OAT 単位・アセスメントの CarePlan とタスクの Procedure に付きます(適用と病日には付きません)。
- バリアンス通知は、重要アウトカム(EPathCarePlanCriticalIndicator = Y)を未達成と評価したときだけ作り、未達成でなくなれば cancelled にします。

### 識別子(ePath IdSystem)

| 階層 | system | value |
|---|---|---|
| 適用 | `.../IdSystem/apply-id` | `{施設番号}.{uuid}` |
| 病日 | `.../IdSystem/event-id` | 適用の値 + `.{経過日数}[-{pathStep}]` |
| OAT 単位 | `.../IdSystem/oat-unit-id` | 病日の値 + `.{unitKey}[-{repeatNo}]` |
| アセスメント | `.../IdSystem/assessment-id` | OAT 単位の値 + `.{assessmentKey}` |
| タスク | `.../IdSystem/task-id` | アセスメントの値 + `.{taskKey}` |
| 適用終了の Goal | `apply-goal-id` | 適用の値と同じ |
| アウトカムの Goal・評価 Observation | `outcome-goal-id` / `observation-evaluation-id` | OAT 単位の値と同じ |
| アセスメントの Goal・実測値 Observation | `assessment-goal-id` / `observation-result-id` | アセスメントの値と同じ |

値は親の値にピリオドで連結した全体を持ちます(例: `1311234567.4c1d2e3f-….1.u1.a1`)。

### ePath の拡張・CodeSystem

- 拡張(`http://e-path.jp/fhir/ePath/StructureDefinition/`): 適用に EPathCarePlanAdaptiveCriteriaConfirmation / EPathCarePlanAdaptiveCriteriaText / EPathCarePlanScheduledDays、病日に EPathCarePlanEventElapsedDays / EPathCarePlanPathStep / EPathCarePlanPathStepName / EPathCarePlanPathStepInpatientOutpatientType(I / O)、OAT 単位に EPathCarePlanStatusTypeWhenOccured(常に 12)/ EPathCarePlanCriticalIndicator(Y / N)/ EPathCarePlanUnplannedKind(Y / N)、アセスメントに EPathCarePlanStatusTypeWhenOccured、タスクの Procedure に EPathProcedureTaskPlannedDateTime(valueDate)、適用終了の Goal に EPathGoalStatusReason。
- CodeSystem(`http://e-path.jp/fhir/ePath/CodeSystem/`): アウトカムの区分(EPathBOMOutcomeCategoryCS: G 患者目標 / H 患者状態。ローカルコードのパスでも同じ)とコード(EPathBOMOutcomeCodeCS / EPathLocalOutcomeCodeCS、コード体系だけ選んだときは EPathLocalOutcomeCategoryCS)、アセスメント分類(EPathBOMAssessmentCategoryCS / EPathBOMAssessmentCodeCS、EPathLocalAssessmentCategoryCS / EPathLocalAssessmentCodeCS、コードが無ければ EPathAssessmentCodeEmptyCS#ZZZZZZZZZZ)、タスク分類(EPathTaskCategoryLv1CS: TP / EX / ML / NO / NC / EG / AL / MD、EPathTaskCategoryLv2CS(ePath に無い EGMG 服薬指導を足している。服薬指導オーダーの雛形を置く)、タスクコードは EPathLocalTaskCodeCS)、EPathPathClosingTypeCS(1 終了 / 2 中止)、EPathEvaluationItemCS(judgement / S / O / A / P / comp-assessment)、EPathStateOfAchievementCS(1 達成 / 2 未達成（バリアンス）/ 3 未評価)。

### 本 IG の拡張

- `pathway-phase`(病日がどのフェーズか、code = phase_key)と `pathway-phase-note`(分岐を選んだ記録)。フェーズ分岐のあるパスはフェーズ単位で段階的に適用します。
- `pathway-evaluation-template`(評価の S / O / A / P をテンプレートで記入したときの QuestionnaireResponse、Observation.component 上)。
- `order-department`(評価を記録した診療科。初回の評価で付け、評価し直しても書き換えない)。
- パスから出したオーダーのヘッダには `pathway-instance` identifier と `pathway-order` 拡張([オーダーセット・パス適用の印](order-set-pathway.html))。

### 例

- [適用](CarePlan-example-pathway-apply-care-plan.html) / [病日](CarePlan-example-pathway-event-care-plan.html) / [OAT 単位](CarePlan-example-pathway-unit-care-plan.html) / [アセスメント](CarePlan-example-pathway-assessment-care-plan.html)
- [アウトカム Goal](Goal-example-pathway-outcome-goal.html) / [アセスメント Goal](Goal-example-pathway-assessment-goal.html) / [適用の終了](Goal-example-pathway-apply-goal.html)
- [タスク](Procedure-example-pathway-task-procedure.html) / [評価](Observation-example-pathway-evaluation-observation.html) / [実測値](Observation-example-pathway-result-observation.html) / [バリアンス通知](Task-example-pathway-variance-task.html)
