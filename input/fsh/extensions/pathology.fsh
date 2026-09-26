// 病理検査(オーダー・レポート)の拡張。

Extension: PathoClinicalInfo
Id: patho-clinical-info
Title: "臨床情報(病理)"
Description: "臨床情報(病理)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: PathoClinicalInfoQuestionnaireResponse
Id: patho-clinical-info-questionnaire-response
Title: "臨床情報テンプレートの記入(病理)"
Description: "臨床情報テンプレートの記入(病理)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: PathoReportDue
Id: patho-report-due
Title: "報告希望日"
Description: "報告希望日。"
Context: ServiceRequest
* insert FCMeta
* value[x] only date

Extension: PathoOperatingRoom
Id: patho-operating-room
Title: "手術室(術中迅速)"
Description: "術中迅速のとき、検体を出す手術室(自由記載)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: PathoSchemaImage
Id: patho-schema-image
Title: "シェーマ画像(病理オーダー)"
Description: "採取部位のシェーマ画像(image/png)。url は Binary/{id}。画像ごとに繰り返す。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Attachment
* valueAttachment.contentType = #image/png
* valueAttachment.url 1..1

Extension: PathoReportImage
Id: patho-report-image
Title: "病理レポートの画像"
Description: "レポートに添える画像。kind は種類(肉眼写真 / 切り出し図 / 鏡検写真 / その他)、image は Binary を指す Attachment(title = 説明)。画像ごとに繰り返す。DiagnosticReport.media は Media を要求し上流で扱えないので使わない。"
Context: DiagnosticReport
* insert FCMeta
* extension contains
    kind 1..1 and
    image 1..1
* extension[kind].value[x] only Coding
* extension[kind].valueCoding from PathoReportImageKindVS (required)
* extension[image].value[x] only Attachment
* extension[image].valueAttachment.url 1..1
