// 薬剤: 処方(ServiceRequest + MedicationRequest)、注射、調剤、投与、持参薬、レジメン。

// JP Core と同じ RP 番号・RP 内連番の identifier スライス。
RuleSet: MedicationRequestIdentifierRules
* identifier 2..*
* identifier ^slicing.discriminator[0].type = #value
* identifier ^slicing.discriminator[0].path = "system"
* identifier ^slicing.rules = #open
* identifier contains
    rpNumber 1..1 MS and
    orderInRp 1..1 MS
* identifier[rpNumber].system = $mhlw-RPGroupNumber
* identifier[rpNumber].value 1..1
* identifier[rpNumber] ^short = "RP 番号(1 始まり)"
* identifier[orderInRp].system = $mhlw-MedicationAdministrationIndex
* identifier[orderInRp].value 1..1
* identifier[orderInRp] ^short = "RP 内の連番(1 始まり)"

Profile: FC_PrescriptionOrder
Parent: FC_OrderHeader
Id: fc-prescription-order
Title: "処方オーダー ヘッダ"
Description: """処方のヘッダ ServiceRequest。

- category は prescription + 入院・外来区分(prescription-setting)+ 処方区分(prescription-category)。
- authoredOn = 処方日(交付日)、occurrenceDateTime = 投与開始日。
- orderDetail は薬剤行ごとに 1 件(text = \"RP{n}-{m}\"、prescription-medication-request 拡張で MedicationRequest を指す)。
- encounter は入院処方のみ。
- 薬剤行の MedicationRequest は basedOn でこのヘッダを指す。削除は `MedicationRequest?based-on=ServiceRequest/{id}` の条件付き削除。
- レジメンの日オーダーとして出したときは requisition(regimen-instance)と regimen-order 拡張が付く。"""
* category[orderType] = $order-type#prescription "処方"
* category[setting] 1..1
* category contains prescriptionCategory 1..1 MS
* category[prescriptionCategory] from PrescriptionCategoryVS (required)
* category[prescriptionCategory].coding 1..1
* category[prescriptionCategory].coding.system = "http://fhir-client.local/CodeSystem/prescription-category"
* code 0..0
* authoredOn ^short = "処方日(交付日)"
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "投与開始日"
* encounter only Reference(FC_InpatientEncounter)
* orderDetail 1..* MS
* orderDetail.text 1..1
* orderDetail.text ^short = "RP{n}-{m}"
* orderDetail.extension contains PrescriptionMedicationRequest named medicationRequest 1..1
* requisition.system ^short = "regimen-instance(レジメンの日オーダー)/ order-set-instance / pathway-instance"
* extension contains RegimenOrder named regimenOrder 0..1

Profile: FC_PrescriptionMedicationRequest
Parent: MedicationRequest
Id: fc-prescription-medication-request
Title: "処方の薬剤行"
Description: """処方の薬剤 1 行。JP Core の JP_MedicationRequest を意識した形(RP 番号・RP 内連番の identifier)だが、doseQuantity に UCUM の code を持たない(unit 文字列のみ)ため JP_MedicationRequest には準拠せず、base から派生する(既知の非準拠)。

- identifier: RP 番号(Medication-RPGroupNumber)と RP 内連番(MedicationAdministrationIndex)。同じ RP 番号の行が 1 つの RP。用法・日数・回数は RP 内の全行に複製する。
- basedOn = 処方ヘッダ。authoredOn はヘッダと同じ。
- medicationCodeableConcept: 銘柄は medicine-code(レセプト電算)+ YJ コード、一般名処方は MedicationGeneralOrderCode のみ。text = 薬剤名。
- dosageInstruction[0]: timing.code = 用法(medicine-usage 16 桁 + medicine-usage-basic-category + text)、doseQuantity = 用量({value, unit}。system 無し)。用量の意味は用法で変わる: 内服(頓用以外)は 1 日量(不均等投与では各回の量の合計)、頓用は 1 回量、外用などは全量。
- additionalInstruction は 補足用法 → 不均等投与(服用順)→ 用法コメント(text のみ)の順。補足用法・不均等投与は JAMI 補足用法コード(urn:oid:1.2.392.200250.2.2.20.22、8 桁)の coding + 同じ文言の text: 日数間隔 `I{服用日数}{休薬日数}00000`、曜日 `W` + 日〜土の 0/1 を 7 桁、日付 `D{月(0 = 毎月)}{日…}`(1 コード 6 日まで)、期間内回数 `C{Y|M|W}{回数}00000`、不均等投与 `V{n 回目}{量}` を N で 8 桁に埋める(例 V13.5NNN)。
-頓用(用法コード 3 桁目 = 5)は asNeededBoolean = true、timing.repeat.count = 回数。
- dispenseRequest.expectedSupplyDuration = 投与日数(内服・非頓用のみ、UCUM d)。
- note = 薬剤コメント。supportingInformation = 元になった持参薬 MedicationStatement。
- requester / order-department / order-ward はヘッダと同じ。レジメンの日オーダーでは regimen-dose 拡張。"""
* insert FCMeta
* insert MedicationRequestIdentifierRules
* basedOn 1..1 MS
* basedOn only Reference(FC_PrescriptionOrder)
* subject only Reference(FC_Patient)
* authoredOn 1..1
* medication[x] only CodeableConcept
* medicationCodeableConcept.coding ^slicing.discriminator[0].type = #value
* medicationCodeableConcept.coding ^slicing.discriminator[0].path = "system"
* medicationCodeableConcept.coding ^slicing.rules = #open
* medicationCodeableConcept.coding contains
    receiptCode 0..1 and
    yjCode 0..1 and
    generalName 0..1
* medicationCodeableConcept.coding[receiptCode].system = $medicine-code
* medicationCodeableConcept.coding[yjCode].system = $YJ-code
* medicationCodeableConcept.coding[generalName].system = $mhlw-GeneralOrderCode
* medicationCodeableConcept.text 1..1
* dosageInstruction 1..1 MS
* dosageInstruction.timing.code.coding ^slicing.discriminator[0].type = #value
* dosageInstruction.timing.code.coding ^slicing.discriminator[0].path = "system"
* dosageInstruction.timing.code.coding ^slicing.rules = #open
* dosageInstruction.timing.code.coding contains
    usage 0..1 and
    basicCategory 0..1
* dosageInstruction.timing.code.coding[usage].system = $medicine-usage
* dosageInstruction.timing.code.coding[basicCategory].system = $medicine-usage-basic-category
* dosageInstruction.additionalInstruction.coding.system = $JAMI-supplementary-usage
* dosageInstruction.asNeeded[x] only boolean
* requester only Reference(FC_Practitioner)
* supportingInformation only Reference(FC_BroughtMedication)
* extension contains
    OrderDepartment named orderDepartment 0..1 and
    OrderWard named orderWard 0..1 and
    RegimenDose named regimenDose 0..1

Profile: FC_InjectionOrder
Parent: FC_OrderHeader
Id: fc-injection-order
Title: "注射オーダー(1 日分)"
Description: """注射オーダーの ServiceRequest。1 日分ごとに 1 件で、連日のオーダーは日ごとに展開する(最大 14 件 / 90 日)。

- category は injection + 入院・外来区分 + 注射区分(injection-category)。
- occurrenceDateTime = 注射日。requisition(injection-series)の uuid で同時に登録した日を束ねる。injection-series-start / injection-series-schedule でシリーズの開始日と間隔を持つ。
- orderDetail と薬剤行(MedicationRequest)の持ち方は処方と同じ。
- レジメンの日オーダーでは requisition が regimen-instance になり、injection-series-* は外れ、regimen-order 拡張が付く。"""
* category[orderType] = $order-type#injection "注射"
* category[setting] 1..1
* category contains injectionCategory 1..1 MS
* category[injectionCategory] from InjectionCategoryVS (required)
* category[injectionCategory].coding 1..1
* category[injectionCategory].coding.system = "http://fhir-client.local/CodeSystem/injection-category"
* code 0..0
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "注射日"
* requisition 1..1 MS
* requisition.system ^short = "injection-series または regimen-instance"
* orderDetail 1..* MS
* orderDetail.text 1..1
* orderDetail.extension contains PrescriptionMedicationRequest named medicationRequest 1..1
* extension contains
    InjectionSeriesStart named seriesStart 0..1 and
    InjectionSeriesSchedule named seriesSchedule 0..1 and
    RegimenOrder named regimenOrder 0..1

Profile: FC_InjectionMedicationRequest
Parent: MedicationRequest
Id: fc-injection-medication-request
Title: "注射の薬剤行"
Description: """注射の薬剤 1 行。identifier(RP 番号・RP 内連番)と basedOn は処方と同じ。medication は medicine-code + YJ コード。

JP Core の JP_MedicationRequest_Injection は medication を Reference(JP_Medication)に限定し、JP_MedicationRequest は doseQuantity に UCUM code を要求するが、アプリはどちらも満たさないため base から派生する(既知の非準拠)。

dosageInstruction[0]:
- text = 要約。timing.event[] = 投与開始時刻。
- extension: injection-usage-type(点滴 / ワンショット)、JP_MedicationDosage_Line(injection-line)、injection-scheduled-period(投与時刻ごとの開始・終了)。
- route = JP Core route-codes(IV / IM / SC / ID / IA / IT / IP)、site = JAMI 部位コード(urn:oid:1.2.392.200250.2.2.20.32)、method = JAMI 詳細用法(urn:oid:1.2.392.200250.2.2.20.40)。
- doseAndRate: doseQuantity と、点滴のときは rateQuantity(mL/h、UCUM)。
- additionalInstruction[0].text = 用法コメント。"""
* insert FCMeta
* insert MedicationRequestIdentifierRules
* basedOn 1..1 MS
* basedOn only Reference(FC_InjectionOrder)
* subject only Reference(FC_Patient)
* authoredOn 1..1
* medication[x] only CodeableConcept
* medicationCodeableConcept.coding ^slicing.discriminator[0].type = #value
* medicationCodeableConcept.coding ^slicing.discriminator[0].path = "system"
* medicationCodeableConcept.coding ^slicing.rules = #open
* medicationCodeableConcept.coding contains
    receiptCode 1..1 and
    yjCode 0..1
* medicationCodeableConcept.coding[receiptCode].system = $medicine-code
* medicationCodeableConcept.coding[yjCode].system = $YJ-code
* dosageInstruction 1..1 MS
* dosageInstruction.extension contains
    InjectionUsageType named usageType 0..1 MS and
    $JP_MedicationDosage_Line named line 0..1 and
    InjectionScheduledPeriod named scheduledPeriod 0..*
* dosageInstruction.extension[line].valueCodeableConcept from InjectionLineVS (required)
* dosageInstruction.extension[line] ^short = "注射ルート(injection-line)"
* dosageInstruction.route.coding.system = $JP_route-codes
* dosageInstruction.site.coding.system = $JAMI-site
* dosageInstruction.method.coding.system = $JAMI-method
* requester only Reference(FC_Practitioner)
* extension contains
    OrderDepartment named orderDepartment 0..1 and
    OrderWard named orderWard 0..1 and
    RegimenDose named regimenDose 0..1

Profile: FC_MedicationDispense
Parent: MedicationDispense
Id: fc-medication-dispense
Title: "調剤・払出"
Description: """処方の調剤、注射の払出。MedicationRequest ごとに 1 件、Task の状態変更と同じ transaction で作る。

- status = completed。authorizingPrescription[0] = MedicationRequest。whenHandedOver = 調剤日時。
- medicationCodeableConcept は処方と同じ系。substitution.wasSubstituted = 処方と異なるコードで調剤したとき true(一般名処方では常に false)。
- quantity {value, unit}: 処方は、内服(頓用以外)= 1 日量 × 投与日数、頓用 = 1 回量 × 投与回数、それ以外(外用など)= 用量そのまま。力価で出たオーダーは換算マスタで製剤の数量に直す。注射は 本数 × その日の投与回数。
- daysSupply(UCUM d)は内服処方のみ。performer[0].actor = 薬剤師。
- JP_MedicationDispense は RP 内連番の identifier を必須とするが、アプリは identifier を付けないため base から派生する(既知の非準拠)。"""
* insert FCMeta
* status = #completed
* subject 1..1
* subject only Reference(FC_Patient)
* medication[x] only CodeableConcept
* authorizingPrescription 1..1 MS
* authorizingPrescription only Reference(FC_PrescriptionMedicationRequest or FC_InjectionMedicationRequest)
* quantity 1..1
* whenHandedOver 1..1
* performer.actor only Reference(FC_Practitioner)

Profile: FC_MedicationAdministration
Parent: MedicationAdministration
Id: fc-medication-administration
Title: "薬剤投与(共通)"
Description: """薬剤の投与記録。実施記録の Procedure ハブ(与薬 / 注射 / 放射線の造影剤 / 内視鏡・生理・処置・手術の薬剤 / 輸血 / 麻酔チャート)に partOf でぶら下がる。

- status: completed(注射の途中中止は stopped、麻酔の持続投与中は in-progress)。
- medicationCodeableConcept = medicine-code + YJ(輸血製剤は transfusion-product)。
- request = 元の MedicationRequest(オーダーに無い薬剤を投与したときは無し)。
- effectiveDateTime または effectivePeriod。dosage の route / site / method / rateQuantity はオーダーから複製。dose は投与した量で、与薬では処方の用量(内服は 1 日量)をその枠の 1 回量に割ったもの(不均等投与はその枠の量)。
- JP_MedicationAdministration は RP 内連番の identifier を必須とするが、アプリは identifier を付けないため base から派生する(既知の非準拠)。"""
* insert FCMeta
* subject 1..1
* subject only Reference(FC_Patient)
* medication[x] only CodeableConcept
* partOf 1..* MS
* partOf only Reference(FC_ProcedureHub)
* request only Reference(MedicationRequest)

Profile: FC_BroughtMedication
Parent: MedicationStatement
Id: fc-brought-medication
Title: "持参薬"
Description: """入院時の持参薬。薬剤ごとに 1 件の MedicationStatement。

- category = medication-statement-category#community。context = 入院 Encounter。informationSource = 登録した職員。
- status: active(未鑑別・未判断・継続)/ on-hold(休止)/ stopped(中止)/ not-taken / completed(退院時)/ entered-in-error。
- medicationCodeableConcept は処方と同じ系、同定できないときは text のみ。dosage[0] は処方と同じ形(自由記載の用法は timing.code.text)だが、doseQuantity は 1 回量(処方の内服は 1 日量)。effectivePeriod.end = 最終服用。
- 登録時の情報は brought-medication-info、薬剤部の鑑別は brought-medication-identification、医師の判断は brought-medication-decision(内容は statusReason = brought-medication-decision CodeSystem)。
- 「継続」は処方区分 brought の院内処方を同じ transaction で作り、decision.convertedOrder がそれを指す。処方の用量は、内服(頓用以外)では 1 回量 × 1 日の服用回数(1 日量)にする。
- JP_MedicationStatement は dosage の doseQuantity に UCUM code を要求するが、アプリは unit 文字列だけを持つため base から派生する(既知の非準拠)。"""
* insert FCMeta
* subject only Reference(FC_Patient)
* context only Reference(FC_InpatientEncounter)
* category 1..1
* category = $medication-statement-category#community
* medication[x] only CodeableConcept
* informationSource only Reference(FC_Practitioner)
* statusReason.coding.system = "http://fhir-client.local/CodeSystem/brought-medication-decision"
* extension contains
    BroughtMedicationInfo named info 0..1 MS and
    BroughtMedicationIdentification named identification 0..1 MS and
    BroughtMedicationDecision named decision 0..1 MS

Profile: FC_RegimenOrder
Parent: ServiceRequest
Id: fc-regimen-order
Title: "化学療法レジメン適用"
Description: """レジメンの適用(コース全体)を表す ServiceRequest。レジメンの定義は backend のマスタで、PlanDefinition は無い。

- **intent = plan**。status: active / on-hold / revoked(中止)/ completed。
- category = chemo-regimen + 入院・外来区分。code = レジメンコード(regimen)。identifier = regimen-instance(uuid)。instantiatesUri = `http://fhir-client.local/regimen/{code}`。
- occurrenceDateTime = 第 1 サイクルの Day 1。
- regimen 拡張にサイクル日数・治療日数・予定サイクル数(任意。無ければ継続)・体表面積・身長・体重、中止・完了の記録。
- 各サイクル・各日の注射 / 処方は通常の注射 / 処方オーダーで、requisition = regimen-instance、regimen-order 拡張でこの適用を指す。化学療法の予約 Appointment は日オーダーを basedOn で指す。"""
* insert FCMeta
* insert OrderHeaderCommonRules
* intent = #plan
* category 2..2
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category ^slicing.ordered = true
* category contains
    orderType 1..1 MS and
    setting 1..1 MS
* category[orderType] = $order-type#chemo-regimen "化学療法"
* category[setting] from PrescriptionSettingVS (required)
* category[setting].coding 1..1
* category[setting].coding.system = "http://fhir-client.local/CodeSystem/prescription-setting"
* code 1..1 MS
* code.coding 1..1
* code.coding.system = "http://fhir-client.local/CodeSystem/regimen"
* identifier contains regimenInstance 1..1 MS
* identifier[regimenInstance].system = "http://fhir-client.local/Identifier/regimen-instance"
* instantiatesUri 1..1
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "第 1 サイクル Day 1"
* extension contains Regimen named regimen 1..1 MS
