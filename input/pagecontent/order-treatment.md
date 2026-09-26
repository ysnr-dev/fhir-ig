### 構造

処置は放射線検査と同じ「ヘッダ + 明細」構造で、`priority`・明細の category / reason / note / 拡張を持たない簡素な形です。

```
ServiceRequest(ヘッダ、FC_TreatmentOrderHeader)
 ├ ServiceRequest(明細、FC_TreatmentOrderItem)  basedOn → ヘッダ
 ├ Appointment  basedOn → ヘッダ(予約が必要な項目のみ)
 ├ Task(treatment、FC_TreatmentTask)  focus → ヘッダ
 └ Procedure(実施記録ハブ、FC_TreatmentProcedure)  basedOn → ヘッダ
     ├ Procedure(2 件目以降の手技)  partOf → ハブ
     └ MedicationAdministration(薬剤)  partOf → ハブ
```

- 明細の `code` = 院内項目コード(`treatment-order-item`)+ 略称。
- 実施記録の手技コードは `treatment-procedure-code`、材料は `medical-material` + `treatment-material-quantity`。

### 例

- [ヘッダ](ServiceRequest-example-treatment-order-header.html) / [明細](ServiceRequest-example-treatment-order-item.html)
- [Task](Task-example-treatment-task.html)
- [実施記録](Procedure-example-treatment-procedure.html)
