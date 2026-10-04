### 処方

```
ServiceRequest(ヘッダ、FC_PrescriptionOrder)
 │  category = prescription + 入院・外来区分 + 処方区分 / orderDetail[] = "RP{n}-{m}" + prescription-medication-request → MedicationRequest
 ├ MedicationRequest(薬剤行、FC_PrescriptionMedicationRequest)  basedOn → ヘッダ
 │   identifier = RP 番号 + RP 内連番 / dosageInstruction[0] = 用法・用量・補足用法 / dispenseRequest.expectedSupplyDuration = 日数
 ├ Task(rx-dispense、FC_RxDispenseTask)  focus → ヘッダ   ※ note = 疑義照会
 ├ MedicationDispense(調剤、FC_MedicationDispense)  authorizingPrescription → 薬剤行   ※ 薬剤行ごと、Task と同じ transaction
 └ Procedure(与薬記録、FC_OralAdministrationProcedure)  basedOn → ヘッダ   ※ 服用予定ごと
     └ MedicationAdministration(FC_MedicationAdministration)  partOf → 与薬記録、request → 薬剤行
```

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
- 持参薬の継続から作った行は `supportingInformation` が MedicationStatement を指します。

### 注射

```
ServiceRequest(1 日分、FC_InjectionOrder)   ※ 連日は日ごとに展開(最大 14 件 / 90 日)、requisition(injection-series)で束ねる
 │  category = injection + 入院・外来区分 + 注射区分 / extension: injection-series-start / injection-series-schedule(Timing)
 ├ MedicationRequest(薬剤行、FC_InjectionMedicationRequest)  basedOn → 1 日分
 │   dosageInstruction[0]: injection-usage-type(点滴 / ワンショット)/ JP_MedicationDosage_Line(injection-line)/ injection-scheduled-period /
 │                         insulin-scale / timing.event / route(JP route-codes)/ site(JAMI 部位)/ method(JAMI 手技)/
 │                         doseQuantity または doseRange / rateQuantity(mL/h)
 ├ Task(injection、FC_InjectionTask)  focus → 1 日分
 ├ MedicationDispense(払出)  authorizingPrescription → 薬剤行
 └ Procedure(実施記録、FC_InjectionProcedure)  basedOn → 1 日分
     └ MedicationAdministration  partOf → 実施記録、request → 薬剤行(投与時に追加した薬剤は request 無し)
```

実施記録の数が `timing.event` の数に達すると Task が completed になります。

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

- 処方: [ヘッダ](ServiceRequest-example-prescription-order.html) / [薬剤行](MedicationRequest-example-prescription-medication-request.html) / [調剤](MedicationDispense-example-medication-dispense.html) / [与薬記録](Procedure-example-oral-administration-procedure.html) / [投与](MedicationAdministration-example-medication-administration.html) / [Task](Task-example-rx-dispense-task.html)
- 注射: [1 日分](ServiceRequest-example-injection-order.html) / [薬剤行](MedicationRequest-example-injection-medication-request.html) / [実施記録](Procedure-example-injection-procedure.html) / [Task](Task-example-injection-task.html)
- インスリン: [薬剤行(血糖スケール)](MedicationRequest-example-insulin-medication-request.html) / [施用](MedicationAdministration-example-insulin-medication-administration.html) / [血糖値](Observation-example-capillary-glucose-observation.html)
- [持参薬](MedicationStatement-example-brought-medication.html) / [鑑別 Task](Task-example-brought-med-review-task.html)
- [レジメン適用](ServiceRequest-example-regimen-order.html) / [有害事象](Observation-example-adverse-event-observation.html)
