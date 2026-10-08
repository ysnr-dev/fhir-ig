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

CodeSystem: ClinicalNoteCategoryCS
Id: clinical-note-category
Title: "診療記録の区分"
Description: "診療記録 Composition.category。nursing = 看護職(看護師・保健師・助産師)が書いた記録で、新規保存のときに付き、編集では保存済みの値を引き継ぐ。看護サマリーの「看護記録」の取り込みはこれで検索する。countersign = 研修医・学生が書いた記録で、指導医のカウンターサインの対象(新規保存のときに付き、編集では引き継ぐ。書いた時点の区分なので後から研修を終えても外れない)。両方を持つことがある。"
* insert EnumCS
* #nursing "看護記録"
* #countersign "カウンターサイン対象"

ValueSet: ClinicalNoteCategoryVS
Id: clinical-note-category-vs
Title: "診療記録の区分 ValueSet"
Description: "診療記録の区分 ValueSet。"
* insert AllOf(ClinicalNoteCategoryCS)

CodeSystem: DocumentTypeCS
Id: document-type
Title: "文書の種類(独自)"
Description: "Composition.type のうち、一致する LOINC を確認できていない文書の種類。"
* insert EnumCS
* #nursing-summary "看護サマリー"

ValueSet: DocumentTypeVS
Id: document-type-vs
Title: "文書の種類(独自) ValueSet"
Description: "文書の種類(独自) ValueSet。"
* insert AllOf(DocumentTypeCS)

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
Description: "CarePlan.category の先頭、および評価 Observation.category の先頭。nursing は看護計画の CarePlan・Goal・評価 Observation の category。"
* insert EnumCS
* #clinical-pathway "クリニカルパス"
* #nursing "看護計画"

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

// ---- DPC の診断群分類 ----

CodeSystem: DpcCodeCS
Id: dpc-code
Title: "診断群分類(DPC コード)"
Description: "診断群分類の 14 桁(060330xx02xxxx など)。backend のマスタ(DPC 電子点数表の診断群分類点数表を版ごとに取込んだもの)にある。display = 傷病名と、手術・処置等1・処置等2・定義副傷病・重症度のうち「なし」でないものの名称を「 / 」で繋いだもの。"
* insert MasterCS

CodeSystem: DpcCodingTimingCS
Id: dpc-coding-timing
Title: "診断群分類を決めた時点"
Description: "診断群分類の決定の記録の timing。転棟時・退院時の決定を保存すると、その入院の未対応の DPC 再判定の督促が閉じる。"
* insert EnumCS
* #admission "入院時"
* #transfer "転棟時"
* #monthly "月末"
* #discharge "退院時"
* #other "その他"

ValueSet: DpcCodingTimingVS
Id: dpc-coding-timing-vs
Title: "診断群分類を決めた時点 ValueSet"
Description: "診断群分類を決めた時点 ValueSet。"
* insert AllOf(DpcCodingTimingCS)
