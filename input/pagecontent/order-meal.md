### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> 食事オーダー</td><td><a href="StructureDefinition-fc-meal-order.html">FC_MealOrder</a></td><td></td><td><code>code</code> = 食種(meal-type)<br><code>orderDetail</code> = 主食(meal-staple-food)・副食の形態(meal-side-dish-form)+ meal-timing<br><code>extension</code>: meal-order-end / meal-skipped-timing(0..3) / meal-fasting-reason / meal-salt-limit / meal-order-link / meal-order-end-reason</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Observation</b> 摂取量</td><td><a href="StructureDefinition-fc-meal-intake-observation.html">FC_MealIntakeObservation</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;食事オーダー</span></td><td></td></tr>
</tbody>
</table>

Task はありません。`ServiceRequest.status` は常に active で、有効期間は `occurrenceDateTime` 〜 `meal-order-end`(無ければ継続中)で読みます。取消はリソースを削除します。

### オーダー

- `category` は meal + inpatient。`encounter` = 入院 Encounter(入院中でない患者にオーダーセット・パスから適用したときは付かない)。
- `occurrenceDateTime` = 開始日時(朝 08:00 / 昼 12:00 / 夕 18:00)、`meal-order-end` = 終了日時。
- 欠食(1 食だけ出さない)は `meal-skipped-timing`(朝 / 昼 / 夕、最大 3 件)。`meal-fasting-reason`(絶食(NPO)/ 手術絶食 / 検査絶食 / 外泊 / 退院 / その他)は欠食と、食止めの食種で出したオーダーの理由です。塩分制限は `meal-salt-limit`(g)。
- 変更・再開・外泊食止めのつながりは `meal-order-link`(kind = start / change / resume / leave-fasting、source = 元のオーダー、leave = 入院の `encounter-leave.id`)。終了理由は `meal-order-end-reason`(reason = change / discharge-plan / discharge / leave、previousEnd = 変更前の終了)。
- 入院の外出・外泊、退院予定、退院の変更と同じ transaction で食事オーダーが作り直されます。

### 摂取量

食事ごとの摂取量は Observation(category = order-type#meal、code = MEDIS 看護観察 31003419「食事摂取量（主食）」/ 31003420「食事摂取量（副食）」、valueQuantity %)で、effectiveDateTime は 08:00 / 12:00 / 18:00 です。

### 例

- [食事オーダー](ServiceRequest-example-meal-order.html)
- [摂取量](Observation-example-meal-intake-observation.html)
