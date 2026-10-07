### オーダー種別の一覧

| 種別(order-type) | 構造 | ヘッダ / 単一 | 明細 | Task | 実施記録 | ページ |
|---|---|---|---|---|---|---|
| lab 検体検査 | ヘッダ + 明細(パネル → 子項目) | [FC_LabOrderHeader](StructureDefinition-fc-lab-order-header.html) | [FC_LabOrderItem](StructureDefinition-fc-lab-order-item.html)(contained Specimen) | lab-exam | 報告(DiagnosticReport) | [検体検査](order-lab.html) |
| micro 細菌検査 | ヘッダ + 検体グループ + 検査項目 | [FC_MicroOrderHeader](StructureDefinition-fc-micro-order-header.html) | [FC_MicroOrderSpecimenGroup](StructureDefinition-fc-micro-order-specimen-group.html) / [FC_MicroOrderItem](StructureDefinition-fc-micro-order-item.html) | 無し | 報告 | [細菌検査](order-micro.html) |
| rad 放射線検査 | ヘッダ + 明細(セット → 子) | [FC_RadOrderHeader](StructureDefinition-fc-rad-order-header.html) | [FC_RadOrderItem](StructureDefinition-fc-rad-order-item.html) | rad-exam | Procedure ハブ + 読影レポート | [放射線検査](order-rad.html) |
| radiotherapy 放射線治療 | 単一 | [FC_RadiotherapyOrder](StructureDefinition-fc-radiotherapy-order.html) | 無し(拡張でフェーズ) | radiotherapy | 照射 Procedure / コース要約 | [放射線治療](order-radiotherapy.html) |
| endoscopy 内視鏡 | ヘッダ + 明細 | [FC_EndoscopyOrderHeader](StructureDefinition-fc-endoscopy-order-header.html) | [FC_EndoscopyOrderItem](StructureDefinition-fc-endoscopy-order-item.html) | endoscopy-exam | Procedure ハブ + 所見レポート | [内視鏡・生理検査](order-endoscopy-physio.html) |
| physio 生理検査 | ヘッダ + 明細 | [FC_PhysioOrderHeader](StructureDefinition-fc-physio-order-header.html) | [FC_PhysioOrderItem](StructureDefinition-fc-physio-order-item.html) | physio-exam | Procedure ハブ + 所見レポート | 同上 |
| pathology 病理検査 | ヘッダ + 検体明細 | [FC_PathoOrderHeader](StructureDefinition-fc-patho-order-header.html) | [FC_PathoOrderItem](StructureDefinition-fc-patho-order-item.html)(contained Specimen) | patho-exam | 病理診断レポート | [病理検査](order-pathology.html) |
| surgery 手術 | ヘッダ + 術式明細 | [FC_SurgeryOrderHeader](StructureDefinition-fc-surgery-order-header.html) | [FC_SurgeryOrderItem](StructureDefinition-fc-surgery-order-item.html) | surgery | Procedure ハブ + 麻酔チャート | [手術](order-surgery.html) |
| treatment 処置 | ヘッダ + 明細 | [FC_TreatmentOrderHeader](StructureDefinition-fc-treatment-order-header.html) | [FC_TreatmentOrderItem](StructureDefinition-fc-treatment-order-item.html) | treatment | Procedure ハブ | [処置](order-treatment.html) |
| rehab リハビリ | 単一 | [FC_RehabOrder](StructureDefinition-fc-rehab-order.html) | 無し | rehab | 回ごとの Procedure | [リハビリ](order-rehab.html) |
| consult 他科依頼 | 単一 | [FC_ConsultOrder](StructureDefinition-fc-consult-order.html) | 無し | consult | 回答 Composition | [他科依頼](order-consult.html) |
| nursing 看護指示 | 指示行ごとに単一 | [FC_NursingOrder](StructureDefinition-fc-nursing-order.html) | 無し | nursing | 看護観察 Observation / 看護行為 Procedure | [看護指示](order-nursing.html) |
| meal 食事 | 単一 | [FC_MealOrder](StructureDefinition-fc-meal-order.html) | 無し | 無し | 摂取量 Observation | [食事](order-meal.html) |
| transfusion 輸血 | ヘッダ + 製剤明細 | [FC_TransfusionOrderHeader](StructureDefinition-fc-transfusion-order-header.html) | [FC_TransfusionOrderItem](StructureDefinition-fc-transfusion-order-item.html) | transfusion | Procedure ハブ | [輸血](order-transfusion.html) |
| nutrition-guidance 栄養指導 | 単一 | [FC_NutritionGuidanceOrder](StructureDefinition-fc-nutrition-guidance-order.html) | 無し | nutrition-guidance | 回ごとの Procedure | [栄養指導](order-nutrition-guidance.html) |
| medication-guidance 服薬指導 | 単一 | [FC_MedicationGuidanceOrder](StructureDefinition-fc-medication-guidance-order.html) | 無し | medication-guidance | 回ごとの Procedure | [服薬指導](order-medication-guidance.html) |
| prescription 処方 | ヘッダ + 薬剤行 | [FC_PrescriptionOrder](StructureDefinition-fc-prescription-order.html) | [FC_PrescriptionMedicationRequest](StructureDefinition-fc-prescription-medication-request.html) | rx-dispense | 調剤 / 与薬 | [薬剤](medication.html) |
| injection 注射 | 日ごとのヘッダ + 薬剤行 | [FC_InjectionOrder](StructureDefinition-fc-injection-order.html) | [FC_InjectionMedicationRequest](StructureDefinition-fc-injection-medication-request.html) | injection | 払出 / 実施 | [薬剤](medication.html) |
| chemo-regimen 化学療法 | 単一(intent = plan) | [FC_RegimenOrder](StructureDefinition-fc-regimen-order.html) | 日オーダーは注射 / 処方 | 無し | 有害事象 Observation | [薬剤](medication.html) |

共通の構造は [共通規約](guidance-common.html)、オーダーセット・パスの印は [オーダーセット・パス適用の印](order-set-pathway.html) を参照。
