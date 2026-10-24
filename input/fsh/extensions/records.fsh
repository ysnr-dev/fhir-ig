// 診療記録・有害事象・Questionnaire・クリニカルパスの拡張。

Extension: ClinicalNoteSectionQuestionnaireResponse
Id: clinical-note-section-questionnaire-response
Title: "セクションのテンプレート記入"
Description: "診療記録 Composition.section をテンプレートで記入したときの QuestionnaireResponse。"
Context: Composition.section
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: TreatmentContext
Id: treatment-context
Title: "有害事象の治療文脈"
Description: "有害事象がどの治療(レジメン / 放射線治療)のものか。type = 種類、name = レジメン名など、cycle = サイクル(化学療法のみ)。"
Context: Observation
* insert FCMeta
* extension contains
    type 1..1 and
    name 0..1 and
    cycle 0..1
* extension[type].value[x] only code
* extension[type].valueCode from TreatmentContextTypeVS (required)
* extension[name].value[x] only string
* extension[cycle].value[x] only integer

// ---- Questionnaire / QuestionnaireResponse ----

Extension: QuestionnaireTemplateCategory
Id: questionnaire-template-category
Title: "テンプレート分類"
Description: "valueCoding.system = questionnaire-template-category、code = 分類の UUID、display = 分類名。"
Context: Questionnaire
* insert FCMeta
* value[x] only Coding
* valueCoding.system = "http://fhir-client.local/CodeSystem/questionnaire-template-category"

Extension: QuestionnaireOrganizationField
Id: questionnaire-organization-field
Title: "施設情報の自動入力"
Description: "この項目に自院の施設情報のどの値を自動入力するか。"
Context: Questionnaire.item, Questionnaire.item.item
* insert FCMeta
* value[x] only code
* valueCode from QuestionnaireOrganizationFieldVS (required)

Extension: QuestionnairePractitionerField
Id: questionnaire-practitioner-field
Title: "医療従事者情報の自動入力"
Description: "この項目に医療従事者のどの値を自動入力するか。"
Context: Questionnaire.item, Questionnaire.item.item
* insert FCMeta
* value[x] only code
* valueCode from QuestionnairePractitionerFieldVS (required)

Extension: QuestionnairePractitionerRoleDefault
Id: questionnaire-practitioner-role-default
Title: "医療従事者選択の既定職種"
Description: "医療従事者を選ぶ項目の既定の職種(practitioner-role のコード)。"
Context: Questionnaire.item, Questionnaire.item.item
* insert FCMeta
* value[x] only code
* valueCode from PractitionerRoleVS (required)

Extension: QuestionnaireLoginAutofill
Id: questionnaire-login-autofill
Title: "ログイン職員の自動入力"
Description: "true なら、この項目にログイン中の職員を自動入力する。"
Context: Questionnaire.item, Questionnaire.item.item
* insert FCMeta
* value[x] only boolean

Extension: QuestionnaireDocumentForm
Id: questionnaire-document-form
Title: "様式テンプレート"
Description: "様式テンプレートから生成した Questionnaire の元のテンプレート。valueString = backend の document_templates の code(UUID)。"
Context: Questionnaire
* insert FCMeta
* value[x] only string

Extension: QuestionnaireResponseDocument
Id: questionnaire-response-document
Title: "様式文書"
Description: "様式テンプレートで作った文書の回答から、その文書(DocumentReference)を指す。逆向きは DocumentReference.context.related。"
Context: QuestionnaireResponse
* insert FCMeta
* value[x] only Reference(DocumentReference)

Extension: QuestionnaireResponseProblem
Id: questionnaire-response-problem
Title: "記入の対象プロブレム"
Description: "記入の対象プロブレム。"
Context: QuestionnaireResponse
* insert FCMeta
* value[x] only Reference(Condition)

Extension: IntakeSource
Id: intake-source
Title: "回答の出どころ(Web 問診)"
Description: "患者が自分の端末で Web 問診に答え、職員が確認して取り込んだ記入に付く(valueCode = patient)。authored は患者が答えた日時。"
Context: QuestionnaireResponse
* insert FCMeta
* value[x] only code
* valueCode = #patient

Extension: QuestionnaireResponseAnnotatedImage
Id: questionnaire-response-annotated-image
Title: "注釈付き画像(記入)"
Description: "シェーマ項目に書き込んだ画像(image/png)。url は Binary/{id}。"
Context: QuestionnaireResponse.item, QuestionnaireResponse.item.item, QuestionnaireResponse.item.answer.item
* insert FCMeta
* value[x] only Attachment
* valueAttachment.url 1..1

// ---- クリニカルパス ----

Extension: PathwayDisplayOrder
Id: pathway-display-order
Title: "パス要素の表示順"
Description: "上流の id は uuid で並びを持たないため、定義どおりの順を保つ。OAT 単位・アセスメントの CarePlan と、タスクの Procedure に付く。"
Context: CarePlan, Procedure
* insert FCMeta
* value[x] only integer

Extension: PathwayPhase
Id: pathway-phase
Title: "パスのフェーズ"
Description: "病日 CarePlan がどのフェーズのものか(valueCoding.code = phase_key、display = フェーズ名)。印の無い病日は先頭のフェーズ。"
Context: CarePlan
* insert FCMeta
* value[x] only Coding
* valueCoding.system = "http://fhir-client.local/CodeSystem/pathway-phase"

Extension: PathwayPhaseNote
Id: pathway-phase-note
Title: "フェーズ分岐の記録"
Description: "フェーズの最初の病日に残す、分岐を選んだときの記録(目安の写しとコメント)。"
Context: CarePlan
* insert FCMeta
* value[x] only string

Extension: PathwayEvaluationTemplate
Id: pathway-evaluation-template
Title: "評価のテンプレート記入"
Description: "評価 Observation.component(S / O / A / P)をテンプレートで記入したときの QuestionnaireResponse。"
Context: Observation.component
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)
