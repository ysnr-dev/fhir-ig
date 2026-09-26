### 構造

```
ServiceRequest(処方、FC_RehabOrder)
 │  code = 疾患別区分 / orderDetail = 療法種別(PT / OT / ST) / quantityQuantity = 単位数
 │  extension: rehab-order-end / rehab-onset-date / rehab-target-disease / rehab-frequency-per-week
 ├ Appointment(リハ室の予約)  basedOn → 処方(別 transaction)
 ├ Task(rehab、FC_RehabTask)  focus → 処方   ※ 期間中は accepted のまま
 └ Procedure(回ごとの実施、FC_RehabProcedure)  basedOn → 処方
     extension: rehab-performed-units
```

- `occurrenceDateTime` = 開始日、`rehab-order-end` = 終了日(上流の `order-period` 検索で期間を引く)。
- 各回の実施は Procedure で、`code` = 療法種別、`rehab-performed-units` = 単位数(1〜24)。Task は変えません。
- Task の状態: requested 依頼済 / accepted 実施中 / completed 終了 / cancelled 中止。

### 例

- [処方](ServiceRequest-example-rehab-order.html)
- [Task](Task-example-rehab-task.html)
- [実施記録](Procedure-example-rehab-procedure.html)
