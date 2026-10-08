### 構造

看護指示は指示 1 行ごとに 1 件の ServiceRequest で、ヘッダ・明細の区別がありません。

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> 指示行</td><td><a href="StructureDefinition-fc-nursing-order.html">FC_NursingOrder</a></td><td></td><td><code>code</code> = MEDIS 看護行為(master-nursingAction-16digits + 8 桁管理番号)または看護観察(master-nursingObservationKeyCode)、または text<br><code>orderDetail[0].text</code> = 条件<br><code>extension</code>: nursing-order-end / nursing-order-schedule(Timing)/ nursing-care-plan-activity(計画から展開)<br>同時入力した指示は requisition(nursing-order-requisition)で束ねる</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> nursing</td><td><a href="StructureDefinition-fc-nursing-task.html">FC_NursingTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;指示</span></td><td>登録時に requested で作られ、指示受けで accepted(owner = 看護師)</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Observation</b> 看護観察の記録</td><td><a href="StructureDefinition-fc-nursing-observation.html">FC_NursingObservation</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;指示</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Procedure</b> 看護行為の実施</td><td><a href="StructureDefinition-fc-nursing-action-procedure.html">FC_NursingActionProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;指示</span></td><td></td></tr>
</tbody>
</table>

- `category` は nursing + inpatient(常に入院)。`encounter` = 入院 Encounter(入院中でない患者にオーダーセット・パスから適用したときは付かない)。
- `occurrenceDateTime` = 開始日、`nursing-order-end` = 終了日、`nursing-order-schedule` = 頻度(付いていない指示は随時)。
- 記録は 1 回のラウンドで入力した Observation / Procedure を identifier(`nursing-perform-entry`)の uuid で束ねます。
- 看護観察の Observation は `category[0]` が order-type#nursing だけで、code に MEDIS の coding と、対応があれば LOINC のバイタルコードを添えます。値は Quantity(LOINC 対応のバイタルだけ UCUM、他は unit 文字列のみ)/ CodeableConcept(`nursing-observation-result`)/ component / string。マスタに無い自由記載の指示の記録は code.text と valueString だけです。
- 看護行為の実施記録(Procedure)は指示の code(16 桁コード + 8 桁管理番号)をそのまま写します。実施記録を付けても Task は変わりません。
- 看護観察「血糖値」(31000303)の記録は LOINC 41653-7(簡易血糖、mg/dL)を添えます。インスリンのスケール施用で実施入力から入れた血糖値も同じ code・category の Observation([FC_CapillaryGlucoseObservation](StructureDefinition-fc-capillary-glucose-observation.html))で、`basedOn` は有効な血糖測定の指示があるときだけ付きます([薬剤](medication.html))。
- 看護計画の行から展開した指示は `nursing-care-plan-activity`(plan = 看護計画、activity = 行の id)を持ち、`reasonReference` = 看護問題で、Task は最初から accepted(owner = 出した看護師)です([看護計画・看護サマリー](nursing-care-plan.html))。

### 例

- [指示(観察)](ServiceRequest-example-nursing-order.html) / [指示(行為)](ServiceRequest-example-nursing-action-order.html) / [指示(看護計画から展開)](ServiceRequest-example-nursing-plan-order.html)
- [Task](Task-example-nursing-task.html)
- [看護観察の記録](Observation-example-nursing-observation.html) / [看護行為の実施](Procedure-example-nursing-action-procedure.html)
