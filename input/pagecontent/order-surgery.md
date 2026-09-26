### 構造

```
ServiceRequest(ヘッダ = 申込、FC_SurgeryOrderHeader)
 │  extension: surgery-room / surgery-department / surgery-duration / surgery-position / surgery-estimated-blood-loss /
 │             surgery-staff(0..*) / surgery-anesthesia-method(0..*) / surgery-anesthesia-management / surgery-blood-preparation /
 │             surgery-equipment(0..*) / surgery-specimen-plan(0..*) / surgery-consent(0..*) / surgery-preop-instruction(-questionnaire-response)
 ├ ServiceRequest(術式明細、FC_SurgeryOrderItem、identifier 1 = 主術式)  basedOn → ヘッダ
 ├ Task(surgery、FC_SurgeryTask)  focus → ヘッダ
 ├ Procedure(実施記録ハブ、FC_SurgeryProcedure)  basedOn → ヘッダ
 │   ├ Procedure(2 件目以降の術式)  partOf → ハブ
 │   ├ MedicationAdministration(薬剤)  partOf → ハブ
 │   └ Observation(出血量 / 尿量 / 輸血量、FC_SurgeryObservation)  partOf → ハブ
 └ Procedure(麻酔チャート、FC_AnesthesiaChartProcedure)  basedOn → ヘッダ
     ├ Observation(バイタル、FC_AnesthesiaVitalObservation)  partOf → 麻酔チャート
     ├ Observation(イベント、FC_AnesthesiaEventObservation)  partOf → 麻酔チャート
     └ MedicationAdministration(麻酔薬)  partOf → 麻酔チャート
```

### 申込

- `priority`: routine 予定 / urgent 準緊急 / stat 緊急。
- `occurrenceDateTime` は予定日時。未定なら省略します(全種別で手術だけが省略可。カルテでは「日付未定」に表示)。
- 術式明細の `code` = 術式マスタ(`surgery-order-item`)+ レセプト K コード(`surgery-procedure-code`)+ 略称。`bodySite` = 左右 + text。`reasonReference` / `reasonCode` = 術前診断。アプローチは `surgery-approach`。
- 日程の確定は ServiceRequest の PUT と Task を同じ transaction で行います。Appointment は作りません。手術室の割当は `surgery-room`(Location)。

### Task

requested 申込済 / accepted 受付済 / in-progress 入室中 / completed 実施済 / cancelled 中止。

### 実施記録・麻酔チャート

[実施記録](procedures.html) を参照。

### 例

- [ヘッダ](ServiceRequest-example-surgery-order-header.html) / [術式明細](ServiceRequest-example-surgery-order-item.html) / [手術室](Location-example-surgery-room.html)
- [Task](Task-example-surgery-task.html)
- [実施記録](Procedure-example-surgery-procedure.html) / [出血量](Observation-example-surgery-observation.html)
- [麻酔チャート](Procedure-example-anesthesia-chart-procedure.html)
