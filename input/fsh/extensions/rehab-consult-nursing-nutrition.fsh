// リハビリ・他科依頼・看護指示・栄養指導の拡張。

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
