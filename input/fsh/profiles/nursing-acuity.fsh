// 重症度、医療・看護必要度の評価 Observation。

Profile: FC_NursingAcuityObservation
Parent: Observation
Id: fc-nursing-acuity-observation
Title: "重症度、医療・看護必要度の評価"
Description: """患者 × 日の評価 1 件。status = final(書き直すと同じリソースを PUT して amended)、category = survey、code = 評価票の版(nursing-acuity)+ text「看護必要度」、effectiveDateTime = 評価日(日付のみ)、encounter = 入院、performer = 評価者、order-ward = 評価した日の届出単位(病棟、病室単位の届出なら病室)。
- component(nursing-acuity-item): A・C の項目と A6 の小項目は valueBoolean、B の項目は状態の点数(valueInteger)、介助を掛ける項目は `<項目>-assist`(valueBoolean)、最後に版にある区分の合計 A / B / C(valueInteger。ICU・HCU 用に C は無い)。版の項目はすべて出す(「なし」も false で持つ)。
- 対象外の日は component を持たず、dataAbsentReason = not-applicable(text = 理由、未入力なら「対象外」)。"""
* insert FCMeta
* extension contains
    OrderWard named orderWard 0..1 MS
* status from FCNursingAcuityStatusVS (required)
* category 1..1
* category = $obs-category#survey
* code.coding 1..1
* code.coding from NursingAcuityVS (required)
* code.text 1..1
* code.text = "看護必要度"
* subject 1..1
* subject only Reference(FC_Patient)
* encounter 1..1
* encounter only Reference(FC_InpatientEncounter)
* effective[x] 1..1
* effective[x] only dateTime
* performer 0..1 MS
* performer only Reference(FC_Practitioner)
* value[x] 0..0
* dataAbsentReason MS
* component MS
* component.code.coding 1..1
* component.code.coding from NursingAcuityItemVS (required)
* component.value[x] 1..1
* component.value[x] only boolean or integer

ValueSet: FCNursingAcuityStatusVS
Id: fc-nursing-acuity-status-vs
Title: "看護必要度の評価の状態"
Description: "新規は final、書き直しは amended。"
* insert FCMeta
* http://hl7.org/fhir/observation-status#final
* http://hl7.org/fhir/observation-status#amended
