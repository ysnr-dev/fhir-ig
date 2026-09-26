### 構造

```
ServiceRequest(ヘッダ、FC_LabOrderHeader)
 ├ ServiceRequest(明細 = 項目、FC_LabOrderItem)  basedOn → ヘッダ
 │   ├ contained Specimen(#specimen、FC_LabOrderSpecimen)
 │   └ ServiceRequest(パネルの子項目)  basedOn → パネルの明細
 ├ Task(lab-exam、FC_LabExamTask)  focus → ヘッダ
 ├ Specimen(検体ラベル、採血管ごと、FC_LabLabelSpecimen)  request → ヘッダ   ※ backend が作る
 └ DiagnosticReport(結果報告、FC_LabDiagnosticReport)  basedOn → ヘッダ
     ├ result → Observation(項目ごと、FC_LabResultObservation)
     └ specimen → 検体ラベルの Specimen
```

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

[検査結果・報告](results.html) を参照。パニック値の通知(`lab-panic`)と結果確認の通知(`result-review`)が報告と同時に作られます。

### 例

- [ヘッダ](ServiceRequest-example-lab-order-header.html)
- [明細](ServiceRequest-example-lab-order-item.html)
- [検体ラベルの Specimen](Specimen-example-lab-label-specimen.html)
- [Task](Task-example-lab-exam-task.html)
- [報告](DiagnosticReport-example-lab-diagnostic-report.html)
