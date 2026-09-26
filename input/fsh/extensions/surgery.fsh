// 手術(オーダー・実施)の拡張。

Extension: SurgeryDuration
Id: surgery-duration
Title: "予定所要時間"
Description: "valueQuantity {value, unit \"分\"}。system は持たない。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Quantity

Extension: SurgeryRoom
Id: surgery-room
Title: "手術室"
Description: "手術室。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(Location)

Extension: SurgeryDepartment
Id: surgery-department
Title: "執刀科"
Description: "手術を行う診療科(依頼科と違うことがある)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(Organization)

Extension: SurgeryPosition
Id: surgery-position
Title: "体位"
Description: "体位。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Coding
* valueCoding from SurgeryPositionVS (required)

Extension: SurgeryEstimatedBloodLoss
Id: surgery-estimated-blood-loss
Title: "予想出血量"
Description: "valueQuantity {value, unit \"mL\"}。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Quantity

Extension: SurgeryStaff
Id: surgery-staff
Title: "手術スタッフ"
Description: "予定スタッフ。役割と人。スタッフごとに繰り返す。"
Context: ServiceRequest
* insert FCMeta
* extension contains
    role 1..1 and
    member 1..1
* extension[role].value[x] only Coding
* extension[role].valueCoding from SurgeryStaffRoleVS (required)
* extension[member].value[x] only Reference(Practitioner)

Extension: SurgeryAnesthesiaMethod
Id: surgery-anesthesia-method
Title: "麻酔方法"
Description: "複数可(併用)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Coding
* valueCoding from SurgeryAnesthesiaMethodVS (required)

Extension: SurgeryAnesthesiaManagement
Id: surgery-anesthesia-management
Title: "麻酔管理"
Description: "麻酔管理。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Coding
* valueCoding from SurgeryAnesthesiaManagementVS (required)

Extension: SurgeryBloodPreparation
Id: surgery-blood-preparation
Title: "輸血準備"
Description: "type = 準備の種類、units = 準備単位数(unit \"単位\")。"
Context: ServiceRequest
* insert FCMeta
* extension contains
    type 1..1 and
    units 0..1
* extension[type].value[x] only Coding
* extension[type].valueCoding from SurgeryBloodPreparationVS (required)
* extension[units].value[x] only Quantity

Extension: SurgeryEquipment
Id: surgery-equipment
Title: "使用機器"
Description: "複数可。other のとき自由記載を display に入れる。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Coding
* valueCoding from SurgeryEquipmentVS (required)

Extension: SurgerySpecimenPlan
Id: surgery-specimen-plan
Title: "検体の予定"
Description: "複数可。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Coding
* valueCoding from SurgerySpecimenPlanVS (required)

Extension: SurgeryConsent
Id: surgery-consent
Title: "取得済みの同意書"
Description: "複数可。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Coding
* valueCoding from SurgeryConsentVS (required)

Extension: SurgeryPreopInstruction
Id: surgery-preop-instruction
Title: "術前指示"
Description: "術前指示。"
Context: ServiceRequest
* insert FCMeta
* value[x] only string

Extension: SurgeryPreopInstructionQuestionnaireResponse
Id: surgery-preop-instruction-questionnaire-response
Title: "術前指示テンプレートの記入"
Description: "術前指示テンプレートの記入。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: SurgeryApproach
Id: surgery-approach
Title: "アプローチ"
Description: "術式明細 ServiceRequest に付く。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Coding
* valueCoding from SurgeryApproachVS (required)

Extension: SurgeryMaterialQuantity
Id: surgery-material-quantity
Title: "使用材料の数量(手術)"
Description: "使用材料の数量(手術)。"
Context: Procedure.usedCode
* insert FCMeta
* value[x] only Quantity

Extension: SurgeryPerformTimes
Id: surgery-perform-times
Title: "手術の各時刻"
Description: "麻酔開始 / 執刀開始 / 執刀終了 / 麻酔終了。入退室は Procedure.performedPeriod。"
Context: Procedure
* insert FCMeta
* extension contains
    anesthesia-start 0..1 and
    incision-start 0..1 and
    incision-end 0..1 and
    anesthesia-end 0..1
* extension[anesthesia-start].value[x] only dateTime
* extension[anesthesia-start] ^short = "麻酔開始"
* extension[incision-start].value[x] only dateTime
* extension[incision-start] ^short = "執刀開始"
* extension[incision-end].value[x] only dateTime
* extension[incision-end] ^short = "執刀終了"
* extension[anesthesia-end].value[x] only dateTime
* extension[anesthesia-end] ^short = "麻酔終了"

Extension: SurgeryWoundClass
Id: surgery-wound-class
Title: "創分類"
Description: "創分類。"
Context: Procedure
* insert FCMeta
* value[x] only Coding
* valueCoding from SurgeryWoundClassVS (required)

Extension: SurgeryCountCheck
Id: surgery-count-check
Title: "カウント確認"
Description: "カウント確認。"
Context: Procedure
* insert FCMeta
* value[x] only Coding
* valueCoding from SurgeryCountCheckVS (required)
