### Procedure ハブのパターン

オーダーの実施は **Procedure をハブ**にして、子リソースを `partOf` でぶら下げます。共通形は [FC_ProcedureHub](StructureDefinition-fc-procedure-hub.html) です。

- `meta.profile` = JP_Procedure(アプリが付ける)。
- `category.coding[0]` = オーダー種別(`order-type`)。上流サーバーは category の先頭しか索引しません。
- `basedOn` = オーダーのヘッダ ServiceRequest。`performer.actor` = 実施者。
- `code` = 先頭の手技(レセプト手技コード)。2 件目以降の手技は別の Procedure(`partOf` → ハブ、`basedOn` は同じ)。
- `usedCode` = 材料。院内材料コードや特定保険医療材料コード(`medical-material`)に、数量の拡張(`<種別>-material-quantity`)を CodeableConcept 上に付けます。
- 薬剤は MedicationAdministration(`partOf` → ハブ、`medicationCodeableConcept` = medicine-code + YJ、`dosage.route` = JP Core route-codes)。
- 測定値は Observation(`partOf` → ハブ)。
- 取消はリソースを削除します(`entered-in-error` にしない)。放射線治療の照射だけは `entered-in-error` にします。
- 同じ transaction で Task を completed にします。

### 種別ごとのプロファイル

| 種別 | プロファイル | 特徴 |
|---|---|---|
| 放射線検査 | [FC_RadProcedure](StructureDefinition-fc-rad-procedure.html) | 材料 `rad-material` + `medical-material`、線量 Observation(`rad-dose`)、造影剤 |
| 内視鏡 | [FC_EndoscopyProcedure](StructureDefinition-fc-endoscopy-procedure.html) | 材料は `medical-material` のみ(text は常に) |
| 生理検査 | [FC_PhysioProcedure](StructureDefinition-fc-physio-procedure.html) | 同上 |
| 処置 | [FC_TreatmentProcedure](StructureDefinition-fc-treatment-procedure.html) | 同上 |
| 手術 | [FC_SurgeryProcedure](StructureDefinition-fc-surgery-procedure.html) | performedPeriod = 入退室、各時刻(`surgery-perform-times`)、performer.function = 役割、outcome、創分類、カウント確認、出血量・尿量・輸血量 Observation |
| 麻酔チャート | [FC_AnesthesiaChartProcedure](StructureDefinition-fc-anesthesia-chart-procedure.html) | category = anesthesia-chart、basedOn = 手術オーダー、バイタル・イベント Observation と麻酔薬 MedicationAdministration |
| リハビリ | [FC_RehabProcedure](StructureDefinition-fc-rehab-procedure.html) | 回ごと、code = 療法種別、単位数 |
| 栄養指導 | [FC_NutritionGuidanceProcedure](StructureDefinition-fc-nutrition-guidance-procedure.html) | 回ごと、code = 実施区分、指導時間、指導記録(QuestionnaireResponse) |
| 放射線治療 照射 | [FC_RadiotherapyFractionProcedure](StructureDefinition-fc-radiotherapy-fraction-procedure.html) | category に `radiotherapy-procedure#fraction`、status preparation → completed / not-done / entered-in-error、`radiotherapy-fraction` 拡張 |
| 放射線治療 コース要約 | [FC_RadiotherapyCourseSummaryProcedure](StructureDefinition-fc-radiotherapy-course-summary-procedure.html) | category に `#course-summary`、outcome、`radiotherapy-course-summary` 拡張 |
| 輸血 | [FC_TransfusionProcedure](StructureDefinition-fc-transfusion-procedure.html) | バッグごとの MedicationAdministration(ロット番号)、輸血反応 Observation |
| 与薬 | [FC_OralAdministrationProcedure](StructureDefinition-fc-oral-administration-procedure.html) | category = prescription、服用予定ごと(`medication-schedule-slot`)、completed / not-done |
| 注射 | [FC_InjectionProcedure](StructureDefinition-fc-injection-procedure.html) | completed / stopped / not-done、performedPeriod |
| 看護行為 | [FC_NursingActionProcedure](StructureDefinition-fc-nursing-action-procedure.html) | code = MEDIS 看護行為、identifier = nursing-perform-entry |
| パスのタスク | [FC_PathwayTaskProcedure](StructureDefinition-fc-pathway-task-procedure.html) | ePath の Procedure。ハブではない |

### MedicationAdministration の共通形

[FC_MedicationAdministration](StructureDefinition-fc-medication-administration.html): `partOf` = ハブ、`request` = 元の MedicationRequest(無いこともある)、`effectiveDateTime` または `effectivePeriod`、`dosage` はオーダーから複製。注射の途中中止は `stopped`、麻酔の持続投与中は `in-progress`。
