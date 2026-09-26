### 報告の共通点

検査結果・報告は **DiagnosticReport** で、`basedOn` がオーダーのヘッダ ServiceRequest、`result` が項目ごとの Observation、`specimen` が検体を指します。

| 報告 | プロファイル | category | code | status |
|---|---|---|---|---|
| 検体検査 | [FC_LabDiagnosticReport](StructureDefinition-fc-lab-diagnostic-report.html) | v2-0074#LAB + 入院・外来区分 | LOINC 11502-2 | preliminary 中間 / final 最終 / corrected 訂正 |
| 細菌検査 | [FC_MicroDiagnosticReport](StructureDefinition-fc-micro-diagnostic-report.html) | v2-0074#MB + 入院・外来区分 | LOINC 18725-2 | preliminary / final |
| 放射線 読影 | [FC_RadDiagnosticReport](StructureDefinition-fc-rad-diagnostic-report.html) | LOINC LP29684-5 + v2-0074#RAD + 入院・外来区分 | JP_DocumentCodes_CS#18748-4 | preliminary / final / amended |
| 病理診断 | [FC_PathoDiagnosticReport](StructureDefinition-fc-patho-diagnostic-report.html) | v2-0074#SP または #CP + 入院・外来区分 | LOINC 11526-1 | preliminary / final / amended 修正 |

- 入院・外来区分は `lab-result-setting`(inpatient / outpatient)。
- 依頼科は `order-department` 拡張。
- 確定した報告を編集保存すると status が corrected(検体検査)/ amended(読影・病理)に遷移します。
- preliminary でない報告で依頼医宛の `result-review` 通知が作られ、確認すると結果確認の Provenance(verifier + signature)が付きます。

### 検体検査

- 項目ごとの Observation([FC_LabResultObservation](StructureDefinition-fc-lab-result-observation.html)): `code.coding` = [院内結果項目(`lab-result-item`), JLAC11, JLAC10, 略称]、値はマスタのデータ型で Quantity(UCUM)/ CodeableConcept / string、`interpretation` = v3(HH / H / L / LL / N)、`referenceRange`。
- パニック値(HH / LL)があると `lab-panic` 通知(priority = stat)が作られます。宛先が決まらないときは owner を持ちません。
- 検体は検体ラベルの Specimen を参照します(結果入力で作ることもある)。

### 細菌検査

- 所見([FC_MicroFindingObservation](StructureDefinition-fc-micro-finding-observation.html)): 培養(陰性 / 陽性)、塗抹(string)、喀痰 Miller & Jones / Geckler 分類、膿尿(method = 判定方法)。
- 分離菌([FC_MicroIsolateObservation](StructureDefinition-fc-micro-isolate-observation.html)): `valueCodeableConcept` = 菌種(JANIS)、component = 菌量の種別 / 菌量 / 起因菌。
- 感受性([FC_MicroSusceptibilityObservation](StructureDefinition-fc-micro-susceptibility-observation.html)): `code` = 抗菌薬(JANIS + 略称)、`derivedFrom` = 分離菌、`method` = 測定法、MIC は Quantity(ug/mL、comparator)、component = 阻止円直径 / 段階、`interpretation` = S / I / R。

### 放射線 読影

- `result` = 所見 Observation(category imaging、`rad-report-item#findings`、valueString)、`conclusion` = 診断、`resultsInterpreter` = 読影医。
- 画像は `rad-report-image`(source / annotated、Binary)、重要所見は `rad-critical-finding`(通知 Task)、テンプレート記入は `rad-report-findings-response` / `rad-report-conclusion-response`。

### 病理診断

- `result` = セクションごとの Observation([FC_PathoFindingObservation](StructureDefinition-fc-patho-finding-observation.html)、LOINC 22634-0 肉眼所見 / 22635-7 顕微鏡所見 / 22637-3 診断 / 10157-6 採取法・検体処理法)。細胞診の診断は `patho-cyto-judgement` と component 推定病変。
- `specimen` = 検体(臓器・検体タイプ・実採取日)。検体が 1 件のときだけ Observation.specimen も指します。
- 画像は `patho-report-image`(kind + image)。

### JP Core との関係

検体検査の報告と Observation にアプリは `meta.profile` = JP_DiagnosticReport_LabResult / JP_Observation_LabResult を付けますが、category の system(HL7 observation-category)や報告の category / code の持ち方が JP Core 1.2.0 の定義と異なります。本 IG では DiagnosticReport を JP_DiagnosticReport_Common から、Observation を base から派生させています([既知の非準拠](known-issues.html))。

### 例

- 検体検査: [報告](DiagnosticReport-example-lab-diagnostic-report.html) / [結果項目](Observation-example-lab-result-observation.html) / [緊急異常値の通知](Task-example-lab-panic-task.html)
- 細菌検査: [報告](DiagnosticReport-example-micro-diagnostic-report.html) / [分離菌](Observation-example-micro-isolate-observation.html) / [感受性](Observation-example-micro-susceptibility-observation.html)
- 放射線: [読影レポート](DiagnosticReport-example-rad-diagnostic-report.html) / [重要所見の通知](Task-example-rad-critical-finding-task.html)
- 病理: [レポート](DiagnosticReport-example-patho-diagnostic-report.html)
