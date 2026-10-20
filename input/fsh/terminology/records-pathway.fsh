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
Description: "診療記録 Composition.category。nursing = 看護職(看護師・保健師・助産師)が書いた記録で、新規保存のときに付き、編集では保存済みの値を引き継ぐ。看護サマリーの「看護記録」の取り込みはこれで検索する。countersign = 研修医・学生が書いた記録で、指導医のカウンターサインの対象(新規保存のときに付き、編集では引き継ぐ。書いた時点の区分なので後から研修を終えても外れない)。team-round = チーム依頼の回診記録(新規保存のときに付き、event がチーム依頼を指す)。複数を持つことがある。"
* insert EnumCS
* #nursing "看護記録"
* #countersign "カウンターサイン対象"
* #team-round "チーム回診記録"

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

CodeSystem: VitalMeasureCS
Id: vital-measure
Title: "バイタルの測定項目(LOINC に無いもの)"
Description: "LOINC に対応の無いバイタルの測定項目。JCS は看護観察 MEDIS 31001657「意識評価(JCS)」と併記する。"
* insert EnumCS
* #jcs "JCS"

ValueSet: VitalMeasureVS
Id: vital-measure-vs
Title: "バイタルの測定項目 ValueSet"
Description: "バイタルの測定項目 ValueSet。"
* insert AllOf(VitalMeasureCS)

CodeSystem: JcsCS
Id: jcs
Title: "JCS(Japan Coma Scale)"
Description: "意識レベル(JCS)の値。code は JCS の数値、display は桁付きの表記。"
* insert EnumCS
* #0 "0"
* #1 "I-1"
* #2 "I-2"
* #3 "I-3"
* #10 "II-10"
* #20 "II-20"
* #30 "II-30"
* #100 "III-100"
* #200 "III-200"
* #300 "III-300"

ValueSet: JcsVS
Id: jcs-vs
Title: "JCS ValueSet"
Description: "JCS ValueSet。"
* insert AllOf(JcsCS)

CodeSystem: EarlyWarningScoreCS
Id: early-warning-score
Title: "早期警告スコア"
Description: "測定セットから算出して残す早期警告スコアの種類。"
* insert EnumCS
* #news2 "NEWS2"

ValueSet: EarlyWarningScoreVS
Id: early-warning-score-vs
Title: "早期警告スコア ValueSet"
Description: "早期警告スコア ValueSet。"
* insert AllOf(EarlyWarningScoreCS)

CodeSystem: EarlyWarningBandCS
Id: early-warning-band
Title: "早期警告スコアの区分"
Description: "NEWS2 の臨床リスク区分(RCP 2017)。low = 合計 0〜4、low-medium = 合計 0〜4 で単項目 3 点あり、medium = 合計 5〜6、high = 合計 7 以上。"
* insert EnumCS
* #low "低"
* #low-medium "低〜中"
* #medium "中"
* #high "高"

ValueSet: EarlyWarningBandVS
Id: early-warning-band-vs
Title: "早期警告スコアの区分 ValueSet"
Description: "早期警告スコアの区分 ValueSet。"
* insert AllOf(EarlyWarningBandCS)

CodeSystem: OralExamCS
Id: oral-exam
Title: "口腔診査情報の種類"
Description: "口腔診査情報(JDAOES 準拠)の Observation.code。1 回の診査を見出し・歯・現在歯の内容・口腔全体の Observation に分けて書く。"
* insert EnumCS
* #snapshot "口腔診査情報"
* #tooth "歯の診査情報"
* #tooth-content "現在歯の内容"
* #mouth "口腔全体の診査情報"

ValueSet: OralExamVS
Id: oral-exam-vs
Title: "口腔診査情報の種類 ValueSet"
Description: "口腔診査情報の種類 ValueSet。"
* insert AllOf(OralExamCS)

CodeSystem: JdaoesItemCS
Id: jdaoes-item
Title: "口腔診査情報の項目(JDAOES)"
Description: "口腔診査情報の Observation.component.code。日本歯科医師会の口腔診査情報標準規格(JDAOES、表 0003)の項目で、code は項目名からハイフンを除いたもの(TP-11 → TP11)。display はコード表マスタ(backend の oral_exam_codes)の項目名で、マスタに無い自由記載・歯式の項目では項目名(TE-3 など)のまま。値のコード表は JDAS の各表の OID(urn:oid:1.2.392.200354.1.2.…)と MEDIS 標準歯式(urn:oid:1.2.392.200119.4.1401)。"
* insert MasterCS
