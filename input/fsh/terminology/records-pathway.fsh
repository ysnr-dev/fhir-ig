// 診療記録・テンプレート・有害事象・クリニカルパスの CodeSystem。

CodeSystem: ObservationCategoryCS
Id: observation-category
Title: "Observation のカテゴリ(独自)"
Description: "HL7 の observation-category に無いカテゴリ。有害事象 Observation.category に使う。system が HL7 と異なることに注意。"
* insert EnumCS
* #adverse-event "有害事象"

ValueSet: ObservationCategoryVS
Id: observation-category-vs
Title: "Observation のカテゴリ(独自) ValueSet"
Description: "Observation のカテゴリ(独自) ValueSet。"
* insert AllOf(ObservationCategoryCS)

CodeSystem: ObservationItemCS
Id: observation-item
Title: "テンプレート項目コード"
Description: "Questionnaire.item.code に付け、抽出した Observation.code になる項目コード。歯科(DENT-*)や心不全(HF-*)など、テンプレートごとに定義する。チャート定義のプリセットも参照する。"
* insert MasterCS

CodeSystem: QuestionnaireTemplateCategoryCS
Id: questionnaire-template-category
Title: "テンプレート分類(院内マスタ)"
Description: "code = backend の questionnaire_categories の UUID。Questionnaire の questionnaire-template-category 拡張。"
* insert MasterCS

CodeSystem: CarePlanTypeCS
Id: care-plan-type
Title: "CarePlan の種類"
Description: "CarePlan.category の先頭、および評価 Observation.category の先頭。"
* insert EnumCS
* #clinical-pathway "クリニカルパス"

ValueSet: CarePlanTypeVS
Id: care-plan-type-vs
Title: "CarePlan の種類 ValueSet"
Description: "CarePlan の種類 ValueSet。"
* insert AllOf(CarePlanTypeCS)

CodeSystem: PathwayLevelCS
Id: pathway-level
Title: "パスの階層"
Description: "クリニカルパスの CarePlan 木の階層(適用 → 病日 → OAT 単位 → アセスメント)。CarePlan.category の 2 番目。"
* insert EnumCS
* #apply "適用"
* #event "病日"
* #oat-unit "OAT 単位"
* #assessment "アセスメント"

ValueSet: PathwayLevelVS
Id: pathway-level-vs
Title: "パスの階層 ValueSet"
Description: "パスの階層 ValueSet。"
* insert AllOf(PathwayLevelCS)

CodeSystem: PathwayPhaseCS
Id: pathway-phase
Title: "パスのフェーズ"
Description: "code = パス定義の phase_key、display = フェーズ名。病日 CarePlan の pathway-phase 拡張。"
* insert MasterCS
