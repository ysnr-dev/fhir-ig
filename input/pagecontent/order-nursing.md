### 構造

看護指示は指示 1 行ごとに 1 件の ServiceRequest で、ヘッダ・明細の区別がありません。

```
ServiceRequest(指示行、FC_NursingOrder)   ※ 同時入力した指示は requisition(nursing-order-requisition)で束ねる
 │  code = MEDIS 看護行為(master-nursingAction-16digits + 8 桁管理番号)または看護観察(master-nursingObservationKeyCode)、または text
 │  orderDetail[0].text = 条件 / extension: nursing-order-end / nursing-order-schedule(Timing)
 ├ Task(nursing、FC_NursingTask)  focus → 指示   ※ 登録時に requested で作られ、指示受けで accepted(owner = 看護師)
 ├ Observation(看護観察の記録、FC_NursingObservation)  basedOn → 指示
 └ Procedure(看護行為の実施、FC_NursingActionProcedure)  basedOn → 指示
```

- `category` は nursing + inpatient(常に入院)。`encounter` = 入院 Encounter(入院中でない患者にオーダーセット・パスから適用したときは付かない)。
- `occurrenceDateTime` = 開始日、`nursing-order-end` = 終了日、`nursing-order-schedule` = 頻度(付いていない指示は随時)。
- 記録は 1 回のラウンドで入力した Observation / Procedure を identifier(`nursing-perform-entry`)の uuid で束ねます。
- 看護観察の Observation は `category[0]` が order-type#nursing だけで、code に MEDIS の coding と、対応があれば LOINC のバイタルコードを添えます。値は Quantity(LOINC 対応のバイタルだけ UCUM、他は unit 文字列のみ)/ CodeableConcept(`nursing-observation-result`)/ component / string。マスタに無い自由記載の指示の記録は code.text と valueString だけです。
- 看護行為の実施記録(Procedure)は指示の code(16 桁コード + 8 桁管理番号)をそのまま写します。実施記録を付けても Task は変わりません。

### 例

- [指示(観察)](ServiceRequest-example-nursing-order.html) / [指示(行為)](ServiceRequest-example-nursing-action-order.html)
- [Task](Task-example-nursing-task.html)
- [看護観察の記録](Observation-example-nursing-observation.html) / [看護行為の実施](Procedure-example-nursing-action-procedure.html)
