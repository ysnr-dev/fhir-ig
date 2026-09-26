### 予約枠(Schedule / Slot)

- [FC_Schedule](StructureDefinition-fc-schedule.html): 予約枠の定義。`actor` = Practitioner および/または Location(診察室・検査室・リハ室など)。`serviceType` = 予約枠の種類(`schedule-service-type`: 診察 / 検査 / リハビリ / 栄養指導 / 化学療法)+ text = 枠の名前。`specialty` = SS-MIX2 診療科コード。`planningHorizon`、`active`、`comment`。
- Slot の生成パターンは `schedule-slot-pattern` 拡張に JSON 文字列で持ちます: `{"weekdays": [1,2,3,4,5], "blocks": [{"start": "09:00", "end": "12:00"}], "durationMinutes": 15, "capacity": 1}`。
- [FC_Slot](StructureDefinition-fc-slot.html): 予約枠 1 コマ。同じ時刻の Slot を複数作ることで定員を表します。`status`: free / busy / busy-tentative / busy-unavailable / entered-in-error。`appointmentType` = v2-0276#ROUTINE。

### 予約・受付(Appointment)

[FC_Appointment](StructureDefinition-fc-appointment.html)

- `status`: booked(予約)/ checked-in(受付済。当日受付は最初から checked-in)/ fulfilled(診察終了)/ cancelled。
- `appointmentType` = v2-0276(ROUTINE 通常 / CHECKUP 健診 / FOLLOWUP 再診 / WALKIN 当日受付 / EMERGENCY 救急)。
- `participant[0]` は必ず Patient、続いて Practitioner / Location。すべて `required = required`、`status = accepted`。
- `serviceType` / `specialty` は Schedule から複製。`slot` = 使った予約枠(同じ transaction で busy にする)。`reasonReference` = Condition。
- `basedOn` = オーダーのヘッダ ServiceRequest。放射線・生理検査・内視鏡・処置はオーダーの transaction に Appointment と Slot を含め、リハビリ・栄養指導・化学療法は別 transaction で予約します。
- `appointment-checked-in-at` = 実際の受付日時。
- レセプトコンピュータからの受付取込(backend)は `identifier.system` = `integrations/receipt-computer/reception` で条件付き PUT し、WALKIN + checked-in の形で作り、`reception-coverage-set` 拡張(保険組合せキー)を付けます。
- 外来受診(Encounter、class = AMB)の `appointment[0]` がこれを指し、診察終了で fulfilled になります。

### 手術室の割当

手術は Appointment を作らず、手術オーダーの `surgery-room` 拡張と `occurrenceDateTime` で手術室の割当を表します。

### 例

- [予約枠の定義](Schedule-example-schedule.html) / [予約枠](Slot-example-slot.html) / [予約](Appointment-example-appointment.html) / [外来受診](Encounter-example-outpatient-encounter.html)
