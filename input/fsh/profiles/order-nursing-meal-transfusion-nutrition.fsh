// 看護指示・食事・輸血・栄養指導のオーダー。

Profile: FC_NursingOrder
Parent: FC_OrderHeader
Id: fc-nursing-order
Title: "看護指示"
Description: """看護指示。指示 1 行ごとに 1 件の ServiceRequest で、ヘッダ・明細の区別は無い。

- category は nursing + inpatient(常に入院)。encounter = 入院(入院中でない患者にオーダーセット・パスから適用したときは付かない)。
- code は MEDIS 看護実践用語標準マスタ(看護行為: master-nursingAction-16digits + urn:oid:1.2.392.200119.4.704 の 8 桁管理番号、看護観察: master-nursingObservationKeyCode)、または text のみ。
- 同時に入力した指示は requisition(nursing-order-requisition)の uuid で束ねる。
- occurrenceDateTime = 開始日、nursing-order-end = 終了日、nursing-order-schedule = 頻度(Timing)。orderDetail[0].text = 条件。
- Task は登録時に requested で作り、指示受けで accepted(owner = 看護師)。
- 看護計画の行から展開した指示は nursing-care-plan-activity(plan = 看護計画、activity = 行の id)を持ち、reasonReference = 看護問題(FC_NursingProblem)。看護師が自分で出すので Task は最初から accepted(owner = 出した看護師)で作る。"""
* category[orderType] = $order-type#nursing "看護指示"
* category[setting] 1..1
* category[setting] = $prescription-setting#inpatient
* encounter 0..1 MS
* encounter only Reference(FC_InpatientEncounter)
* code 1..1 MS
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    nursingAction 0..1 and
    nursingActionNumber 0..1 and
    nursingObservation 0..1
* code.coding[nursingAction].system = $medis-nursing-action
* code.coding[nursingActionNumber].system = $medis-nursing-action-oid
* code.coding[nursingObservation].system = $medis-nursing-observation
* requisition 1..1 MS
* requisition.system = "http://fhir-client.local/Identifier/nursing-order-requisition"
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "開始日"
* orderDetail 0..1
* orderDetail.text ^short = "条件"
* extension contains
    NursingOrderEnd named orderEnd 0..1 MS and
    NursingOrderSchedule named schedule 0..1 MS and
    NursingCarePlanActivity named planActivity 0..1

Profile: FC_MealOrder
Parent: FC_OrderHeader
Id: fc-meal-order
Title: "食事オーダー"
Description: """食事オーダー。明細 ServiceRequest も Task も無い。

- category は meal + inpatient。encounter = 入院(入院中でない患者にオーダーセット・パスから適用したときは付かない)。status は常に active で、取消はリソースを削除する。
- occurrenceDateTime = 開始日時(朝 08:00 / 昼 12:00 / 夕 18:00)、meal-order-end = 終了日時。
- code = 食種(meal-type)。orderDetail = 主食(meal-staple-food)と副食の形態(meal-side-dish-form)で、それぞれ meal-timing 拡張で朝 / 昼 / 夕を持つ。
- 欠食(1 食だけ出さない)は meal-skipped-timing(最大 3 件)。meal-fasting-reason は欠食と、食止めの食種で出したオーダーの理由。塩分制限は meal-salt-limit。
- 変更・再開・外泊食止めのつながりは meal-order-link、終了理由は meal-order-end-reason。入院の外出・外泊や退院の変更と同じ transaction で作られる。"""
* category[orderType] = $order-type#meal "食事"
* category[setting] 1..1
* category[setting] = $prescription-setting#inpatient
* encounter 0..1 MS
* encounter only Reference(FC_InpatientEncounter)
* code 1..1 MS
* code.coding.system = "http://fhir-client.local/CodeSystem/meal-type"
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "開始日時(08 / 12 / 18 時)"
* orderDetail ^slicing.discriminator[0].type = #value
* orderDetail ^slicing.discriminator[0].path = "coding.system"
* orderDetail ^slicing.rules = #open
* orderDetail contains
    staple 0..* and
    sideDishForm 0..*
* orderDetail[staple].coding 1..1
* orderDetail[staple].coding.system = "http://fhir-client.local/CodeSystem/meal-staple-food"
* orderDetail[sideDishForm].coding 1..1
* orderDetail[sideDishForm].coding.system = "http://fhir-client.local/CodeSystem/meal-side-dish-form"
* orderDetail.extension contains MealTiming named timing 0..1
* extension contains
    MealSkippedTiming named skippedTiming 0..3 and
    MealSaltLimit named saltLimit 0..1 and
    MealFastingReason named fastingReason 0..1 and
    MealOrderEnd named orderEnd 0..1 MS and
    MealOrderLink named link 0..1 and
    MealOrderEndReason named endReason 0..1

Profile: FC_TransfusionOrderHeader
Parent: FC_OrderHeader
Id: fc-transfusion-order-header
Title: "輸血オーダー ヘッダ"
Description: "輸血オーダーのヘッダ。code = 輸血前検査の種類(交差適合試験 / T&S)。occurrenceDateTime = 投与予定日時(画面からの登録では必須)。血液型と同意は拡張(同意の確認も画面で必須なので、登録したオーダーは transfusion-consent = true を持つ)。"
* category[orderType] = $order-type#transfusion "輸血"
* priority 1..1 MS
* priority from FCPriorityRoutineUrgentVS (required)
* code 1..1 MS
* code from TransfusionTestTypeVS (required)
* occurrenceDateTime ^short = "投与予定日時"
* extension contains
    TransfusionAbo named abo 0..1 MS and
    TransfusionRhd named rhd 0..1 MS and
    TransfusionConsent named consent 0..1

Profile: FC_TransfusionOrderItem
Parent: FC_OrderItem
Id: fc-transfusion-order-item
Title: "輸血オーダー 製剤明細"
Description: "製剤ごとの ServiceRequest。code = 製剤マスタ(transfusion-product)、quantityQuantity = 数量(unit = 製剤の単位名)。略称は付けない。"
* identifier.system = "http://fhir-client.local/IdSystem/transfusion-order-item-number"
* basedOn only Reference(FC_TransfusionOrderHeader)
* code 1..1 MS
* code.coding 1..1
* code.coding.system = "http://fhir-client.local/CodeSystem/transfusion-product"
* quantity[x] only Quantity
* quantity[x] 1..1

Profile: FC_NutritionGuidanceOrder
Parent: FC_OrderHeader
Id: fc-nutrition-guidance-order
Title: "栄養指導オーダー"
Description: "栄養指導の依頼。明細 ServiceRequest は無い。code = 指導形式(個別 / 集団)、reasonCode[0].text = 目的。occurrenceDateTime = 開始日、nutrition-guidance-order-end = 終了日。対象疾患・病名・食種と目的テンプレートは拡張。各回の実施は Procedure(basedOn = このオーダー)。"
* category[orderType] = $order-type#nutrition-guidance "栄養指導"
* code 1..1 MS
* code from NutritionGuidanceFormatVS (required)
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "開始日"
* reasonCode 0..1
* reasonCode.text ^short = "指導目的"
* extension contains
    NutritionGuidanceOrderEnd named orderEnd 0..1 MS and
    NutritionGuidanceTargetDisease named targetDisease 0..1 and
    NutritionGuidanceTargetCondition named targetCondition 0..1 and
    NutritionGuidanceTargetDiet named targetDiet 0..1 and
    NutritionGuidancePurposeQuestionnaireResponse named purposeResponse 0..1
* extension[targetCondition].valueReference only Reference(FC_Condition)

Profile: FC_MedicationGuidanceOrder
Parent: FC_OrderHeader
Id: fc-medication-guidance-order
Title: "服薬指導オーダー"
Description: "医師から薬剤師への服薬指導の依頼。明細 ServiceRequest は無い。code = 指導区分(服薬指導 / 退院時指導)、orderDetail = 指導条件(複数、ハイリスク薬・麻薬など)、reasonCode[0].text = 指導してほしいこと、note = 薬剤部への連絡事項。occurrenceDateTime = 開始日、medication-guidance-order-end = 終了日(無ければ継続中)、medication-guidance-target-drugs = 対象薬剤。予約は持たない。各回の指導は Procedure(basedOn = このオーダー)。"
* category[orderType] = $order-type#medication-guidance "服薬指導"
* code 1..1 MS
* code from MedicationGuidanceKindVS (required)
* orderDetail 0..* MS
* orderDetail from MedicationGuidanceConditionVS (required)
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "開始日"
* reasonCode 0..1
* reasonCode.text ^short = "指導してほしいこと"
* note 0..1
* extension contains
    MedicationGuidanceOrderEnd named orderEnd 0..1 MS and
    MedicationGuidanceTargetDrugs named targetDrugs 0..1
