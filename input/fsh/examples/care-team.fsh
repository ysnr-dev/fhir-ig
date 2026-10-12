// チーム医療: チーム、チーム依頼、進捗 Task、回診記録の例。

Instance: example-care-team
InstanceOf: FC_CareTeam
Usage: #example
Title: "チーム医療のチームの例(NST)"
Description: "チーム医療のチームの例(NST)"
* status = #active
* category = http://fhir-client.local/CodeSystem/care-team-kind#nst "栄養サポート(NST)"
* name = "NST"
* participant[0].role = http://fhir-client.local/CodeSystem/care-team-role#lead "リーダー"
* participant[0].member = Reference(Practitioner/example-practitioner) "山田 一郎"
* participant[1].role = http://fhir-client.local/CodeSystem/care-team-role#member "構成員"
* participant[1].member = Reference(Practitioner/example-nurse) "看護 花子"
* managingOrganization = Reference(Organization/example-organization)
* extension[roundTemplate].valueCanonical = "http://fhir-client.local/Questionnaire/social-01"

Instance: example-team-request-order
InstanceOf: FC_TeamRequestOrder
Usage: #example
Title: "チーム依頼の例"
Description: "チーム依頼の例(回診記録 1 件を書いた介入中の依頼)"
* status = #active
* intent = #order
* priority = #routine
* category[orderType] = $order-type#team-request "チーム依頼"
* category[setting] = $prescription-setting#inpatient "入院"
* code = http://fhir-client.local/CodeSystem/care-team-kind#nst "栄養サポート(NST)"
* code.text = "栄養サポート(NST)"
* subject = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* performer = Reference(CareTeam/example-care-team) "NST"
* authoredOn = "2026-04-02T09:00:00+09:00"
* occurrenceDateTime = "2026-04-02"
* reasonCode.text = "食事摂取量低下、Alb 2.8。栄養評価と介入をお願いします"
* reasonReference = Reference(Condition/example-condition) "2型糖尿病"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
* extension[lastRound].valueReference = Reference(Composition/example-team-round-note) "山田 一郎"
* extension[lastRoundDate].valueDate = "2026-04-03"
* extension[nextRound].valueDate = "2026-04-10"

Instance: example-team-request-task
InstanceOf: FC_TeamRequestTask
Usage: #example
Title: "チーム依頼 進捗 Task の例(介入中)"
Description: "チーム依頼 進捗 Task の例(介入中)"
* status = #accepted
* intent = #filler-order
* priority = #routine
* code = $task-code#team-request "チーム依頼"
* code.text = "チーム依頼"
* focus = Reference(ServiceRequest/example-team-request-order)
* for = Reference(Patient/example-patient)
* requester = Reference(Practitioner/example-practitioner)
* authoredOn = "2026-04-03T14:00:00+09:00"
* lastModified = "2026-04-03T14:00:00+09:00"
* executionPeriod.start = "2026-04-03T14:00:00+09:00"

Instance: example-team-round-note
InstanceOf: FC_ClinicalNote
Usage: #example
Title: "チームの回診記録の例"
Description: "チーム依頼の回診記録(Progress note、category = clinical-note-category#team-round、event = consult-note-event#round → 依頼)。"
* status = #final
* type = $loinc#11506-3 "Progress note"
* category = http://fhir-client.local/CodeSystem/clinical-note-category#team-round "チーム回診記録"
* subject = Reference(Patient/example-patient)
* date = "2026-04-03T14:00:00+09:00"
* author = Reference(Practitioner/example-practitioner)
* title = "NST 回診記録"
* attester.mode = #legal
* attester.time = "2026-04-03T14:00:00+09:00"
* attester.party = Reference(Practitioner/example-practitioner)
* event.code = http://fhir-client.local/CodeSystem/consult-note-event#round "チーム依頼の回診"
* event.detail = Reference(ServiceRequest/example-team-request-order)
* section[0].code = $loinc#77599-9 "Additional documentation"
* section[0].text.status = #additional
* section[0].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>経口補助食品を追加。1 週後に再評価。</p></div>"
* extension[orderDepartment].valueReference = Reference(Organization/example-department)
