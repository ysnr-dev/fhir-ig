### 構造

```
ServiceRequest(ヘッダ、FC_MicroOrderHeader)
 ├ ServiceRequest(検体グループ、identifier = 1、FC_MicroOrderSpecimenGroup)  basedOn → ヘッダ
 │   ├ contained Specimen(#specimen、FC_MicroOrderSpecimen)
 │   ├ orderDetail = 目的菌(janis-organism)
 │   └ ServiceRequest(検査項目、identifier = 2〜、FC_MicroOrderItem)  basedOn → 検体グループ
 └ DiagnosticReport(結果報告、FC_MicroDiagnosticReport)  basedOn → ヘッダ
     ├ specimen → Specimen(FC_MicroResultSpecimen)
     └ result → 所見 / 分離菌 / 感受性の Observation
```

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
