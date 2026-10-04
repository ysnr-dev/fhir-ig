// クリニカルパスの CarePlan 木の例。identifier.value は親の値にピリオドで連結する(ePath の規則)。

Instance: example-pathway-apply-care-plan
InstanceOf: FC_PathwayApplyCarePlan
Usage: #example
Title: "パス適用(根)の例"
Description: "パス適用(根)の例"
* status = #active
* intent = #plan
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/apply-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f"
* instantiatesUri = "http://fhir-client.local/pathway/900002"
* title = "大腿骨頚部骨折"
* category[marker].coding[0] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway
* category[marker].coding[1] = http://fhir-client.local/CodeSystem/pathway-level#apply
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* period.start = "2026-04-08"
* period.end = "2026-04-15"
* addresses = Reference(Condition/example-condition)

Instance: example-pathway-event-care-plan
InstanceOf: FC_PathwayEventCarePlan
Usage: #example
Title: "パスの病日の例"
Description: "パスの病日の例"
* status = #active
* intent = #plan
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/event-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f.1"
* title = "術後 1 日目"
* category[marker].coding[0] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway
* category[marker].coding[1] = http://fhir-client.local/CodeSystem/pathway-level#event
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* partOf = Reference(CarePlan/example-pathway-apply-care-plan)
* period.start = "2026-04-09"
* period.end = "2026-04-09"
* extension[0].url = "http://e-path.jp/fhir/ePath/StructureDefinition/EPathCarePlanEventElapsedDays"
* extension[0].valueInteger = 1
* extension[1].url = "http://e-path.jp/fhir/ePath/StructureDefinition/EPathCarePlanPathStep"
* extension[1].valueInteger = 1
* extension[2].url = "http://e-path.jp/fhir/ePath/StructureDefinition/EPathCarePlanPathStepInpatientOutpatientType"
* extension[2].valueCode = #I

Instance: example-pathway-outcome-goal
InstanceOf: FC_PathwayOutcomeGoal
Usage: #example
Title: "パスのアウトカム目標の例(未達成で評価済み)"
Description: "パスのアウトカム目標の例(未達成で評価済み)"
* lifecycleStatus = #completed
* achievementStatus = http://e-path.jp/fhir/ePath/CodeSystem/EPathStateOfAchievementCS#2 "未達成（バリアンス）"
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/outcome-goal-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f.1.u1"
* description.text = "疼痛がコントロールされている"
* subject = Reference(Patient/example-patient)
* statusDate = "2026-04-09"
* outcomeReference = Reference(Observation/example-pathway-evaluation-observation)

Instance: example-pathway-unit-care-plan
InstanceOf: FC_PathwayUnitCarePlan
Usage: #example
Title: "パスの OAT 単位の例(重要アウトカム)"
Description: "パスの OAT 単位の例(重要アウトカム)"
* status = #active
* intent = #plan
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/oat-unit-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f.1.u1"
* title = "疼痛がコントロールされている"
* category[marker].coding[0] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway
* category[marker].coding[1] = http://fhir-client.local/CodeSystem/pathway-level#oat-unit
* category[1].coding.system = "http://e-path.jp/fhir/ePath/CodeSystem/EPathBOMOutcomeCategoryCS"
* category[1].coding.code = #H
* subject = Reference(Patient/example-patient)
* partOf[0] = Reference(CarePlan/example-pathway-apply-care-plan)
* partOf[1] = Reference(CarePlan/example-pathway-event-care-plan)
* goal = Reference(Goal/example-pathway-outcome-goal)
* extension[displayOrder].valueInteger = 1
* extension[1].url = "http://e-path.jp/fhir/ePath/StructureDefinition/EPathCarePlanStatusTypeWhenOccured"
* extension[1].valueCode = #12
* extension[2].url = "http://e-path.jp/fhir/ePath/StructureDefinition/EPathCarePlanCriticalIndicator"
* extension[2].valueCode = #Y
* extension[3].url = "http://e-path.jp/fhir/ePath/StructureDefinition/EPathCarePlanUnplannedKind"
* extension[3].valueCode = #N

Instance: example-pathway-assessment-goal
InstanceOf: FC_PathwayAssessmentGoal
Usage: #example
Title: "パスのアセスメント目標の例"
Description: "パスのアセスメント目標の例"
* lifecycleStatus = #active
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/assessment-goal-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f.1.u1.a1"
* description.text = "NRS"
* subject = Reference(Patient/example-patient)
* target.measure.text = "NRS"
* target.detailString = "3 以下"

Instance: example-pathway-assessment-care-plan
InstanceOf: FC_PathwayAssessmentCarePlan
Usage: #example
Title: "パスのアセスメントの例"
Description: "パスのアセスメントの例"
* status = #active
* intent = #plan
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/assessment-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f.1.u1.a1"
* title = "NRS"
* category[marker].coding[0] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway
* category[marker].coding[1] = http://fhir-client.local/CodeSystem/pathway-level#assessment
* category[1].coding.system = "http://e-path.jp/fhir/ePath/CodeSystem/EPathAssessmentCodeEmptyCS"
* category[1].coding.code = #ZZZZZZZZZZ
* subject = Reference(Patient/example-patient)
* partOf[0] = Reference(CarePlan/example-pathway-apply-care-plan)
* partOf[1] = Reference(CarePlan/example-pathway-event-care-plan)
* partOf[2] = Reference(CarePlan/example-pathway-unit-care-plan)
* goal = Reference(Goal/example-pathway-assessment-goal)
* extension[displayOrder].valueInteger = 1
* extension[1].url = "http://e-path.jp/fhir/ePath/StructureDefinition/EPathCarePlanStatusTypeWhenOccured"
* extension[1].valueCode = #12

Instance: example-pathway-task-procedure
InstanceOf: FC_PathwayTaskProcedure
Usage: #example
Title: "パスのタスクの例"
Description: "パスのタスクの例"
* status = #completed
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/task-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f.1.u1.a1.t1"
* category.coding.system = "http://e-path.jp/fhir/ePath/CodeSystem/EPathTaskCategoryLv1CS"
* category.coding.code = #EX
* code.text = "採血"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* basedOn[0] = Reference(CarePlan/example-pathway-assessment-care-plan)
* basedOn[1] = Reference(ServiceRequest/example-lab-order-header)
* performedDateTime = "2026-04-09T08:00:00+09:00"
* extension[displayOrder].valueInteger = 1
* extension[1].url = "http://e-path.jp/fhir/ePath/StructureDefinition/EPathProcedureTaskPlannedDateTime"
* extension[1].valueDate = "2026-04-09"

Instance: example-pathway-evaluation-observation
InstanceOf: FC_PathwayEvaluationObservation
Usage: #example
Title: "パスのアウトカム評価の例"
Description: "パスのアウトカム評価の例"
* status = #final
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/observation-evaluation-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f.1.u1"
* category[type].coding.system = "http://fhir-client.local/CodeSystem/care-plan-type"
* category[type].coding.code = #clinical-pathway
* code = http://e-path.jp/fhir/ePath/CodeSystem/EPathEvaluationItemCS#judgement "評価"
* code.text = "疼痛がコントロールされている"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(CarePlan/example-pathway-unit-care-plan)
* effectiveDateTime = "2026-04-09T17:00:00+09:00"
* performer = Reference(Practitioner/example-nurse)
* valueCodeableConcept = http://e-path.jp/fhir/ePath/CodeSystem/EPathStateOfAchievementCS#2 "未達成（バリアンス）"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[orderDepartment].valueReference.display = "内科"
* component[0].code = http://e-path.jp/fhir/ePath/CodeSystem/EPathEvaluationItemCS#S "S"
* component[0].valueString = "痛みが強い"

Instance: example-pathway-result-observation
InstanceOf: FC_PathwayResultObservation
Usage: #example
Title: "パスのアセスメント実測値の例"
Description: "パスのアセスメント実測値の例"
* status = #final
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/observation-result-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f.1.u1.a1"
* category[type].coding.system = "http://fhir-client.local/CodeSystem/care-plan-type"
* category[type].coding.code = #clinical-pathway
* code.text = "NRS"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(CarePlan/example-pathway-assessment-care-plan)
* effectiveDateTime = "2026-04-09T16:00:00+09:00"
* performer = Reference(Practitioner/example-nurse)
* valueQuantity.value = 5

Instance: example-pathway-apply-goal
InstanceOf: FC_PathwayApplyGoal
Usage: #example
Title: "パス適用の終了の例"
Description: "パス適用の終了の例"
* lifecycleStatus = #completed
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/apply-goal-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f"
* description.text = "大腿骨頚部骨折"
* subject = Reference(Patient/example-patient)
* statusDate = "2026-04-15"
* extension[0].url = "http://e-path.jp/fhir/ePath/StructureDefinition/EPathGoalStatusReason"
* extension[0].valueCodeableConcept = http://e-path.jp/fhir/ePath/CodeSystem/EPathPathClosingTypeCS#1 "終了"
