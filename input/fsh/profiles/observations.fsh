// 患者プロファイル・バイタル・看護観察・食事摂取・テンプレート抽出・有害事象の Observation。

Profile: FC_BloodTypeObservation
Parent: Observation
Id: fc-blood-type-observation
Title: "血液型"
Description: "ABO と RhD で 1 件ずつ。status = final、category = laboratory。code = LOINC 883-9(ABO)/ 10331-7(RhD)。valueCodeableConcept = transfusion-abo / transfusion-rhd。method = 情報源(blood-type-source)。effectiveDateTime、note。"
* insert FCMeta
* subject only Reference(FC_Patient)
* status = #final
* category 1..1
* category = $obs-category#laboratory
* code.coding 1..1
* code.coding.system = $loinc
* value[x] only CodeableConcept
* method 1..1
* method from BloodTypeSourceVS (required)

Profile: FC_PregnancyObservation
Parent: Observation
Id: fc-pregnancy-observation
Title: "妊娠・授乳"
Description: "妊娠と授乳で 1 件ずつ。category = survey。code = LOINC 82810-3 Pregnancy status / 63895-7 Breastfeeding status。valueCodeableConcept = SNOMED CT(妊娠: 77386006 妊娠中 / 60001007 妊娠していない / 261665006 不明、授乳: 413712001 授乳中 / 169750002 授乳していない)。妊娠中は component LOINC 11778-8(分娩予定日、valueDateTime)。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category = $obs-category#survey
* code.coding 1..1
* code.coding.system = $loinc
* value[x] only CodeableConcept
* valueCodeableConcept.coding.system = $sct
* component 0..1
* component.code = $loinc#11778-8
* component.value[x] only dateTime

Profile: FC_InfectionObservation
Parent: Observation
Id: fc-infection-observation
Title: "感染症(手入力)"
Description: "手入力の感染症情報。category = exam。code.coding[0] = infection-type、coding[1] = 対応する LOINC。valueCodeableConcept = infection-result(陽性 / 陰性)。method = 情報源(infection-source)。検査結果由来の感染症は検体検査 Observation を JLAC11 で読む。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category = $obs-category#exam
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    type 1..1 and
    loinc 0..1
* code.coding[type].system = "http://fhir-client.local/CodeSystem/infection-type"
* code.coding[type] from InfectionTypeVS (required)
* code.coding[loinc].system = $loinc
* value[x] only CodeableConcept
* valueCodeableConcept from InfectionResultVS (required)
* method from InfectionSourceVS (required)

Profile: FC_VitalObservation
Parent: Observation
Id: fc-vital-observation
Title: "バイタル測定"
Description: """バイタル。1 回の測定で入力した項目を identifier(vital-entry の uuid)で束ねる。編集は古い Observation を削除して作り直す。

- category = vital-signs。code = LOINC: 85354-9 血圧パネル(component 8480-6 収縮期 / 8462-4 拡張期、mm[Hg])、8310-5 体温(Cel)、8867-4 脈拍(/min)、2708-6 SpO2(%)、9279-1 呼吸数(/min)、8302-2 身長(cm)、29463-7 体重(kg)、39156-5 BMI(kg/m2)。
- observation-problem = 対象のプロブレム。order-department = 記録した診療科(編集では元の値を引き継ぐ)。
- アプリは meta.profile を付けないが、上流サーバーは読み出し時に JP_Observation_Common を付ける(category の system は HL7 observation-category)。"""
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier 1..1
* identifier.system = "http://fhir-client.local/vital-entry"
* category 1..1
* category = $obs-category#vital-signs
* code.coding 1..1
* code.coding.system = $loinc
* value[x] only Quantity
* valueQuantity.system = $ucum
* component.code.coding.system = $loinc
* extension contains
    ObservationProblem named problem 0..1 and
    OrderDepartment named orderDepartment 0..1

Profile: FC_NursingObservation
Parent: Observation
Id: fc-nursing-observation
Title: "看護観察 記録"
Description: "看護観察の指示に対する記録。category[0] = order-type#nursing のみ。code = 指示の MEDIS coding(master-nursingObservationKeyCode)に、対応があれば LOINC のバイタルコードを添える(31000001 SpO2 / 31001368 体温 / 31001390 脈拍 / 31001369 呼吸数 / 31000296 体重 / 31000298 身長 / 31002365 血圧)。value = valueQuantity(LOINC に対応するバイタルだけ UCUM の system / code を持ち、他は unit 文字列のみ)/ valueCodeableConcept(nursing-observation-result + text)/ component(2 数値型。code.text のみ)/ valueString。マスタに無い自由記載の指示の記録は code.text のみ + valueString。basedOn = 看護指示、encounter、performer。identifier = nursing-perform-entry。"
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier.system = "http://fhir-client.local/nursing-perform-entry"
* category 1..1
* category = $order-type#nursing
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    medis 0..1 and
    loinc 0..1
* code.coding[medis].system = $medis-nursing-observation
* code.coding[loinc].system = $loinc
* basedOn 1..1
* basedOn only Reference(FC_NursingOrder)
* encounter only Reference(FC_InpatientEncounter)
* performer only Reference(FC_Practitioner)

Profile: FC_MealIntakeObservation
Parent: Observation
Id: fc-meal-intake-observation
Title: "食事摂取量"
Description: "食事ごとの摂取量。category = order-type#meal。code = MEDIS 看護観察 31003419(主食)/ 31003420(副食)。valueQuantity = %(UCUM)。basedOn = 食事オーダー。effectiveDateTime は 08:00 / 12:00 / 18:00。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category = $order-type#meal
* code.coding 1..1
* code.coding.system = $medis-nursing-observation
* value[x] only Quantity
* valueQuantity.system = $ucum
* valueQuantity.code = #%
* basedOn 1..1
* basedOn only Reference(FC_MealOrder)
* effective[x] only dateTime

Profile: FC_ExtractedObservation
Parent: Observation
Id: fc-extracted-observation
Title: "テンプレート記入から抽出した Observation"
Description: "Questionnaire の sdc-questionnaire-observationExtract が true の項目から抽出した Observation。category = テンプレートの抽出カテゴリ(social-history / vital-signs / exam / survey(既定)/ laboratory / imaging / procedure / therapy / activity)。code = item.code(observation-item や JP_ObservationSocialHistoryCode_CS)。derivedFrom = QuestionnaireResponse。valueQuantity の unit は文字列のみ(UCUM system 無し)。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category.coding.system = $obs-category
* derivedFrom 1..1 MS
* derivedFrom only Reference(FC_QuestionnaireResponse)

Profile: FC_AdverseEventObservation
Parent: Observation
Id: fc-adverse-event-observation
Title: "有害事象(CTCAE)"
Description: "有害事象。AdverseEvent リソースは使わず Observation で持つ。category = 本 IG の observation-category#adverse-event(HL7 の system ではない)。code.text = CTCAE 用語(コードシステムは無い)。valueInteger = Grade 1〜5。effectivePeriod = 発現〜消失。basedOn = レジメン適用または放射線治療処方。treatment-context = 治療の文脈。旧形式の regimen-order 拡張は読み取りのみ。"
* insert FCMeta
* subject only Reference(FC_Patient)
* category 1..1
* category = http://fhir-client.local/CodeSystem/observation-category#adverse-event "有害事象"
* code.text 1..1
* value[x] only integer
* effective[x] only Period
* basedOn only Reference(FC_RegimenOrder or FC_RadiotherapyOrder)
* performer only Reference(FC_Practitioner)
* extension contains TreatmentContext named treatmentContext 0..1 MS

Profile: FC_TriageObservation
Parent: Observation
Id: fc-triage-observation
Title: "トリアージ(JTAS)の判定記録"
Description: "救急受診のトリアージ 1 回ぶんの判定記録。status = final、category = survey、code = emergency-observation#jtas。valueCodeableConcept = JTAS レベル(jtas-level の 1〜5)。encounter = 救急受診、effectiveDateTime = 判定日時、performer = 判定した職員。再判定のたびに 1 件増え、現在のレベルは Encounter の emergency-triage-level 拡張が持つ。"
* insert FCMeta
* status = #final
* category 1..1
* category = $obs-category#survey
* code = http://fhir-client.local/CodeSystem/emergency-observation#jtas
* subject 1..1
* subject only Reference(FC_Patient)
* encounter 1..1
* encounter only Reference(FC_EmergencyEncounter)
* effective[x] 1..1
* effective[x] only dateTime
* value[x] 1..1
* value[x] only CodeableConcept
* valueCodeableConcept from JtasLevelVS (required)
* performer only Reference(FC_Practitioner)
