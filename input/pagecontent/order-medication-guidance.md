### 構造

```
ServiceRequest(依頼、FC_MedicationGuidanceOrder)
 │  code = 指導区分(服薬指導 / 退院時指導) / orderDetail = 指導条件(複数) / reasonCode[0].text = 指導してほしいこと / note = 薬剤部への連絡事項
 │  extension: medication-guidance-order-end / medication-guidance-target-drugs
 ├ Task(medication-guidance、FC_MedicationGuidanceTask)  focus → 依頼、owner = 担当薬剤師
 └ Procedure(回ごとの指導、FC_MedicationGuidanceProcedure)  basedOn → 依頼
     code = 指導種別(服薬指導 / 服薬指導(ハイリスク薬) / 退院時指導) / performer = 指導した薬剤師 / note = 指導内容
     extension: medication-guidance-understanding / medication-guidance-record(QuestionnaireResponse)
```

- 医師が薬剤師へ服薬指導を依頼し、薬剤部が受付 → 入院中に週ごとの指導 → 退院時指導 → 終了と進めます。栄養指導と同じ期間継続型で、明細 ServiceRequest と予約は持ちません。
- `occurrenceDateTime` = 開始日、`medication-guidance-order-end` = 終了日(無ければ継続中)。部門一覧の「終了」と退院時の打ち切りで、ServiceRequest に終了日を書き足します(Task を completed にするだけでは部門一覧の検索に残り続けるため)。
- 指導区分(`medication-guidance-kind`)と指導条件(`medication-guidance-condition`: ハイリスク薬 / 麻薬 / 吸入・自己注射の手技 / 多剤併用 / 服薬状況の確認 / 嚥下・剤形の相談 / 家族への指導)は施設で増減しない固定のコードです。
- 対象薬剤(`medication-guidance-target-drugs`)は、持参薬・院外の薬も対象になるので処方の参照ではなく文字列で持ちます。
- 進捗 Task は薬剤部の受け入れ状態(requested 依頼済 / accepted 実施中 / completed 終了 / cancelled 中止)です。日々の指導は Task を動かさず Procedure を足すだけです。`owner` = 担当薬剤師(受け持つ人。実施した人は Procedure.performer で、別人のこともある)。
- 指導種別(`medication-guidance-session-type`)は、退院時指導のオーダーでは discharge だけ、服薬指導のオーダーでは standard / high-risk を選びます(指導条件にハイリスク薬があれば high-risk が初期値)。
- 指導記録はテンプレート(QuestionnaireResponse)で書くこともでき、実施 Procedure の `medication-guidance-record` が指します(平文は note にも入る)。実施記録を消すときは QuestionnaireResponse も消します。
- クリニカルパスでは、タスク分類(小)EGMG(服薬指導)のタスクに服薬指導オーダーの雛形を置きます([クリニカルパス](pathway.html))。
- レセプトコンピュータへの送信は未対応です(薬剤管理指導料の区分を実施記録の指導種別から引く必要がある)。

### 例

- [依頼](ServiceRequest-example-medication-guidance-order.html)
- [Task](Task-example-medication-guidance-task.html)
- [実施記録](Procedure-example-medication-guidance-procedure.html)
