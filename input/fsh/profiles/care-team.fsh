// チーム医療: チーム(CareTeam)、チーム依頼(ServiceRequest)と進捗 Task。

Profile: FC_CareTeam
Parent: CareTeam
Id: fc-care-team
Title: "チーム医療のチーム"
Description: """NST・ICT・褥瘡対策・緩和ケアなどの組織的なチーム。JP Core に CareTeam プロファイルは無い。

- subject を持たない(患者コンパートメントに入らない)。チーム依頼の宛先(ServiceRequest.performer)になる。
- status: active 有効 / inactive 無効。category[0] = チームの区分(care-team-kind)。
- participant: role = care-team-role(lead / member)、member = Practitioner(display = 氏名)。構成員の変更は CareTeam の PUT(読んだ版を If-Match に添える)。
- managingOrganization = 自院(自院が未設定なら持たない)。
- care-team-round-template = 回診記録の既定テンプレート(任意)。"""
* insert FCMeta
* status 1..1 MS
* status from FCCareTeamStatusVS (required)
* category 1..1 MS
* category from CareTeamKindVS (required)
* category.coding 1..1
* name 1..1 MS
* subject 0..0
* encounter 0..0
* participant MS
* participant.role 1..1
* participant.role from CareTeamRoleVS (required)
* participant.role.coding 1..1
* participant.member 1..1
* participant.member only Reference(FC_Practitioner)
* managingOrganization 0..1
* managingOrganization only Reference(FC_Facility)
* extension contains CareTeamRoundTemplate named roundTemplate 0..1

Profile: FC_TeamRequestOrder
Parent: FC_OrderHeader
Id: fc-team-request-order
Title: "チーム依頼"
Description: """チーム医療のチームへの介入依頼。明細 ServiceRequest は無い(他科依頼と同じ形)。

- status は Task と同じ transaction で動かす: active(依頼済・介入中)→ completed(終了)/ revoked(却下)。
- code = チームの区分(care-team-kind、一覧の絞り込み用)。occurrenceDateTime = 希望日。
- performer[0] = 依頼先のチーム(CareTeam、display = チーム名)。
- reasonCode[0].text = 依頼目的。テンプレートで書いたときは team-request-purpose-questionnaire-response。
- 回診記録は診療記録(Progress note、category = clinical-note-category#team-round、event = consult-note-event#round → 依頼)。回診記録の保存と同じ transaction で team-request-last-round / team-request-last-round-date / team-request-next-round を書き、依頼済なら Task を accepted にする。
- 通知 Task は作らない(宛先がチームで、通知は職員 1 人あてのため)。"""
* category[orderType] = $order-type#team-request "チーム依頼"
* priority 1..1 MS
* priority from FCPriorityRoutineUrgentVS (required)
* code 0..1 MS
* code from CareTeamKindVS (required)
* occurrenceDateTime 1..1
* occurrenceDateTime ^short = "希望日"
* performer 1..1 MS
* performer only Reference(FC_CareTeam)
* reasonCode 0..1 MS
* reasonCode.text 1..1
* reasonCode.text ^short = "依頼目的"
* extension contains
    TeamRequestPurposeQuestionnaireResponse named purposeResponse 0..1 and
    TeamRequestNextRound named nextRound 0..1 MS and
    TeamRequestLastRound named lastRound 0..1 MS and
    TeamRequestLastRoundDate named lastRoundDate 0..1 MS

Profile: FC_TeamRequestTask
Parent: FC_DepartmentTask
Id: fc-team-request-task
Title: "チーム依頼 進捗 Task"
Description: "requested 依頼済 / accepted 介入中 / completed 終了 / cancelled 却下。チームが最初に触ったとき(受付・却下・回診記録の保存)に作る。却下の理由は statusReason.text(却下以外へ動かすと外す)。"
* code = $task-code#team-request "チーム依頼"
* status from FCTaskStatusBasicVS (required)
* focus only Reference(FC_TeamRequestOrder)
* statusReason.text ^short = "却下の理由"
