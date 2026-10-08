### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> 依頼</td><td><a href="StructureDefinition-fc-nutrition-guidance-order.html">FC_NutritionGuidanceOrder</a></td><td></td><td><code>code</code> = 指導形式(個別 / 集団)<br><code>reasonCode[0].text</code> = 目的<br><code>extension</code>: nutrition-guidance-order-end / -target-disease / -target-condition / -target-diet / -purpose-questionnaire-response</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Appointment</b> 栄養指導の予約</td><td><a href="StructureDefinition-fc-appointment.html">FC_Appointment</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;依頼(別 transaction)</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> nutrition-guidance</td><td><a href="StructureDefinition-fc-nutrition-guidance-task.html">FC_NutritionGuidanceTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;依頼</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Procedure</b> 回ごとの実施</td><td><a href="StructureDefinition-fc-nutrition-guidance-procedure.html">FC_NutritionGuidanceProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;依頼</span></td><td><code>code</code> = 実施区分(初回 / 2 回目以降 / 集団)<br><code>extension</code>: nutrition-guidance-performed-minutes / nutrition-guidance-record(QuestionnaireResponse)</td></tr>
</tbody>
</table>

- `occurrenceDateTime` = 開始日、`nutrition-guidance-order-end` = 終了日。リハビリと同じ継続型のオーダーです。
- 対象の食種は `nutrition-guidance-target-diet`(valueCoding.system = `meal-type`)。
- 指導記録はテンプレート(QuestionnaireResponse)で書き、実施 Procedure の `nutrition-guidance-record` が指します。

### 例

- [依頼](ServiceRequest-example-nutrition-guidance-order.html)
- [Task](Task-example-nutrition-guidance-task.html)
- [実施記録](Procedure-example-nutrition-guidance-procedure.html)
