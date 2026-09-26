// 食事オーダーの拡張。

Extension: MealTiming
Id: meal-timing
Title: "食事のタイミング(orderDetail)"
Description: "主食・副食の orderDetail が朝 / 昼 / 夕のどれに対するものか。"
Context: ServiceRequest.orderDetail
* insert FCMeta
* value[x] only code
* valueCode from MealTimingVS (required)

Extension: MealSkippedTiming
Id: meal-skipped-timing
Title: "欠食のタイミング"
Description: "欠食する食事(朝 / 昼 / 夕)。最大 3 件。"
Context: ServiceRequest
* insert FCMeta
* value[x] only code
* valueCode from MealTimingVS (required)

Extension: MealSaltLimit
Id: meal-salt-limit
Title: "塩分制限"
Description: "1 日の塩分(g、UCUM)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Quantity
* valueQuantity.system = $ucum
* valueQuantity.code = #g

Extension: MealFastingReason
Id: meal-fasting-reason
Title: "欠食の理由"
Description: "欠食の理由。"
Context: ServiceRequest
* insert FCMeta
* value[x] only code
* valueCode from MealFastingReasonVS (required)

Extension: MealOrderEnd
Id: meal-order-end
Title: "食事オーダーの終了日時"
Description: "上流サーバーは order-period 検索パラメータでこれを索引する。"
Context: ServiceRequest
* insert FCMeta
* value[x] only dateTime

Extension: MealOrderLink
Id: meal-order-link
Title: "食事オーダーのつながり"
Description: "このオーダーが前のオーダーからどう作られたか。kind = 種類、source = 元のオーダー、leave = 外出・外泊の id(encounter-leave.id)。"
Context: ServiceRequest
* insert FCMeta
* extension contains
    kind 1..1 and
    source 0..1 and
    leave 0..1
* extension[kind].value[x] only code
* extension[kind].valueCode from MealOrderLinkKindVS (required)
* extension[source].value[x] only Reference(ServiceRequest)
* extension[leave].value[x] only string

Extension: MealOrderEndReason
Id: meal-order-end-reason
Title: "食事オーダーの終了理由"
Description: "reason = 理由、leave = 外出・外泊の id、previousEnd = 変更前の終了日時。"
Context: ServiceRequest
* insert FCMeta
* extension contains
    reason 1..1 and
    leave 0..1 and
    previousEnd 0..1
* extension[reason].value[x] only code
* extension[reason].valueCode from MealOrderEndReasonVS (required)
* extension[leave].value[x] only string
* extension[previousEnd].value[x] only dateTime
