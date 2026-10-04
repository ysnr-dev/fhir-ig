// valueCode(system を持たない code 型)で使うコードの一覧。
// アプリはこれらの値を system 無しの code として書くため、CodeSystem の URI は本 IG での定義・バインド用で、
// インスタンスの JSON には現れない。

CodeSystem: MicroExamPurposeCS
Id: micro-exam-purpose
Title: "細菌検査の目的"
Description: "細菌検査の目的のコード。"
* insert EnumCS
* #diagnostic "診断目的"
* #surveillance "監視培養"

ValueSet: MicroExamPurposeVS
Id: micro-exam-purpose-vs
Title: "細菌検査の目的 ValueSet"
Description: "細菌検査の目的 ValueSet。"
* insert AllOf(MicroExamPurposeCS)

CodeSystem: RadiotherapyPhaseStatusCS
Id: radiotherapy-phase-status
Title: "放射線治療フェーズの状態"
Description: "放射線治療フェーズの状態のコード。"
* insert EnumCS
* #active "有効"
* #revoked "取消"

ValueSet: RadiotherapyPhaseStatusVS
Id: radiotherapy-phase-status-vs
Title: "放射線治療フェーズの状態 ValueSet"
Description: "放射線治療フェーズの状態 ValueSet。"
* insert AllOf(RadiotherapyPhaseStatusCS)

CodeSystem: MealTimingCS
Id: meal-timing
Title: "食事のタイミング"
Description: "食事のタイミングのコード。"
* insert EnumCS
* #breakfast "朝"
* #lunch "昼"
* #dinner "夕"

ValueSet: MealTimingVS
Id: meal-timing-vs
Title: "食事のタイミング ValueSet"
Description: "食事のタイミング ValueSet。"
* insert AllOf(MealTimingCS)

CodeSystem: MealFastingReasonCS
Id: meal-fasting-reason
Title: "欠食・食止めの理由"
Description: "欠食(meal-skipped-timing)と、食止めの食種で出した食事オーダーの理由(meal-fasting-reason 拡張の valueCode)。"
* insert EnumCS
* #npo "絶食(NPO)"
* #ope "手術絶食"
* #exam "検査絶食"
* #leave "外泊"
* #discharge "退院"
* #other "その他"

ValueSet: MealFastingReasonVS
Id: meal-fasting-reason-vs
Title: "欠食の理由 ValueSet"
Description: "欠食の理由 ValueSet。"
* insert AllOf(MealFastingReasonCS)

CodeSystem: MealOrderLinkKindCS
Id: meal-order-link-kind
Title: "食事オーダーのつながりの種類"
Description: "食事オーダーのつながりの種類のコード。"
* insert EnumCS
* #start "開始"
* #change "変更"
* #resume "再開"
* #leave-fasting "外泊食止め"

ValueSet: MealOrderLinkKindVS
Id: meal-order-link-kind-vs
Title: "食事オーダーのつながりの種類 ValueSet"
Description: "食事オーダーのつながりの種類 ValueSet。"
* insert AllOf(MealOrderLinkKindCS)

CodeSystem: MealOrderEndReasonCS
Id: meal-order-end-reason
Title: "食事オーダーの終了理由"
Description: "食事オーダーの終了理由のコード。"
* insert EnumCS
* #change "変更"
* #discharge-plan "退院食止め(予定)"
* #discharge "退院食止め"
* #leave "外泊"

ValueSet: MealOrderEndReasonVS
Id: meal-order-end-reason-vs
Title: "食事オーダーの終了理由 ValueSet"
Description: "食事オーダーの終了理由 ValueSet。"
* insert AllOf(MealOrderEndReasonCS)

CodeSystem: BroughtMedicationSubstitutionCS
Id: brought-medication-substitution
Title: "持参薬の院内採用薬"
Description: "持参薬の院内採用薬のコード。"
* insert EnumCS
* #same "同じ薬が院内にある"
* #alternative "院内の代替薬"
* #none "持参分を使う"

ValueSet: BroughtMedicationSubstitutionVS
Id: brought-medication-substitution-vs
Title: "持参薬の院内採用薬 ValueSet"
Description: "持参薬の院内採用薬 ValueSet。"
* insert AllOf(BroughtMedicationSubstitutionCS)

CodeSystem: RegimenDiscontinuationReasonCS
Id: regimen-discontinuation-reason
Title: "レジメン中止理由"
Description: "レジメン中止理由のコード。"
* insert EnumCS
* #progression "病勢進行"
* #adverse-event "有害事象"
* #patient-request "患者希望"
* #change "治療変更"
* #other "その他"

ValueSet: RegimenDiscontinuationReasonVS
Id: regimen-discontinuation-reason-vs
Title: "レジメン中止理由 ValueSet"
Description: "レジメン中止理由 ValueSet。"
* insert AllOf(RegimenDiscontinuationReasonCS)

CodeSystem: TreatmentContextTypeCS
Id: treatment-context-type
Title: "有害事象の治療文脈の種類"
Description: "有害事象の治療文脈の種類のコード。"
* insert EnumCS
* #chemo-regimen "化学療法"
* #radiotherapy "放射線治療"

ValueSet: TreatmentContextTypeVS
Id: treatment-context-type-vs
Title: "有害事象の治療文脈の種類 ValueSet"
Description: "有害事象の治療文脈の種類 ValueSet。"
* insert AllOf(TreatmentContextTypeCS)

CodeSystem: QuestionnaireOrganizationFieldCS
Id: questionnaire-organization-field
Title: "施設情報の自動入力項目"
Description: "施設情報の自動入力項目のコード。"
* insert EnumCS
* #name "名称"
* #institutionNumber "保険医療機関番号"
* #addressFull "郵便番号+所在地"
* #address "所在地"
* #postalCode "郵便番号"
* #phone "電話番号"
* #fax "ＦＡＸ"

ValueSet: QuestionnaireOrganizationFieldVS
Id: questionnaire-organization-field-vs
Title: "施設情報の自動入力項目 ValueSet"
Description: "施設情報の自動入力項目 ValueSet。"
* insert AllOf(QuestionnaireOrganizationFieldCS)

CodeSystem: QuestionnairePractitionerFieldCS
Id: questionnaire-practitioner-field
Title: "医療従事者情報の自動入力項目"
Description: "医療従事者情報の自動入力項目のコード。"
* insert EnumCS
* #name "氏名"
* #kana "氏名(カナ)"
* #medicalRegistrationNumber "医籍登録番号"
* #role "職種"
* #organizationName "所属医療機関名"
* #phone "電話番号"
* #email "メールアドレス"

ValueSet: QuestionnairePractitionerFieldVS
Id: questionnaire-practitioner-field-vs
Title: "医療従事者情報の自動入力項目 ValueSet"
Description: "医療従事者情報の自動入力項目 ValueSet。"
* insert AllOf(QuestionnairePractitionerFieldCS)

CodeSystem: NursingPlanActivityTypeCS
Id: nursing-plan-activity-type
Title: "看護計画の行の区分"
Description: "CarePlan.activity の nursing-plan-activity-type 拡張(valueCode)。"
* insert EnumCS
* #op "OP(観察)"
* #tp "TP(ケア)"
* #ep "EP(教育)"

ValueSet: NursingPlanActivityTypeVS
Id: nursing-plan-activity-type-vs
Title: "看護計画の行の区分 ValueSet"
Description: "看護計画の行の区分 ValueSet。"
* insert AllOf(NursingPlanActivityTypeCS)

CodeSystem: NursingCarePlanEntryCS
Id: nursing-care-plan-entry
Title: "看護計画の立案の入口"
Description: "看護計画 CarePlan の nursing-care-plan-entry 拡張(valueCode)。"
* insert EnumCS
* #standard_plan "標準看護計画"
* #diagnosis "看護診断"

ValueSet: NursingCarePlanEntryVS
Id: nursing-care-plan-entry-vs
Title: "看護計画の立案の入口 ValueSet"
Description: "看護計画の立案の入口 ValueSet。"
* insert AllOf(NursingCarePlanEntryCS)
