### 評価の持ち方

重症度、医療・看護必要度の評価は、患者 × 日の Observation 1 件です。評価票の項目・配点はアプリが版ごとに持ち、Observation には版のコードと項目ごとの値を書きます。

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>Observation</b> 評価</td><td><a href="StructureDefinition-fc-nursing-acuity-observation.html">FC_NursingAcuityObservation</a></td><td><span style="white-space: nowrap;"><code>encounter</code>&nbsp;→&nbsp;入院</span><br><span style="white-space: nowrap;"><code>performer</code>&nbsp;→&nbsp;評価者</span><br><span style="white-space: nowrap;"><code>order-ward</code>&nbsp;→&nbsp;届出単位の Location</span></td><td><code>category</code> = survey<br><code>code</code> = 評価票の版(<code>nursing-acuity</code>)<br><code>effectiveDateTime</code> = 評価日(日付のみ)<br><code>component[]</code> = 項目ごとの値と A / B / C の合計(<code>nursing-acuity-item</code>)<br><code>dataAbsentReason</code> = 対象外の日</td></tr>
</tbody>
</table>

### 評価票の版

| code | 評価票 | 区分 |
|---|---|---|
| general-2026 | 一般病棟用 重症度、医療・看護必要度Ⅰ(令和8年度、別紙7) | A 1〜7(A6 は小項目 A6-1〜A6-11)/ B 8〜14 / C 15〜23 |
| icu-2026 | 特定集中治療室用 重症度、医療・看護必要度(令和8年度、別紙17) | A 1〜10 / B 11〜17 |
| hcu-2026 | ハイケアユニット用 重症度、医療・看護必要度(令和8年度、別紙18) | A 1〜13 / B 14〜20 |

- 項目の番号は版ごとに意味が違います(一般病棟用の A1 は創傷処置、ICU 用の A1 は蘇生術の施行)。component は `Observation.code` の版と組にして読みます。改定で項目・配点が変われば版を足し、過去の評価は書いた版の定義で読みます。
- 届出単位(病棟、ICU などは病室)ごとにどの版で評価するかは backend の施設設定(`nursing_acuity`)で、FHIR リソースではありません。該当患者の基準(割合1・割合2)も同じ設定と版の既定にあり、表示のときに判定します(Observation には判定結果を書きません)。

### component

| 項目 | 値 | 備考 |
|---|---|---|
| A・C の項目(`A1`、`C15` など) | valueBoolean | 「なし」も false で持つ |
| A6 の小項目(`A6-1`〜`A6-11`、一般病棟用) | valueBoolean | A6 そのものは component にならない。A 得点には該当した小項目の最高点を数える |
| B の項目(`B8` など) | valueInteger | 選んだ状態の点数(項目の中で点数は重ならないので、点数から状態に戻せる) |
| 介助の実施(`B9-assist` など) | valueBoolean | 移乗・口腔清潔・食事摂取・衣服の着脱だけ。B 得点は状態の点数 × 介助の実施 |
| 合計(`A` / `B` / `C`) | valueInteger | 版にある区分だけ(ICU・HCU 用に C は無い)。評価票の定義を知らない読み手も得点を読めるように持つ |

- component は版の項目の順(A → B → C)に並び、最後に合計が続きます。アプリは component の coding に display を付けません。
- 対象外の日は component を持たず、`dataAbsentReason` = data-absent-reason#not-applicable、`text` = 理由(未入力なら「対象外」)です。

### 登録と書き直し

- 1 人ずつの評価も、病棟の一括入力も、1 つの transaction で書きます。新規は status = final、書き直しは同じ Observation を PUT して status = amended(版は If-Match)。
- `order-ward` は評価した日の届出単位です。転棟した日は、移動前後のどちらの単位で評価したかで集計が分かれます。
- 上流からは `Observation?code=http://fhir-client.local/CodeSystem/nursing-acuity|<版>&patient=<複数>&date=ge..&date=le..` で引きます。

### 例

- [一般病棟用](Observation-example-nursing-acuity-observation.html) / [対象外の日](Observation-example-nursing-acuity-excluded-observation.html)
