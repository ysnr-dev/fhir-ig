### 構造

```
ServiceRequest(ヘッダ、FC_TransfusionOrderHeader)
 │  code = 輸血前検査(交差適合試験 / T&S) / extension: transfusion-abo / transfusion-rhd / transfusion-consent
 ├ ServiceRequest(製剤明細、FC_TransfusionOrderItem)  basedOn → ヘッダ
 ├ Task(transfusion、FC_TransfusionTask)  focus → ヘッダ
 └ Procedure(実施記録ハブ、FC_TransfusionProcedure)  basedOn → ヘッダ
     ├ MedicationAdministration(バッグごと、transfusion-lot-number)  partOf → ハブ
     └ Observation(輸血反応、FC_TransfusionReactionObservation)  partOf → ハブ
```

- `occurrenceDateTime` = 投与予定日時(空なら省略)。
- 製剤明細の `code` = 製剤マスタ(`transfusion-product`)、`quantityQuantity` = 数量(unit = 製剤の単位名)。略称は付けません。
- 血液型は患者プロファイルの血液型 Observation(LOINC 883-9 / 10331-7)と同じ CodeSystem(`transfusion-abo` / `transfusion-rhd`)を使います。
- Task の状態: requested 依頼済 / accepted 受付済 / in-progress 出庫済 / completed 実施済 / cancelled 中止。

### 例

- [ヘッダ](ServiceRequest-example-transfusion-order-header.html) / [製剤明細](ServiceRequest-example-transfusion-order-item.html)
- [Task](Task-example-transfusion-task.html)
- [実施記録](Procedure-example-transfusion-procedure.html) / [製剤の投与](MedicationAdministration-example-transfusion-medication-administration.html) / [輸血反応](Observation-example-transfusion-reaction-observation.html)
