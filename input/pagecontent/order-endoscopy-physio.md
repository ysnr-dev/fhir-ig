### 構造

内視鏡と生理検査は放射線検査と同じ構造です(JJ1017 と bodySite は持たない)。

```
ServiceRequest(ヘッダ、FC_EndoscopyOrderHeader / FC_PhysioOrderHeader)
 ├ ServiceRequest(明細、FC_EndoscopyOrderItem / FC_PhysioOrderItem)  basedOn → ヘッダ
 ├ Appointment  basedOn → ヘッダ(同じ transaction)
 ├ Task(endoscopy-exam / physio-exam)  focus → ヘッダ
 ├ Procedure(実施記録ハブ、FC_EndoscopyProcedure / FC_PhysioProcedure)  basedOn → ヘッダ
 │   ├ Procedure(2 件目以降の手技)  partOf → ハブ
 │   └ MedicationAdministration(薬剤)  partOf → ハブ
 └ DiagnosticReport(所見レポート、FC_EndoscopyDiagnosticReport / FC_PhysioDiagnosticReport)  basedOn → ヘッダ
     └ result → Observation(所見、FC_EndoscopyFindingsObservation / FC_PhysioFindingsObservation)
```

### オーダー

| | 内視鏡 | 生理検査 |
|---|---|---|
| 項目コード | `endoscopy-order-item` | `physio-order-item` |
| 検査種別(明細の category) | `endoscopy-exam-type` | `physio-exam-type` |
| 検査目的 | `endoscopy-exam-purpose` / `endoscopy-exam-purpose-questionnaire-response` | `physio-exam-purpose` / `physio-exam-purpose-questionnaire-response` |
| 特別指示テンプレート | `endoscopy-remarks-questionnaire-response` | `physio-remarks-questionnaire-response` |
| 明細番号 | `IdSystem/endoscopy-order-item-number` | `IdSystem/physio-order-item-number` |

`priority` は routine / urgent / asap。分割と予約は放射線検査と同じです。

### 実施記録

[実施記録](procedures.html) を参照。手技コードは `endoscopy-procedure-code` / `physio-procedure-code`、材料は `medical-material` + `endoscopy-material-quantity` / `physio-material-quantity`。

### 所見レポート

[検査結果・報告](results.html) の生理検査・内視鏡を参照。重要所見(`endoscopy-critical-finding` / `physio-critical-finding`)が付くと依頼医宛の通知 Task が作られます。レポートが付いたオーダーは取消・削除できません。

### 例

- 内視鏡: [ヘッダ](ServiceRequest-example-endoscopy-order-header.html) / [明細](ServiceRequest-example-endoscopy-order-item.html) / [実施記録](Procedure-example-endoscopy-procedure.html) / [所見レポート](DiagnosticReport-example-endoscopy-diagnostic-report.html)
- 生理検査: [ヘッダ](ServiceRequest-example-physio-order-header.html) / [明細](ServiceRequest-example-physio-order-item.html) / [実施記録](Procedure-example-physio-procedure.html) / [所見レポート](DiagnosticReport-example-physio-diagnostic-report.html)
