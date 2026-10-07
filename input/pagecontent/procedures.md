### Procedure ハブのパターン

オーダーの実施は **Procedure をハブ**にして、子リソースを `partOf` でぶら下げます。共通形は [FC_ProcedureHub](StructureDefinition-fc-procedure-hub.html) です。

- `meta.profile` = JP_Procedure(アプリが付ける)。
- `category.coding[0]` = オーダー種別(`order-type`)。上流サーバーは category の先頭しか索引しません。
- `basedOn` = オーダーのヘッダ ServiceRequest。`performer.actor` = 実施者。
- `code` = 先頭の手技(レセプト手技コード)。2 件目以降の手技は別の Procedure(`partOf` → ハブ、`basedOn` は同じ)。
- `usedCode` = 材料。院内材料コードや特定保険医療材料コード(`medical-material`)に、数量の拡張(`<種別>-material-quantity`)を CodeableConcept 上に付けます。
- 薬剤は MedicationAdministration(`partOf` → ハブ、`medicationCodeableConcept` = medicine-code + YJ、`dosage.route` = JP Core route-codes)。
- 測定値は Observation(`partOf` → ハブ)。
- 取消はリソースを削除します(`entered-in-error` にしない)。放射線治療の照射済みの記録だけは `entered-in-error` にします(照射予定 = preparation の取消は削除)。
- 検査・処置・手術・輸血・注射の実施は、同じ transaction で部門 Task を進めます(completed など)。リハビリ・栄養指導・服薬指導・看護行為・与薬・放射線治療(照射・治療終了サマリー)は Task を変えません。

### 種別ごとのプロファイル

| 種別 | プロファイル | 特徴 |
|---|---|---|
| 放射線検査 | [FC_RadProcedure](StructureDefinition-fc-rad-procedure.html) | 材料 `rad-material` + `medical-material`、線量 Observation(`rad-dose`)、造影剤 |
| 内視鏡 | [FC_EndoscopyProcedure](StructureDefinition-fc-endoscopy-procedure.html) | 材料は `medical-material` のみ(text は常に) |
| 生理検査 | [FC_PhysioProcedure](StructureDefinition-fc-physio-procedure.html) | 同上 |
| 処置 | [FC_TreatmentProcedure](StructureDefinition-fc-treatment-procedure.html) | 同上 |
| 手術 | [FC_SurgeryProcedure](StructureDefinition-fc-surgery-procedure.html) | code = `surgery-procedure-code`(レセプト電算コード + display)、performedPeriod = 入退室、各時刻(`surgery-perform-times`)、performer.function = 役割、outcome、創分類、カウント確認、出血量・尿量・輸血量 Observation |
| 麻酔チャート | [FC_AnesthesiaChartProcedure](StructureDefinition-fc-anesthesia-chart-procedure.html) | category = anesthesia-chart、basedOn = 手術オーダー、code.text = 麻酔チャート、in-progress ⇄ completed(確定後に再開できる)、バイタル・イベント Observation と麻酔薬 MedicationAdministration |
| リハビリ | [FC_RehabProcedure](StructureDefinition-fc-rehab-procedure.html) | 回ごと、code = 療法種別、単位数 |
| 栄養指導 | [FC_NutritionGuidanceProcedure](StructureDefinition-fc-nutrition-guidance-procedure.html) | 回ごと、code = 実施区分、指導時間、指導記録(QuestionnaireResponse) |
| 服薬指導 | [FC_MedicationGuidanceProcedure](StructureDefinition-fc-medication-guidance-procedure.html) | 回ごと、code = 指導種別、performer = 薬剤師、理解度、指導記録(QuestionnaireResponse)、note = 指導内容 |
| 放射線治療 照射 | [FC_RadiotherapyFractionProcedure](StructureDefinition-fc-radiotherapy-fraction-procedure.html) | category に `radiotherapy-procedure#fraction`、status preparation → completed / not-done / entered-in-error、performedPeriod(時刻あり)または performedDateTime(日付のみ)、`radiotherapy-fraction` 拡張(fractionNumber はフェーズ内の回数) |
| 放射線治療 治療終了サマリー | [FC_RadiotherapyCourseSummaryProcedure](StructureDefinition-fc-radiotherapy-course-summary-procedure.html) | category に `#course-summary`、performedPeriod(日付のみ)、outcome、`radiotherapy-course-summary` 拡張 |
| 輸血 | [FC_TransfusionProcedure](StructureDefinition-fc-transfusion-procedure.html) | バッグごとの MedicationAdministration(単位数・ロット番号)、輸血副作用 Observation |
| 与薬 | [FC_OralAdministrationProcedure](StructureDefinition-fc-oral-administration-procedure.html) | category = prescription、服用予定ごと(`medication-schedule-slot`)、completed / not-done |
| 注射 | [FC_InjectionProcedure](StructureDefinition-fc-injection-procedure.html) | completed / stopped / not-done、performedPeriod |
| 看護行為 | [FC_NursingActionProcedure](StructureDefinition-fc-nursing-action-procedure.html) | code = 指示の MEDIS 看護行為(16 桁コード + 8 桁管理番号)、identifier = nursing-perform-entry |
| パスのタスク | [FC_PathwayTaskProcedure](StructureDefinition-fc-pathway-task-procedure.html) | ePath の Procedure。ハブではない |

### MedicationAdministration の共通形

[FC_MedicationAdministration](StructureDefinition-fc-medication-administration.html): `partOf` = ハブ、`request` = 元の MedicationRequest(無いこともある)、`effectiveDateTime` または `effectivePeriod`、`dosage` はオーダーから複製(与薬の `dose` は、処方の 1 日量をその枠の 1 回量に割ったもの)。注射の途中中止は `stopped`、麻酔の持続投与中は `in-progress`。
