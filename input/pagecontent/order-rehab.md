### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> 処方</td><td><a href="StructureDefinition-fc-rehab-order.html">FC_RehabOrder</a></td><td></td><td><code>code</code> = 疾患別区分<br><code>orderDetail</code> = 療法種別(PT / OT / ST)<br><code>quantityQuantity</code> = 単位数<br><code>extension</code>: rehab-order-end / rehab-onset-date / rehab-target-disease / rehab-frequency-per-week</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Appointment</b> リハ室の予約</td><td><a href="StructureDefinition-fc-appointment.html">FC_Appointment</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;処方(別 transaction)</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> rehab</td><td><a href="StructureDefinition-fc-rehab-task.html">FC_RehabTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;処方</span></td><td>期間中は accepted のまま</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Procedure</b> 回ごとの実施</td><td><a href="StructureDefinition-fc-rehab-procedure.html">FC_RehabProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;処方</span></td><td><code>extension</code>: rehab-performed-units</td></tr>
</tbody>
</table>

- `occurrenceDateTime` = 開始日、`rehab-order-end` = 終了日(上流の `order-period` 検索で期間を引く)。
- 各回の実施は Procedure で、`code` = 療法種別、`rehab-performed-units` = 単位数(1〜24)。Task は変えません。
- Task の状態: requested 依頼済 / accepted 実施中 / completed 終了 / cancelled 中止。

### 例

- [処方](ServiceRequest-example-rehab-order.html)
- [Task](Task-example-rehab-task.html)
- [実施記録](Procedure-example-rehab-procedure.html)
