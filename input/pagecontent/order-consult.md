### 構造

```
ServiceRequest(依頼、FC_ConsultOrder)
 │  code = 依頼の種類 / performer[0] = 依頼先の診療科 / performer[1] = 依頼先の医師 / reasonCode[0].text = 目的
 │  extension: consult-purpose-questionnaire-response / consult-reply
 ├ Task(consult、FC_ConsultTask)  focus → 依頼
 └ Composition(回答、FC_ClinicalNote)   ※ consult-reply 拡張がこれを指す
     type = LOINC 11488-4 Consult note / event.code = consult-note-event#reply / event.detail → 依頼
```

- `status` は Task と連動して active → completed(回答済)/ revoked(取消)。
- `occurrenceDateTime` = 希望日。日付軸ではなく status で絞る運用です。
- 回答は診療記録と同じ Composition で、`type` が Consult note、`event` が依頼を指します。回答の transaction で依頼の `consult-reply` 拡張(display = 回答者)を書き、Task を completed にします。
- 放射線治療科への依頼から放射線治療処方を作ると、処方の `radiotherapy-consult-request` が依頼を指します。

### 例

- [依頼](ServiceRequest-example-consult-order.html)
- [Task](Task-example-consult-task.html)
