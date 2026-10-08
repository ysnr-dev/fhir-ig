### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> 依頼</td><td><a href="StructureDefinition-fc-medication-guidance-order.html">FC_MedicationGuidanceOrder</a></td><td></td><td><code>code</code> = 指導区分(服薬指導 / 退院時指導)<br><code>orderDetail</code> = 指導条件(複数)<br><code>reasonCode[0].text</code> = 指導してほしいこと<br><code>note</code> = 薬剤部への連絡事項<br><code>extension</code>: medication-guidance-order-end / medication-guidance-target-drugs</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> medication-guidance</td><td><a href="StructureDefinition-fc-medication-guidance-task.html">FC_MedicationGuidanceTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;依頼</span><br><span style="white-space: nowrap;"><code>owner</code>&nbsp;=&nbsp;担当薬剤師</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Procedure</b> 回ごとの指導</td><td><a href="StructureDefinition-fc-medication-guidance-procedure.html">FC_MedicationGuidanceProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;依頼</span></td><td><code>code</code> = 指導種別(服薬指導 / 服薬指導(ハイリスク薬) / 退院時指導)<br><code>performer</code> = 指導した薬剤師<br><code>note</code> = 指導内容<br><code>extension</code>: medication-guidance-understanding / medication-guidance-record(QuestionnaireResponse)</td></tr>
</tbody>
</table>

- 医師が薬剤師へ服薬指導を依頼し、薬剤部が受付 → 入院中に週ごとの指導 → 退院時指導 → 終了と進めます。栄養指導と同じ期間継続型で、明細 ServiceRequest と予約は持ちません。
- `occurrenceDateTime` = 開始日、`medication-guidance-order-end` = 終了日(無ければ継続中)。部門一覧の「終了」と退院時の打ち切りで、ServiceRequest に終了日を書き足します(Task を completed にするだけでは部門一覧の検索に残り続けるため)。
- 指導区分(`medication-guidance-kind`)と指導条件(`medication-guidance-condition`: ハイリスク薬 / 麻薬 / 吸入・自己注射の手技 / 多剤併用 / 服薬状況の確認 / 嚥下・剤形の相談 / 家族への指導)は施設で増減しない固定のコードです。
- 対象薬剤(`medication-guidance-target-drugs`)は、持参薬・院外の薬も対象になるので処方の参照ではなく文字列で持ちます。
- 進捗 Task は薬剤部の受け入れ状態(requested 依頼済 / accepted 実施中 / completed 終了 / cancelled 中止)です。日々の指導は Task を動かさず Procedure を足すだけです。`owner` = 担当薬剤師(受け持つ人。実施した人は Procedure.performer で、別人のこともある)。
- 指導種別(`medication-guidance-session-type`)は、退院時指導のオーダーでは discharge だけ、服薬指導のオーダーでは standard / high-risk を選びます(指導条件にハイリスク薬があれば high-risk が初期値)。
- 指導記録はテンプレート(QuestionnaireResponse)で書くこともでき、実施 Procedure の `medication-guidance-record` が指します(平文は note にも入る)。実施記録を消すときは QuestionnaireResponse も消します。
- クリニカルパスでは、タスク分類(小)EGMG(服薬指導)のタスクに服薬指導オーダーの雛形を置きます([クリニカルパス](pathway.html))。
- レセプトコンピュータへの送信は未対応です(薬剤管理指導料の区分を実施記録の指導種別から引く必要がある)。

### 例

- [依頼](ServiceRequest-example-medication-guidance-order.html)
- [Task](Task-example-medication-guidance-task.html)
- [実施記録](Procedure-example-medication-guidance-procedure.html)
