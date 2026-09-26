// 細菌検査オーダーの拡張(ヘッダ ServiceRequest)。

Extension: MicroPriorAntimicrobial
Id: micro-prior-antimicrobial
Title: "先行抗菌薬"
Description: "検体採取前に投与していた抗菌薬(自由記載)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: MicroExamPurpose
Id: micro-exam-purpose
Title: "細菌検査の目的"
Description: "diagnostic 診断目的 / surveillance 監視培養。valueCode(system 無し)。既定は diagnostic。"
Context: ServiceRequest
* insert FCMeta
* value[x] only code
* valueCode from MicroExamPurposeVS (required)
