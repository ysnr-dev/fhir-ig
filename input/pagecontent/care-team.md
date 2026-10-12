### チーム(CareTeam)

NST・ICT・褥瘡対策・緩和ケアなどの組織的なチームは **CareTeam**([FC_CareTeam](StructureDefinition-fc-care-team.html))です。`subject` を持たないので患者コンパートメントには入りません。

- `status`: active 有効 / inactive 無効。`category[0]` = チームの区分(`care-team-kind`: nst / ict / pressure-ulcer / palliative / dementia / rst / other)。`name` = チーム名。
- `participant`: `role` = `care-team-role`(lead リーダー / member 構成員)、`member` = Practitioner(display = 氏名)。
- `managingOrganization` = 自院。`care-team-round-template` = 回診記録に挿入する既定テンプレート(Questionnaire の url、任意)。
- 構成員の変更も CareTeam の PUT です(読んだ版を If-Match に添える)。
- データ抽出の保存条件の持ち主にチームを選べます(スクリーニング)。保存条件は backend のマスタで、FHIR リソースではありません。

### チーム依頼

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> 依頼</td><td><a href="StructureDefinition-fc-team-request-order.html">FC_TeamRequestOrder</a></td><td><span style="white-space: nowrap;"><code>performer</code>&nbsp;→&nbsp;CareTeam</span></td><td><code>code</code> = チームの区分<br><code>reasonCode[0].text</code> = 依頼目的<br><code>extension</code>: team-request-purpose-questionnaire-response / team-request-next-round / team-request-last-round / team-request-last-round-date</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> team-request</td><td><a href="StructureDefinition-fc-team-request-task.html">FC_TeamRequestTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;依頼</span></td><td>却下の理由 = <code>statusReason.text</code></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Composition</b> 回診記録</td><td><a href="StructureDefinition-fc-clinical-note.html">FC_ClinicalNote</a></td><td><span style="white-space: nowrap;">event.detail → 依頼</span></td><td><code>type</code> = LOINC 11506-3 Progress note<br><code>category</code> = clinical-note-category#team-round<br><code>event.code</code> = consult-note-event#round</td></tr>
</tbody>
</table>

- 他科依頼と同じ「明細を持たないヘッダ 1 本」です。`occurrenceDateTime` = 希望日、`priority` = routine / urgent。
- `status` は Task と同じ transaction で動かします: 依頼済・介入中 = active、終了 = completed、却下 = revoked。
- Task は requested 依頼済 / accepted 介入中 / completed 終了 / cancelled 却下。チームが最初に触ったときに作ります。
- 他科依頼と違い、回診記録を書いても完了しません(終了はチームが明示する)。回診記録の保存は 1 つの transaction で、Composition(fullUrl = urn:uuid)と、依頼の `team-request-last-round`(display = 記録者)・`team-request-last-round-date`・`team-request-next-round` を書き、依頼済なら Task を accepted にします。
- 回診記録は通常の診療記録と同じ形(SOAP・自由記載・テンプレート)で、カルテの時系列にも出ます。上流は `Composition.event` を索引しないので、依頼の回診記録は患者の `category=…|team-round` で引いて `event.detail` で絞ります。
- 通知 Task は作りません(宛先がチームのため)。チーム依頼一覧が受信箱です。

### 褥瘡の DESIGN-R 評価

褥瘡の評価は同梱テンプレート `http://fhir-client.local/Questionnaire/pressure-ulcer-designr-01`(PU_DESIGNR_01)の記入([FC_QuestionnaireResponse](StructureDefinition-fc-questionnaire-response.html))で、**1 創 1 回答**です。評価のたびに新しい回答を書きます。

- 項目の linkId は固定の約束です(施設がテンプレートを複製して直すときも変えない): `pu_site`(部位)/ `pu_site_other` / `pu_onset_kind`(brought 持込 / acquired 院内発生)/ `pu_onset_date` / `pu_state`(open 継続 / healed 治癒)/ `pu_healed_date` / `designr_d` `designr_e` `designr_s` `designr_i` `designr_g` `designr_n` `designr_p`(DESIGN-R 2020 の 7 項目。選択肢のコードは記号そのもの: d2・E6 など)/ `designr_total`(深さを除く合計)/ `designr_severity`(重症度)/ `designr_note`(所見・処置)。
- 項目コード(`observation-item`: NURS-PU-*)から Observation を抽出します。
- 褥瘡管理の保有患者・発生率は、施設設定のテンプレートの url(版を問わない)の回答から数えます。

### 例

- [チーム](CareTeam-example-care-team.html)
- [依頼](ServiceRequest-example-team-request-order.html) / [Task](Task-example-team-request-task.html) / [回診記録](Composition-example-team-round-note.html)
