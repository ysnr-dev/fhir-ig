### 構造

```
ServiceRequest(ヘッダ、FC_PathoOrderHeader)
 │  extension: patho-clinical-info / patho-clinical-info-questionnaire-response / patho-report-due / patho-operating-room / patho-schema-image(0..*)
 ├ ServiceRequest(検体明細、FC_PathoOrderItem)  basedOn → ヘッダ
 │   └ contained Specimen(#specimen、FC_PathoOrderSpecimen)
 ├ Binary(シェーマ画像)、QuestionnaireResponse(臨床情報テンプレート)   ※ 同じ transaction
 ├ Task(patho-exam、FC_PathoExamTask)  focus → ヘッダ
 └ DiagnosticReport(病理診断レポート、FC_PathoDiagnosticReport)  basedOn → ヘッダ
     ├ specimen → Specimen(FC_PathoResultSpecimen)
     └ result → Observation(セクションごと、FC_PathoFindingObservation)
```

### オーダー

- ヘッダの `code` = 検査区分(JAHIS LPATHO001: N000 組織診 / N004 細胞診 / N003 術中迅速)。`occurrenceDateTime` = 採取日時。
- 検体明細は `identifier` = 検体番号、`code.text` のみ。contained Specimen は `type` = JAHIS 検体タイプ(LPATHO002)、`collection.bodySite` = 臓器(`jahis-patho-organ`、JAHIS 付録 533 件)+ 左右(`patho-laterality`)、`collection.method` = 採取方法。
- シェーマ画像は `patho-schema-image`(valueAttachment、url = Binary)。

### レポート

JAHIS 病理診断レポート構造化記述規約のセクション構成に合わせ、セクションごとの Observation(LOINC 22634-0 肉眼所見 / 22635-7 顕微鏡所見 / 22637-3 診断 / 10157-6 採取法・検体処理法)を `result` に並べます。細胞診の診断は `valueCodeableConcept`(`patho-cyto-judgement`)と component 推定病変です。詳細は [検査結果・報告](results.html)。

### 例

- [ヘッダ](ServiceRequest-example-patho-order-header.html) / [検体明細](ServiceRequest-example-patho-order-item.html)
- [Task](Task-example-patho-exam-task.html)
- [レポート](DiagnosticReport-example-patho-diagnostic-report.html)
