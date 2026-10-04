// 患者・管理リソース(Condition / Flag / Location / PractitionerRole / Encounter / 予約)の CodeSystem。

CodeSystem: ConditionCategoryCS
Id: condition-category
Title: "病名カテゴリ(既往歴・看護問題)"
Description: "既往歴・看護問題の Condition に、HL7 の problem-list-item と併せて付ける 2 つ目の category。看護問題は病名・プロブレムの一覧とレセコン送信から外す(病名の検索は category:not で除く)。"
* insert EnumCS
* #past-history "既往歴"
* #nursing-problem "看護問題"

ValueSet: ConditionCategoryVS
Id: condition-category-vs
Title: "病名カテゴリ(既往歴・看護問題) ValueSet"
Description: "病名カテゴリ(既往歴・看護問題) ValueSet。"
* insert AllOf(ConditionCategoryCS)

CodeSystem: FlagCategoryCS
Id: flag-category
Title: "注意情報の区分"
Description: "患者の注意情報(Flag)の区分。"
* insert EnumCS
* #safety "安全"
* #clinical "臨床"
* #advance-directive "意思"
* #administrative "事務"

ValueSet: FlagCategoryVS
Id: flag-category-vs
Title: "注意情報の区分 ValueSet"
Description: "注意情報の区分 ValueSet。"
* insert AllOf(FlagCategoryCS)

CodeSystem: PatientCautionCS
Id: patient-caution
Title: "注意区分(院内マスタ)"
Description: "code = 院内マスタ patient_cautions のコード。display はマスタの名称を転記する。"
* insert MasterCS

CodeSystem: RoomClassCS
Id: room-class
Title: "病室の種別"
Description: "病室 Location.type。"
* insert EnumCS
* #general "一般室"
* #private "個室"
* #special "特別室"
* #icu "ICU(集中治療室)"
* #hcu "HCU(高度治療室)"
* #ccu "CCU(循環器疾患集中治療室)"
* #scu "SCU(脳卒中集中治療室)"

ValueSet: RoomClassVS
Id: room-class-vs
Title: "病室の種別 ValueSet"
Description: "病室の種別 ValueSet。"
* insert AllOf(RoomClassCS)

CodeSystem: PractitionerRoleCS
Id: practitioner-role
Title: "職種"
Description: "医療従事者の職種(PractitionerRole.code)。HPKI の 27 資格に、事務職員と医師事務作業補助者を加えたもの。physio は理学療法士の職種コードで、生理検査のオーダー種別 physio とは別物。"
* insert EnumCS
* #doctor "医師"
* #dentist "歯科医師"
* #pharmacist "薬剤師"
* #nurse "看護師"
* #public-health-nurse "保健師"
* #midwife "助産師"
* #radiological-technologist "診療放射線技師"
* #medical-technologist "臨床検査技師"
* #laboratory-technician "衛生検査技師"
* #clinical-engineer "臨床工学技士"
* #physio "理学療法士"
* #occupational "作業療法士"
* #speech "言語聴覚士"
* #orthoptist "視能訓練士"
* #prosthetist "義肢装具士"
* #dental-hygienist "歯科衛生士"
* #dental-technician "歯科技工士"
* #dietitian "管理栄養士"
* #emergency-technician "救急救命士"
* #social-worker "社会福祉士"
* #psychiatric-social-worker "精神保健福祉士"
* #care-worker "介護福祉士"
* #psychologist "公認心理師"
* #judo-therapist "柔道整復師"
* #massage-practitioner "あん摩マッサージ指圧師"
* #acupuncturist "はり師"
* #moxibustionist "きゅう師"
* #clerk "事務職員"
* #medical-clerk "医師事務作業補助者"

ValueSet: PractitionerRoleVS
Id: practitioner-role-vs
Title: "職種 ValueSet"
Description: "職種 ValueSet。"
* insert AllOf(PractitionerRoleCS)

CodeSystem: EncounterParticipantRoleCS
Id: encounter-participant-role
Title: "入院の担当者区分"
Description: "入院 Encounter.participant.type。担当医は HL7 の ATND を使い、担当看護師にこの CodeSystem を使う。"
* insert EnumCS
* #nurse "担当看護師"

ValueSet: EncounterParticipantRoleVS
Id: encounter-participant-role-vs
Title: "入院の担当者区分 ValueSet"
Description: "入院の担当者区分 ValueSet。"
* insert AllOf(EncounterParticipantRoleCS)

CodeSystem: BloodTypeSourceCS
Id: blood-type-source
Title: "血液型の情報源"
Description: "血液型 Observation.method。"
* insert EnumCS
* #tested "検査確定"
* #reported "本人・家族の申告"
* #referred "他院からの情報"

ValueSet: BloodTypeSourceVS
Id: blood-type-source-vs
Title: "血液型の情報源 ValueSet"
Description: "血液型の情報源 ValueSet。"
* insert AllOf(BloodTypeSourceCS)

CodeSystem: InfectionTypeCS
Id: infection-type
Title: "感染症の種類"
Description: "手入力の感染症 Observation.code。LOINC を 2 つ目の coding に添える(hbs 5195-3 / hcv 16128-1 / hiv 31201-7 / syphilis 20507-0 / htlv1 31418-7 / mrsa 43409-2 / tb 11476-9)。"
* insert EnumCS
* #hbs "HBs 抗原"
* #hcv "HCV 抗体"
* #hiv "HIV"
* #syphilis "梅毒"
* #htlv1 "HTLV-1"
* #mrsa "MRSA"
* #tb "結核"

ValueSet: InfectionTypeVS
Id: infection-type-vs
Title: "感染症の種類 ValueSet"
Description: "感染症の種類 ValueSet。"
* insert AllOf(InfectionTypeCS)

CodeSystem: InfectionResultCS
Id: infection-result
Title: "感染症の結果"
Description: "感染症の結果のコード。"
* insert EnumCS
* #positive "陽性"
* #negative "陰性"

ValueSet: InfectionResultVS
Id: infection-result-vs
Title: "感染症の結果 ValueSet"
Description: "感染症の結果 ValueSet。"
* insert AllOf(InfectionResultCS)

CodeSystem: InfectionSourceCS
Id: infection-source
Title: "感染症の情報源"
Description: "手入力の感染症 Observation.method。検査結果由来のものは検体検査の Observation を JLAC11 で読む。"
* insert EnumCS
* #reported "本人・家族の申告"
* #referred "他院からの情報"

ValueSet: InfectionSourceVS
Id: infection-source-vs
Title: "感染症の情報源 ValueSet"
Description: "感染症の情報源 ValueSet。"
* insert AllOf(InfectionSourceCS)

CodeSystem: ScheduleServiceTypeCS
Id: schedule-service-type
Title: "予約枠の種類"
Description: "Schedule.serviceType。Appointment には Schedule から複製する。"
* insert EnumCS
* #consultation "診察予約"
* #exam "検査予約"
* #rehab "リハビリ予約"
* #nutrition-guidance "栄養指導予約"
* #chemo "化学療法予約"

ValueSet: ScheduleServiceTypeVS
Id: schedule-service-type-vs
Title: "予約枠の種類 ValueSet"
Description: "予約枠の種類 ValueSet。"
* insert AllOf(ScheduleServiceTypeCS)

CodeSystem: FileCategoryCS
Id: file-category
Title: "ファイル分類(院内マスタ)"
Description: "code = backend の file_categories の UUID。display と text に分類名を入れる。患者ファイル DocumentReference.category。"
* insert MasterCS

CodeSystem: DocumentTemplateCS
Id: document-template
Title: "文書テンプレート(院内マスタ)"
Description: "code = backend の document_templates の UUID。display と text にテンプレート名を入れる。文書作成で作った患者ファイル DocumentReference.type。"
* insert MasterCS

CodeSystem: PatientTagCS
Id: patient-tag
Title: "患者の印(meta.tag)"
Description: "Patient.meta.tag に付ける印。unidentified は救急受付で仮登録した身元不明の患者で、身元が分かったときに外す。"
* insert EnumCS
* #unidentified "身元不明"

ValueSet: PatientTagVS
Id: patient-tag-vs
Title: "患者の印 ValueSet"
Description: "患者の印 ValueSet。"
* insert AllOf(PatientTagCS)

CodeSystem: AppointmentVisitKindCS
Id: appointment-visit-kind
Title: "初再診"
Description: "受付で指定する初診・再診(appointment-visit-kind 拡張の valueCode)。未指定は判定をレセプトコンピュータに任せる意味で、拡張ごと持たない。"
* insert EnumCS
* #first "初診"
* #revisit "再診"

ValueSet: AppointmentVisitKindVS
Id: appointment-visit-kind-vs
Title: "初再診 ValueSet"
Description: "初再診 ValueSet。"
* insert AllOf(AppointmentVisitKindCS)

// ---- 救急 ----

CodeSystem: EmergencyArrivalModeCS
Id: emergency-arrival-mode
Title: "救急の来院方法"
Description: "救急受診 Encounter.hospitalization.admitSource。ambulance / doctor-heli / doctor-car は、救急から入院するときに「救急車による搬送」(encounter-ambulance)として引き継ぐ。"
* insert EnumCS
* #ambulance "救急車"
* #doctor-heli "ドクターヘリ"
* #doctor-car "ドクターカー"
* #walk-in "自力来院"
* #referral "紹介"
* #transfer "転院搬送"

ValueSet: EmergencyArrivalModeVS
Id: emergency-arrival-mode-vs
Title: "救急の来院方法 ValueSet"
Description: "救急の来院方法 ValueSet。"
* insert AllOf(EmergencyArrivalModeCS)

CodeSystem: EmergencyDispositionCS
Id: emergency-disposition
Title: "救急の転帰"
Description: "救急受診 Encounter.hospitalization.dischargeDisposition。入院の退院先(HL7 discharge-disposition)とは別のコード体系。"
* insert EnumCS
* #home "帰宅"
* #admitted "入院"
* #transferred "転院"
* #deceased "死亡"
* #left "診察前離院"
* #other "その他"

ValueSet: EmergencyDispositionVS
Id: emergency-disposition-vs
Title: "救急の転帰 ValueSet"
Description: "救急の転帰 ValueSet。"
* insert AllOf(EmergencyDispositionCS)

CodeSystem: JtasLevelCS
Id: jtas-level
Title: "JTAS レベル"
Description: "JTAS(緊急度判定支援システム)の 5 段階。トリアージの判定記録 Observation.valueCodeableConcept。Encounter の emergency-triage-level 拡張には同じ数値を valueInteger で持つ。"
* insert EnumCS
* #1 "蘇生"
* #2 "緊急"
* #3 "準緊急"
* #4 "低緊急"
* #5 "非緊急"

ValueSet: JtasLevelVS
Id: jtas-level-vs
Title: "JTAS レベル ValueSet"
Description: "JTAS レベル ValueSet。"
* insert AllOf(JtasLevelCS)

CodeSystem: EmergencyObservationCS
Id: emergency-observation
Title: "救急の Observation コード"
Description: "救急で記録する Observation.code。"
* insert EnumCS
* #jtas "JTAS 緊急度判定"

ValueSet: EmergencyObservationVS
Id: emergency-observation-vs
Title: "救急の Observation コード ValueSet"
Description: "救急の Observation コード ValueSet。"
* insert AllOf(EmergencyObservationCS)

// ---- 入院の経緯(DPC 様式1 のコードのまま持つ) ----

CodeSystem: DpcAdmissionRouteCS
Id: dpc-admission-route
Title: "入院経路(DPC 様式1)"
Description: "DPC 様式1 の入院経路。入院 Encounter.hospitalization.admitSource に持つのは 0 以外(0 は様式1 の入力でだけ使う)。display は様式1 の定義表の区分名。"
* insert EnumCS
* #0 "院内の他病棟からの転棟"
* #1 "家庭からの入院"
* #4 "他の病院・診療所の病棟からの転院"
* #5 "介護施設・福祉施設に入所中"
* #8 "院内で出生"
* #9 "その他"

ValueSet: DpcAdmissionRouteVS
Id: dpc-admission-route-vs
Title: "入院経路(DPC 様式1) ValueSet"
Description: "入院経路(DPC 様式1) ValueSet。"
* insert AllOf(DpcAdmissionRouteCS)

CodeSystem: DpcAdmissionTypeCS
Id: dpc-admission-type
Title: "予定・救急医療入院(DPC 様式1)"
Description: "DPC 様式1 の予定・救急医療入院の区分(2025 年度版)。入院 Encounter.priority。3** は救急医療入院で、下 2 桁が患者の状態。"
* insert EnumCS
* #100 "予定入院"
* #101 "予定された再入院(悪性腫瘍患者に係る化学療法を実施)"
* #200 "救急医療入院以外の予定外入院"
* #301 "救急医療入院: 吐血、喀血又は重篤な脱水で全身状態不良の状態"
* #302 "救急医療入院: 意識障害又は昏睡"
* #333 "救急医療入院: 呼吸不全で重篤な状態"
* #334 "救急医療入院: 心不全で重篤な状態"
* #304 "救急医療入院: 急性薬物中毒"
* #305 "救急医療入院: ショック"
* #306 "救急医療入院: 重篤な代謝障害(肝不全、腎不全、重症糖尿病等)"
* #307 "救急医療入院: 広範囲熱傷、顔面熱傷又は気道熱傷"
* #308 "救急医療入院: 外傷、破傷風等で重篤な状態"
* #309 "救急医療入院: 緊急手術、緊急カテーテル治療・検査又はt-PA療法を必要とする状態"
* #331 "救急医療入院: 消化器疾患で緊急処置を必要とする重篤な状態"
* #332 "救急医療入院: 蘇生術を必要とする重篤な状態"
* #311 "救急医療入院: 吐血、喀血又は重篤な脱水で全身状態不良の状態に準ずる状態"
* #312 "救急医療入院: 意識障害又は昏睡に準ずる状態"
* #323 "救急医療入院: 呼吸不全で重篤な状態に準ずる状態"
* #324 "救急医療入院: 心不全で重篤な状態に準ずる状態"
* #314 "救急医療入院: 急性薬物中毒に準ずる状態"
* #315 "救急医療入院: ショックに準ずる状態"
* #316 "救急医療入院: 重篤な代謝障害(肝不全、腎不全、重症糖尿病等)に準ずる状態"
* #317 "救急医療入院: 広範囲熱傷、顔面熱傷又は気道熱傷に準ずる状態"
* #318 "救急医療入院: 外傷、破傷風等で重篤な状態に準ずる状態"
* #319 "救急医療入院: 緊急手術、緊急カテーテル治療・検査又はt-PA療法を必要とする状態に準ずる状態"
* #321 "救急医療入院: 消化器疾患で緊急処置を必要とする重篤な状態に準ずる状態"
* #322 "救急医療入院: 蘇生術を必要とする重篤な状態に準ずる状態"
* #320 "救急医療入院: その他の重症な状態"

ValueSet: DpcAdmissionTypeVS
Id: dpc-admission-type-vs
Title: "予定・救急医療入院(DPC 様式1) ValueSet"
Description: "予定・救急医療入院(DPC 様式1) ValueSet。"
* insert AllOf(DpcAdmissionTypeCS)

CodeSystem: EncounterPriorHomeCareCS
Id: encounter-prior-home-care
Title: "入院前の在宅医療(DPC 様式1)"
Description: "DPC 様式1 の入院前の在宅医療の有無(encounter-prior-home-care 拡張の valueCode)。"
* insert EnumCS
* #0 "無"
* #1 "当院が提供"
* #2 "他施設が提供"
* #9 "不明"

ValueSet: EncounterPriorHomeCareVS
Id: encounter-prior-home-care-vs
Title: "入院前の在宅医療(DPC 様式1) ValueSet"
Description: "入院前の在宅医療(DPC 様式1) ValueSet。"
* insert AllOf(EncounterPriorHomeCareCS)
