### 構造

処置は放射線検査と同じ「ヘッダ + 明細」構造で、`priority`・明細の category / reason / note / 拡張を持たない簡素な形です。

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> ヘッダ</td><td><a href="StructureDefinition-fc-treatment-order-header.html">FC_TreatmentOrderHeader</a></td><td></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>ServiceRequest</b> 明細</td><td><a href="StructureDefinition-fc-treatment-order-item.html">FC_TreatmentOrderItem</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Appointment</b></td><td><a href="StructureDefinition-fc-appointment.html">FC_Appointment</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ(予約が必要な項目のみ)</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> treatment</td><td><a href="StructureDefinition-fc-treatment-task.html">FC_TreatmentTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Procedure</b> 実施記録ハブ</td><td><a href="StructureDefinition-fc-treatment-procedure.html">FC_TreatmentProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  ├ </span><b>Procedure</b> 2 件目以降の手技</td><td></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  └ </span><b>MedicationAdministration</b> 薬剤</td><td><a href="StructureDefinition-fc-medication-administration.html">FC_MedicationAdministration</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
</tbody>
</table>

- 明細の `code` = 院内項目コード(`treatment-order-item`)+ 略称。
- 実施記録の手技コードは `treatment-procedure-code`、材料は `medical-material` + `treatment-material-quantity`。
- 「即実施」では、オーダー・実施記録・completed の Task を同じ transaction で作ります(Task.focus と Procedure.basedOn は urn:uuid)。実施入力をしない項目だけのオーダーでは実施記録を作らず、Task だけ completed にします。

### 例

- [ヘッダ](ServiceRequest-example-treatment-order-header.html) / [明細](ServiceRequest-example-treatment-order-item.html)
- [Task](Task-example-treatment-task.html)
- [実施記録](Procedure-example-treatment-procedure.html)
