// 内視鏡・生理検査・処置の拡張(放射線と同形)。

Extension: EndoscopyExamPurpose
Id: endoscopy-exam-purpose
Title: "検査目的(内視鏡)"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: EndoscopyExamPurposeQuestionnaireResponse
Id: endoscopy-exam-purpose-questionnaire-response
Title: "検査目的テンプレートの記入(内視鏡)"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: EndoscopyRemarksQuestionnaireResponse
Id: endoscopy-remarks-questionnaire-response
Title: "特別指示テンプレートの記入(内視鏡)"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: EndoscopyMaterialQuantity
Id: endoscopy-material-quantity
Title: "使用材料の数量(内視鏡)"
Context: Procedure.usedCode
* insert FCMeta
* value[x] only Quantity

Extension: PhysioExamPurpose
Id: physio-exam-purpose
Title: "検査目的(生理検査)"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: PhysioExamPurposeQuestionnaireResponse
Id: physio-exam-purpose-questionnaire-response
Title: "検査目的テンプレートの記入(生理検査)"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: PhysioRemarksQuestionnaireResponse
Id: physio-remarks-questionnaire-response
Title: "特別指示テンプレートの記入(生理検査)"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: PhysioMaterialQuantity
Id: physio-material-quantity
Title: "使用材料の数量(生理検査)"
Context: Procedure.usedCode
* insert FCMeta
* value[x] only Quantity

Extension: TreatmentMaterialQuantity
Id: treatment-material-quantity
Title: "使用材料の数量(処置)"
Context: Procedure.usedCode
* insert FCMeta
* value[x] only Quantity
