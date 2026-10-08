### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> 依頼</td><td><a href="StructureDefinition-fc-consult-order.html">FC_ConsultOrder</a></td><td></td><td><code>code</code> = 依頼の種類<br><code>performer[0]</code> = 依頼先の診療科<br><code>performer[1]</code> = 依頼先の医師<br><code>reasonCode[0].text</code> = 目的<br><code>extension</code>: consult-purpose-questionnaire-response / consult-reply</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> consult</td><td><a href="StructureDefinition-fc-consult-task.html">FC_ConsultTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;依頼</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Composition</b> 回答</td><td><a href="StructureDefinition-fc-clinical-note.html">FC_ClinicalNote</a></td><td><span style="white-space: nowrap;">event.detail → 依頼</span></td><td><code>type</code> = LOINC 11488-4 Consult note<br><code>event.code</code> = consult-note-event#reply<br>consult-reply 拡張がこれを指す</td></tr>
</tbody>
</table>

- `status` は Task と連動して active → completed(回答済)/ revoked(取消)。
- `occurrenceDateTime` = 希望日。日付軸ではなく status で絞る運用です。
- 回答は診療記録と同じ Composition で、`type` が Consult note、`event` が依頼を指します。回答の transaction で依頼の `consult-reply` 拡張(display = 回答者)を書き、Task を completed にします。
- 放射線治療科への依頼から放射線治療処方を作ると、処方の `radiotherapy-consult-request` が依頼を指します。

### 例

- [依頼](ServiceRequest-example-consult-order.html)
- [Task](Task-example-consult-task.html)
