// 手術・リハビリ・他科依頼・看護指示・食事・輸血・栄養指導のオーダーの例。

Instance: example-surgery-room
InstanceOf: FC_Room
Usage: #example
Title: "手術室の例"
Description: "手術室の例"
* status = #active
* name = "手術室 1"
* mode = #instance
* type = $v3-RoleCode#SU "手術室"
* physicalType = $location-physical-type#ro
* managingOrganization = Reference(Organization/example-organization)
* extension[displayOrder].valueInteger = 1

Instance: example-surgery-order-header
InstanceOf: FC_SurgeryOrderHeader
Usage: #example
Title: "手術オーダー ヘッダの例"
Description: "手術オーダー ヘッダの例"
* status = #active
* intent = #order
* priority = #routine
* category[orderType] = $order-type#surgery "手術"
* category[setting] = $prescription-setting#inpatient "入院"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T15:00:00+09:00"
* occurrenceDateTime = "2026-04-08T09:00:00+09:00"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderWard].valueReference = Reference(Location/example-ward)
* extension[duration].valueQuantity.value = 120
* extension[duration].valueQuantity.unit = "分"
* extension[room].valueReference = Reference(Location/example-surgery-room)
* extension[department].valueReference = Reference(Organization/example-department)
* extension[position].valueCoding = http://fhir-client.local/CodeSystem/surgery-position#supine "仰臥位"
* extension[estimatedBloodLoss].valueQuantity.value = 100
* extension[estimatedBloodLoss].valueQuantity.unit = "mL"
* extension[staff][0].extension[role].valueCoding = http://fhir-client.local/CodeSystem/surgery-staff-role#surgeon "執刀医"
* extension[staff][0].extension[member].valueReference = Reference(Practitioner/example-practitioner)
* extension[anesthesiaMethod][0].valueCoding = http://fhir-client.local/CodeSystem/surgery-anesthesia-method#general-inhalation "全身麻酔(吸入)"
* extension[anesthesiaManagement].valueCoding = http://fhir-client.local/CodeSystem/surgery-anesthesia-management#anesthesiologist "麻酔科管理"
* extension[bloodPreparation].extension[type].valueCoding = http://fhir-client.local/CodeSystem/surgery-blood-preparation#type-screen "T&S"
* extension[equipment][0].valueCoding = http://fhir-client.local/CodeSystem/surgery-equipment#stapler "自動縫合器"
* extension[specimenPlan][0].valueCoding = http://fhir-client.local/CodeSystem/surgery-specimen-plan#permanent "永久標本"
* extension[consent][0].valueCoding = http://fhir-client.local/CodeSystem/surgery-consent#surgery "手術同意書"
* extension[consent][1].valueCoding = http://fhir-client.local/CodeSystem/surgery-consent#anesthesia "麻酔同意書"
* extension[preopInstruction].valueString = "前日 21 時以降絶食"

Instance: example-surgery-order-item
InstanceOf: FC_SurgeryOrderItem
Usage: #example
Title: "手術オーダー 術式明細の例"
Description: "手術オーダー 術式明細の例"
* status = #active
* intent = #order
* identifier.system = "http://fhir-client.local/IdSystem/surgery-order-item-number"
* identifier.value = "1"
* basedOn = Reference(ServiceRequest/example-surgery-order-header)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-01T15:00:00+09:00"
* occurrenceDateTime = "2026-04-08T09:00:00+09:00"
* code.coding[item] = http://fhir-client.local/CodeSystem/surgery-order-item#150323510 "腹腔鏡下胃切除術（悪性腫瘍手術）"
* code.coding[procedureCode] = http://fhir-client.local/CodeSystem/surgery-procedure-code#150323510
* code.text = "腹腔鏡下胃切除術（悪性腫瘍手術）"
* reasonReference = Reference(Condition/example-condition)
* extension[approach].valueCoding = http://fhir-client.local/CodeSystem/surgery-approach#laparoscopic "腹腔鏡"

Instance: example-rehab-order
InstanceOf: FC_RehabOrder
Usage: #example
Title: "リハビリオーダーの例"
Description: "リハビリオーダーの例"
* status = #active
* intent = #order
* category[orderType] = $order-type#rehab "リハビリ"
* category[setting] = $prescription-setting#inpatient "入院"
* code = http://fhir-client.local/CodeSystem/rehab-disease-category#musculoskeletal "運動器リハビリテーション"
* orderDetail[0] = http://fhir-client.local/CodeSystem/rehab-therapy-type#pt "理学療法(PT)"
* orderDetail[1] = http://fhir-client.local/CodeSystem/rehab-therapy-type#ot "作業療法(OT)"
* quantityQuantity.value = 2
* quantityQuantity.unit = "単位"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-09T10:00:00+09:00"
* occurrenceDateTime = "2026-04-10"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderWard].valueReference = Reference(Location/example-ward)
* extension[orderEnd].valueDate = "2026-05-09"
* extension[onsetDate].valueDate = "2026-04-08"
* extension[targetDisease].valueString = "術後廃用"
* extension[frequencyPerWeek].valueInteger = 5

Instance: example-consult-order
InstanceOf: FC_ConsultOrder
Usage: #example
Title: "他科依頼の例"
Description: "他科依頼の例"
* status = #active
* intent = #order
* priority = #routine
* category[orderType] = $order-type#consult "他科依頼"
* category[setting] = $prescription-setting#inpatient "入院"
* code = http://fhir-client.local/CodeSystem/consult-request-type#consult "診察依頼"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* performer[department] = Reference(Organization/example-department)
* authoredOn = "2026-04-02T09:00:00+09:00"
* occurrenceDateTime = "2026-04-03"
* reasonCode.text = "血糖コントロールについてご高診ください"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)

Instance: example-nursing-order
InstanceOf: FC_NursingOrder
Usage: #example
Title: "看護指示の例(観察)"
Description: "看護指示の例(観察)"
* status = #active
* intent = #order
* category[orderType] = $order-type#nursing "看護指示"
* category[setting] = $prescription-setting#inpatient "入院"
* code.coding[nursingObservation] = $medis-nursing-observation#31000525 "努力呼吸"
* code.text = "努力呼吸"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* requester = Reference(Practitioner/example-practitioner)
* requisition.system = "http://fhir-client.local/Identifier/nursing-order-requisition"
* requisition.value = "3f0d2f2e-8b7f-4b6e-9a1c-2d3e4f5a6b7c"
* authoredOn = "2026-04-01T11:00:00+09:00"
* occurrenceDateTime = "2026-04-01"
* orderDetail.text = "努力呼吸があれば報告"
* extension[orderEnd].valueDate = "2026-04-10"
* extension[schedule].valueTiming.repeat.frequency = 3
* extension[schedule].valueTiming.repeat.period = 1
* extension[schedule].valueTiming.repeat.periodUnit = #d
* extension[schedule].valueTiming.repeat.timeOfDay[0] = "09:00:00"
* extension[schedule].valueTiming.repeat.timeOfDay[1] = "14:00:00"
* extension[schedule].valueTiming.repeat.timeOfDay[2] = "20:00:00"

Instance: example-nursing-action-order
InstanceOf: FC_NursingOrder
Usage: #example
Title: "看護指示の例(行為)"
Description: "看護指示の例(行為)"
* status = #active
* intent = #order
* category[orderType] = $order-type#nursing "看護指示"
* category[setting] = $prescription-setting#inpatient "入院"
* code.coding[nursingAction] = $medis-nursing-action#A001B001C008D005 "日常生活ケア・清潔ケア・清拭・全身"
* code.coding[nursingActionNumber] = $medis-nursing-action-oid#11000026 "日常生活ケア・清潔ケア・清拭・全身"
* code.text = "全身清拭"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* requester = Reference(Practitioner/example-practitioner)
* requisition.system = "http://fhir-client.local/Identifier/nursing-order-requisition"
* requisition.value = "3f0d2f2e-8b7f-4b6e-9a1c-2d3e4f5a6b7c"
* authoredOn = "2026-04-01T11:00:00+09:00"
* occurrenceDateTime = "2026-04-01"
* extension[schedule].valueTiming.repeat.timeOfDay[0] = "10:00:00"

Instance: example-meal-order
InstanceOf: FC_MealOrder
Usage: #example
Title: "食事オーダーの例"
Description: "食事オーダーの例"
* status = #active
* intent = #order
* category[orderType] = $order-type#meal "食事"
* category[setting] = $prescription-setting#inpatient "入院"
* code = http://fhir-client.local/CodeSystem/meal-type#DM1600 "糖尿病食 1600kcal"
* orderDetail[staple][0] = http://fhir-client.local/CodeSystem/meal-staple-food#RICE "米飯"
* orderDetail[staple][0].extension[timing].valueCode = #breakfast
* orderDetail[sideDishForm][0] = http://fhir-client.local/CodeSystem/meal-side-dish-form#NORMAL "常菜"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T11:30:00+09:00"
* occurrenceDateTime = "2026-04-01T18:00:00+09:00"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderWard].valueReference = Reference(Location/example-ward)
* extension[saltLimit].valueQuantity = 6 'g' "g"
* extension[link].extension[kind].valueCode = #start

Instance: example-transfusion-order-header
InstanceOf: FC_TransfusionOrderHeader
Usage: #example
Title: "輸血オーダー ヘッダの例"
Description: "輸血オーダー ヘッダの例"
* status = #active
* intent = #order
* priority = #urgent
* category[orderType] = $order-type#transfusion "輸血"
* category[setting] = $prescription-setting#inpatient "入院"
* code = http://fhir-client.local/CodeSystem/transfusion-test-type#crossmatch "交差適合試験"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-08T12:00:00+09:00"
* occurrenceDateTime = "2026-04-08T15:00:00+09:00"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderWard].valueReference = Reference(Location/example-ward)
* extension[abo].valueCodeableConcept = http://fhir-client.local/CodeSystem/transfusion-abo#A "A"
* extension[rhd].valueCodeableConcept = http://fhir-client.local/CodeSystem/transfusion-rhd#positive "＋"
* extension[consent].valueBoolean = true

Instance: example-transfusion-order-item
InstanceOf: FC_TransfusionOrderItem
Usage: #example
Title: "輸血オーダー 製剤明細の例"
Description: "輸血オーダー 製剤明細の例"
* status = #active
* intent = #order
* identifier.system = "http://fhir-client.local/IdSystem/transfusion-order-item-number"
* identifier.value = "1"
* basedOn = Reference(ServiceRequest/example-transfusion-order-header)
* subject = Reference(Patient/example-patient)
* authoredOn = "2026-04-08T12:00:00+09:00"
* occurrenceDateTime = "2026-04-08T15:00:00+09:00"
* code = http://fhir-client.local/CodeSystem/transfusion-product#RBC-LR-2 "照射赤血球液-LR 2 単位"
* quantityQuantity.value = 2
* quantityQuantity.unit = "バッグ"

Instance: example-nutrition-guidance-order
InstanceOf: FC_NutritionGuidanceOrder
Usage: #example
Title: "栄養指導オーダーの例"
Description: "栄養指導オーダーの例"
* status = #active
* intent = #order
* category[orderType] = $order-type#nutrition-guidance "栄養指導"
* category[setting] = $prescription-setting#outpatient "外来"
* code = http://fhir-client.local/CodeSystem/nutrition-guidance-format#individual "個別指導"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-01T10:00:00+09:00"
* occurrenceDateTime = "2026-04-05"
* reasonCode.text = "糖尿病の食事指導"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderEnd].valueDate = "2026-06-30"
* extension[targetDisease].valueString = "2型糖尿病"
* extension[targetCondition].valueReference = Reference(Condition/example-condition)
* extension[targetCondition].valueReference.display = "2型糖尿病"
* extension[targetDiet].valueCoding = http://fhir-client.local/CodeSystem/meal-type#DM1600 "糖尿病食 1600kcal"
