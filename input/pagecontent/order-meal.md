### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> 食事オーダー</td><td><a href="StructureDefinition-fc-meal-order.html">FC_MealOrder</a></td><td></td><td><code>code</code> = 食種(meal-type)<br><code>orderDetail</code> = 主食(meal-staple-food)・副食の形態(meal-side-dish-form)+ meal-timing<br><code>extension</code>: meal-order-end / meal-skipped-timing(0..3) / meal-fasting-reason / meal-salt-limit / meal-order-link / meal-order-end-reason / meal-pattern<br><code>supportingInfo</code> = 食物アレルギー</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>AllergyIntolerance</b> 食物アレルギー</td><td><a href="StructureDefinition-fc-allergy-intolerance.html">FC_AllergyIntolerance</a></td><td><span style="white-space: nowrap;">食事オーダーの<code>supportingInfo</code>&nbsp;→&nbsp;これ</span></td><td>オーダーを出した時点で有効なもの</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> 食事のアレルギー確認</td><td><a href="StructureDefinition-fc-meal-allergy-check-task.html">FC_MealAllergyCheckTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;食事オーダー</span></td><td>通知 Task</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Observation</b> 摂取量</td><td><a href="StructureDefinition-fc-meal-intake-observation.html">FC_MealIntakeObservation</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;食事オーダー</span></td><td></td></tr>
</tbody>
</table>

部門進捗の Task はありません。`ServiceRequest.status` は常に active で、有効期間は `occurrenceDateTime` 〜 `meal-order-end`(無ければ継続中)で読みます。取消はリソースを削除します。

### オーダー

- `category` は meal + inpatient。`encounter` = 入院 Encounter(入院中でない患者にオーダーセット・パスから適用したときは付かない)。
- `occurrenceDateTime` = 開始日時(朝 08:00 / 昼 12:00 / 夕 18:00)、`meal-order-end` = 終了日時。
- 欠食(1 食だけ出さない)は `meal-skipped-timing`(朝 / 昼 / 夕、最大 3 件)。`meal-fasting-reason`(絶食(NPO)/ 手術絶食 / 検査絶食 / 外泊 / 退院 / その他)は欠食と、食止めの食種で出したオーダーの理由です。塩分制限は `meal-salt-limit`(g)。
- 変更・再開・外泊食止めのつながりは `meal-order-link`(kind = start / change / resume / leave-fasting、source = 元のオーダー、leave = 入院の `encounter-leave.id`)。終了理由は `meal-order-end-reason`(reason = change / discharge-plan / discharge / leave、previousEnd = 変更前の終了)。
- 入院の外出・外泊、退院予定、退院の変更と同じ transaction で食事オーダーが作り直されます。

### パターン食

術後の食上げ(流動食 → 三分粥 → … → 常食)や検査前の食事のように段階的に変わる食事は、1 回の登録で段階ごとの食事オーダーに展開され、同じ transaction で作られます。段階は前の段階の終了の次の食事から始まり、最後の段階だけ終了を持たないことがあります(次の指示まで継続)。

- 各段階のオーダーは `meal-pattern`(code = パターン食マスタのコード、name = パターン名、step = 段階(1 始まり)、count = 段階数)を持ちます。表示のためだけの拡張で、展開後は段階ごとに独立した食事オーダーです。
- `meal-order-link` の kind は、最初の段階が start(出ている食事を終わらせるときは change)、2 段階目以降は change です(source は持ちません)。

### 食物アレルギー

- `supportingInfo` = オーダーを出した時点で有効な食物アレルギー(AllergyIntolerance の参照、`display` = アレルゲン名)。SS-MIX2 の食事オーダー(OMD^O03)の AL1 にあたり、給食部門はこのオーダーだけを読んで除去の対応を取れます。登録・編集・再開の保存のたびにその時点のもので入れ直し、外泊の食止めは止める食事のものを引き継ぎます。オーダーセット・パスの雛形には持ちません。
- 食物アレルギーを登録(または有効化)したとき、それを写していない進行中の食事オーダーがあれば、オーダーごとに [食事のアレルギー確認](StructureDefinition-fc-meal-allergy-check-task.html) の通知 Task をオーダーの依頼医に出します。食事オーダーを保存し直してアレルギーが写ると completed、アレルギーが解消・否定・削除されると cancelled になります。

### 摂取量

食事ごとの摂取量は Observation(category = order-type#meal、code = MEDIS 看護観察 31003419「食事摂取量（主食）」/ 31003420「食事摂取量（副食）」、valueQuantity %)で、effectiveDateTime は 08:00 / 12:00 / 18:00 です。

### 例

- [食事オーダー](ServiceRequest-example-meal-order.html)
- [パターン食から展開した食事オーダー](ServiceRequest-example-meal-order-pattern.html)
- [食事のアレルギー確認](Task-example-meal-allergy-check-task.html)
- [摂取量](Observation-example-meal-intake-observation.html)
