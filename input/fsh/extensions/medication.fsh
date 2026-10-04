// 薬剤(注射・与薬・持参薬・レジメン)の拡張。処方ヘッダの prescription-medication-request は order-common.fsh。

Extension: InjectionSeriesStart
Id: injection-series-start
Title: "注射シリーズの開始日"
Description: "連日注射を日ごとの ServiceRequest に展開したときの、シリーズ全体の開始日。"
Context: ServiceRequest
* insert FCMeta
* value[x] only date

Extension: InjectionSeriesSchedule
Id: injection-series-schedule
Title: "注射シリーズの間隔"
Description: "連日注射の間隔。無ければ毎日。隔日など: repeat.boundsPeriod + period N / periodUnit d。曜日指定: period 1 / periodUnit wk / dayOfWeek。シリーズを継続して日を足したときは、足した日だけが新しい boundsPeriod.end を持つ(既存の日は書き換えない)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Timing

Extension: InjectionUsageType
Id: injection-usage-type
Title: "投与形態(点滴 / ワンショット)"
Description: "投与形態(点滴 / ワンショット)。"
Context: MedicationRequest.dosageInstruction
* insert FCMeta
* value[x] only CodeableConcept
* valueCodeableConcept from InjectionUsageTypeVS (required)

Extension: InjectionScheduledPeriod
Id: injection-scheduled-period
Title: "投与予定時間帯"
Description: "投与時刻ごとの開始・終了。終了が開始以前なら翌日に繰り上がる。timing.event に対応して繰り返す。"
Context: MedicationRequest.dosageInstruction
* insert FCMeta
* extension contains
    start 1..1 and
    end 1..1
* extension[start].value[x] only dateTime
* extension[end].value[x] only dateTime

Extension: MedicationScheduleSlot
Id: medication-schedule-slot
Title: "与薬予定の時刻"
Description: "この与薬記録がどの服用予定(用法コードから展開した時刻)に対するものか。"
Context: Procedure
* insert FCMeta
* value[x] only dateTime

Extension: BroughtMedicationInfo
Id: brought-medication-info
Title: "持参薬の情報(登録時)"
Description: "source = 情報源(本人 / 家族 / お薬手帳 / 薬剤情報提供書 / 紹介状)、prescriber = 処方元、broughtQuantity = 持参量。"
Context: MedicationStatement
* insert FCMeta
* extension contains
    source 0..1 and
    prescriber 0..1 and
    broughtQuantity 0..1
* extension[source].value[x] only string
* extension[prescriber].value[x] only string
* extension[broughtQuantity].value[x] only Quantity

Extension: BroughtMedicationIdentification
Id: brought-medication-identification
Title: "持参薬の鑑別(薬剤部)"
Description: "identifiedBy / identifiedAt = 鑑別者と日時、reportedName = 申告名、remainingDays = 残日数(d)、substitution = 院内採用薬の有無、substitute = 代替薬、comment = コメント。"
Context: MedicationStatement
* insert FCMeta
* extension contains
    identifiedBy 1..1 and
    identifiedAt 1..1 and
    reportedName 0..1 and
    remainingDays 0..1 and
    substitution 0..1 and
    substitute 0..1 and
    comment 0..1
* extension[identifiedBy].value[x] only Reference(Practitioner)
* extension[identifiedAt].value[x] only dateTime
* extension[reportedName].value[x] only string
* extension[remainingDays].value[x] only Quantity
* extension[remainingDays].valueQuantity.system = $ucum
* extension[remainingDays].valueQuantity.code = #d
* extension[substitution].value[x] only code
* extension[substitution].valueCode from BroughtMedicationSubstitutionVS (required)
* extension[substitute].value[x] only CodeableConcept
* extension[comment].value[x] only string

Extension: BroughtMedicationDecision
Id: brought-medication-decision
Title: "持参薬の判断(医師)"
Description: "decidedBy / decidedAt = 判断者と日時、convertedOrder = 継続で作った院内処方のヘッダ ServiceRequest。判断の内容は MedicationStatement.statusReason(brought-medication-decision CodeSystem)。"
Context: MedicationStatement
* insert FCMeta
* extension contains
    decidedBy 1..1 and
    decidedAt 1..1 and
    convertedOrder 0..1
* extension[decidedBy].value[x] only Reference(Practitioner)
* extension[decidedAt].value[x] only dateTime
* extension[convertedOrder].value[x] only Reference(ServiceRequest)

Extension: Regimen
Id: regimen
Title: "レジメン適用の内容"
Description: "適用時のサイクル日数・治療日数・予定サイクル数、体表面積・身長・体重、中止・完了の記録。plannedCycles が無ければ継続(クール数を決めない)。"
Context: ServiceRequest
* insert FCMeta
* extension contains
    cycleDays 1..1 and
    treatmentDays 1..1 and
    plannedCycles 0..1 and
    bsa 0..1 and
    height 0..1 and
    weight 0..1 and
    discontinuationReason 0..1 and
    discontinuationNote 0..1 and
    discontinuedOn 0..1 and
    completedOn 0..1
* extension[cycleDays].value[x] only integer
* extension[treatmentDays].value[x] only integer
* extension[plannedCycles].value[x] only integer
* extension[bsa].value[x] only decimal
* extension[height].value[x] only decimal
* extension[weight].value[x] only decimal
* extension[discontinuationReason].value[x] only code
* extension[discontinuationReason].valueCode from RegimenDiscontinuationReasonVS (required)
* extension[discontinuationNote].value[x] only string
* extension[discontinuedOn].value[x] only date
* extension[completedOn].value[x] only date

Extension: RegimenOrder
Id: regimen-order
Title: "レジメンの日オーダーの印"
Description: "レジメン適用から出した日オーダー(注射・処方の ServiceRequest)に付く。regimen = 適用ヘッダ、cycle / day = サイクルと Day、code / name = レジメンコードと名前、reduction = 減量の記録。"
Context: ServiceRequest
* insert FCMeta
* extension contains
    regimen 1..1 and
    cycle 1..1 and
    day 1..1 and
    code 0..1 and
    name 0..1 and
    reduction 0..1
* extension[regimen].value[x] only Reference(ServiceRequest)
* extension[cycle].value[x] only integer
* extension[day].value[x] only integer
* extension[code].value[x] only string
* extension[name].value[x] only string
* extension[reduction].value[x] only string

Extension: RegimenDose
Id: regimen-dose
Title: "レジメンの薬剤の投与量計算"
Description: "日オーダーの各 MedicationRequest に付く。drug = レジメン薬剤 id(backend)、ratio = 投与率(%)、amount / unit = 計算した量、packs = 本数。"
Context: MedicationRequest
* insert FCMeta
* extension contains
    drug 1..1 and
    ratio 0..1 and
    amount 0..1 and
    unit 0..1 and
    packs 0..1
* extension[drug].value[x] only integer
* extension[ratio].value[x] only decimal
* extension[amount].value[x] only decimal
* extension[unit].value[x] only string
* extension[packs].value[x] only decimal
