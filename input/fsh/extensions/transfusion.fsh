// 輸血(オーダー・実施)の拡張。

Extension: TransfusionAbo
Id: transfusion-abo
Title: "ABO 血液型(輸血オーダー)"
Context: ServiceRequest
* insert FCMeta
* value[x] only CodeableConcept
* valueCodeableConcept from TransfusionAboVS (required)

Extension: TransfusionRhd
Id: transfusion-rhd
Title: "RhD 血液型(輸血オーダー)"
Context: ServiceRequest
* insert FCMeta
* value[x] only CodeableConcept
* valueCodeableConcept from TransfusionRhdVS (required)

Extension: TransfusionConsent
Id: transfusion-consent
Title: "輸血同意"
Description: "同意取得済みなら true。"
Context: ServiceRequest
* insert FCMeta
* value[x] only boolean

Extension: TransfusionLotNumber
Id: transfusion-lot-number
Title: "製剤のロット番号"
Description: "投与した製剤(バッグ)のロット番号。MedicationAdministration に付く。"
Context: MedicationAdministration
* insert FCMeta
* value[x] only string
