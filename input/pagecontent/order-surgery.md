### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> ヘッダ = 申込</td><td><a href="StructureDefinition-fc-surgery-order-header.html">FC_SurgeryOrderHeader</a></td><td></td><td><code>extension</code>: surgery-room / surgery-department / surgery-duration / surgery-position / surgery-estimated-blood-loss / surgery-staff(0..*) / surgery-anesthesia-method(0..*) / surgery-anesthesia-management / surgery-blood-preparation / surgery-equipment(0..*) / surgery-specimen-plan(0..*) / surgery-consent(0..*) / surgery-preop-instruction(-questionnaire-response)</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>ServiceRequest</b> 術式明細、identifier 1 = 主術式</td><td><a href="StructureDefinition-fc-surgery-order-item.html">FC_SurgeryOrderItem</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> surgery</td><td><a href="StructureDefinition-fc-surgery-task.html">FC_SurgeryTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Procedure</b> 実施記録ハブ</td><td><a href="StructureDefinition-fc-surgery-procedure.html">FC_SurgeryProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ ├ </span><b>Procedure</b> 2 件目以降の術式</td><td></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ ├ </span><b>MedicationAdministration</b> 薬剤</td><td><a href="StructureDefinition-fc-medication-administration.html">FC_MedicationAdministration</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ └ </span><b>Observation</b> 出血量 / 尿量 / 輸血量</td><td><a href="StructureDefinition-fc-surgery-observation.html">FC_SurgeryObservation</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Procedure</b> 麻酔チャート</td><td><a href="StructureDefinition-fc-anesthesia-chart-procedure.html">FC_AnesthesiaChartProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  ├ </span><b>Observation</b> バイタル</td><td><a href="StructureDefinition-fc-anesthesia-vital-observation.html">FC_AnesthesiaVitalObservation</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;麻酔チャート</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  ├ </span><b>Observation</b> イベント</td><td><a href="StructureDefinition-fc-anesthesia-event-observation.html">FC_AnesthesiaEventObservation</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;麻酔チャート</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  └ </span><b>MedicationAdministration</b> 麻酔薬</td><td><a href="StructureDefinition-fc-medication-administration.html">FC_MedicationAdministration</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;麻酔チャート</span></td><td></td></tr>
</tbody>
</table>

### 申込

- `priority`: routine 予定 / urgent 準緊急 / stat 緊急。
- `occurrenceDateTime` は予定日時。未定なら省略します(全種別で手術だけが省略可。カルテでは「日付未定」に表示)。
- 術式明細の `code` = 術式マスタ(`surgery-order-item`)+ レセプト K コード(`surgery-procedure-code`)+ 略称。`bodySite` = 左右 + text。`reasonReference` / `reasonCode` = 術前診断。アプローチは `surgery-approach`。
- 日程の確定はヘッダの PUT と Task(accepted)を同じ transaction で行います。カレンダー上の移動はヘッダの PUT だけで Task は変えません。日程未定のまま入室すると、入室日時を `occurrenceDateTime` に入れ、Task を in-progress で作ります。いずれも術式明細の `occurrenceDateTime` を同じ transaction でヘッダに揃えます。Appointment は作りません。手術室の割当は `surgery-room`(Location)。

### Task

requested 申込済 / accepted 受付済 / in-progress 入室中 / completed 実施済 / cancelled 中止。

### 実施記録・麻酔チャート

[実施記録](procedures.html) を参照。

### 例

- [ヘッダ](ServiceRequest-example-surgery-order-header.html) / [術式明細](ServiceRequest-example-surgery-order-item.html) / [手術室](Location-example-surgery-room.html)
- [Task](Task-example-surgery-task.html)
- [実施記録](Procedure-example-surgery-procedure.html) / [出血量](Observation-example-surgery-observation.html)
- [麻酔チャート](Procedure-example-anesthesia-chart-procedure.html)
