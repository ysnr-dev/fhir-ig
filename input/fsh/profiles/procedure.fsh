// 実施記録: Procedure ハブのパターンと、種別ごとの Procedure。

Profile: FC_ProcedureHub
Parent: $JP_Procedure
Id: fc-procedure-hub
Title: "実施記録ハブ(共通)"
Description: """オーダーの実施を表す Procedure の共通形(ハブ)。

- category.coding の先頭 = オーダー種別(order-type)。上流サーバーは category の先頭しか索引しない。
- basedOn = オーダーのヘッダ ServiceRequest。subject = 患者。performer.actor = 実施者。
- 2 件目以降の手技は別の Procedure(partOf = ハブ、basedOn は同じ)。薬剤は MedicationAdministration(partOf = ハブ)、測定値は Observation(partOf = ハブ)。
- 取消は entered-in-error にせずリソースを削除する(放射線治療の照射済みの記録だけは entered-in-error)。
- 検査・処置・手術・輸血・注射の実施は同じ transaction で部門 Task を進める。リハビリ・栄養指導・看護行為・与薬・放射線治療の実施記録は Task を変えない。"""
* insert FCMeta
* ^abstract = true
* category 1..1 MS
* category.coding 1..*
* category.coding ^slicing.discriminator[0].type = #value
* category.coding ^slicing.discriminator[0].path = "system"
* category.coding ^slicing.rules = #open
* category.coding ^slicing.ordered = true
* category.coding contains orderType 1..1 MS
* category.coding[orderType].system = "http://fhir-client.local/CodeSystem/order-type"
* category.coding[orderType] from OrderTypeVS (required)
* subject only Reference(FC_Patient)
* basedOn 1..* MS
* basedOn only Reference(ServiceRequest)
* performer.actor only Reference(FC_Practitioner)
* partOf only Reference(FC_ProcedureHub)

Profile: FC_RadProcedure
Parent: FC_ProcedureHub
Id: fc-rad-procedure
Title: "放射線検査 実施記録"
Description: "放射線検査の実施。code = 先頭の手技(rad-procedure-code)、usedCode = 材料(rad-material + medical-material、rad-material-quantity 拡張で数量)。造影剤は MedicationAdministration(route: IV / IA / PO / PR / IB / IT / IJ)、線量は Observation(rad-dose)。同じ transaction で Task を completed にする。"
* category.coding[orderType] = $order-type#rad "放射線検査"
* status = #completed
* basedOn only Reference(FC_RadOrderHeader)
* performed[x] only dateTime
* code.coding.system = "http://fhir-client.local/CodeSystem/rad-procedure-code"
* usedCode.coding ^slicing.discriminator[0].type = #value
* usedCode.coding ^slicing.discriminator[0].path = "system"
* usedCode.coding ^slicing.rules = #open
* usedCode.coding contains
    material 0..1 and
    medicalMaterial 0..1
* usedCode.coding[material].system = "http://fhir-client.local/CodeSystem/rad-material"
* usedCode.coding[medicalMaterial].system = "http://fhir-client.local/CodeSystem/medical-material"
* usedCode.extension contains RadMaterialQuantity named quantity 0..1

Profile: FC_EndoscopyProcedure
Parent: FC_ProcedureHub
Id: fc-endoscopy-procedure
Title: "内視鏡 実施記録"
Description: "内視鏡の実施。放射線と同形(線量は無い)。usedCode はマスタから選んだときだけ medical-material を持ち、text は常にある。薬剤の route: IV / IM / SC / PO / TOP / PR。"
* category.coding[orderType] = $order-type#endoscopy "内視鏡"
* status = #completed
* basedOn only Reference(FC_EndoscopyOrderHeader)
* performed[x] only dateTime
* code.coding.system = "http://fhir-client.local/CodeSystem/endoscopy-procedure-code"
* usedCode.text 1..1
* usedCode.coding.system = "http://fhir-client.local/CodeSystem/medical-material"
* usedCode.extension contains EndoscopyMaterialQuantity named quantity 0..1

Profile: FC_PhysioProcedure
Parent: FC_ProcedureHub
Id: fc-physio-procedure
Title: "生理検査 実施記録"
Description: "生理検査の実施。内視鏡と同形。薬剤の route: IV / IA / IM / SC / PO / IH。"
* category.coding[orderType] = $order-type#physio "生理検査"
* status = #completed
* basedOn only Reference(FC_PhysioOrderHeader)
* performed[x] only dateTime
* code.coding.system = "http://fhir-client.local/CodeSystem/physio-procedure-code"
* usedCode.text 1..1
* usedCode.coding.system = "http://fhir-client.local/CodeSystem/medical-material"
* usedCode.extension contains PhysioMaterialQuantity named quantity 0..1

Profile: FC_TreatmentProcedure
Parent: FC_ProcedureHub
Id: fc-treatment-procedure
Title: "処置 実施記録"
Description: "処置の実施。内視鏡と同形。薬剤の route: TOP / IV / IM / SC / PO / IH / PR。"
* category.coding[orderType] = $order-type#treatment "処置"
* status = #completed
* basedOn only Reference(FC_TreatmentOrderHeader)
* performed[x] only dateTime
* code.coding.system = "http://fhir-client.local/CodeSystem/treatment-procedure-code"
* usedCode.text 1..1
* usedCode.coding.system = "http://fhir-client.local/CodeSystem/medical-material"
* usedCode.extension contains TreatmentMaterialQuantity named quantity 0..1

Profile: FC_SurgeryProcedure
Parent: FC_ProcedureHub
Id: fc-surgery-procedure
Title: "手術 実施記録"
Description: """手術の実施(ハブ)。

- performedPeriod = 入室〜退室。各時刻(麻酔開始 / 執刀開始 / 執刀終了 / 麻酔終了)は surgery-perform-times。
- performer[].function = スタッフの役割(surgery-staff-role)。
- status = completed。code = 先頭の術式・麻酔の手技(surgery-procedure-code のレセプト電算コード + display、text = 手技名)。2 件目以降の手技は partOf でぶら下がる別の Procedure(performer は持たない)。usedCode = 材料(medical-material + surgery-material-quantity、text は常にある)。
- complication[].text、outcome(surgery-outcome)、創分類・カウント確認は拡張。
- 出血量・尿量・輸血量は Observation(surgery-observation、mL)、薬剤は MedicationAdministration(route: IV / IM / SC / TOP / IH / PO / PR)。"""
* category.coding[orderType] = $order-type#surgery "手術"
* basedOn only Reference(FC_SurgeryOrderHeader)
* status = #completed
* performed[x] only Period
* code.coding.system = "http://fhir-client.local/CodeSystem/surgery-procedure-code"
* performer.function.coding.system = "http://fhir-client.local/CodeSystem/surgery-staff-role"
* outcome from SurgeryOutcomeVS (required)
* usedCode.coding.system = "http://fhir-client.local/CodeSystem/medical-material"
* usedCode.extension contains SurgeryMaterialQuantity named quantity 0..1
* extension contains
    SurgeryPerformTimes named performTimes 0..1 MS and
    SurgeryWoundClass named woundClass 0..1 and
    SurgeryCountCheck named countCheck 0..1

Profile: FC_RehabProcedure
Parent: FC_ProcedureHub
Id: fc-rehab-procedure
Title: "リハビリ 実施記録"
Description: "リハビリの 1 回の実施。code = 療法種別(rehab-therapy-type)、rehab-performed-units = 単位数。Task は変えない。"
* category.coding[orderType] = $order-type#rehab "リハビリ"
* status = #completed
* basedOn only Reference(FC_RehabOrder)
* code 1..1
* code from RehabTherapyTypeVS (required)
* performed[x] only dateTime
* extension contains RehabPerformedUnits named performedUnits 1..1 MS

Profile: FC_NutritionGuidanceProcedure
Parent: FC_ProcedureHub
Id: fc-nutrition-guidance-procedure
Title: "栄養指導 実施記録"
Description: "栄養指導の 1 回の実施。code = 実施区分(nutrition-guidance-session-type)、nutrition-guidance-performed-minutes = 指導時間、nutrition-guidance-record = 指導記録の QuestionnaireResponse(同じ transaction)。Task は変えない。"
* category.coding[orderType] = $order-type#nutrition-guidance "栄養指導"
* status = #completed
* basedOn only Reference(FC_NutritionGuidanceOrder)
* code 1..1
* code from NutritionGuidanceSessionTypeVS (required)
* performed[x] only dateTime
* extension contains
    NutritionGuidancePerformedMinutes named performedMinutes 0..1 and
    NutritionGuidanceRecord named record 0..1

Profile: FC_RadiotherapyFractionProcedure
Parent: FC_ProcedureHub
Id: fc-radiotherapy-fraction-procedure
Title: "放射線治療 照射記録"
Description: "1 回の照射。category = [order-type#radiotherapy, radiotherapy-procedure#fraction]。status: preparation(照射予定)/ completed / not-done(statusReason = 中止理由)/ entered-in-error(照射済みの記録の取消。削除はしない)。照射予定(preparation)の取消だけはリソースを削除する。performed[x] は、時刻を入力したとき performedPeriod(start、end)、入力しないとき日付のみの performedDateTime。code = 処方の照射技術(radiotherapy-technique)、usedCode = 治療装置。radiotherapy-fraction 拡張にフェーズ・フェーズ内の回数・IGRT・体積ごとの線量。Task は変えない。"
* category.coding ^slicing.discriminator[0].type = #value
* category.coding ^slicing.discriminator[0].path = "system"
* category.coding ^slicing.rules = #open
* category.coding ^slicing.ordered = true
* category.coding contains kind 1..1
* category.coding[orderType] = $order-type#radiotherapy "放射線治療"
* category.coding[kind].system 1..1
* category.coding[kind].system = "http://fhir-client.local/CodeSystem/radiotherapy-procedure"
* category.coding[kind].code = #fraction
* basedOn only Reference(FC_RadiotherapyOrder)
* code.coding.system = "http://fhir-client.local/CodeSystem/radiotherapy-technique"
* statusReason.coding.system = "http://fhir-client.local/CodeSystem/radiotherapy-stop-reason"
* usedCode.coding.system = "http://fhir-client.local/CodeSystem/radiotherapy-device"
* extension contains RadiotherapyFraction named fraction 1..1 MS

Profile: FC_RadiotherapyCourseSummaryProcedure
Parent: FC_ProcedureHub
Id: fc-radiotherapy-course-summary-procedure
Title: "放射線治療 治療終了サマリー"
Description: "コース終了時の治療終了サマリー。category = [order-type#radiotherapy, radiotherapy-procedure#course-summary]。status: completed / stopped。outcome = 転帰(radiotherapy-course-outcome)。performedPeriod = 治療期間(日付のみ)。radiotherapy-course-summary 拡張に照射回数・線量・中止理由・経過・有害事象・今後の方針。Task は変えない。"
* category.coding ^slicing.discriminator[0].type = #value
* category.coding ^slicing.discriminator[0].path = "system"
* category.coding ^slicing.rules = #open
* category.coding ^slicing.ordered = true
* category.coding contains kind 1..1
* category.coding[orderType] = $order-type#radiotherapy "放射線治療"
* category.coding[kind].system 1..1
* category.coding[kind].system = "http://fhir-client.local/CodeSystem/radiotherapy-procedure"
* category.coding[kind].code = #course-summary
* basedOn only Reference(FC_RadiotherapyOrder)
* outcome from RadiotherapyCourseOutcomeVS (required)
* extension contains RadiotherapyCourseSummary named courseSummary 1..1 MS

Profile: FC_TransfusionProcedure
Parent: FC_ProcedureHub
Id: fc-transfusion-procedure
Title: "輸血 実施記録"
Description: "輸血の実施(ハブ)。code.text = 輸血、performedPeriod。バッグごとの投与は MedicationAdministration(medication = transfusion-product + text、effectivePeriod、dosage.dose = 単位数(unit は製剤の単位名)、transfusion-lot-number)、輸血副作用は Observation(transfusion-observation#reaction)。"
* category.coding[orderType] = $order-type#transfusion "輸血"
* status = #completed
* basedOn only Reference(FC_TransfusionOrderHeader)
* performed[x] only Period

Profile: FC_OralAdministrationProcedure
Parent: FC_ProcedureHub
Id: fc-oral-administration-procedure
Title: "与薬記録"
Description: "処方の与薬(1 回の服用予定に対する記録、ハブ)。category = order-type#prescription、code.text = 与薬。status: completed(与薬)/ not-done(与薬せず、statusReason.text)。basedOn = 処方ヘッダ、encounter = 入院。medication-schedule-slot = 対応する服用予定時刻。薬剤ごとの MedicationAdministration(request = MedicationRequest)がぶら下がる。調剤 Task は変えない。服用予定は用法コードからクライアント側で展開し、FHIR には持たない。"
* category.coding[orderType] = $order-type#prescription "処方"
* basedOn only Reference(FC_PrescriptionOrder)
* encounter only Reference(FC_InpatientEncounter)
* performed[x] only dateTime
* extension contains MedicationScheduleSlot named scheduleSlot 0..1 MS

Profile: FC_InjectionProcedure
Parent: FC_ProcedureHub
Id: fc-injection-procedure
Title: "注射 実施記録"
Description: "注射の実施(ハブ)。category = order-type#injection、code.text = 注射。status: completed / stopped(途中で中止)/ not-done(実施せず)。basedOn = その日の注射 ServiceRequest。performedPeriod。薬剤ごとの MedicationAdministration(status = completed / stopped、request = MedicationRequest、投与時に追加した薬剤は request 無し)がぶら下がる。"
* category.coding[orderType] = $order-type#injection "注射"
* basedOn only Reference(FC_InjectionOrder)
* performed[x] only Period

Profile: FC_NursingActionProcedure
Parent: Procedure
Id: fc-nursing-action-procedure
Title: "看護行為 実施記録"
Description: "看護行為(MEDIS 看護行為マスタ)の指示の実施。category = order-type#nursing、code = 指示の code をそのまま写す(master-nursingAction-16digits と、8 桁管理番号 urn:oid:1.2.392.200119.4.704 の 2 coding + text)。Task は変えない。identifier(nursing-perform-entry)で同じラウンドの記録を束ねる。アプリは meta.profile に JP_Procedure を付けるが、JP_Procedure の nurse スライスは system を medis.or.jp の URL に固定しつつ ValueSet が urn:oid:1.2.392.200119.4.701 のコードだけを含むため、どのコードも準拠できない。本 IG では base から派生する(既知の非準拠)。"
* insert FCMeta
* category 1..1 MS
* category.coding 1..*
* category.coding ^slicing.discriminator[0].type = #value
* category.coding ^slicing.discriminator[0].path = "system"
* category.coding ^slicing.rules = #open
* category.coding ^slicing.ordered = true
* category.coding contains orderType 1..1 MS
* category.coding[orderType].system = "http://fhir-client.local/CodeSystem/order-type"
* category.coding[orderType] = $order-type#nursing "看護指示"
* subject only Reference(FC_Patient)
* performer.actor only Reference(FC_Practitioner)
* status = #completed
* basedOn only Reference(FC_NursingOrder)
* identifier.system = "http://fhir-client.local/nursing-perform-entry"
* code 1..1
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    nursingAction 1..1 MS and
    nursingActionNumber 0..1
* code.coding[nursingAction].system = $medis-nursing-action
* code.coding[nursingActionNumber].system = $medis-nursing-action-oid
* encounter only Reference(FC_InpatientEncounter)

Profile: FC_AnesthesiaChartProcedure
Parent: FC_ProcedureHub
Id: fc-anesthesia-chart-procedure
Title: "麻酔チャート"
Description: "麻酔チャートのハブ。category = order-type#anesthesia-chart、basedOn = 手術オーダー。code.text = 麻酔チャート。status: in-progress(記録中)→ completed(確定、performedPeriod.end)。確定後に再開すると in-progress に戻り end が消える。取消は子とハブを削除する。performer(ログイン中の職員が医療従事者のときだけ)の function = surgery-staff-role#anesthetist。バイタル Observation(category 無し、LOINC)、イベント Observation(anesthesia-event)、薬剤 MedicationAdministration(ボーラス: completed + effectiveDateTime + dose、持続: in-progress + effectivePeriod.start + rateQuantity → 終了で completed + end)が partOf でぶら下がる。"
* category.coding[orderType] = $order-type#anesthesia-chart "麻酔チャート"
* basedOn only Reference(FC_SurgeryOrderHeader)
* performed[x] only Period
* performer.function.coding.system = "http://fhir-client.local/CodeSystem/surgery-staff-role"

Profile: FC_PathwayTaskProcedure
Parent: Procedure
Id: fc-pathway-task-procedure
Title: "パスのタスク"
Description: "クリニカルパスのタスク(ePath の Procedure)。status: preparation(予定)/ completed。category = ePath の EPathTaskCategoryLv1CS と(あれば)EPathTaskCategoryLv2CS の coding を 1 つの CodeableConcept に持つ(display 無し)。code = タスクコード(EPathLocalTaskCodeCS。あれば)+ text = タスク名。basedOn = アセスメントの CarePlan と、タスクから出したオーダーのヘッダ ServiceRequest。identifier = ePath task-id(値はアセスメントの値に連結)。拡張は ePath の EPathProcedureTaskPlannedDateTime(valueDate)と pathway-display-order。"
* insert FCMeta
* subject only Reference(FC_Patient)
* status from http://hl7.org/fhir/ValueSet/event-status (required)
* category 1..1
* basedOn 1..* MS
* basedOn only Reference(FC_PathwayAssessmentCarePlan or ServiceRequest)
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/task-id"
* extension contains PathwayDisplayOrder named displayOrder 0..1
