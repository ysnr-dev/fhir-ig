### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> ヘッダ</td><td><a href="StructureDefinition-fc-rad-order-header.html">FC_RadOrderHeader</a></td><td></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>ServiceRequest</b> 明細 = 撮影項目</td><td><a href="StructureDefinition-fc-rad-order-item.html">FC_RadOrderItem</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ └ </span><b>ServiceRequest</b> セットの子項目</td><td></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;セットの明細</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Appointment</b> 予約</td><td><a href="StructureDefinition-fc-appointment.html">FC_Appointment</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ(予約が必要な項目のみ、同じ transaction)</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> rad-exam</td><td><a href="StructureDefinition-fc-rad-exam-task.html">FC_RadExamTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Procedure</b> 実施記録ハブ</td><td><a href="StructureDefinition-fc-rad-procedure.html">FC_RadProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ ├ </span><b>Procedure</b> 2 件目以降の手技</td><td></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ ├ </span><b>MedicationAdministration</b> 造影剤</td><td><a href="StructureDefinition-fc-medication-administration.html">FC_MedicationAdministration</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ └ </span><b>Observation</b> 線量</td><td><a href="StructureDefinition-fc-rad-dose-observation.html">FC_RadDoseObservation</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>DiagnosticReport</b> 読影レポート</td><td><a href="StructureDefinition-fc-rad-diagnostic-report.html">FC_RadDiagnosticReport</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  └ </span><b>Observation</b> 所見</td><td><a href="StructureDefinition-fc-rad-findings-observation.html">FC_RadFindingsObservation</a></td><td><span style="white-space: nowrap;">親の <code>result</code> から参照</span></td><td></td></tr>
</tbody>
</table>

### オーダー

- `priority` は routine / urgent / asap(事後 = 実施後に登録)。
- `occurrenceDateTime` は撮影日。時刻を指定したときはオフセット付きの dateTime。
- 明細の `code.coding`: 院内項目コード(`rad-order-item`)、JJ1017 32 桁(`jj1017-32`、全 0 なら省略)、前半 16 桁(`jj1017-16m`)、後半 16 桁(`jj1017-16s`)、略称。
- 明細の `category` = モダリティ(`jj1017-modality`)、`bodySite` = 部位(`jj1017p`)+ 左右(`jj1017-laterality`)。
- 検査目的・特別指示のテンプレート記入は `rad-exam-purpose*` / `rad-remarks-questionnaire-response` 拡張。

#### 分割と予約

グループ化できない項目(単純撮影以外など、マスタの `groupable = false`)は項目ごとに別のヘッダ + 明細に分割し、1 つの transaction で登録します。予約が必要な項目は Appointment と Slot(busy への PUT)を同じ transaction に含めます。

### 実施記録

[実施記録](procedures.html) を参照。「即時実施」(実施してから登録)では completed の Task がオーダーと同じ transaction で作られます。

### 読影レポート

[検査結果・報告](results.html) の放射線を参照。重要所見(`rad-critical-finding`)が付くと依頼医宛の通知 Task が作られます。レポートが付いたオーダーは取消・削除できません。

### 例

- [ヘッダ](ServiceRequest-example-rad-order-header.html) / [明細](ServiceRequest-example-rad-order-item.html)
- [Task](Task-example-rad-exam-task.html)
- [実施記録](Procedure-example-rad-procedure.html) / [線量](Observation-example-rad-dose-observation.html)
- [読影レポート](DiagnosticReport-example-rad-diagnostic-report.html)
