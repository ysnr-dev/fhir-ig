### 構造

```
ServiceRequest(ヘッダ、FC_RadOrderHeader)
 ├ ServiceRequest(明細 = 撮影項目、FC_RadOrderItem)  basedOn → ヘッダ
 │   └ ServiceRequest(セットの子項目)  basedOn → セットの明細
 ├ Appointment(予約、FC_Appointment)  basedOn → ヘッダ(予約が必要な項目のみ、同じ transaction)
 ├ Task(rad-exam、FC_RadExamTask)  focus → ヘッダ
 ├ Procedure(実施記録ハブ、FC_RadProcedure)  basedOn → ヘッダ
 │   ├ Procedure(2 件目以降の手技)  partOf → ハブ
 │   ├ MedicationAdministration(造影剤)  partOf → ハブ
 │   └ Observation(線量、FC_RadDoseObservation)  partOf → ハブ
 └ DiagnosticReport(読影レポート、FC_RadDiagnosticReport)  basedOn → ヘッダ
     └ result → Observation(所見、FC_RadFindingsObservation)
```

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
