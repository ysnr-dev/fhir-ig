### 構造

<table class="grid" style="clear: both;">
<thead><tr><th>リソース</th><th>プロファイル</th><th>参照</th><th>主な要素・備考</th></tr></thead>
<tbody>
<tr><td style="white-space: nowrap;"><b>ServiceRequest</b> ヘッダ</td><td><a href="StructureDefinition-fc-micro-order-header.html">FC_MicroOrderHeader</a></td><td></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">├ </span><b>ServiceRequest</b> 検体グループ、identifier = 1</td><td><a href="StructureDefinition-fc-micro-order-specimen-group.html">FC_MicroOrderSpecimenGroup</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td><code>orderDetail</code> = 目的菌(janis-organism)</td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ ├ </span><b>Specimen</b> #specimen</td><td><a href="StructureDefinition-fc-micro-order-specimen.html">FC_MicroOrderSpecimen</a></td><td><span style="white-space: nowrap;">親の <code>contained</code></span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">│ └ </span><b>ServiceRequest</b> 検査項目、identifier = 2〜</td><td><a href="StructureDefinition-fc-micro-order-item.html">FC_MicroOrderItem</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;検体グループ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">└ </span><b>DiagnosticReport</b> 結果報告</td><td><a href="StructureDefinition-fc-micro-diagnostic-report.html">FC_MicroDiagnosticReport</a></td><td><span style="white-space: nowrap;"><code>basedOn</code>&nbsp;→&nbsp;ヘッダ</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  ├ </span><b>Specimen</b></td><td><a href="StructureDefinition-fc-micro-result-specimen.html">FC_MicroResultSpecimen</a></td><td><span style="white-space: nowrap;">親の <code>specimen</code> から参照</span></td><td></td></tr>
<tr><td style="white-space: nowrap;"><span style="white-space: pre; color: #888;">  └ </span><b>Observation</b> 所見 / 分離菌 / 感受性</td><td></td><td><span style="white-space: nowrap;">親の <code>result</code> から参照</span></td><td></td></tr>
</tbody>
</table>

進捗の Task はありません。`ServiceRequest.status` は常に active で、結果の有無は `basedOn` で紐付く DiagnosticReport(preliminary 中間報告 / final 最終報告)で読みます。

### オーダー

- ヘッダの拡張: `micro-prior-antimicrobial`(先行抗菌薬、自由記載)、`micro-exam-purpose`(diagnostic 診断目的 / surveillance 監視培養)。
- 検体グループの contained Specimen: `type` = JANIS 検体種別、`collection.bodySite` = 採取部位(`micro-collection-site`)+ 左右(`micro-laterality`)、`collection.method` = 採取方法。
- 検査項目の `code` = `micro-order-item`(培養・同定・感受性・塗抹など)。

2026-10-03 より前に書かれた細菌検査ヘッダは、ほとんどが依頼科・病棟を持ちません([既知の問題](known-issues.html))。

### 結果

[検査結果・報告](results.html) の細菌検査を参照。

### 例

- [ヘッダ](ServiceRequest-example-micro-order-header.html)
- [検体グループ](ServiceRequest-example-micro-order-specimen-group.html)
- [検査項目](ServiceRequest-example-micro-order-item.html)
- [報告](DiagnosticReport-example-micro-diagnostic-report.html)
