// 放射線検査(オーダー明細・実施・読影レポート)の拡張。

Extension: RadExamPurpose
Id: rad-exam-purpose
Title: "検査目的(放射線)"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: RadExamPurposeQuestionnaireResponse
Id: rad-exam-purpose-questionnaire-response
Title: "検査目的テンプレートの記入"
Description: "検査目的をテンプレート(Questionnaire)で記入したときの QuestionnaireResponse。同じ transaction で登録する。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: RadRemarksQuestionnaireResponse
Id: rad-remarks-questionnaire-response
Title: "特別指示テンプレートの記入"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: RadMaterialQuantity
Id: rad-material-quantity
Title: "使用材料の数量(放射線)"
Description: "実施記録 Procedure.usedCode の各材料の数量。unit は院内の単位名(UCUM ではない)。"
Context: Procedure.usedCode
* insert FCMeta
* value[x] only Quantity

Extension: RadReportImage
Id: rad-report-image
Title: "読影レポートの画像"
Description: "レポートに添える画像。source は元画像(Binary)、annotated は注釈を書き込んだ画像(Binary)。画像ごとに繰り返す。"
Context: DiagnosticReport
* insert FCMeta
* extension contains
    source 1..1 and
    annotated 0..1
* extension[source].value[x] only Attachment
* extension[source].valueAttachment.url 1..1
* extension[source].valueAttachment.url ^short = "Binary/{id}"
* extension[source].valueAttachment.title ^short = "キャプション"
* extension[annotated].value[x] only Attachment

Extension: RadCriticalFinding
Id: rad-critical-finding
Title: "重要所見"
Description: "重要所見の要点。付くと rad-critical-finding 通知 Task が依頼医宛に作られる。"
Context: DiagnosticReport
* insert FCMeta
* value[x] only string

Extension: RadReportFindingsResponse
Id: rad-report-findings-response
Title: "所見テンプレートの記入"
Context: DiagnosticReport
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: RadReportConclusionResponse
Id: rad-report-conclusion-response
Title: "診断テンプレートの記入"
Context: DiagnosticReport
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)
