### 構造

```
ServiceRequest(依頼、FC_NutritionGuidanceOrder)
 │  code = 指導形式(個別 / 集団) / reasonCode[0].text = 目的
 │  extension: nutrition-guidance-order-end / -target-disease / -target-condition / -target-diet / -purpose-questionnaire-response
 ├ Appointment(栄養指導の予約)  basedOn → 依頼(別 transaction)
 ├ Task(nutrition-guidance、FC_NutritionGuidanceTask)  focus → 依頼
 └ Procedure(回ごとの実施、FC_NutritionGuidanceProcedure)  basedOn → 依頼
     code = 実施区分(初回 / 2 回目以降 / 集団) / extension: nutrition-guidance-performed-minutes / nutrition-guidance-record(QuestionnaireResponse)
```

- `occurrenceDateTime` = 開始日、`nutrition-guidance-order-end` = 終了日。リハビリと同じ継続型のオーダーです。
- 対象の食種は `nutrition-guidance-target-diet`(valueCoding.system = `meal-type`)。
- 指導記録はテンプレート(QuestionnaireResponse)で書き、実施 Procedure の `nutrition-guidance-record` が指します。

### 例

- [依頼](ServiceRequest-example-nutrition-guidance-order.html)
- [Task](Task-example-nutrition-guidance-task.html)
- [実施記録](Procedure-example-nutrition-guidance-procedure.html)
