### 処方

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> ヘッダ</td><td><a href="StructureDefinition-fc-prescription-order.html">FC_PrescriptionOrder</a></td><td></td><td><code>category</code> = prescription + 入院・外来区分 + 処方区分<br><code>orderDetail[]</code> = "RP{n}-{m}" + prescription-medication-request → MedicationRequest</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>MedicationRequest</b> 薬剤行</td><td><a href="StructureDefinition-fc-prescription-medication-request.html">FC_PrescriptionMedicationRequest</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td><code>identifier</code> = RP 番号 + RP 内連番<br><code>dosageInstruction[0]</code> = 用法・用量・補足用法<br><code>dispenseRequest.expectedSupplyDuration</code> = 日数<br><code>dispenseRequest.extension</code> = 調剤指示<br><code>substitution</code> = 後発品変更不可</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> rx-dispense</td><td><a href="StructureDefinition-fc-rx-dispense-task.html">FC_RxDispenseTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;ヘッダ</span></td><td>疑義照会の回答待ちは <code>on-hold</code></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> rx-inquiry</td><td><a href="StructureDefinition-fc-rx-inquiry-task.html">FC_RxInquiryTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;ヘッダ</span></td><td>疑義照会(処方医宛の通知)</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>MedicationDispense</b> 調剤</td><td><a href="StructureDefinition-fc-medication-dispense.html">FC_MedicationDispense</a></td><td><span style="white-space: nowrap;"><code>authorizingPrescription</code>&nbsp;→&nbsp;薬剤行</span></td><td>薬剤行ごと、Task と同じ transaction</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Procedure</b> 与薬記録</td><td><a href="StructureDefinition-fc-oral-administration-procedure.html">FC_OralAdministrationProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td>服用予定ごと</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  └ </span><b>MedicationAdministration</b></td><td><a href="StructureDefinition-fc-medication-administration.html">FC_MedicationAdministration</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;与薬記録</span><br><span style="white-space: nowrap;"><code>request</code>&nbsp;→&nbsp;薬剤行</span></td><td></td></tr>
</tbody>
</table>

#### 見分け方

処方のヘッダは、ほかのオーダーと同じく `ServiceRequest.category` の先頭にオーダー種別 `order-type#prescription` を持ちます。2026-10-04 より前のヘッダは種別を持たなかったので、`_history` の旧版を読むときは [既知の非準拠・不具合](known-issues.html) を参照してください。

#### 区分

- 入院・外来区分(`prescription-setting`)と処方区分(`prescription-category`: 入院は 定期 / 継続 / 臨時 / 退院 / 緊急、外来は 院外 / 院内、持参薬の継続は 持参)。
- `authoredOn` = 処方日(交付日)、`occurrenceDateTime` = 投与開始日。定期処方は処方日と投与開始日が一致しないのが普通です。

#### 薬剤行(MedicationRequest)

- `identifier`: RP 番号(`Medication-RPGroupNumber`)と RP 内連番(`MedicationAdministrationIndex`)。同じ RP 番号の行が 1 つの RP で、用法・日数・回数は RP 内の全行に複製します。
- `medicationCodeableConcept`: 銘柄は レセプト電算コード(`medicine-code`)+ YJ コード、一般名処方は `MedicationGeneralOrderCode` のみ。
- `dosageInstruction[0].timing.code` = 用法(JAMI 16 桁 `medicine-usage` + 基本区分 `medicine-usage-basic-category` + text)。
- `doseAndRate[0].doseQuantity` = 用量(`{value, unit}`、UCUM の code は無し)。意味は用法で変わります: 内服(頓用以外)は **1 日量**(不均等投与では各回の量の合計)、頓用は 1 回量、外用などは全量。調剤の数量は 1 日量 × 投与日数(頓用は 1 回量 × 回数)です。
- `additionalInstruction[]` = JAMI 補足用法コード(`urn:oid:1.2.392.200250.2.2.20.22`: I 日数間隔 / W 曜日 / D 日付 / C 期間内回数、不均等投与 V)と用法コメント(text のみ)。
- 頓用は用法コードの 3 桁目が 5 で、`asNeededBoolean = true`、`timing.repeat.count` = 回数。用法マスタに「頓服」区分はありません。
- `dispenseRequest.expectedSupplyDuration` = 投与日数(内服・非頓用のみ、UCUM d)。
- `dispenseRequest.extension` = 調剤指示(JP Core の `JP_MedicationRequest_DispenseRequest_InstructionForDispense`、`valueCodeableConcept` は JAMI 調剤方法コード `http://jami.jp/CodeSystem/DrugDispensePreparationMethod` の OP 一包化 / C 粉砕 / SP 別包化 / MX 混合)。RP 単位で選び、RP 内の全行に同じものを書きます。
- `substitution` = 後発品変更不可。銘柄を指定した外来処方の行だけに付きます(一般名処方と入院処方には付きません)。`allowedCodeableConcept` = JP Core の変更可否コード `MedicationSubstitutionProhibittedCategory#1`「後発品変更不可」、`reason` = `substitution-not-allowed-reason`(medical-necessity 医療上必要 / patient-request 患者希望。処方箋の「変更不可」「患者希望」の列)。変更可なら `substitution` を持ちません。
- 持参薬の継続から作った行は `supportingInformation` が MedicationStatement を指します。

### 注射

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> 1 日分</td><td><a href="StructureDefinition-fc-injection-order.html">FC_InjectionOrder</a></td><td></td><td><code>category</code> = injection + 入院・外来区分 + 注射区分<br><code>extension</code>: injection-series-start / injection-series-schedule(Timing)<br>連日は日ごとに展開(最大 14 件 / 90 日)、requisition(injection-series)で束ねる</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>MedicationRequest</b> 薬剤行</td><td><a href="StructureDefinition-fc-injection-medication-request.html">FC_InjectionMedicationRequest</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;1 日分</span></td><td><code>dosageInstruction[0]</code>: injection-usage-type(点滴 / ワンショット)/ JP_MedicationDosage_Line(injection-line)/ injection-scheduled-period / insulin-scale / timing.event / route(JP route-codes)/ site(JAMI 部位)/ method(JAMI 手技)/ doseQuantity または doseRange / rateQuantity(mL/h)</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> injection</td><td><a href="StructureDefinition-fc-injection-task.html">FC_InjectionTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;1 日分</span></td><td>疑義照会の回答待ちは <code>on-hold</code></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> rx-inquiry</td><td><a href="StructureDefinition-fc-rx-inquiry-task.html">FC_RxInquiryTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;1 日分</span></td><td>疑義照会(処方医宛の通知)</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>MedicationDispense</b> 払出</td><td></td><td><span style="white-space: nowrap;"><code>authorizingPrescription</code>&nbsp;→&nbsp;薬剤行</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>Procedure</b> 実施記録</td><td><a href="StructureDefinition-fc-injection-procedure.html">FC_InjectionProcedure</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;1 日分</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  └ </span><b>MedicationAdministration</b></td><td><a href="StructureDefinition-fc-medication-administration.html">FC_MedicationAdministration</a></td><td><span style="white-space: nowrap;"><code>partOf</code>&nbsp;→&nbsp;実施記録、request → 薬剤行(投与時に追加した薬剤は request 無し)</span></td><td></td></tr>
</tbody>
</table>

実施記録の数が `timing.event` の数に達すると Task が completed になります。

薬剤付加情報マスタでロット管理にした薬(特定生物由来製剤など)は、施用の MedicationAdministration に `medication-lot-number`(valueString)でロット番号を持ちます。注射のほか、処置・手術・内視鏡・放射線の実施入力で投与した薬剤も同じで、ロット管理画面から後で入れることもあります(拡張だけを付け替える)。`Medication.batch` は使いません。上流サーバーの `lot-number` 検索は、この拡張と輸血の `transfusion-lot-number` の両方を引きます。

#### インスリン

量の単位が「単位」の薬剤(インスリン)は、オーダーの `doseQuantity` と実施の `dosage.dose` に UCUM の `[iU]` を持ちます(経過表はこれでインスリンの行を作り、輸血製剤の「単位」と区別します)。スケール指示は薬剤行の `insulin-scale` 拡張です。

| 指示 | dosageInstruction[0] |
|---|---|
| 単位指定 | `doseAndRate.doseQuantity` |
| 血糖・食事量・フリースケール | `insulin-scale`(kind = `insulin-scale-kind`、row = 幅 low / high または条件 condition、dose、note)+ `doseAndRate.doseRange`(施行量の最小〜最大) |
| 単位指定 + スケール | `doseQuantity`(基本量)+ `insulin-scale`(行の dose は基本量への上乗せ) |

- `dose[x]` は choice なので doseQuantity と doseRange は併せ持てません。スケールのみで doseRange を置くのは、単一の量を前提にした読み手(払出数量など)が量を見失わないためです。`text` にはスケールの要約を足します。
- スケールセット(院内マスタ)から写したまま直していなければ `set`(`insulin-scale-set`)を持ちます。
- 実施の MedicationAdministration は 0 単位でも `dose` を残し、`supportingInformation` = スケールに使った測定値(血糖値または主食の摂取量の Observation)です。直近の記録が無く実施入力で血糖値を入れたときは、同じ transaction で血糖値の Observation([FC_CapillaryGlucoseObservation](StructureDefinition-fc-capillary-glucose-observation.html))を作って指します。手で入れた主食の摂取量・フリースケールで選んだ行・案内量と変えた理由は `note` に残します。
- 払出の数量は、スケールの薬剤では施行しうる最大量で数えます。

連日のシリーズを継続するときは、同じ requisition・開始日(`injection-series-start`)・間隔で日を足します。足した日の `injection-series-schedule` だけが新しい終了日(`repeat.boundsPeriod.end`)を持ち、既存の日は書き換えません。

### 疑義照会

処方・注射の疑義照会は、薬剤部から処方医(オーダーの依頼医)への通知 Task で持ちます。照会 1 件が通知 1 件で、1 オーダーに未回答の照会は同時に 1 件までです。

1. 照会: 通知 `rx-inquiry`([FC_RxInquiryTask](StructureDefinition-fc-rx-inquiry-task.html)、owner = 処方医、requester = 薬剤師、input に照会内容)を作り、同じ transaction で進捗 Task(`rx-dispense` / `injection`)を `on-hold`(`statusReason` = `rx-hold-reason#inquiry` 照会中)にします。進捗 Task がまだ無ければ作ります。照会中は調剤登録・払出登録をしません。
2. 回答: 処方医が照会を completed にし、`output` に回答区分(`rx-inquiry-answer`: 処方どおり / 薬剤部で変更してよい / 処方を変更する)と回答文を書きます。同じ transaction で照会した薬剤師宛の通知 `rx-inquiry-answered`([FC_RxInquiryAnsweredTask](StructureDefinition-fc-rx-inquiry-answered-task.html))を作り、進捗 Task を受付済(`accepted`、statusReason を消す)へ戻します。「処方を変更する」のときは `on-hold` のまま `statusReason` を `rx-hold-reason#order-change`(処方変更待ち)にし、処方医がオーダーを編集して保存した transaction で受付済へ戻します。
3. 調剤登録・払出登録の transaction で、そのオーダーの未対応の回答通知を completed にします。
4. 取下げ: 照会を cancelled にし、進捗 Task を受付済へ戻します。

`executionPeriod.start` は on-hold の間も最初に受け付けた時刻のままです。進捗 Task の `note` は、この仕組みより前に調剤登録・払出登録で書いた照会の記録で、今は書きません([既知の非準拠・不具合](known-issues.html))。

### 持参薬

入院時の持参薬は薬剤ごとに MedicationStatement([FC_BroughtMedication](StructureDefinition-fc-brought-medication.html))で持ち、登録(`brought-medication-info`)→ 薬剤部の鑑別(`brought-medication-identification`、Task `brought-med-review`)→ 医師の判断(`brought-medication-decision`、statusReason = 継続 / 休止 / 中止)の順に拡張が増えます。鑑別が終わると入院の主治医宛(主治医がいなければ宛先なし)に `brought-med-identified` 通知が作られます。持参薬の `doseQuantity` は 1 回量で、処方(内服は 1 日量)と意味が違います。継続で処方を起こすときは、内服(頓用以外)の用量を 1 回量 × 1 日の服用回数にします。「継続」は処方区分 brought の院内処方を同じ transaction で作ります。

### 化学療法レジメン

レジメンの定義は backend のマスタ(PlanDefinition は無し)で、適用は `intent = plan` の ServiceRequest([FC_RegimenOrder](StructureDefinition-fc-regimen-order.html))です。

- `code` = レジメンコード(`regimen`)、`identifier` = `regimen-instance`、`instantiatesUri` = `http://fhir-client.local/regimen/{code}`、`occurrenceDateTime` = 第 1 サイクル Day 1。
- `regimen` 拡張にサイクル日数・治療日数・予定サイクル数(任意。無ければ継続)・体表面積・身長・体重と、中止・完了の記録。
- 日オーダーを中止すると、その調剤・注射の Task が cancelled になり `statusReason.text` に中止理由を持ちます(中止取消で消える)。
- 各サイクル・各日の注射 / 処方は通常の注射 / 処方オーダーで、`requisition` = regimen-instance、`regimen-order` 拡張(regimen / cycle / day / code / name / reduction)を持ち、各 MedicationRequest に `regimen-dose`(drug / ratio / amount / unit / packs)が付きます。
- 化学療法の予約 Appointment は日オーダーを `basedOn` で指します。有害事象は Observation([FC_AdverseEventObservation](StructureDefinition-fc-adverse-event-observation.html))で、`basedOn` がレジメン適用を指します。

### JP Core との関係

処方の MedicationRequest は JP Core の JP_MedicationRequest を意識した形(RP 番号・RP 内連番の identifier 必須スライス)ですが、`doseQuantity` に UCUM の code を持たないため JP_MedicationRequest には準拠せず、本 IG のプロファイルは base から派生しています。注射も同様で、JP_MedicationRequest_Injection が要求する `medicationReference` ではなく `medicationCodeableConcept` を使います。MedicationDispense / MedicationAdministration も JP Core が要求する RP 内連番の identifier を持ちません([既知の非準拠](known-issues.html))。

### 例

- 処方: [ヘッダ](ServiceRequest-example-prescription-order.html) / [薬剤行](MedicationRequest-example-prescription-medication-request.html) / [外来のヘッダ](ServiceRequest-example-outpatient-prescription-order.html) / [後発品変更不可・調剤指示のある薬剤行](MedicationRequest-example-outpatient-prescription-medication-request.html) / [調剤](MedicationDispense-example-medication-dispense.html) / [与薬記録](Procedure-example-oral-administration-procedure.html) / [投与](MedicationAdministration-example-medication-administration.html) / [Task](Task-example-rx-dispense-task.html)
- 注射: [1 日分](ServiceRequest-example-injection-order.html) / [薬剤行](MedicationRequest-example-injection-medication-request.html) / [実施記録](Procedure-example-injection-procedure.html) / [Task](Task-example-injection-task.html)
- 疑義照会: [照会](Task-example-rx-inquiry-task.html) / [回答の通知](Task-example-rx-inquiry-answered-task.html) / [処方変更待ちの調剤 Task](Task-example-rx-dispense-task-on-hold.html)
- インスリン: [薬剤行(血糖スケール)](MedicationRequest-example-insulin-medication-request.html) / [施用](MedicationAdministration-example-insulin-medication-administration.html) / [血糖値](Observation-example-capillary-glucose-observation.html)
- ロット番号: [施用](MedicationAdministration-example-lot-medication-administration.html)
- [持参薬](MedicationStatement-example-brought-medication.html) / [鑑別 Task](Task-example-brought-med-review-task.html)
- [レジメン適用](ServiceRequest-example-regimen-order.html) / [有害事象](Observation-example-adverse-event-observation.html)
