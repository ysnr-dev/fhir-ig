// 検査結果・報告: DiagnosticReport / Observation / Specimen。

// ---- 検体検査 ----

Profile: FC_LabDiagnosticReport
Parent: $JP_DiagnosticReport_Common
Id: fc-lab-diagnostic-report
Title: "検体検査 報告"
Description: """検体検査の結果報告。

- アプリは meta.profile に JP_DiagnosticReport_LabResult を付けるが、category / code の持ち方が JP Core と異なる(v2-0074 LAB と LOINC 11502-2)ため、本 IG では JP_DiagnosticReport_Common から派生する(既知の非準拠)。
- status: preliminary 中間報告 / final 最終報告 / corrected 訂正報告(final / corrected の報告を編集保存すると必ず corrected)。
- category[0] = v2-0074#LAB、category[1] = 入院・外来区分(lab-result-setting)。code = LOINC 11502-2(text 臨床検査結果)。
- effectiveDateTime = 検体日(日付のみ)、issued = 保存日時。performer = 自院 Organization と入力者 Practitioner。
- basedOn = オーダーのヘッダ、specimen[] = 検体ラベルの Specimen(または結果入力で作った Specimen)、result[] = 項目ごとの Observation。conclusion、order-department。
- preliminary でない報告で result-review 通知、パニック値で lab-panic 通知が作られる。"""
* insert FCMeta
* subject 1..1
* subject only Reference(FC_Patient)
* category 2..2
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category ^slicing.ordered = true
* category contains
    kind 1..1 and
    setting 1..1
* category[kind] = $v2-0074#LAB
* category[setting] from LabResultSettingVS (required)
* code = $loinc#11502-2
* effective[x] only dateTime
* effective[x] 1..1
* issued 1..1
* performer only Reference(FC_Facility or FC_Practitioner)
* basedOn 1..1 MS
* basedOn only Reference(FC_LabOrderHeader)
* specimen only Reference(FC_LabLabelSpecimen or FC_LabResultSpecimen)
* result only Reference(FC_LabResultObservation)
* extension contains OrderDepartment named orderDepartment 0..1

Profile: FC_LabResultObservation
Parent: Observation
Id: fc-lab-result-observation
Title: "検体検査 結果項目"
Description: """検体検査の項目ごとの結果。

- アプリは meta.profile に JP_Observation_LabResult を付けるが、category の system が HL7 observation-category(JP Core は JP_SimpleObservationCategory_CS)なので、本 IG では base から派生する(既知の非準拠)。
- status は報告と同じ。category = observation-category#laboratory。
- code.coding は [lab-result-item, jlac11, jlac10, lab-item-abbreviation(display = 略称)] の順。
- value: マスタの data_type が PQ → valueQuantity(UCUM)、CD / CO → valueCodeableConcept(system はマスタの value_code_system)、それ以外 → valueString。
- interpretation = v3-ObservationInterpretation(HH / H / L / LL / N。空は N)。referenceRange(PQ のみ、type = normal)。method.text、specimen、note。"""
* insert FCMeta
* subject 1..1
* subject only Reference(FC_Patient)
* category 1..1
* category = $obs-category#laboratory
* code.coding 1..*
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    item 1..1 MS and
    jlac11 0..1 and
    jlac10 0..1 and
    abbreviation 0..1
* code.coding[item].system = "http://fhir-client.local/CodeSystem/lab-result-item"
* code.coding[jlac11].system = "http://fhir-client.local/CodeSystem/jlac11"
* code.coding[jlac10].system = "http://fhir-client.local/CodeSystem/jlac10"
* code.coding[abbreviation].system = "http://fhir-client.local/CodeSystem/lab-item-abbreviation"
* value[x] only Quantity or CodeableConcept or string
* interpretation.coding.system = $v3-ObservationInterpretation
* specimen only Reference(FC_LabLabelSpecimen or FC_LabResultSpecimen)

Profile: FC_LabResultSpecimen
Parent: $JP_Specimen_Common
Id: fc-lab-result-specimen
Title: "検体検査結果の検体"
Description: "結果入力時に作る検体(ラベルの Specimen が無いとき)。status = available、type = JLAC11 材料コード、collection.collectedDateTime。"
* insert FCMeta
* status = #available
* subject only Reference(FC_Patient)
* type 1..1
* type.coding.system = "http://fhir-client.local/CodeSystem/jlac11-specimen"

// ---- 細菌検査 ----

Profile: FC_MicroDiagnosticReport
Parent: $JP_DiagnosticReport_Common
Id: fc-micro-diagnostic-report
Title: "細菌検査 報告"
Description: "細菌検査の結果報告。category = v2-0074#MB + 入院・外来区分。code = LOINC 18725-2。status: preliminary / final。basedOn = ヘッダ、specimen(1 件)、result[] = 所見・分離菌・感受性の Observation。order-department。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 2..2
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category ^slicing.ordered = true
* category contains
    kind 1..1 and
    setting 1..1
* category[kind] = $v2-0074#MB
* category[setting] from LabResultSettingVS (required)
* code = $loinc#18725-2
* basedOn 1..1 MS
* basedOn only Reference(FC_MicroOrderHeader)
* specimen 1..1
* specimen only Reference(FC_MicroResultSpecimen)
* result only Reference(FC_MicroFindingObservation or FC_MicroIsolateObservation or FC_MicroSusceptibilityObservation)
* extension contains OrderDepartment named orderDepartment 0..1

Profile: FC_MicroResultSpecimen
Parent: $JP_Specimen_Common
Id: fc-micro-result-specimen
Title: "細菌検査結果の検体"
* insert FCMeta
* subject only Reference(FC_Patient)
* type 1..1
* type.coding.system = "http://fhir-client.local/CodeSystem/janis-specimen-type"

Profile: FC_MicroFindingObservation
Parent: Observation
Id: fc-micro-finding-observation
Title: "細菌検査 所見"
Description: "培養・塗抹・喀痰分類・膿尿の所見。code = micro-result-item(culture / smear / sputum-miller-jones / sputum-geckler / pyuria)。value は valueCodeableConcept(micro-culture-result / micro-miller-jones / micro-geckler / micro-pyuria-result)、塗抹は valueString。膿尿の判定方法は method(micro-pyuria-method)。category = laboratory、specimen。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category = $obs-category#laboratory
* code from MicroResultItemVS (required)
* value[x] only CodeableConcept or string
* specimen only Reference(FC_MicroResultSpecimen)

Profile: FC_MicroIsolateObservation
Parent: Observation
Id: fc-micro-isolate-observation
Title: "細菌検査 分離菌"
Description: "分離菌。code = micro-result-item#isolate、valueCodeableConcept = 菌種(janis-organism)。component: colony-quantity-type / colony-count / causative(いずれも valueCodeableConcept)。感受性 Observation が derivedFrom でこれを指す。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category = $obs-category#laboratory
* code = http://fhir-client.local/CodeSystem/micro-result-item#isolate "分離菌"
* value[x] only CodeableConcept
* valueCodeableConcept.coding.system = "http://fhir-client.local/CodeSystem/janis-organism"
* component ^slicing.discriminator[0].type = #pattern
* component ^slicing.discriminator[0].path = "code"
* component ^slicing.rules = #open
* component contains
    quantityType 0..1 and
    colonyCount 0..1 and
    causative 0..1
* component[quantityType].code = http://fhir-client.local/CodeSystem/micro-result-item#colony-quantity-type
* component[quantityType].value[x] only CodeableConcept
* component[quantityType].valueCodeableConcept from MicroColonyQuantityTypeVS (required)
* component[colonyCount].code = http://fhir-client.local/CodeSystem/micro-result-item#colony-count
* component[colonyCount].value[x] only CodeableConcept
* component[colonyCount].valueCodeableConcept from MicroColonyCountVS (required)
* component[causative].code = http://fhir-client.local/CodeSystem/micro-result-item#causative
* component[causative].value[x] only CodeableConcept
* component[causative].valueCodeableConcept from MicroCausativeVS (required)
* specimen only Reference(FC_MicroResultSpecimen)

Profile: FC_MicroSusceptibilityObservation
Parent: Observation
Id: fc-micro-susceptibility-observation
Title: "細菌検査 薬剤感受性"
Description: "分離菌ごと・抗菌薬ごとの感受性。code = 抗菌薬(janis-antimicrobial + 略称)。derivedFrom = 分離菌 Observation。method = 測定法(janis-susceptibility-method)。MIC は valueQuantity(ug/mL、comparator < <= >= >)。component: disk-diameter(mm)/ susceptibility-grade。interpretation = v3 S / I / R。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category = $obs-category#laboratory
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    antimicrobial 1..1 and
    abbreviation 0..1
* code.coding[antimicrobial].system = "http://fhir-client.local/CodeSystem/janis-antimicrobial"
* code.coding[abbreviation].system = "http://fhir-client.local/CodeSystem/micro-antimicrobial-abbreviation"
* derivedFrom 1..1 MS
* derivedFrom only Reference(FC_MicroIsolateObservation)
* method.coding.system = "http://fhir-client.local/CodeSystem/janis-susceptibility-method"
* value[x] only Quantity
* interpretation.coding.system = $v3-ObservationInterpretation
* component ^slicing.discriminator[0].type = #pattern
* component ^slicing.discriminator[0].path = "code"
* component ^slicing.rules = #open
* component contains
    diskDiameter 0..1 and
    grade 0..1
* component[diskDiameter].code = http://fhir-client.local/CodeSystem/micro-result-item#disk-diameter
* component[diskDiameter].value[x] only Quantity
* component[grade].code = http://fhir-client.local/CodeSystem/micro-result-item#susceptibility-grade
* component[grade].value[x] only CodeableConcept
* component[grade].valueCodeableConcept from MicroSusceptibilityGradeVS (required)
* specimen only Reference(FC_MicroResultSpecimen)

// ---- 放射線 読影レポート ----

Profile: FC_RadDiagnosticReport
Parent: $JP_DiagnosticReport_Common
Id: fc-rad-diagnostic-report
Title: "放射線 読影レポート"
Description: """読影レポート。

- category = [LOINC LP29684-5 Radiology, v2-0074#RAD, 入院・外来区分]。code = JP_DocumentCodes_CS#18748-4 画像検査報告書(text = 検査内容)。
- status: preliminary / final / amended。issued、performer = 自院 Organization、resultsInterpreter = 読影医、conclusion = 診断。
- basedOn = 放射線検査オーダーのヘッダ。result = 所見 Observation(category imaging、code rad-report-item#findings、valueString)。
- 画像は rad-report-image(Binary は同じ transaction)、重要所見は rad-critical-finding(通知 Task が作られる)、テンプレート記入は rad-report-findings-response / rad-report-conclusion-response。
- レポートが付いたオーダーは取消・削除できない。"""
* insert FCMeta
* subject only Reference(FC_Patient)
* category 3..3
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category ^slicing.ordered = true
* category contains
    loinc 1..1 and
    kind 1..1 and
    setting 1..1
* category[loinc] = $loinc#LP29684-5
* category[kind] = $v2-0074#RAD
* category[setting] from LabResultSettingVS (required)
* code.coding 1..1
* code.coding = $JP_DocumentCodes#18748-4
* issued 1..1
* performer only Reference(FC_Facility)
* resultsInterpreter only Reference(FC_Practitioner)
* basedOn 1..1 MS
* basedOn only Reference(FC_RadOrderHeader)
* result only Reference(FC_RadFindingsObservation)
* extension contains
    RadReportImage named image 0..* and
    RadCriticalFinding named criticalFinding 0..1 MS and
    RadReportFindingsResponse named findingsResponse 0..1 and
    RadReportConclusionResponse named conclusionResponse 0..1

Profile: FC_RadFindingsObservation
Parent: Observation
Id: fc-rad-findings-observation
Title: "読影 所見"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category = $obs-category#imaging
* code = http://fhir-client.local/CodeSystem/rad-report-item#findings "所見"
* value[x] only string

Profile: FC_RadDoseObservation
Parent: Observation
Id: fc-rad-dose-observation
Title: "被ばく線量"
Description: "放射線検査の実施記録にぶら下がる線量。category 無し。code = rad-dose、valueQuantity(UCUM)。partOf = 実施記録の Procedure。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 0..0
* code from RadDoseVS (required)
* value[x] only Quantity
* valueQuantity.system = $ucum
* partOf 1..1
* partOf only Reference(FC_RadProcedure)

// ---- 病理 ----

Profile: FC_PathoDiagnosticReport
Parent: $JP_DiagnosticReport_Common
Id: fc-patho-diagnostic-report
Title: "病理診断レポート"
Description: """病理診断レポート。JAHIS 病理診断レポート構造化記述規約のセクション構成に合わせ、セクションごとの Observation を result に並べる。

- category = [v2-0074#SP(組織診)または #CP(細胞診), 入院・外来区分]。code = LOINC 11526-1 Pathology study(text 病理診断レポート)。
- status: preliminary 中間報告 / final 最終報告 / amended 修正報告(確定後の編集保存)。effectiveDateTime。
- basedOn = 病理オーダーのヘッダ。specimen[] = 検体(臓器・検体タイプ・実採取日)。
- result[] = 肉眼所見(LOINC 22634-0)/ 顕微鏡所見(22635-7)/ 診断(22637-3)/ 採取法・検体処理法(10157-6)の Observation。細胞診の診断は valueCodeableConcept(patho-cyto-judgement)と component 推定病変。
- 画像は patho-report-image(Binary は同じ transaction)、order-department。"""
* insert FCMeta
* subject only Reference(FC_Patient)
* category 2..2
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "$this"
* category ^slicing.rules = #open
* category ^slicing.ordered = true
* category contains
    kind 1..1 and
    setting 1..1
* category[kind].coding.system = $v2-0074
* category[setting] from LabResultSettingVS (required)
* code = $loinc#11526-1
* effective[x] only dateTime
* basedOn 1..1 MS
* basedOn only Reference(FC_PathoOrderHeader)
* specimen only Reference(FC_PathoResultSpecimen)
* result only Reference(FC_PathoFindingObservation)
* extension contains
    OrderDepartment named orderDepartment 0..1 and
    PathoReportImage named image 0..*

Profile: FC_PathoResultSpecimen
Parent: $JP_Specimen_Common
Id: fc-patho-result-specimen
Title: "病理レポートの検体"
Description: "status = available、type = JAHIS 検体タイプ、collection.bodySite = 臓器(JAHIS)、collection.collectedDateTime = 実採取日。"
* insert FCMeta
* status = #available
* subject only Reference(FC_Patient)
* type.coding.system = "http://fhir-client.local/CodeSystem/jahis-patho-specimen-type"
* collection.bodySite.coding.system = "http://fhir-client.local/CodeSystem/jahis-patho-organ"

Profile: FC_PathoFindingObservation
Parent: Observation
Id: fc-patho-finding-observation
Title: "病理レポートのセクション"
Description: "肉眼所見 / 顕微鏡所見 / 診断 / 採取法・検体処理法。code = LOINC(22634-0 / 22635-7 / 22637-3 / 10157-6)。category = laboratory。valueString(細胞診の診断は valueCodeableConcept = patho-cyto-judgement、component patho-result-item#estimated-lesion = valueString)。検体が 1 件のときだけ specimen を指す。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category = $obs-category#laboratory
* code.coding 1..1
* code.coding.system = $loinc
* value[x] only string or CodeableConcept
* valueCodeableConcept from PathoCytoJudgementVS (required)
* component.code.coding.system = "http://fhir-client.local/CodeSystem/patho-result-item"
* specimen only Reference(FC_PathoResultSpecimen)

// ---- 手術・輸血・麻酔チャートの Observation ----

Profile: FC_SurgeryObservation
Parent: Observation
Id: fc-surgery-observation
Title: "手術中の測定値"
Description: "出血量 / 尿量 / 輸血量。code = surgery-observation、valueQuantity(mL、UCUM)、category 無し、partOf = 手術実施記録。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 0..0
* code from SurgeryObservationVS (required)
* value[x] only Quantity
* valueQuantity.system = $ucum
* valueQuantity.code = #mL
* partOf 1..1
* partOf only Reference(FC_SurgeryProcedure)

Profile: FC_TransfusionReactionObservation
Parent: Observation
Id: fc-transfusion-reaction-observation
Title: "輸血反応"
Description: "category = order-type#transfusion、code = transfusion-observation#reaction、valueCodeableConcept = transfusion-reaction(none / present)、partOf = 輸血実施記録。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category = $order-type#transfusion
* code = http://fhir-client.local/CodeSystem/transfusion-observation#reaction "輸血反応"
* value[x] only CodeableConcept
* valueCodeableConcept from TransfusionReactionVS (required)
* partOf 1..1
* partOf only Reference(FC_TransfusionProcedure)

Profile: FC_AnesthesiaVitalObservation
Parent: Observation
Id: fc-anesthesia-vital-observation
Title: "麻酔チャートのバイタル"
Description: "麻酔中のバイタル。category 無し。code = LOINC(85354-9 血圧パネル(component 8480-6 / 8462-4)、8867-4 脈拍、2708-6 SpO2、19889-5 EtCO2、8310-5 体温、9279-1 呼吸数)。partOf = 麻酔チャート。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 0..0
* code.coding.system = $loinc
* partOf 1..1
* partOf only Reference(FC_AnesthesiaChartProcedure)

Profile: FC_AnesthesiaEventObservation
Parent: Observation
Id: fc-anesthesia-event-observation
Title: "麻酔チャートのイベント"
Description: "麻酔開始・挿管・執刀開始・執刀終了・抜管・麻酔終了・その他。code = anesthesia-event、effectiveDateTime、note。partOf = 麻酔チャート。"
* insert FCMeta
* subject only Reference(FC_Patient)
* code from AnesthesiaEventVS (required)
* effective[x] only dateTime
* effective[x] 1..1
* partOf 1..1
* partOf only Reference(FC_AnesthesiaChartProcedure)
