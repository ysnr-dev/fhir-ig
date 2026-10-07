### 看護計画の構造

看護問題 1 件を、Condition・CarePlan・Goal の 3 種で持ち、評価を Observation で残します。立案・更新は Condition・Goal・CarePlan を 1 transaction で書きます。

```
Condition(看護問題、FC_NursingProblem)   category = problem-list-item + condition-category#nursing-problem
 ↑ addresses
CarePlan(看護計画、FC_NursingCarePlan)   category = care-plan-type#nursing、activity = OP / TP / EP の行・看護介入の行動
 │  goal → Goal(目標、FC_NursingGoal)   addresses → 看護問題
 ↑ 拡張 nursing-care-plan-activity(plan = CarePlan、activity = 行の id)
ServiceRequest(計画の行から展開した看護指示、FC_NursingOrder)   reasonReference → 看護問題
Observation(評価、FC_NursingEvaluationObservation)   basedOn → CarePlan、focus → Goal または Condition
```

- 看護問題は病名と同じ Condition です。`category` に problem-list-item を併記するのでレセコン送信の保険病名から外れ、病名・プロブレムの一覧からは `condition-category#nursing-problem` で外します(病名の検索は `category:not`)。
- `code` = 看護診断(`nursing-diagnosis`)+ text。自由記載は text のみです。`evidence` に選んだ診断指標・関連因子・危険因子(`nursing-defining-characteristic` / `nursing-related-factor` / `nursing-risk-factor`)を持ちます。`nursing-problem-priority` = 優先度で、並べ替えでは番号の変わった Condition だけを PUT します。
- 看護計画・目標・評価の `category` は `care-plan-type#nursing` で、上流はこの 1 つで引けます。

### 立案の 2 つの入口

`nursing-care-plan-entry` に入口を持ちます。

| 入口 | 行の書き方 |
|---|---|
| standard_plan(標準看護計画) | OP / TP / EP の行(`nursing-plan-activity-type`)。`instantiatesUri` = `http://fhir-client.local/master/nursing-standard-plans/{コード}`。看護介入が結びついている行は `nursing-intervention` も持つ |
| diagnosis(看護診断) | 目標に看護成果(`nursing-outcome`)、行は看護介入(`nursing-intervention`)の行動で、区分の拡張を持たない |

- `activity.id` は行の uuid で、展開した看護指示が指します。`detail.code` は看護指示と同じ形(MEDIS 看護行為の 16 桁コード + 8 桁管理番号、看護観察、または text のみ)、`detail.description` = 行の文言、`detail.status` = in-progress / stopped(中止した行)。
- 目標を計画から外すと Goal は削除せず `cancelled` にし、CarePlan.goal から外します(評価の履歴を残す)。

### 評価

1 回の評価で、評価した目標ごとの Observation(`nursing-evaluation#goal`、focus = Goal、値 = HL7 goal-achievement の達成度)と、看護問題単位の判定(`nursing-evaluation#problem`、focus = Condition、値 = `nursing-evaluation-decision`: 継続 / 修正 / 解決)を書きます。どちらも `basedOn` = 看護計画、`observation-problem` = 看護問題です。

- 目標の Goal は `statusDate`・`achievementStatus`・`outcomeReference` が増え、達成なら `completed` になります。
- 解決では看護問題を `resolved`(`abatementDateTime`)、計画を `completed`(`period.end`)にし、展開した看護指示に終了日を入れます。取消では看護問題を `entered-in-error` にし、展開した看護指示を中止します。

### 計画から展開した看護指示

計画の行を選んで看護指示([FC_NursingOrder](StructureDefinition-fc-nursing-order.html))を出します。`basedOn` に CarePlan を入れると指示がオーダーのヘッダと見なされなくなるので、指示の側から `nursing-care-plan-activity` 拡張で行を指します。看護師が自分で出す指示なので、指示受けの Task は最初から accepted(owner = 出した看護師)で作ります。

### 看護サマリー

看護サマリー([FC_NursingSummary](StructureDefinition-fc-nursing-summary.html))は受け持ち看護師が中間・転棟・退院の区分で書き、病棟の看護職が承認します。器は退院時サマリーと同じ Composition です。

- `type` = `document-type#nursing-summary`(一致する LOINC を確認できていないため)、`category` = 区分(`nursing-summary-kind`)、`event[0].period` = 対象期間、`encounter` = 入院。
- `order-ward` = 作成時の病棟で、病棟単位の承認一覧はこれで検索します。
- 看護経過には、看護職が書いた診療記録(`category` = `clinical-note-category#nursing`)を選んで取り込みます。

| section.code | タイトル | 内容 |
|---|---|---|
| nursing-summary-section#basic | 基本情報 | 年齢・性別、入退院日、病棟、主治医、担当看護師、アレルギー |
| LOINC 11348-0 | 既往歴 | text |
| nursing-summary-section#conditions | 病名 | entry = Condition(text.status = generated、選択が無ければ「なし」) |
| nursing-summary-section#nursing-problems | 看護問題・計画 | entry = 看護計画 CarePlan(display = 看護問題・目標・計画・最新の評価の要約) |
| nursing-summary-section#nursing-course | 看護経過 | text |
| nursing-summary-section#current-status | 現在の状態 | text |
| nursing-summary-section#continuing-care | 継続看護 | text |

本文のセクションは空なら書きません。entry のセクションは常に書きます。

| 状態 | status | attester |
|---|---|---|
| 作成中 | preliminary | なし |
| 承認待ち | final(確定し直しは amended) | legal = 確定した人 |
| 承認済 | 承認待ちのまま(承認者が直して承認したときは amended) | legal + official = 承認者 |
| 差戻し | preliminary | なし。理由は `nursing-summary-returned` 通知 Task(作成者宛)で、確定し直すと completed |

承認できるのは看護職で、作成者でも確定した人でもない職員です。

### 看護プロファイル

入院時に看護師が聴き取る生活・看護上の状態です。施設設定で並べたテンプレート(区画。同梱は入院時の情報・ADL・転倒転落・褥瘡リスク)ごとに、1 入院 1 件の QuestionnaireResponse([FC_QuestionnaireResponse](StructureDefinition-fc-questionnaire-response.html))で持ちます。

- `encounter` = 入院。区画はテンプレートの `url`(版なし)で引き、`questionnaire` の版は問いません。1 区画に複数あれば `authored` の新しいものを使います。
- 書き直しは同じ回答の更新で、版の履歴は上流の `_history` に残ります。
- encounter を持つ回答はカルテの時系列に出ません。看護サマリーの下書きでは、区画の順に回答の平文を「現在の状態」の初期値にします。
- 施設設定(区画の並び)は backend にあり、FHIR には持ちません。

### 例

- [看護問題](Condition-example-nursing-problem.html) / [看護計画](CarePlan-example-nursing-care-plan.html) / [目標](Goal-example-nursing-goal.html)
- [評価(目標)](Observation-example-nursing-goal-evaluation.html) / [評価(看護問題)](Observation-example-nursing-problem-evaluation.html)
- [計画から展開した看護指示](ServiceRequest-example-nursing-plan-order.html)
- [看護記録](Composition-example-nursing-clinical-note.html) / [看護サマリー](Composition-example-nursing-summary.html) / [差戻し通知](Task-example-nursing-summary-returned-task.html)
- [看護プロファイルの記入](QuestionnaireResponse-example-nursing-profile-response.html)
