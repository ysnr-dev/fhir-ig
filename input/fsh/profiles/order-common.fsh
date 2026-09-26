// オーダー共通のプロファイル(抽象)と優先度の ValueSet。

ValueSet: FCPriorityRoutineUrgentVS
Id: fc-priority-routine-urgent-vs
Title: "優先度(通常 / 至急)"
Description: "routine 通常 / urgent 至急"
* insert FCMeta
* $request-priority#routine
* $request-priority#urgent

ValueSet: FCPriorityExamVS
Id: fc-priority-exam-vs
Title: "優先度(通常 / 至急 / 事後)"
Description: "routine 通常 / urgent 至急 / asap 事後(実施後に登録するオーダー)。放射線・生理検査・内視鏡で使う。"
* insert FCMeta
* $request-priority#routine
* $request-priority#urgent
* $request-priority#asap

ValueSet: FCPrioritySurgeryVS
Id: fc-priority-surgery-vs
Title: "優先度(手術)"
Description: "routine 予定 / urgent 準緊急 / stat 緊急"
* insert FCMeta
* $request-priority#routine
* $request-priority#urgent
* $request-priority#stat

Profile: FC_OrderHeader
Parent: ServiceRequest
Id: fc-order-header
Title: "オーダーヘッダ(共通)"
Description: """各部門オーダーのヘッダ ServiceRequest の共通形。

- basedOn を持たない ServiceRequest がヘッダ。明細は basedOn でヘッダを指す。
- category の先頭がオーダー種別(order-type)。上流サーバーは category の先頭要素しか索引しないため順序を固定する。
- authoredOn は登録日時(システム時刻、更新しても変えない)。occurrenceDateTime はオーダー開始日(実施予定日)。occurrencePeriod は使わない(上流が索引しない)。
- requester は依頼医(Practitioner)。依頼科と病棟は拡張で持つ。
- 対象の問題は reasonReference(Condition)、コメントは note[0].text。"""
* insert FCMeta
* ^abstract = true
* intent = #order
* category 1..*
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category ^slicing.ordered = true
* category ^slicing.description = "先頭がオーダー種別、2 番目が入院・外来区分"
* category contains
    orderType 1..1 MS and
    setting 0..1 MS
* category[orderType] from OrderTypeVS (required)
* category[orderType].coding 1..1
* category[orderType].coding.system = "http://fhir-client.local/CodeSystem/order-type"
* category[setting] from PrescriptionSettingVS (required)
* category[setting].coding 1..1
* category[setting].coding.system = "http://fhir-client.local/CodeSystem/prescription-setting"
* subject 1..1
* subject only Reference(FC_Patient)
* requester only Reference(FC_Practitioner)
* requester MS
* authoredOn 1..1 MS
* authoredOn ^short = "登録日時(更新しても変えない)"
* occurrence[x] only dateTime
* occurrence[x] MS
* occurrence[x] ^short = "オーダー開始日(実施予定日)。時刻付きのこともある"
* basedOn 0..0
* reasonReference only Reference(FC_Condition)
* reasonReference ^short = "対象の問題(プロブレム)"
* note ^short = "note[0].text = コメント"
* extension contains
    OrderDepartment named orderDepartment 0..1 MS and
    OrderWard named orderWard 0..1 MS and
    OrderSet named orderSet 0..1 and
    PathwayOrder named pathwayOrder 0..1
* extension[orderWard] ^short = "入院オーダーのみ"
* identifier ^slicing.discriminator[0].type = #value
* identifier ^slicing.discriminator[0].path = "system"
* identifier ^slicing.rules = #open
* identifier contains
    orderSetInstance 0..1 and
    pathwayInstance 0..1
* identifier[orderSetInstance].system = "http://fhir-client.local/Identifier/order-set-instance"
* identifier[orderSetInstance] ^short = "オーダーセット適用 1 回ぶんの uuid"
* identifier[pathwayInstance].system = "http://fhir-client.local/Identifier/pathway-instance"
* identifier[pathwayInstance] ^short = "パス適用 1 回ぶんの uuid"

Profile: FC_OrderItem
Parent: ServiceRequest
Id: fc-order-item
Title: "オーダー明細(共通)"
Description: """ヘッダ ServiceRequest に basedOn でぶら下がる明細 ServiceRequest の共通形。

- identifier に部門ごとの IdSystem(`<部門>-order-item-number`)で連番(文字列)を持つ。並び順に使う。
- authoredOn / occurrenceDateTime はヘッダから複製する。
- category は持たない(種別はヘッダで判定する)。"""
* insert FCMeta
* ^abstract = true
* intent = #order
* identifier 1..1 MS
* identifier.system 1..1
* identifier.value 1..1
* identifier.value ^short = "ヘッダ内の連番(文字列)"
* basedOn 1..1 MS
* basedOn only Reference(ServiceRequest)
* subject 1..1
* subject only Reference(FC_Patient)
* authoredOn 1..1
* occurrence[x] only dateTime
