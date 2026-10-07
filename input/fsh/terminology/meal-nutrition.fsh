// 食事・栄養指導・服薬指導の CodeSystem。

CodeSystem: MealTypeCS
Id: meal-type
Title: "食種(院内マスタ)"
Description: "院内マスタ master_meal_diets。食事オーダー ServiceRequest.code と栄養指導の対象食種。"
* insert MasterCS

CodeSystem: MealStapleFoodCS
Id: meal-staple-food
Title: "主食(院内マスタ)"
Description: "院内マスタ master_meal_items(kind = staple)。食事オーダー ServiceRequest.orderDetail。"
* insert MasterCS

CodeSystem: MealSideDishFormCS
Id: meal-side-dish-form
Title: "副食の形態(院内マスタ)"
Description: "院内マスタ master_meal_items(kind = side-dish-form)。食事オーダー ServiceRequest.orderDetail。"
* insert MasterCS

CodeSystem: NutritionGuidanceFormatCS
Id: nutrition-guidance-format
Title: "栄養指導の形式"
Description: "栄養指導オーダー ServiceRequest.code。"
* insert EnumCS
* #individual "個別指導"
* #group "集団指導"

ValueSet: NutritionGuidanceFormatVS
Id: nutrition-guidance-format-vs
Title: "栄養指導の形式 ValueSet"
Description: "栄養指導の形式 ValueSet。"
* insert AllOf(NutritionGuidanceFormatCS)

CodeSystem: NutritionGuidanceSessionTypeCS
Id: nutrition-guidance-session-type
Title: "栄養指導の実施区分"
Description: "栄養指導の実施記録 Procedure.code。"
* insert EnumCS
* #initial "初回指導"
* #follow-up "2 回目以降"
* #group "集団指導"

ValueSet: NutritionGuidanceSessionTypeVS
Id: nutrition-guidance-session-type-vs
Title: "栄養指導の実施区分 ValueSet"
Description: "栄養指導の実施区分 ValueSet。"
* insert AllOf(NutritionGuidanceSessionTypeCS)

// 服薬指導(薬剤師の指導。栄養指導と同じ期間継続型)。

CodeSystem: MedicationGuidanceKindCS
Id: medication-guidance-kind
Title: "服薬指導の指導区分"
Description: "服薬指導オーダー ServiceRequest.code。薬剤管理指導料 / 退院時薬剤情報管理指導料の区分に対応する。"
* insert EnumCS
* #inpatient "服薬指導"
* #discharge "退院時指導"

ValueSet: MedicationGuidanceKindVS
Id: medication-guidance-kind-vs
Title: "服薬指導の指導区分 ValueSet"
Description: "服薬指導の指導区分 ValueSet。"
* insert AllOf(MedicationGuidanceKindCS)

CodeSystem: MedicationGuidanceConditionCS
Id: medication-guidance-condition
Title: "服薬指導の指導条件"
Description: "服薬指導オーダー ServiceRequest.orderDetail(複数可)。指導で特に見てほしい点。"
* insert EnumCS
* #high-risk "ハイリスク薬"
* #narcotic "麻薬"
* #device "吸入・自己注射の手技"
* #polypharmacy "多剤併用"
* #adherence "服薬状況の確認"
* #swallowing "嚥下・剤形の相談"
* #family "家族への指導"

ValueSet: MedicationGuidanceConditionVS
Id: medication-guidance-condition-vs
Title: "服薬指導の指導条件 ValueSet"
Description: "服薬指導の指導条件 ValueSet。"
* insert AllOf(MedicationGuidanceConditionCS)

CodeSystem: MedicationGuidanceSessionTypeCS
Id: medication-guidance-session-type
Title: "服薬指導の指導種別"
Description: "服薬指導の実施記録 Procedure.code。薬剤管理指導料(1・2)と退院時薬剤情報管理指導料の区分に対応する。退院時指導のオーダーでは discharge だけ、服薬指導のオーダーでは standard / high-risk を選ぶ。"
* insert EnumCS
* #standard "服薬指導"
* #high-risk "服薬指導(ハイリスク薬)"
* #discharge "退院時指導"

ValueSet: MedicationGuidanceSessionTypeVS
Id: medication-guidance-session-type-vs
Title: "服薬指導の指導種別 ValueSet"
Description: "服薬指導の指導種別 ValueSet。"
* insert AllOf(MedicationGuidanceSessionTypeCS)

CodeSystem: MedicationGuidanceUnderstandingCS
Id: medication-guidance-understanding
Title: "服薬指導での患者の理解度"
Description: "服薬指導の実施記録の medication-guidance-understanding 拡張。"
* insert EnumCS
* #good "良好"
* #partial "一部理解"
* #poor "不十分"

ValueSet: MedicationGuidanceUnderstandingVS
Id: medication-guidance-understanding-vs
Title: "服薬指導での患者の理解度 ValueSet"
Description: "服薬指導での患者の理解度 ValueSet。"
* insert AllOf(MedicationGuidanceUnderstandingCS)
