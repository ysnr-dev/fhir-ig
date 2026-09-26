// 患者・管理リソース(Condition / Flag / Location / PractitionerRole / Encounter / 予約)の CodeSystem。

CodeSystem: ConditionCategoryCS
Id: condition-category
Title: "病名カテゴリ(既往歴)"
Description: "既往歴の Condition に、HL7 の problem-list-item と併せて付ける 2 つ目の category。"
* insert EnumCS
* #past-history "既往歴"

ValueSet: ConditionCategoryVS
Id: condition-category-vs
Title: "病名カテゴリ(既往歴) ValueSet"
Description: "病名カテゴリ(既往歴) ValueSet。"
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
* #icu "ICU"
* #hcu "HCU"
* #ccu "CCU"
* #scu "SCU"

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
