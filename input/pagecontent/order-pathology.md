### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> ヘッダ</td><td><a href="StructureDefinition-fc-patho-order-header.html">FC_PathoOrderHeader</a></td><td></td><td><code>extension</code>: patho-clinical-info / patho-clinical-info-questionnaire-response / patho-report-due / patho-operating-room / patho-schema-image(0..*)</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>ServiceRequest</b> 検体明細</td><td><a href="StructureDefinition-fc-patho-order-item.html">FC_PathoOrderItem</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ └ </span><b>Specimen</b> #specimen</td><td><a href="StructureDefinition-fc-patho-order-specimen.html">FC_PathoOrderSpecimen</a></td><td><span style="white-space: nowrap;">親の <code>contained</code></span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Binary</b> シェーマ画像</td><td></td><td></td><td>ヘッダと同じ transaction</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>QuestionnaireResponse</b> 臨床情報テンプレート</td><td><a href="StructureDefinition-fc-questionnaire-response.html">FC_QuestionnaireResponse</a></td><td></td><td>ヘッダと同じ transaction</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>Task</b> patho-exam</td><td><a href="StructureDefinition-fc-patho-exam-task.html">FC_PathoExamTask</a></td><td><span style="white-space: nowrap;"><code>focus</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>DiagnosticReport</b> 病理診断レポート</td><td><a href="StructureDefinition-fc-patho-diagnostic-report.html">FC_PathoDiagnosticReport</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  ├ </span><b>Specimen</b></td><td><a href="StructureDefinition-fc-patho-result-specimen.html">FC_PathoResultSpecimen</a></td><td><span style="white-space: nowrap;">親の <code>specimen</code> から参照</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  └ </span><b>Observation</b> セクションごと</td><td><a href="StructureDefinition-fc-patho-finding-observation.html">FC_PathoFindingObservation</a></td><td><span style="white-space: nowrap;">親の <code>result</code> から参照</span></td><td></td></tr>
</tbody>
</table>

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
