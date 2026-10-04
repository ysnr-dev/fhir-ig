### この実装ガイドについて

fhir-client は、FHIR R4 の JSON を直接組み立てて上流の FHIR サーバー(fhir-server)に書き込む電子カルテ Web クライアントです。
この実装ガイドは、fhir-client が作成する FHIR リソースの仕様を定義します。

- 独自の Extension(`http://fhir-client.local/StructureDefinition/...`)
- 独自の CodeSystem(`http://fhir-client.local/CodeSystem/...`)と ValueSet
- 識別子体系(`http://fhir-client.local/IdSystem/...` ほか)
- リソース種別ごとのプロファイル(JP Core プロファイルからの派生と、base リソースからの派生)
- リソース間の参照関係(オーダーのヘッダと明細、Task、実施記録、報告書 など)

### 対象読者

- fhir-client / fhir-server の開発者
- fhir-client が書いたデータを読む外部システム(院内エージェント、レセプトコンピュータ連携、分析基盤)の開発者

### 依存する実装ガイド

| 実装ガイド | バージョン | 用途 |
|---|---|---|
| [JP Core](http://jpfhir.jp/fhir/core/) | 1.2.0 | Patient / Practitioner / Organization / Location / Encounter / Condition / AllergyIntolerance / Procedure / Specimen / Observation / DiagnosticReport / Medication* の親プロファイルと、用法・部位などの用語 |
| [SDC](http://hl7.org/fhir/uv/sdc/) | 3.0.0 | テンプレート(Questionnaire)が使う拡張(sdc-questionnaire-observationExtract、initialExpression など)の定義 |
| [JASPEHR](https://jaspehr.jp/) | 1.0.0 | Questionnaire / QuestionnaireResponse にアプリが付ける meta.profile と上流サーバーの検証規則。パッケージ依存にはせず本文で参照する |
| [ePath R4](https://e-path.jp/fhir/ePath/) | 1.0.1 | クリニカルパス(CarePlan 木)の拡張と用語。パッケージ依存にはせず URL を参照する |

### 読み方

1. [共通規約](guidance-common.html) でオーダー全体に共通する構造(ヘッダと明細、category の順序、日付の意味、Task)を読む。
2. 部門ごとのページ([オーダー](orders.html))でその部門の ServiceRequest / Task / 実施記録の形を確認する。
3. 要素ごとの制約は Artifacts の各プロファイル・拡張・CodeSystem を参照する。

### 実装上の注意

- 上流サーバーはクライアントが送った `meta.profile` を保存しない(読み出し時にリソース種別ごとに 1 つのプロファイルを付け直す)。本 IG のプロファイル準拠は要素の内容で判定する。
- 上流サーバーは Procedure・Observation・DiagnosticReport の `category` を先頭要素しか検索索引に載せない。種別を表す coding は必ず先頭に置く(ServiceRequest も同じ並び)。
- 詳細は [既知の非準拠・不具合](known-issues.html) を参照。
