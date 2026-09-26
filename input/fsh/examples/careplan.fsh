// クリニカルパスの CarePlan 木の例。

Instance: example-pathway-apply-care-plan
InstanceOf: FC_PathwayApplyCarePlan
Usage: #example
Title: "パス適用(根)の例"
* status = #active
* intent = #plan
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/apply-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f"
* instantiatesUri = "http://fhir-client.local/pathway/900002"
* category[type] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway "クリニカルパス"
* category[level] = http://fhir-client.local/CodeSystem/pathway-level#apply "適用"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* period.start = "2026-04-08"
* period.end = "2026-04-15"
* addresses = Reference(Condition/example-condition)

Instance: example-pathway-event-care-plan
InstanceOf: FC_PathwayEventCarePlan
Usage: #example
Title: "パスの病日の例"
* status = #active
* intent = #plan
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/event-id"
* identifier.value = ".1"
* category[type] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway "クリニカルパス"
* category[level] = http://fhir-client.local/CodeSystem/pathway-level#event "病日"
* subject = Reference(Patient/example-patient)
* partOf = Reference(CarePlan/example-pathway-apply-care-plan)
* period.start = "2026-04-09"
* period.end = "2026-04-09"
* extension[displayOrder].valueInteger = 2

Instance: example-pathway-outcome-goal
InstanceOf: FC_PathwayOutcomeGoal
Usage: #example
Title: "パスのアウトカム目標の例"
* lifecycleStatus = #active
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/outcome-goal-id"
* identifier.value = ".u1"
* description.text = "疼痛がコントロールされている"
* subject = Reference(Patient/example-patient)
* outcomeReference = Reference(Observation/example-pathway-evaluation-observation)

Instance: example-pathway-unit-care-plan
InstanceOf: FC_PathwayUnitCarePlan
Usage: #example
Title: "パスの OAT 単位の例"
* status = #active
* intent = #plan
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/oat-unit-id"
* identifier.value = ".u1"
* category[type] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway "クリニカルパス"
* category[level] = http://fhir-client.local/CodeSystem/pathway-level#oat-unit "OAT 単位"
* subject = Reference(Patient/example-patient)
* partOf[0] = Reference(CarePlan/example-pathway-apply-care-plan)
* partOf[1] = Reference(CarePlan/example-pathway-event-care-plan)
* goal = Reference(Goal/example-pathway-outcome-goal)

Instance: example-pathway-assessment-goal
InstanceOf: FC_PathwayAssessmentGoal
Usage: #example
Title: "パスのアセスメント目標の例"
* lifecycleStatus = #active
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/assessment-goal-id"
* identifier.value = ".a1"
* description.text = "NRS"
* subject = Reference(Patient/example-patient)
* target.measure.text = "NRS"
* target.detailString = "3 以下"

Instance: example-pathway-assessment-care-plan
InstanceOf: FC_PathwayAssessmentCarePlan
Usage: #example
Title: "パスのアセスメントの例"
* status = #active
* intent = #plan
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/assessment-id"
* identifier.value = ".a1"
* category[type] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway "クリニカルパス"
* category[level] = http://fhir-client.local/CodeSystem/pathway-level#assessment "アセスメント"
* subject = Reference(Patient/example-patient)
* partOf[0] = Reference(CarePlan/example-pathway-apply-care-plan)
* partOf[1] = Reference(CarePlan/example-pathway-event-care-plan)
* partOf[2] = Reference(CarePlan/example-pathway-unit-care-plan)
* goal = Reference(Goal/example-pathway-assessment-goal)

Instance: example-pathway-task-procedure
InstanceOf: FC_PathwayTaskProcedure
Usage: #example
Title: "パスのタスクの例"
* status = #completed
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/task-id"
* identifier.value = ".t1"
* category = http://e-path.jp/fhir/ePath/CodeSystem/TaskCategoryLv1CS#EX "検査"
* code.text = "採血"
* subject = Reference(Patient/example-patient)
* basedOn[0] = Reference(CarePlan/example-pathway-assessment-care-plan)
* basedOn[1] = Reference(ServiceRequest/example-lab-order-header)
* performedDateTime = "2026-04-09T08:00:00+09:00"

Instance: example-pathway-evaluation-observation
InstanceOf: FC_PathwayEvaluationObservation
Usage: #example
Title: "パスのアウトカム評価の例"
* status = #final
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/observation-evaluation-id"
* identifier.value = ".u1"
* category[type] = http://fhir-client.local/CodeSystem/care-plan-type#clinical-pathway "クリニカルパス"
* code = http://e-path.jp/fhir/ePath/CodeSystem/EPathEvaluationItemCS#judgement "判定"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(CarePlan/example-pathway-unit-care-plan)
* effectiveDateTime = "2026-04-09T17:00:00+09:00"
* performer = Reference(Practitioner/example-practitioner)
* valueCodeableConcept = http://e-path.jp/fhir/ePath/CodeSystem/EPathStateOfAchievementCS#2 "未達成"
* component[0].code = http://e-path.jp/fhir/ePath/CodeSystem/EPathEvaluationItemCS#S "S"
* component[0].valueString = "痛みが強い"

Instance: example-pathway-result-observation
InstanceOf: FC_PathwayResultObservation
Usage: #example
Title: "パスのアセスメント実測値の例"
* status = #final
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/observation-result-id"
* identifier.value = ".a1"
* code.text = "NRS"
* subject = Reference(Patient/example-patient)
* basedOn = Reference(CarePlan/example-pathway-assessment-care-plan)
* effectiveDateTime = "2026-04-09T16:00:00+09:00"
* valueInteger = 5

Instance: example-pathway-apply-goal
InstanceOf: FC_PathwayApplyGoal
Usage: #example
Title: "パス適用の終了の例"
* lifecycleStatus = #completed
* identifier.system = "http://e-path.jp/fhir/ePath/IdSystem/apply-goal-id"
* identifier.value = "1311234567.4c1d2e3f-5a6b-4c7d-8e9f-0a1b2c3d4e5f"
* description.text = "パス終了"
* subject = Reference(Patient/example-patient)
* statusDate = "2026-04-15"
* extension[0].url = "http://e-path.jp/fhir/ePath/StructureDefinition/EPathGoalStatusReason"
* extension[0].valueCodeableConcept = http://e-path.jp/fhir/ePath/CodeSystem/EPathPathClosingTypeCS#1 "終了"
