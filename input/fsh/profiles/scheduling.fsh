// 予約枠(Schedule / Slot)と予約(Appointment)。

Profile: FC_Schedule
Parent: Schedule
Id: fc-schedule
Title: "予約枠の定義"
Description: "予約枠の定義。actor は Practitioner および/または Location。serviceType = 予約枠の種類(schedule-service-type)+ text = 枠の名前。specialty = SS-MIX2 診療科コード。Slot の生成パターンは schedule-slot-pattern 拡張(JSON 文字列)。"
* insert FCMeta
* actor only Reference(FC_Practitioner or FC_Room)
* serviceType 1..1 MS
* serviceType from ScheduleServiceTypeVS (required)
* serviceType.text ^short = "予約枠の名前"
* specialty from Ssmix2DepartmentCodeVS (required)
* extension contains ScheduleSlotPattern named slotPattern 1..1 MS

Profile: FC_Slot
Parent: Slot
Id: fc-slot
Title: "予約枠"
Description: "予約枠 1 コマ。同じ時刻の Slot を複数作ることで定員を表す。status: free / busy / busy-tentative / busy-unavailable / entered-in-error。appointmentType = v2-0276#ROUTINE。"
* insert FCMeta
* schedule only Reference(FC_Schedule)
* appointmentType 1..1
* appointmentType.coding.system = $v2-0276

Profile: FC_Appointment
Parent: Appointment
Id: fc-appointment
Title: "予約・受付"
Description: """予約と当日受付。

- status: booked 予約 / checked-in 受付済(当日受付は最初から checked-in)/ fulfilled 診察終了 / cancelled。
- appointmentType = v2-0276(ROUTINE 通常 / CHECKUP 健診 / FOLLOWUP 再診 / WALKIN 当日受付 / EMERGENCY 救急)。
- participant[0] は必ず Patient、続いて Practitioner / Location。すべて required = required、status = accepted。
- serviceType / specialty は Schedule から複製。slot は使った予約枠(同じ transaction で busy にする)。
- basedOn = オーダーのヘッダ ServiceRequest(検査・リハビリ・栄養指導・化学療法の予約)。
- appointment-checked-in-at 拡張 = 実際の受付日時。レセプトコンピュータからの受付取込(backend)は identifier.system = `http://fhir-client.local/integrations/receipt-computer/reception` で条件付き PUT し、reception-coverage-set 拡張を付ける。"""
* insert FCMeta
* appointmentType 1..1 MS
* appointmentType.coding.system = $v2-0276
* serviceType from ScheduleServiceTypeVS (required)
* specialty from Ssmix2DepartmentCodeVS (required)
* participant 1..*
* participant ^short = "先頭が患者(必須)、続いて Practitioner / Location"
* participant.actor 1..1
* participant.actor only Reference(FC_Patient or FC_Practitioner or FC_Room)
* slot only Reference(FC_Slot)
* basedOn only Reference(ServiceRequest)
* reasonReference only Reference(FC_Condition)
* extension contains
    AppointmentCheckedInAt named checkedInAt 0..1 MS and
    ReceptionCoverageSet named receptionCoverageSet 0..1
