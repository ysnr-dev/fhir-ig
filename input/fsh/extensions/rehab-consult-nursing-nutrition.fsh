// リハビリ・他科依頼・看護指示・栄養指導・服薬指導の拡張。

Extension: RehabOrderEnd
Id: rehab-order-end
Title: "リハビリの終了日"
Description: "オーダー期間の終了日。上流サーバーは order-period 検索パラメータでこれを索引する。"
Context: ServiceRequest
* insert FCMeta
* value[x] only date

Extension: RehabOnsetDate
Id: rehab-onset-date
Title: "発症日・手術日"
Description: "発症日・手術日。"
Context: ServiceRequest
* insert FCMeta
* value[x] only date

Extension: RehabTargetDisease
Id: rehab-target-disease
Title: "対象疾患(リハビリ)"
Description: "対象疾患(リハビリ)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: RehabFrequencyPerWeek
Id: rehab-frequency-per-week
Title: "週あたりの回数"
Description: "週あたりの回数。"
Context: ServiceRequest
* insert FCMeta
* value[x] only integer

Extension: RehabPerformedUnits
Id: rehab-performed-units
Title: "実施単位数(リハビリ)"
Description: "1 回の実施の単位数(1〜24)。"
Context: Procedure
* insert FCMeta
* value[x] only integer

Extension: ConsultPurposeQuestionnaireResponse
Id: consult-purpose-questionnaire-response
Title: "依頼目的テンプレートの記入"
Description: "依頼目的テンプレートの記入。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: ConsultReply
Id: consult-reply
Title: "他科依頼への回答"
Description: "回答の Composition(Consult note)。display = 回答者。同じ transaction で urn:uuid を指し、上流が実 id に書き換える。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(Composition)

Extension: NursingOrderEnd
Id: nursing-order-end
Title: "看護指示の終了日"
Description: "看護指示の終了日。"
Context: ServiceRequest
* insert FCMeta
* value[x] only date

Extension: NursingOrderSchedule
Id: nursing-order-schedule
Title: "看護指示の頻度"
Description: "実施の頻度(Timing.repeat)。付いていない指示は随時。形は 4 つ: 1 日 N 回(frequency = N、period = 1、periodUnit = d、timeOfDay = 各回の時刻)/ N 時間毎(period = N、periodUnit = h、timeOfDay = 起点の時刻。frequency は持たない)/ 時刻指定(timeOfDay のみ)/ 週 N 回(frequency = N、period = 1、periodUnit = wk、dayOfWeek、timeOfDay は任意)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Timing

Extension: NutritionGuidanceOrderEnd
Id: nutrition-guidance-order-end
Title: "栄養指導の終了日"
Description: "栄養指導の終了日。"
Context: ServiceRequest
* insert FCMeta
* value[x] only date

Extension: NutritionGuidanceTargetDisease
Id: nutrition-guidance-target-disease
Title: "対象疾患(栄養指導)"
Description: "対象疾患(栄養指導)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: NutritionGuidanceTargetCondition
Id: nutrition-guidance-target-condition
Title: "対象の病名(栄養指導)"
Description: "対象の病名(栄養指導)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(Condition)

Extension: NutritionGuidanceTargetDiet
Id: nutrition-guidance-target-diet
Title: "対象の食種(栄養指導)"
Description: "valueCoding.system = meal-type。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Coding
* valueCoding.system = "http://fhir-client.local/CodeSystem/meal-type"

Extension: NutritionGuidancePurposeQuestionnaireResponse
Id: nutrition-guidance-purpose-questionnaire-response
Title: "指導目的テンプレートの記入"
Description: "指導目的テンプレートの記入。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: NutritionGuidancePerformedMinutes
Id: nutrition-guidance-performed-minutes
Title: "指導時間(分)"
Description: "指導時間(分)。"
Context: Procedure
* insert FCMeta
* value[x] only integer

Extension: NutritionGuidanceRecord
Id: nutrition-guidance-record
Title: "指導記録テンプレートの記入"
Description: "指導記録の QuestionnaireResponse。同じ transaction で登録する。"
Context: Procedure
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: NursingCarePlanActivity
Id: nursing-care-plan-activity
Title: "看護計画の行から展開した指示"
Description: "看護指示がどの看護計画の行から展開されたか。plan = 看護計画の CarePlan、activity = CarePlan.activity.id。basedOn に CarePlan を入れると指示がオーダーのヘッダと見なされなくなるので、指示の側から拡張で指す。"
Context: ServiceRequest
* insert FCMeta
* extension contains
    plan 1..1 and
    activity 1..1
* extension[plan].value[x] only Reference(FC_NursingCarePlan)
* extension[activity].value[x] only string

Extension: NursingProblemPriority
Id: nursing-problem-priority
Title: "看護問題の優先度"
Description: "看護問題の並び順(1 から)。継続中の看護問題の中で振り直し、番号の変わった Condition だけを PUT する。"
Context: Condition
* insert FCMeta
* value[x] only positiveInt

Extension: NursingCarePlanEntry
Id: nursing-care-plan-entry
Title: "看護計画の立案の入口"
Description: "standard_plan = 標準看護計画から(OP / TP / EP の行)、diagnosis = 看護診断から(看護成果・看護介入で書く)。"
Context: CarePlan
* insert FCMeta
* value[x] only code
* valueCode from NursingCarePlanEntryVS (required)

Extension: NursingPlanActivityType
Id: nursing-plan-activity-type
Title: "看護計画の行の区分(OP / TP / EP)"
Description: "標準看護計画の入口で書いた行の区分。看護診断の入口で看護介入の行動として書いた行には付かない(nursing-intervention の下にまとめる)。"
Context: CarePlan.activity
* insert FCMeta
* value[x] only code
* valueCode from NursingPlanActivityTypeVS (required)

Extension: NursingIntervention
Id: nursing-intervention
Title: "看護計画の行の看護介入"
Description: "行が属する看護介入(nursing-intervention CodeSystem)。看護診断の入口では必ず付き、標準看護計画の行はマスタで介入が結びついているときだけ付く。"
Context: CarePlan.activity
* insert FCMeta
* value[x] only Coding
* valueCoding.system = "http://fhir-client.local/CodeSystem/nursing-intervention"

Extension: MedicationGuidanceOrderEnd
Id: medication-guidance-order-end
Title: "服薬指導の終了日"
Description: "服薬指導の終了日。無ければ継続中。部門一覧の「終了」と退院時の打ち切りで書き足す。"
Context: ServiceRequest
* insert FCMeta
* value[x] only date

Extension: MedicationGuidanceTargetDrugs
Id: medication-guidance-target-drugs
Title: "対象薬剤(服薬指導)"
Description: "指導の対象薬剤(自由記載)。持参薬・院外の薬も対象になるので処方の参照ではなく文字列で持つ。"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: MedicationGuidanceUnderstanding
Id: medication-guidance-understanding
Title: "患者の理解度(服薬指導)"
Description: "服薬指導の実施記録での患者の理解度。valueCoding.system = medication-guidance-understanding。"
Context: Procedure
* insert FCMeta
* value[x] only Coding
* valueCoding from MedicationGuidanceUnderstandingVS (required)

Extension: MedicationGuidanceRecord
Id: medication-guidance-record
Title: "指導記録テンプレートの記入(服薬指導)"
Description: "指導記録の QuestionnaireResponse。同じ transaction で登録する。平文は Procedure.note にも入る。"
Context: Procedure
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)
