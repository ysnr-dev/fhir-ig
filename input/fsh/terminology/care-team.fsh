// チーム医療(CareTeam・チーム依頼)の CodeSystem。

CodeSystem: CareTeamKindCS
Id: care-team-kind
Title: "チームの区分"
Description: "チーム医療のチームの区分。CareTeam.category と、チーム依頼 ServiceRequest.code(一覧の絞り込み用)に使う。"
* insert EnumCS
* #nst "栄養サポート(NST)"
* #ict "感染対策(ICT)"
* #pressure-ulcer "褥瘡対策"
* #palliative "緩和ケア"
* #dementia "認知症ケア"
* #rst "呼吸ケア(RST)"
* #other "その他"

ValueSet: CareTeamKindVS
Id: care-team-kind-vs
Title: "チームの区分 ValueSet"
Description: "チームの区分 ValueSet。"
* insert AllOf(CareTeamKindCS)

CodeSystem: CareTeamRoleCS
Id: care-team-role
Title: "チームでの役割"
Description: "CareTeam.participant.role。"
* insert EnumCS
* #lead "リーダー"
* #member "構成員"

ValueSet: CareTeamRoleVS
Id: care-team-role-vs
Title: "チームでの役割 ValueSet"
Description: "チームでの役割 ValueSet。"
* insert AllOf(CareTeamRoleCS)

ValueSet: FCCareTeamStatusVS
Id: fc-care-team-status-vs
Title: "チームの状態"
Description: "active 有効 / inactive 無効"
* insert FCMeta
* http://hl7.org/fhir/care-team-status#active
* http://hl7.org/fhir/care-team-status#inactive
