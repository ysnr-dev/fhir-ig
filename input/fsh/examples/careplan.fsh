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

// ---- 看護計画 ----

Instance: example-nursing-problem
InstanceOf: FC_NursingProblem
Usage: #example
Title: "看護問題の例"
Description: "看護問題の例(標準看護計画「転倒転落予防」から立案)"
* clinicalStatus = $condition-clinical#active
* verificationStatus = $condition-ver-status#confirmed
* category[problem] = $condition-category#problem-list-item "Problem List Item"
* category[nursingProblem] = http://fhir-client.local/CodeSystem/condition-category#nursing-problem "看護問題"
* code = http://fhir-client.local/CodeSystem/nursing-diagnosis#L0001 "転倒転落の危険がある状態"
* code.text = "転倒転落の危険がある状態"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* onsetDateTime = "2026-04-02"
* recordedDate = "2026-04-02T10:00:00+09:00"
* recorder = Reference(Practitioner/example-nurse)
* evidence[0].code = http://fhir-client.local/CodeSystem/nursing-risk-factor#LR0101 "歩行が不安定"
* evidence[0].code.text = "歩行が不安定"
* evidence[1].code = http://fhir-client.local/CodeSystem/nursing-risk-factor#LR0103 "夜間の頻尿"
* evidence[1].code.text = "夜間の頻尿"
* extension[priority].valuePositiveInt = 1

Instance: example-nursing-care-plan
InstanceOf: FC_NursingCarePlan
Usage: #example
Title: "看護計画の例"
Description: "看護計画の例(標準看護計画から。OP / TP / EP の行)"
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>看護計画: 転倒転落の危険がある状態(2026-04-02〜)</p><ul><li>OP: 意識障害の有無</li><li>TP(転倒予防): 低床ベッドへ交換する</li><li>EP: 家族に転倒の危険と予防策を説明する(中止)</li></ul></div>"
* status = #active
* intent = #plan
* category = http://fhir-client.local/CodeSystem/care-plan-type#nursing "看護計画"
* title = "転倒転落の危険がある状態"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* period.start = "2026-04-02"
* created = "2026-04-02T10:00:00+09:00"
* author = Reference(Practitioner/example-nurse)
* addresses = Reference(Condition/example-nursing-problem)
* goal[0] = Reference(Goal/example-nursing-goal)
* instantiatesUri = "http://fhir-client.local/master/nursing-standard-plans/LSP001"
* activity[0].id = "6f1c2a3b-4d5e-4f60-8a71-9b0c1d2e3f40"
* activity[0].extension[type].valueCode = #op
* activity[0].detail.status = #in-progress
* activity[0].detail.code = $medis-nursing-observation#31001254 "意識障害"
* activity[0].detail.code.text = "意識障害の有無"
* activity[0].detail.description = "意識障害の有無"
* activity[1].id = "7a2d3b4c-5e6f-4071-8b82-ac1d2e3f4051"
* activity[1].extension[type].valueCode = #tp
* activity[1].extension[intervention].valueCoding = http://fhir-client.local/CodeSystem/nursing-intervention#LI001 "転倒予防"
* activity[1].detail.status = #in-progress
* activity[1].detail.code.coding[0] = $medis-nursing-action#A001B006C051D031 "低床ベッドへ交換"
* activity[1].detail.code.coding[1] = $medis-nursing-action-oid#12000956 "低床ベッドへ交換"
* activity[1].detail.code.text = "低床ベッドへ交換する"
* activity[1].detail.description = "低床ベッドへ交換する"
* activity[2].id = "8b3e4c5d-6f70-4182-9c93-bd2e3f405162"
* activity[2].extension[type].valueCode = #ep
* activity[2].detail.status = #stopped
* activity[2].detail.code.text = "家族に転倒の危険と予防策を説明する"
* activity[2].detail.description = "家族に転倒の危険と予防策を説明する"
* extension[entry].valueCode = #standard_plan

Instance: example-nursing-goal
InstanceOf: FC_NursingGoal
Usage: #example
Title: "看護計画の目標の例"
Description: "看護計画の目標の例(評価済み)"
* lifecycleStatus = #active
* category = http://fhir-client.local/CodeSystem/care-plan-type#nursing "看護計画"
* description = http://fhir-client.local/CodeSystem/nursing-outcome#LO001 "転倒を防ぐ行動"
* description.text = "移動のときにナースコールを押せる"
* subject = Reference(Patient/example-patient)
* startDate = "2026-04-02"
* addresses = Reference(Condition/example-nursing-problem)
* target.dueDate = "2026-04-16"
* statusDate = "2026-04-09"
* achievementStatus = http://terminology.hl7.org/CodeSystem/goal-achievement#improving "改善"
* outcomeReference = Reference(Observation/example-nursing-goal-evaluation)

Instance: example-nursing-goal-evaluation
InstanceOf: FC_NursingEvaluationObservation
Usage: #example
Title: "看護計画の評価の例(目標)"
Description: "看護計画の評価の例(目標ごと)"
* status = #final
* category = http://fhir-client.local/CodeSystem/care-plan-type#nursing "看護計画"
* code = http://fhir-client.local/CodeSystem/nursing-evaluation#goal "目標の評価"
* code.text = "移動のときにナースコールを押せる"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* effectiveDateTime = "2026-04-09T15:00:00+09:00"
* performer = Reference(Practitioner/example-nurse)
* basedOn = Reference(CarePlan/example-nursing-care-plan)
* focus = Reference(Goal/example-nursing-goal)
* valueCodeableConcept = http://terminology.hl7.org/CodeSystem/goal-achievement#improving "改善"
* note.text = "夜間はナースコールを押せている。日中は単独での移動が残る。"
* extension[problem].valueReference = Reference(Condition/example-nursing-problem)

Instance: example-nursing-problem-evaluation
InstanceOf: FC_NursingEvaluationObservation
Usage: #example
Title: "看護計画の評価の例(看護問題)"
Description: "看護計画の評価の例(看護問題単位の判定)"
* status = #final
* category = http://fhir-client.local/CodeSystem/care-plan-type#nursing "看護計画"
* code = http://fhir-client.local/CodeSystem/nursing-evaluation#problem "看護問題の評価"
* code.text = "転倒転落の危険がある状態"
* subject = Reference(Patient/example-patient)
* encounter = Reference(Encounter/example-encounter)
* effectiveDateTime = "2026-04-09T15:00:00+09:00"
* performer = Reference(Practitioner/example-nurse)
* basedOn = Reference(CarePlan/example-nursing-care-plan)
* focus = Reference(Condition/example-nursing-problem)
* valueCodeableConcept = http://fhir-client.local/CodeSystem/nursing-evaluation-decision#continue "継続"
* extension[problem].valueReference = Reference(Condition/example-nursing-problem)
