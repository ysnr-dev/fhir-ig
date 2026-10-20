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

- category = vital-signs。code = LOINC: 85354-9 血圧パネル(component 8480-6 収縮期 / 8462-4 拡張期、mm[Hg])、8310-5 体温(Cel)、8867-4 脈拍(/min)、2708-6 SpO2(%)、9279-1 呼吸数(/min)、8302-2 身長(cm)、29463-7 体重(kg)、39156-5 BMI(kg/m2)、3151-8 酸素流量(L/min、0 は室内気)。同じ測定の意識(JCS)は FC_JcsObservation、早期警告スコアは FC_EarlyWarningObservation で、同じ identifier を持つ。
- observation-problem = 対象のプロブレム。order-department = 記録した診療科(編集では元の値を引き継ぐ)。
- 測定の Observation は fullUrl(urn:uuid)付きで POST する(NEWS2 の derivedFrom が同じ transaction の測定を指す)。
- 入院患者一覧の経過表一括入力は、患者ごとに 1 回の測定として書き、encounter = 入院、performer = 測定者(ログイン中の医療従事者)を持つ(プロブレム・診療科は持たない)。体重だけを入れたときは、その患者の最新の身長で BMI も書く(身長の Observation は同じ測定に無い)。
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
* encounter 0..1 MS
* encounter only Reference(FC_InpatientEncounter)
* performer 0..1 MS
* performer only Reference(FC_Practitioner)
* extension contains
    ObservationProblem named problem 0..1 and
    OrderDepartment named orderDepartment 0..1

Profile: FC_JcsObservation
Parent: Observation
Id: fc-jcs-observation
Title: "意識レベル(JCS)"
Description: """バイタル測定で入力した意識レベル(JCS)。同じ測定の他の項目と同じ identifier(vital-entry)・category・subject・encounter・performer・拡張を持つ。

- code = 看護観察 MEDIS 31001657「意識評価(JCS)」+ vital-measure#jcs(LOINC に JCS は無い)、text = 意識(JCS)。MEDIS を持つので、看護指示の観察として記録した JCS と経過表の同じ行に並ぶ。
- valueCodeableConcept = jcs(code = JCS の数値、display = I-1 などの表記)、text = 表記。"""
* insert FCMeta
* status = #final
* subject only Reference(FC_Patient)
* identifier 1..1
* identifier.system = "http://fhir-client.local/vital-entry"
* category 1..1
* category = $obs-category#vital-signs
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    medis 1..1 and
    measure 1..1
* code.coding[medis].system = $medis-nursing-observation
* code.coding[medis].code = #31001657
* code.coding[measure].system = "http://fhir-client.local/CodeSystem/vital-measure"
* code.coding[measure].code = #jcs
* code.text 1..1
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept.coding 1..1
* valueCodeableConcept from JcsVS (required)
* encounter 0..1 MS
* encounter only Reference(FC_InpatientEncounter)
* performer 0..1 MS
* performer only Reference(FC_Practitioner)
* extension contains
    ObservationProblem named problem 0..1 and
    OrderDepartment named orderDepartment 0..1

Profile: FC_EarlyWarningObservation
Parent: Observation
Id: fc-early-warning-observation
Title: "早期警告スコア(NEWS2)"
Description: """測定セットから算出した NEWS2(RCP 2017)。施設設定で早期警告を有効にしているとき、測定の transaction に派生の Observation として同梱する(病棟一覧・患者帯が 1 本の検索で最新の点数を引けるように)。qSOFA は表示時に計算し、保存しない。

- identifier・category・subject・encounter・effectiveDateTime・performer・拡張は、同じ測定の最初の Observation をそのまま写す。
- code = early-warning-score#news2、valueInteger = 合計点、interpretation = early-warning-band(低 / 低〜中 / 中 / 高)。
- derivedFrom = 同じ transaction で POST する測定の Observation(fullUrl の urn:uuid。保存後はサーバーが Observation/{id} に書き換える)。
- component は 7 項目(呼吸数 9279-1 / SpO2 2708-6 / 酸素 3151-8 / 収縮期血圧 8480-6 / 脈拍 8867-4 / 意識 vital-measure#jcs / 体温 8310-5)。測った項目は valueInteger = 点数(0〜3)、測っていない項目は dataAbsentReason = not-performed(合計は暫定)。意識は JCS を ACVPU に写し、A 以外を 3 点とする。SpO2 は注意区分 spo2-scale2 の患者でスケール 2 を使う。
- 測定に呼吸数・SpO2・酸素流量・収縮期血圧・脈拍・JCS・体温のどれも無ければ作らない。測定セットは保存のたびに作り直す(DELETE + POST)ので NEWS2 も作り直す。
- 入院中で区分が施設設定の下限以上なら、同じ transaction で早期警告の通知(FC_EwsAlertTask)を出す。"""
* insert FCMeta
* status = #final
* subject only Reference(FC_Patient)
* identifier 1..1
* identifier.system = "http://fhir-client.local/vital-entry"
* category 1..1
* category = $obs-category#vital-signs
* code.coding 1..1
* code = EarlyWarningScoreCS#news2
* code.text 1..1
* effective[x] only dateTime
* value[x] only integer
* valueInteger 1..1
* interpretation 1..1
* interpretation.coding 1..1
* interpretation from EarlyWarningBandVS (required)
* derivedFrom 1..* MS
* derivedFrom only Reference(FC_VitalObservation or FC_JcsObservation)
* component 7..7
* component.code.coding 1..1
* component.value[x] only integer
* component.dataAbsentReason = $data-absent-reason#not-performed
* encounter 0..1 MS
* encounter only Reference(FC_InpatientEncounter)
* performer 0..1 MS
* performer only Reference(FC_Practitioner)
* extension contains
    ObservationProblem named problem 0..1 and
    OrderDepartment named orderDepartment 0..1

Profile: FC_OralExamObservation
Parent: Observation
Id: fc-oral-exam-observation
Title: "口腔診査情報"
Description: """歯科の口腔診査情報(日本歯科医師会 口腔診査情報標準規格 JDAOES 準拠)。1 回の診査を、同じ identifier(oral-exam-snapshot の uuid)を持つ複数の Observation に分けて書く。子同士は参照を持たず、identifier と歯の鍵(歯種 + TB-3 + TB-4 + TB-5)で結び付く。

- code = oral-exam: snapshot 見出し(1 件)/ tooth 歯(記録のある歯 × 併存グループ)/ tooth-content 現在歯の内容(併存レコードごと)/ mouth 口腔全体(KS・KK・SI・SK の行ごと)。text = 種類名。
- category = exam。effectiveDateTime = 診査日(日付のみ)。performer = 記録した医療従事者(ログイン中の医療従事者があるときだけ。編集では元の値を引き継ぐ)。encounter は持たない。
- component.code = jdaoes-item(項目名からハイフンを除いたコード)。値は valueCodeableConcept(JDAS の各表の OID、または MEDIS 標準歯式 urn:oid:1.2.392.200119.4.1401)/ valueString(製品名・特記事項などの自由記載)/ valueDateTime(年月日)。値のある項目だけを書く。
- 見出し: NS2 入力種別(常に)、NS3 最新初診年月日・NS4 最終診療年月日(入力があるとき)、note = メモ(あるとき)。
- 歯: bodySite = 歯種(MEDIS 標準歯式 4 桁、text = 右上6 などの略記)。TB3 状態・TB4 部分(常に)、TB5 併存グループ(同じ歯に 2 つ以上のとき)、TD2 歯の基本状態(常に)、TD3 歯科健診記号、TM2〜TM12 欠損歯の内容、TE2〜TE6 製品識別・特記事項、TE8 当該歯の入力・更新年月日(前回から変わった歯だけ新しい日付)、TF2 + TF3〜TF28 標準プロファイル 26 項目(歯の状態から導出)。
- 現在歯の内容: bodySite は親の歯と同じ。TB3・TB4(・TB5)と、TP2 併存レコード連番(2 行以上のとき)、TP3〜TP34。
- 口腔全体: bodySite を持たない。歯式の項目(KS4・KK9・SI5・SI8・SK4)は歯 1 本ごとに 1 つの component(MEDIS 標準歯式 6 桁)。
- 保存は 1 つの transaction: 編集では前回の子をすべて DELETE、見出しを POST(fullUrl = urn:uuid)/ PUT(If-Match)、子をすべて POST(fullUrl = urn:uuid)。"""
* insert FCMeta
* status = #final
* subject only Reference(FC_Patient)
* identifier 1..1
* identifier.system = "http://fhir-client.local/oral-exam-snapshot"
* category 1..1
* category = $obs-category#exam
* code.coding 1..1
* code from OralExamVS (required)
* code.text 1..1
* effective[x] 1..1
* effective[x] only dateTime
* performer 0..1 MS
* performer only Reference(FC_Practitioner)
* encounter 0..0
* value[x] 0..0
* component 1..* MS
* component.code.coding 1..1
* component.code.coding.system = "http://fhir-client.local/CodeSystem/jdaoes-item"
* component.value[x] only CodeableConcept or string or dateTime

Profile: FC_NursingObservation
Parent: Observation
Id: fc-nursing-observation
Title: "看護観察 記録"
Description: "看護観察の指示に対する記録。category[0] = order-type#nursing のみ。code = 指示の MEDIS coding(master-nursingObservationKeyCode)に、対応があれば LOINC のバイタルコードを添える(31000001 SpO2 / 31001368 体温 / 31001390 脈拍 / 31001369 呼吸数 / 31000296 体重 / 31000298 身長 / 31002365 血圧、31000303 血糖値 → 41653-7 簡易血糖 / 31006122 酸素流量 → 3151-8)。value = valueQuantity(LOINC に対応するバイタルだけ UCUM の system / code を持ち、他は unit 文字列のみ)/ valueCodeableConcept(nursing-observation-result + text)/ component(2 数値型。code.text のみ)/ valueString。マスタに無い自由記載の指示の記録は code.text のみ + valueString。basedOn = 看護指示、encounter、performer。identifier = nursing-perform-entry。"
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

Profile: FC_CapillaryGlucoseObservation
Parent: Observation
Id: fc-capillary-glucose-observation
Title: "血糖値(インスリンの実施入力)"
Description: "インスリンのスケール施用で、直近の記録が無く実施入力で入れた血糖値。看護指示から記録した血糖値(FC_NursingObservation)と同じ category・code にし、経過表・直近値の検索で区別せずに読む。category = order-type#nursing、code = MEDIS 31000303 血糖値 + LOINC 41653-7、text = 血糖値。valueQuantity = mg/dL(UCUM)。basedOn = 有効な血糖測定の看護指示(無ければ付けない)。effectiveDateTime = 施用の開始日時。注射の実施と同じ transaction で書き、MedicationAdministration.supportingInformation が指す。identifier は持たない。"
* insert FCMeta
* status = #final
* subject only Reference(FC_Patient)
* category 1..1
* category = $order-type#nursing
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[0].path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains
    medis 1..1 and
    loinc 1..1
* code.coding[medis].system = $medis-nursing-observation
* code.coding[medis].code = #31000303
* code.coding[loinc].system = $loinc
* code.coding[loinc].code = #41653-7
* basedOn 0..1
* basedOn only Reference(FC_NursingOrder)
* encounter only Reference(FC_InpatientEncounter)
* performer only Reference(FC_Practitioner)
* effective[x] only dateTime
* value[x] only Quantity
* valueQuantity.system = $ucum
* valueQuantity.code = #mg/dL

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
