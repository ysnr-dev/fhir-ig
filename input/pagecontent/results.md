### 報告の共通点

検査結果・報告は **DiagnosticReport** で、`basedOn` がオーダーのヘッダ ServiceRequest、`result` が項目ごとの Observation、`specimen` が検体を指します。検体検査・細菌検査・病理は、オーダーに紐付けずに結果を登録(取込)でき、そのときは `basedOn` を持ちません。

| 報告 | プロファイル | category | code | status |
|---|---|---|---|---|
| 検体検査 | [FC_LabDiagnosticReport](StructureDefinition-fc-lab-diagnostic-report.html) | v2-0074#LAB + 入院・外来区分 | LOINC 11502-2 | preliminary 中間 / final 最終 / corrected 訂正 |
| 細菌検査 | [FC_MicroDiagnosticReport](StructureDefinition-fc-micro-diagnostic-report.html) | v2-0074#MB + 入院・外来区分 | LOINC 18725-2 | preliminary / final |
| 放射線 読影 | [FC_RadDiagnosticReport](StructureDefinition-fc-rad-diagnostic-report.html) | LOINC LP29684-5 + v2-0074#RAD + 入院・外来区分 | JP_DocumentCodes_CS#18748-4 | preliminary / final / amended |
| 生理検査 所見 | [FC_PhysioDiagnosticReport](StructureDefinition-fc-physio-diagnostic-report.html) | order-type#physio + v2-0074#OTH + 入院・外来区分 | exam-report#physio | preliminary / final / amended |
| 内視鏡 所見 | [FC_EndoscopyDiagnosticReport](StructureDefinition-fc-endoscopy-diagnostic-report.html) | order-type#endoscopy + v2-0074#OTH + 入院・外来区分 | LOINC 18751-8 | preliminary / final / amended |
| 病理診断 | [FC_PathoDiagnosticReport](StructureDefinition-fc-patho-diagnostic-report.html) | v2-0074#SP または #CP + 入院・外来区分 | LOINC 11526-1 | preliminary / final / amended 修正 |

- 入院・外来区分は `lab-result-setting`(inpatient / outpatient)。
- 依頼科は `order-department` 拡張。
- 確定した報告を編集保存すると status が corrected(検体検査)/ amended(読影・生理検査・内視鏡・病理)に遷移します。
- preliminary でない報告で依頼医宛の `result-review` 通知が作られ、確認すると結果確認の Provenance(verifier + signature)が付きます。オーダーに紐付かない結果の通知は宛先(owner)を持ちません。
- 同じ報告に緊急異常値(検体検査)・重要所見(読影・生理検査・内視鏡)の通知が未対応で残っている間は `result-review` を作らず、既にある未対応の `result-review` は cancelled にします(1 つの結果に通知を 1 件にする)。緊急の通知を確認したときに、報告が final / corrected(amended)なら結果確認の Provenance も書き、未対応の `result-review` を completed にします。
- `effectiveDateTime` の意味は報告ごとに違います: 検体検査・細菌検査 = 検体日(採取日、日付のみ)、読影・生理検査・内視鏡 = 検査日時(実施記録の日時。無ければオーダーの実施予定日)、病理 = 報告日。`issued` と `performer` は検体検査と読影・生理検査・内視鏡が持ち、細菌検査と病理は持ちません。

### 検体検査

- 項目ごとの Observation([FC_LabResultObservation](StructureDefinition-fc-lab-result-observation.html)): `code.coding` = [院内結果項目(`lab-result-item`), JLAC11, JLAC10, 略称(`lab-item-abbreviation`。code = 結果項目コード、display = 略称)]。施設の結果項目コードを持たない項目は JLAC11 から始まります、値はマスタのデータ型で Quantity(UCUM)/ CodeableConcept / string、`interpretation` = v3(HH / H / L / LL / N)、`referenceRange`。
- パニック値(HH / LL)があると、報告区分に関係なく(中間報告でも)`lab-panic` 通知(priority = stat)が作られます。訂正で値が変わると本文を更新して未対応に戻し、パニック値が無くなると未対応の通知を cancelled にします。宛先が決まらないときは owner を持ちません。
- 検体は検体ラベルの Specimen を参照します(結果入力で作ることもある)。

### 細菌検査

- 所見([FC_MicroFindingObservation](StructureDefinition-fc-micro-finding-observation.html)): 培養結果(陰性 / 陽性)、塗抹・鏡検所見(string)、喀痰品質評価(Miller & Jones 分類 / Geckler 分類)、膿尿評価(method = 判定方法)。
- 分離菌([FC_MicroIsolateObservation](StructureDefinition-fc-micro-isolate-observation.html)): `valueCodeableConcept` = 菌種(JANIS)、component = 菌量(半定量 / 定量)/ 菌数 / 起炎性。
- 感受性([FC_MicroSusceptibilityObservation](StructureDefinition-fc-micro-susceptibility-observation.html)): `code` = 抗菌薬(JANIS コード + 同じコードに略号を display として付けた coding)、`derivedFrom` = 分離菌、`method` = 測定法、MIC は Quantity(µg/mL、comparator)、component = 阻止円径 / 判定(+)、`interpretation` = S / I / R。

### 放射線 読影

- `result` = 所見 Observation(category imaging、`rad-report-item#findings`、valueString)、`conclusion` = 診断、`resultsInterpreter` = 読影医。
- 画像は `rad-report-image`(source / annotated、Binary)、重要所見は `rad-critical-finding`(通知 Task)、テンプレート記入は `rad-report-findings-response` / `rad-report-conclusion-response`。
- 重要所見の通知は暫定報告でも出します。要点を書き換えると通知を未対応に戻し、要点を外すと未対応の通知を cancelled にします。レポートを削除すると、未対応の重要所見・検査結果確認の通知を cancelled にします(生理検査・内視鏡も同じ)。

### 生理検査・内視鏡 所見

読影レポートと同じ形で、category・code・拡張の接頭辞(`physio-` / `endoscopy-`)が違います。

- category の 1 つ目はオーダー種別(`order-type#physio` / `#endoscopy`、実施記録 Procedure.category と同じ coding)で、`DiagnosticReport?category=` で種別ごとに引けます。2 つ目の v2-0074 は `OTH` に固定しています。
- code は生理検査が施設コード `exam-report#physio`(心電図・超音波・呼吸機能…と文書の種類が分かれるため)、内視鏡が LOINC 18751-8。`code.text` = 検査内容。
- `result` = 所見 Observation([FC_PhysioFindingsObservation](StructureDefinition-fc-physio-findings-observation.html) / [FC_EndoscopyFindingsObservation](StructureDefinition-fc-endoscopy-findings-observation.html)、category procedure、`physio-report-item#findings` / `endoscopy-report-item#findings`、valueString)、`conclusion` = 判定(生理検査)/ 診断(内視鏡)、`resultsInterpreter` = 記載医。
- 画像は `<接頭辞>-report-image`、重要所見は `<接頭辞>-critical-finding`(通知 Task `physio-critical-finding` / `endoscopy-critical-finding`)、テンプレート記入は `<接頭辞>-report-findings-response` / `<接頭辞>-report-conclusion-response`。

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
- 生理検査: [所見レポート](DiagnosticReport-example-physio-diagnostic-report.html) / [所見](Observation-example-physio-findings-observation.html) / [重要所見の通知](Task-example-physio-critical-finding-task.html)
- 内視鏡: [所見レポート](DiagnosticReport-example-endoscopy-diagnostic-report.html) / [所見](Observation-example-endoscopy-findings-observation.html) / [重要所見の通知](Task-example-endoscopy-critical-finding-task.html)
- 病理: [レポート](DiagnosticReport-example-patho-diagnostic-report.html)
