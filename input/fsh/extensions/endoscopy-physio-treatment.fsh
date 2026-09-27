// 内視鏡・生理検査・処置の拡張(放射線と同形)。所見レポートの拡張は末尾(読影レポートと同形)。

Extension: EndoscopyExamPurpose
Id: endoscopy-exam-purpose
Title: "検査目的(内視鏡)"
Description: "検査目的(内視鏡)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: EndoscopyExamPurposeQuestionnaireResponse
Id: endoscopy-exam-purpose-questionnaire-response
Title: "検査目的テンプレートの記入(内視鏡)"
Description: "検査目的テンプレートの記入(内視鏡)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: EndoscopyRemarksQuestionnaireResponse
Id: endoscopy-remarks-questionnaire-response
Title: "特別指示テンプレートの記入(内視鏡)"
Description: "特別指示テンプレートの記入(内視鏡)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: EndoscopyMaterialQuantity
Id: endoscopy-material-quantity
Title: "使用材料の数量(内視鏡)"
Description: "使用材料の数量(内視鏡)。"
Context: Procedure.usedCode
* insert FCMeta
* value[x] only Quantity

Extension: PhysioExamPurpose
Id: physio-exam-purpose
Title: "検査目的(生理検査)"
Description: "検査目的(生理検査)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: PhysioExamPurposeQuestionnaireResponse
Id: physio-exam-purpose-questionnaire-response
Title: "検査目的テンプレートの記入(生理検査)"
Description: "検査目的テンプレートの記入(生理検査)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: PhysioRemarksQuestionnaireResponse
Id: physio-remarks-questionnaire-response
Title: "特別指示テンプレートの記入(生理検査)"
Description: "特別指示テンプレートの記入(生理検査)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: PhysioMaterialQuantity
Id: physio-material-quantity
Title: "使用材料の数量(生理検査)"
Description: "使用材料の数量(生理検査)。"
Context: Procedure.usedCode
* insert FCMeta
* value[x] only Quantity

Extension: TreatmentMaterialQuantity
Id: treatment-material-quantity
Title: "使用材料の数量(処置)"
Description: "使用材料の数量(処置)。"
Context: Procedure.usedCode
* insert FCMeta
* value[x] only Quantity

// ---- 生理検査 所見レポート ----

Extension: PhysioReportImage
Id: physio-report-image
Title: "生理検査 所見レポートの画像"
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

Extension: PhysioCriticalFinding
Id: physio-critical-finding
Title: "重要所見(生理検査)"
Description: "重要所見の要点。付くと physio-critical-finding 通知 Task が依頼医宛に作られる。"
Context: DiagnosticReport
* insert FCMeta
* value[x] only string

Extension: PhysioReportFindingsResponse
Id: physio-report-findings-response
Title: "所見テンプレートの記入(生理検査)"
Description: "所見テンプレートの記入。"
Context: DiagnosticReport
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: PhysioReportConclusionResponse
Id: physio-report-conclusion-response
Title: "判定テンプレートの記入(生理検査)"
Description: "判定テンプレートの記入。"
Context: DiagnosticReport
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

// ---- 内視鏡 所見レポート ----

Extension: EndoscopyReportImage
Id: endoscopy-report-image
Title: "内視鏡 所見レポートの画像"
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

Extension: EndoscopyCriticalFinding
Id: endoscopy-critical-finding
Title: "重要所見(内視鏡)"
Description: "重要所見の要点。付くと endoscopy-critical-finding 通知 Task が依頼医宛に作られる。"
Context: DiagnosticReport
* insert FCMeta
* value[x] only string

Extension: EndoscopyReportFindingsResponse
Id: endoscopy-report-findings-response
Title: "所見テンプレートの記入(内視鏡)"
Description: "所見テンプレートの記入。"
Context: DiagnosticReport
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: EndoscopyReportConclusionResponse
Id: endoscopy-report-conclusion-response
Title: "診断テンプレートの記入(内視鏡)"
Description: "診断テンプレートの記入。"
Context: DiagnosticReport
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)
