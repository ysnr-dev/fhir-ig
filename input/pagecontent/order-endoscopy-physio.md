### 構造

内視鏡と生理検査は放射線検査と同じ構造です(JJ1017 と bodySite は持たない)。

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> ヘッダ</td><td><a href="StructureDefinition-fc-endoscopy-order-header.html">FC_EndoscopyOrderHeader</a><br><a href="StructureDefinition-fc-physio-order-header.html">FC_PhysioOrderHeader</a></td><td></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>ServiceRequest</b> 明細</td><td><a href="StructureDefinition-fc-endoscopy-order-item.html">FC_EndoscopyOrderItem</a><br><a href="StructureDefinition-fc-physio-order-item.html">FC_PhysioOrderItem</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Appointment</b></td><td><a href="StructureDefinition-fc-appointment.html">FC_Appointment</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ(同じ transaction)</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> endoscopy-exam / physio-exam</td><td><a href="StructureDefinition-fc-endoscopy-exam-task.html">FC_EndoscopyExamTask</a><br><a href="StructureDefinition-fc-physio-exam-task.html">FC_PhysioExamTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Procedure</b> 実施記録ハブ</td><td><a href="StructureDefinition-fc-endoscopy-procedure.html">FC_EndoscopyProcedure</a><br><a href="StructureDefinition-fc-physio-procedure.html">FC_PhysioProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ ├ </span><b>Procedure</b> 2 件目以降の手技</td><td></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ └ </span><b>MedicationAdministration</b> 薬剤</td><td><a href="StructureDefinition-fc-medication-administration.html">FC_MedicationAdministration</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>DiagnosticReport</b> 所見レポート</td><td><a href="StructureDefinition-fc-endoscopy-diagnostic-report.html">FC_EndoscopyDiagnosticReport</a><br><a href="StructureDefinition-fc-physio-diagnostic-report.html">FC_PhysioDiagnosticReport</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  └ </span><b>Observation</b> 所見</td><td><a href="StructureDefinition-fc-endoscopy-findings-observation.html">FC_EndoscopyFindingsObservation</a><br><a href="StructureDefinition-fc-physio-findings-observation.html">FC_PhysioFindingsObservation</a></td><td><span style="white-space: nowrap;">親の <code>result</code> から参照</span></td><td></td></tr>
</tbody>
</table>

### オーダー

| | 内視鏡 | 生理検査 |
|---|---|---|
| 項目コード | `endoscopy-order-item` | `physio-order-item` |
| 検査種別(明細の category) | `endoscopy-exam-type` | `physio-exam-type` |
| 検査目的 | `endoscopy-exam-purpose` / `endoscopy-exam-purpose-questionnaire-response` | `physio-exam-purpose` / `physio-exam-purpose-questionnaire-response` |
| 特別指示テンプレート | `endoscopy-remarks-questionnaire-response` | `physio-remarks-questionnaire-response` |
| 明細番号 | `IdSystem/endoscopy-order-item-number` | `IdSystem/physio-order-item-number` |

`priority` は routine / urgent / asap。分割と予約は放射線検査と同じです。

### 実施記録

[実施記録](procedures.html) を参照。手技コードは `endoscopy-procedure-code` / `physio-procedure-code`、材料は `medical-material` + `endoscopy-material-quantity` / `physio-material-quantity`。

### 所見レポート

[検査結果・報告](results.html) の生理検査・内視鏡を参照。重要所見(`endoscopy-critical-finding` / `physio-critical-finding`)が付くと依頼医宛の通知 Task が作られます。レポートが付いたオーダーは取消・削除できません。

### 例

- 内視鏡: [ヘッダ](ServiceRequest-example-endoscopy-order-header.html) / [明細](ServiceRequest-example-endoscopy-order-item.html) / [実施記録](Procedure-example-endoscopy-procedure.html) / [所見レポート](DiagnosticReport-example-endoscopy-diagnostic-report.html)
- 生理検査: [ヘッダ](ServiceRequest-example-physio-order-header.html) / [明細](ServiceRequest-example-physio-order-item.html) / [実施記録](Procedure-example-physio-procedure.html) / [所見レポート](DiagnosticReport-example-physio-diagnostic-report.html)
