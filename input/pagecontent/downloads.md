### パッケージ

- [FHIR パッケージ(package.tgz)](package.tgz): 本 IG の StructureDefinition / CodeSystem / ValueSet / NamingSystem / 例を含む NPM 形式のパッケージ。
- [定義のみ(definitions.json.zip)](definitions.json.zip)
- [例のみ(examples.json.zip)](examples.json.zip)
- [IG 全体(full-ig.zip)](full-ig.zip)

### ソース

FSH のソースと本文は GitHub の [ysnr-dev/fhir-ig](https://github.com/ysnr-dev/fhir-ig) にあります。`main` ブランチへの push で GitHub Actions がビルドし、このサイトを更新します。

### 依存パッケージ

| パッケージ | バージョン | 入手先 |
|---|---|---|
| jpfhir.jp.core(JP Core) | 1.2.0 | https://jpfhir.jp/fhir/core/1.2.0/package.tgz |
| jpfhir-terminology | 1.4.0 | https://jpfhir.jp/fhir/core/terminology/jpfhir-terminology.r4-1.4.0.tgz |
| jaspehr(JASPEHR) | 1.0.0 | https://jaspehr.jp/wp-content/docs/full-ig_v1.0.0/site/package.tgz |

いずれも公開パッケージレジストリには無いため、ビルド前に `_installdeps.sh` で `~/.fhir/packages` に展開します。

### QA

IG Publisher の検証結果は [qa.html](qa.html) にあります。
