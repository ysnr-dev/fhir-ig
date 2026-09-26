// 放射線治療(処方・照射・コース要約)の拡張。mCODE Radiotherapy を模した設計。

Extension: RadiotherapyCourse
Id: radiotherapy-course
Title: "放射線治療コース"
Description: """治療コースの処方内容と状態。放射線治療 ServiceRequest に 1 件。

endedOn / terminationReason / terminationNote は終了時、suspendedOn / suspensionReason / suspensionNote は休止時に Task と一緒に書かれる。"""
Context: ServiceRequest
* insert FCMeta
* extension contains
    courseNumber 1..1 and
    intent 1..1 and
    concurrentTherapy 0..1 and
    protocol 0..1 and
    endedOn 0..1 and
    terminationReason 0..1 and
    terminationNote 0..1 and
    suspendedOn 0..1 and
    suspensionReason 0..1 and
    suspensionNote 0..1
* extension[courseNumber].value[x] only integer
* extension[intent].value[x] only Coding
* extension[intent].valueCoding from RadiotherapyIntentVS (required)
* extension[concurrentTherapy].value[x] only Coding
* extension[concurrentTherapy].valueCoding from RadiotherapyConcurrentTherapyVS (required)
* extension[protocol].value[x] only Coding
* extension[protocol].valueCoding.system = "http://fhir-client.local/CodeSystem/radiotherapy-protocol"
* extension[endedOn].value[x] only date
* extension[terminationReason].value[x] only Coding
* extension[terminationReason].valueCoding.system = "http://fhir-client.local/CodeSystem/radiotherapy-stop-reason"
* extension[terminationNote].value[x] only string
* extension[suspendedOn].value[x] only date
* extension[suspensionReason].value[x] only Coding
* extension[suspensionReason].valueCoding.system = "http://fhir-client.local/CodeSystem/radiotherapy-stop-reason"
* extension[suspensionNote].value[x] only string

Extension: RadiotherapyVolume
Id: radiotherapy-volume
Title: "標的体積"
Description: "標的体積(GTV / CTV / PTV など)。体積ごとに繰り返す。volumeId はフェーズの dosePrescribedToVolume.volume から参照される。"
Context: ServiceRequest
* insert FCMeta
* extension contains
    volumeId 1..1 and
    label 1..1 and
    type 1..1 and
    bodySite 0..1 and
    description 0..1
* extension[volumeId].value[x] only string
* extension[label].value[x] only string
* extension[type].value[x] only Coding
* extension[type].valueCoding from RadiotherapyVolumeTypeVS (required)
* extension[bodySite].value[x] only CodeableConcept
* extension[description].value[x] only string

Extension: RadiotherapyPhase
Id: radiotherapy-phase
Title: "放射線治療フェーズ"
Description: "照射のフェーズ(処方線量・分割・装置)。フェーズごとに繰り返す。modalityAndTechnique と dosePrescribedToVolume は 2 段目の複合拡張。線量の単位は Gy(UCUM)。"
Context: ServiceRequest
* insert FCMeta
* extension contains
    phaseId 1..1 and
    number 1..1 and
    label 0..1 and
    status 1..1 and
    modalityAndTechnique 1..1 and
    fractionsPrescribed 1..1 and
    device 0..1 and
    fractionsPerWeek 0..1 and
    dosePrescribedToVolume 0..*
* extension[phaseId].value[x] only string
* extension[number].value[x] only integer
* extension[label].value[x] only string
* extension[status].value[x] only code
* extension[status].valueCode from RadiotherapyPhaseStatusVS (required)
* extension[modalityAndTechnique].value[x] 0..0
* extension[modalityAndTechnique].extension contains
    modality 1..1 and
    technique 1..1
* extension[modalityAndTechnique].extension[modality].value[x] only CodeableConcept
* extension[modalityAndTechnique].extension[modality].valueCodeableConcept.coding.system = "http://fhir-client.local/CodeSystem/radiotherapy-modality"
* extension[modalityAndTechnique].extension[technique].value[x] only CodeableConcept
* extension[modalityAndTechnique].extension[technique].valueCodeableConcept.coding.system = "http://fhir-client.local/CodeSystem/radiotherapy-technique"
* extension[fractionsPrescribed].value[x] only unsignedInt
* extension[device].value[x] only CodeableConcept
* extension[device].valueCodeableConcept.coding.system = "http://fhir-client.local/CodeSystem/radiotherapy-device"
* extension[fractionsPerWeek].value[x] only integer
* extension[dosePrescribedToVolume].value[x] 0..0
* extension[dosePrescribedToVolume].extension contains
    volume 1..1 and
    fractionDose 1..1 and
    totalDose 1..1
* extension[dosePrescribedToVolume].extension[volume].value[x] only string
* extension[dosePrescribedToVolume].extension[volume] ^short = "radiotherapy-volume の volumeId"
* extension[dosePrescribedToVolume].extension[fractionDose].value[x] only Quantity
* extension[dosePrescribedToVolume].extension[fractionDose].valueQuantity.system = $ucum
* extension[dosePrescribedToVolume].extension[fractionDose].valueQuantity.code = #Gy
* extension[dosePrescribedToVolume].extension[totalDose].value[x] only Quantity
* extension[dosePrescribedToVolume].extension[totalDose].valueQuantity.system = $ucum
* extension[dosePrescribedToVolume].extension[totalDose].valueQuantity.code = #Gy

Extension: RadiotherapyConsultRequest
Id: radiotherapy-consult-request
Title: "元になった他科依頼"
Description: "放射線治療科への他科依頼(ServiceRequest)から作った処方のとき、その依頼。basedOn ではなく拡張で持つ。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(ServiceRequest)

Extension: RadiotherapyFraction
Id: radiotherapy-fraction
Title: "照射の実施内容"
Description: "照射 1 回の実施内容。phaseId は処方のフェーズ、fractionNumber は通算の照射回数。doseDeliveredToVolume は体積ごとに繰り返す(volume = volumeId、dose は Gy)。"
Context: Procedure
* insert FCMeta
* extension contains
    phaseId 1..1 and
    fractionNumber 1..1 and
    imageGuidance 0..1 and
    doseDeliveredToVolume 0..*
* extension[phaseId].value[x] only string
* extension[fractionNumber].value[x] only integer
* extension[imageGuidance].value[x] only Coding
* extension[imageGuidance].valueCoding from RadiotherapyImageGuidanceVS (required)
* extension[doseDeliveredToVolume].value[x] 0..0
* extension[doseDeliveredToVolume].extension contains
    volume 1..1 and
    dose 1..1
* extension[doseDeliveredToVolume].extension[volume].value[x] only string
* extension[doseDeliveredToVolume].extension[dose].value[x] only Quantity
* extension[doseDeliveredToVolume].extension[dose].valueQuantity.system = $ucum
* extension[doseDeliveredToVolume].extension[dose].valueQuantity.code = #Gy

Extension: RadiotherapyCourseSummary
Id: radiotherapy-course-summary
Title: "放射線治療コース要約"
Description: "コース終了時の要約。terminationReason は中止理由マスタの Coding か自由記載(string)。"
Context: Procedure
* insert FCMeta
* extension contains
    fractionsDelivered 1..1 and
    fractionsPrescribed 0..1 and
    doseDeliveredToVolume 0..* and
    terminationReason 0..1 and
    terminationNote 0..1 and
    progressNote 0..1 and
    adverseEvents 0..1 and
    followUpPlan 0..1
* extension[fractionsDelivered].value[x] only integer
* extension[fractionsPrescribed].value[x] only integer
* extension[doseDeliveredToVolume].value[x] 0..0
* extension[doseDeliveredToVolume].extension contains
    volume 1..1 and
    dose 1..1 and
    fractions 0..1
* extension[doseDeliveredToVolume].extension[volume].value[x] only string
* extension[doseDeliveredToVolume].extension[dose].value[x] only Quantity
* extension[doseDeliveredToVolume].extension[fractions].value[x] only integer
* extension[terminationReason].value[x] only Coding or string
* extension[terminationNote].value[x] only string
* extension[progressNote].value[x] only string
* extension[adverseEvents].value[x] only string
* extension[followUpPlan].value[x] only string
