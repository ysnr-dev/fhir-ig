// リハビリ・他科依頼・看護指示の CodeSystem。

CodeSystem: RehabDiseaseCategoryCS
Id: rehab-disease-category
Title: "リハビリテーションの疾患別区分"
Description: "リハビリオーダー ServiceRequest.code。診療報酬の疾患別リハビリテーション料の区分。"
* insert EnumCS
* #cardiovascular "心大血管疾患リハビリテーション"
* #cerebrovascular "脳血管疾患等リハビリテーション"
* #disuse "廃用症候群リハビリテーション"
* #musculoskeletal "運動器リハビリテーション"
* #respiratory "呼吸器リハビリテーション"

ValueSet: RehabDiseaseCategoryVS
Id: rehab-disease-category-vs
Title: "リハビリテーションの疾患別区分 ValueSet"
Description: "リハビリテーションの疾患別区分 ValueSet。"
* insert AllOf(RehabDiseaseCategoryCS)

CodeSystem: RehabTherapyTypeCS
Id: rehab-therapy-type
Title: "療法種別"
Description: "リハビリオーダー ServiceRequest.orderDetail と実施記録 Procedure.code。"
* insert EnumCS
* #pt "理学療法(PT)"
* #ot "作業療法(OT)"
* #st "言語聴覚療法(ST)"

ValueSet: RehabTherapyTypeVS
Id: rehab-therapy-type-vs
Title: "療法種別 ValueSet"
Description: "療法種別 ValueSet。"
* insert AllOf(RehabTherapyTypeCS)

CodeSystem: ConsultRequestTypeCS
Id: consult-request-type
Title: "他科依頼の種類"
Description: "他科依頼 ServiceRequest.code。"
* insert EnumCS
* #consult "診察依頼"
* #opinion "意見のみ"
* #exam "検査依頼"
* #transfer "転科相談"

ValueSet: ConsultRequestTypeVS
Id: consult-request-type-vs
Title: "他科依頼の種類 ValueSet"
Description: "他科依頼の種類 ValueSet。"
* insert AllOf(ConsultRequestTypeCS)

CodeSystem: ConsultNoteEventCS
Id: consult-note-event
Title: "診療記録のイベント(他科依頼)"
Description: "他科依頼への回答の Composition.event.code。event.detail が依頼の ServiceRequest を指す。"
* insert EnumCS
* #reply "他科依頼への回答"

ValueSet: ConsultNoteEventVS
Id: consult-note-event-vs
Title: "診療記録のイベント(他科依頼) ValueSet"
Description: "診療記録のイベント(他科依頼) ValueSet。"
* insert AllOf(ConsultNoteEventCS)

CodeSystem: NursingObservationResultCS
Id: nursing-observation-result
Title: "看護観察の結果(MEDIS)"
Description: "code = \"{結果グループコード}-{NN}\"。MEDIS 看護実践用語標準マスタ(看護観察編)の結果選択肢。院内マスタから取り込む。看護観察 Observation.valueCodeableConcept。"
* insert MasterCS

// ---- 看護計画 ----

CodeSystem: NursingDiagnosisCS
Id: nursing-diagnosis
Title: "看護診断(院内マスタ)"
Description: "code = 看護用語マスタ(診断)の用語コード、display = 用語名。看護問題 Condition.code.coding。自由記載の看護問題は code.text のみ。"
* insert MasterCS

CodeSystem: NursingOutcomeCS
Id: nursing-outcome
Title: "看護成果(院内マスタ)"
Description: "code = 看護用語マスタ(成果)の用語コード、display = 用語名。看護計画の目標 Goal.description.coding。"
* insert MasterCS

CodeSystem: NursingInterventionCS
Id: nursing-intervention
Title: "看護介入(院内マスタ)"
Description: "code = 看護用語マスタ(介入)の用語コード、display = 用語名。CarePlan.activity の nursing-intervention 拡張。"
* insert MasterCS

CodeSystem: NursingDefiningCharacteristicCS
Id: nursing-defining-characteristic
Title: "看護診断の診断指標(院内マスタ)"
Description: "code = 看護診断の付随項目(診断指標)のコード。看護問題 Condition.evidence.code。自由記載は system だけの coding + text。"
* insert MasterCS

CodeSystem: NursingRelatedFactorCS
Id: nursing-related-factor
Title: "看護診断の関連因子(院内マスタ)"
Description: "code = 看護診断の付随項目(関連因子)のコード。看護問題 Condition.evidence.code。自由記載は system だけの coding + text。"
* insert MasterCS

CodeSystem: NursingRiskFactorCS
Id: nursing-risk-factor
Title: "看護診断の危険因子(院内マスタ)"
Description: "code = 看護診断の付随項目(危険因子)のコード。看護問題 Condition.evidence.code。自由記載は system だけの coding + text。"
* insert MasterCS

CodeSystem: NursingEvaluationCS
Id: nursing-evaluation
Title: "看護計画の評価"
Description: "看護計画の評価 Observation.code。goal = 目標ごとの評価(focus = Goal)、problem = 看護問題単位の判定(focus = Condition)。"
* insert EnumCS
* #goal "目標の評価"
* #problem "看護問題の評価"

ValueSet: NursingEvaluationVS
Id: nursing-evaluation-vs
Title: "看護計画の評価 ValueSet"
Description: "看護計画の評価 ValueSet。"
* insert AllOf(NursingEvaluationCS)

CodeSystem: NursingEvaluationDecisionCS
Id: nursing-evaluation-decision
Title: "看護問題の判定"
Description: "看護問題の評価 Observation.valueCodeableConcept。resolve で看護問題を resolved、計画を completed にする。"
* insert EnumCS
* #continue "継続"
* #revise "修正"
* #resolve "解決"

ValueSet: NursingEvaluationDecisionVS
Id: nursing-evaluation-decision-vs
Title: "看護問題の判定 ValueSet"
Description: "看護問題の判定 ValueSet。"
* insert AllOf(NursingEvaluationDecisionCS)

// ---- 看護サマリー ----

CodeSystem: NursingSummaryKindCS
Id: nursing-summary-kind
Title: "看護サマリーの区分"
Description: "看護サマリー Composition.category。"
* insert EnumCS
* #interim "中間"
* #transfer "転棟"
* #discharge "退院"

ValueSet: NursingSummaryKindVS
Id: nursing-summary-kind-vs
Title: "看護サマリーの区分 ValueSet"
Description: "看護サマリーの区分 ValueSet。"
* insert AllOf(NursingSummaryKindCS)

CodeSystem: NursingSummarySectionCS
Id: nursing-summary-section
Title: "看護サマリーのセクション"
Description: "看護サマリー Composition.section.code のうち、LOINC に一致するコードを確認できていないセクション。display はアプリが書く英語の表示名(section.title が日本語の見出し)。既往歴だけは LOINC 11348-0。"
* insert EnumCS
* #basic "Basic information"
* #conditions "Conditions"
* #nursing-problems "Nursing problems"
* #nursing-course "Nursing course"
* #current-status "Current status"
* #continuing-care "Continuing nursing care"

ValueSet: NursingSummarySectionVS
Id: nursing-summary-section-vs
Title: "看護サマリーのセクション ValueSet"
Description: "看護サマリーのセクション ValueSet。"
* insert AllOf(NursingSummarySectionCS)
