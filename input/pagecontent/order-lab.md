### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> ヘッダ</td><td><a href="StructureDefinition-fc-lab-order-header.html">FC_LabOrderHeader</a></td><td></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>ServiceRequest</b> 明細 = 項目</td><td><a href="StructureDefinition-fc-lab-order-item.html">FC_LabOrderItem</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ ├ </span><b>Specimen</b> #specimen</td><td><a href="StructureDefinition-fc-lab-order-specimen.html">FC_LabOrderSpecimen</a></td><td><span style="white-space: nowrap;">親の <code>contained</code></span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ └ </span><b>ServiceRequest</b> パネルの子項目</td><td></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;パネルの明細</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> lab-exam</td><td><a href="StructureDefinition-fc-lab-exam-task.html">FC_LabExamTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Specimen</b> 検体ラベル、採血管ごと</td><td><a href="StructureDefinition-fc-lab-label-specimen.html">FC_LabLabelSpecimen</a></td><td><span style="white-space: nowrap;"><code>request</code>&nbsp;→&nbsp;ヘッダ</span></td><td>backend が作る</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>DiagnosticReport</b> 結果報告</td><td><a href="StructureDefinition-fc-lab-diagnostic-report.html">FC_LabDiagnosticReport</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  ├ </span><b>Observation</b> 項目ごと</td><td><a href="StructureDefinition-fc-lab-result-observation.html">FC_LabResultObservation</a></td><td><span style="white-space: nowrap;">親の <code>result</code> から参照</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  └ </span><b>Specimen</b> 検体ラベル。上の Specimen と同じもの</td><td></td><td><span style="white-space: nowrap;">親の <code>specimen</code> から参照</span></td><td></td></tr>
</tbody>
</table>

### オーダー

- ヘッダは `code` を持たず、`priority`(routine / urgent)、`occurrenceDateTime`(検査日)を持つ。
- 明細の `code.coding` は院内項目コード(`lab-order-item`)を必ず持ち、JLAC11 / JLAC10 / 略称(`lab-item-abbreviation`)を任意で添える。
- 検体は明細の contained Specimen(`id = specimen`)で持ち、`type` = JLAC11 材料コード(`jlac11-specimen`)、`container.type` = 採血管(`lab-container`)。
- 旧形式では検体・採血管を `lab-order-specimen` / `lab-order-container` 拡張で持っていた。読み取りのみ。

### 検体ラベル

検体ラベルの発行時に backend が採血管ごとに Specimen を作ります(`accessionIdentifier.system = lab-label-number`、値は上流サーバーが採番)。
検体をまたぐセット項目は採血管グループに乗らないため、ラベルは項目の検体ごとに分かれます。
到着確認で `status = available`、`receivedTime`、`lab-arrival-recorder` 拡張が付きます。

### 結果

[検査結果・報告](results.html) を参照。報告と同時に、パニック値があれば `lab-panic` 通知が、中間報告でなければ結果確認の通知(`result-review`)が作られます(`lab-panic` が未対応の間は `result-review` を作りません)。

### 例

- [ヘッダ](ServiceRequest-example-lab-order-header.html)
- [明細](ServiceRequest-example-lab-order-item.html)
- [検体ラベルの Specimen](Specimen-example-lab-label-specimen.html)
- [Task](Task-example-lab-exam-task.html)
- [報告](DiagnosticReport-example-lab-diagnostic-report.html)
