### 構造

```
ServiceRequest(食事オーダー、FC_MealOrder)
 │  code = 食種(meal-type) / orderDetail = 主食(meal-staple-food)・副食の形態(meal-side-dish-form)+ meal-timing
 │  extension: meal-order-end / meal-skipped-timing(0..3) / meal-fasting-reason / meal-salt-limit / meal-order-link / meal-order-end-reason
 └ Observation(摂取量、FC_MealIntakeObservation)  basedOn → 食事オーダー
```

Task はありません。`ServiceRequest.status` で進捗を読みます。

### オーダー

- `category` は meal + inpatient。`encounter` = 入院 Encounter。
- `occurrenceDateTime` = 開始日時(朝 08:00 / 昼 12:00 / 夕 18:00)、`meal-order-end` = 終了日時。
- 欠食は `meal-skipped-timing`(朝 / 昼 / 夕、最大 3 件)と `meal-fasting-reason`(絶食 / 手術 / 検査 / 外出・外泊 / 退院 / その他)。塩分制限は `meal-salt-limit`(g)。
- 変更・再開・外泊欠食のつながりは `meal-order-link`(kind = start / change / resume / leave-fasting、source = 元のオーダー、leave = 入院の `encounter-leave.id`)。終了理由は `meal-order-end-reason`(reason = change / discharge-plan / discharge / leave、previousEnd = 変更前の終了)。
- 入院の外出・外泊、退院予定、退院の変更と同じ transaction で食事オーダーが作り直されます。

### 摂取量

食事ごとの摂取量は Observation(category = order-type#meal、code = MEDIS 看護観察 31003419 主食 / 31003420 副食、valueQuantity %)で、effectiveDateTime は 08:00 / 12:00 / 18:00 です。

### 例

- [食事オーダー](ServiceRequest-example-meal-order.html)
- [摂取量](Observation-example-meal-intake-observation.html)
