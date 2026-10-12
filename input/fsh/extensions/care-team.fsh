// チーム医療(CareTeam・チーム依頼)の拡張。

Extension: CareTeamRoundTemplate
Id: care-team-round-template
Title: "回診記録の既定テンプレート"
Description: "チームの回診記録を書くときに選択済みで開くテンプレート(Questionnaire の url)。"
Context: CareTeam
* insert FCMeta
* value[x] only Canonical(Questionnaire)

Extension: TeamRequestPurposeQuestionnaireResponse
Id: team-request-purpose-questionnaire-response
Title: "依頼目的テンプレートの記入(チーム依頼)"
Description: "依頼目的をテンプレートで書いたときの記入(QuestionnaireResponse)。同じ transaction で登録する。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(QuestionnaireResponse)

Extension: TeamRequestNextRound
Id: team-request-next-round
Title: "次回回診日"
Description: "チーム依頼の次回回診日。回診記録の保存とチーム依頼一覧から書き換える(空にすると外す)。"
Context: ServiceRequest
* insert FCMeta
* value[x] only date

Extension: TeamRequestLastRound
Id: team-request-last-round
Title: "最後の回診記録"
Description: "最後の回診記録(Composition)。display = 記録者。表示用のキャッシュで、正本は回診記録の event.detail。同じ transaction で urn:uuid を指し、上流が実 id に書き換える。"
Context: ServiceRequest
* insert FCMeta
* value[x] only Reference(Composition)

Extension: TeamRequestLastRoundDate
Id: team-request-last-round-date
Title: "最後の回診日"
Description: "最後の回診記録の日付。"
Context: ServiceRequest
* insert FCMeta
* value[x] only date
