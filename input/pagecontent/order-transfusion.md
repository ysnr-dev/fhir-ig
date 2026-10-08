### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> ヘッダ</td><td><a href="StructureDefinition-fc-transfusion-order-header.html">FC_TransfusionOrderHeader</a></td><td></td><td><code>code</code> = 輸血前検査(交差適合試験 / T&amp;S)<br><code>extension</code>: transfusion-abo / transfusion-rhd / transfusion-consent</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>ServiceRequest</b> 製剤明細</td><td><a href="StructureDefinition-fc-transfusion-order-item.html">FC_TransfusionOrderItem</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> transfusion</td><td><a href="StructureDefinition-fc-transfusion-task.html">FC_TransfusionTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Procedure</b> 実施記録ハブ</td><td><a href="StructureDefinition-fc-transfusion-procedure.html">FC_TransfusionProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  ├ </span><b>MedicationAdministration</b> バッグごと、transfusion-lot-number</td><td><a href="StructureDefinition-fc-medication-administration.html">FC_MedicationAdministration</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  └ </span><b>Observation</b> 輸血副作用</td><td><a href="StructureDefinition-fc-transfusion-reaction-observation.html">FC_TransfusionReactionObservation</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;ハブ</span></td><td></td></tr>
</tbody>
</table>

- `occurrenceDateTime` = 投与予定日時(画面からの登録では必須)。
- 製剤明細の `code` = 製剤マスタ(`transfusion-product`)、`quantityQuantity` = 数量(unit = 製剤の単位名)。略称は付けません。
- 血液型は患者プロファイルの血液型 Observation(LOINC 883-9 / 10331-7)と同じ CodeSystem(`transfusion-abo` / `transfusion-rhd`)を使います。
- Task の状態: requested 依頼済 / accepted 受付済 / in-progress 出庫済 / completed 実施済 / cancelled 中止。

### 例

- [ヘッダ](ServiceRequest-example-transfusion-order-header.html) / [製剤明細](ServiceRequest-example-transfusion-order-item.html)
- [Task](Task-example-transfusion-task.html)
- [実施記録](Procedure-example-transfusion-procedure.html) / [製剤の投与](MedicationAdministration-example-transfusion-medication-administration.html) / [輸血副作用](Observation-example-transfusion-reaction-observation.html)
