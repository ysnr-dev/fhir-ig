// 食事・栄養指導の CodeSystem。

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
