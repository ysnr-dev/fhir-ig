# fhir-ig

[fhir-client](https://github.com/ysnr-dev/fhir-client) が上流 FHIR サーバーに作成する FHIR R4 リソースの仕様を、
FHIR Shorthand(FSH)で記述した実装ガイド(IG)です。
`main` ブランチへの push で GitHub Actions がビルドし、GitHub Pages に公開します。

- 公開先: https://ysnr-dev.github.io/fhir-ig/
- canonical: `http://fhir-client.local`(fhir-client のコードが出す Extension / CodeSystem の URL と一致させている)

## 構成

```
fhir-ig/
├── sushi-config.yaml        # IG の定義(id / canonical / 依存 / ページ / メニュー)
├── ig.ini
├── input/
│   ├── fsh/
│   │   ├── aliases.fsh  rulesets.fsh  namingsystems.fsh
│   │   ├── terminology/     # CodeSystem と対の ValueSet(ドメインごと)
│   │   ├── extensions/      # Extension(ドメインごと)
│   │   ├── profiles/        # Profile(オーダー / Task / 薬剤 / 実施記録 / 結果 / 記録 / パス / 管理 / 予約)
│   │   └── examples/        # 例(具象プロファイルごとに 1 件以上)
│   └── pagecontent/         # 本文ページ(Markdown、日本語)
├── _installdeps.sh          # 公開レジストリに無い依存パッケージを ~/.fhir/packages に展開
├── _updatepublisher.sh      # IG Publisher(publisher.jar)のダウンロード
├── _build.sh                # sushi → IG Publisher(-tx n/a)
├── _docker.sh               # hl7fhir/ig-publisher-base コンテナで _build.sh を実行
└── .github/workflows/publish.yml
```

## 依存パッケージ

| パッケージ | バージョン | 入手先 |
|---|---|---|
| jpfhir.jp.core(JP Core) | 1.2.0 | https://jpfhir.jp/fhir/core/1.2.0/package.tgz |
| jpfhir-terminology(.r4) | 1.4.0 | https://jpfhir.jp/fhir/core/terminology/jpfhir-terminology.r4-1.4.0.tgz |

いずれも公開パッケージレジストリ(packages.fhir.org)には無いため、`_installdeps.sh` でダウンロードして
`~/.fhir/packages/<name>#<version>/package` に展開します(SUSHI と IG Publisher が共用するキャッシュ)。

## ビルド

### FSH だけを検査する(速い)

```bash
npm install -g fsh-sushi   # 初回。node 22 以上
./_installdeps.sh          # 初回
sushi .                    # fsh-generated/ に FHIR JSON を出力
```

### IG 全体をビルドする(Docker)

ホストに Java 17 以上が無くても、IG Publisher 同梱のコンテナでビルドできます。

```bash
./_docker.sh               # output/index.html と output/qa.html ができる(約 20 分)
open output/index.html
```

バインドマウント上で IG Publisher を動かすと Docker Desktop for Mac では数万ファイルの書き込みが極端に遅い(2 時間以上)ため、
`_docker.sh` はリポジトリをコンテナ内のディスクにコピーしてビルドし、`output/` だけホストに書き戻します。
`IG_HEAP=4g ./_docker.sh` でヒープを変えられます(既定 3g。Jekyll と合わせて Docker Desktop のメモリは 6 GB 以上)。

### IG 全体をビルドする(ホスト)

Java 17 以上・jekyll・sushi がある環境では `./_build.sh` を直接実行します。

## 公開(GitHub Pages)

1. GitHub にリポジトリ `ysnr-dev/fhir-ig` を作り、`git remote add origin git@github-ysnr:ysnr-dev/fhir-ig.git` で紐付ける。
2. リポジトリの Settings → Pages → Build and deployment → Source を **GitHub Actions** にする。
3. `main` に push すると `.github/workflows/publish.yml` が SUSHI → IG Publisher → Pages デプロイを行う。
   Pull Request ではビルドだけ行い、デプロイしない。
4. ビルド結果の QA(エラー / 警告数)は Actions の Job Summary に出る。`qa.html` は公開先の `/qa.html`。

ビルドが失敗するのは SUSHI のエラーと IG Publisher の異常終了だけで、IG Publisher の QA のエラー・警告では失敗しません。
QA に残るエラーは、アプリ側の既知の非準拠(`known-issues.md` に記載: 処方・注射ヘッダの prr-1、jpfhir-terminology に無い MEDIS コード)と、
院内マスタ由来コードへの narrative リンクだけです。

## 書き方の規約

- Extension / CodeSystem の `Id` は fhir-client が出す URL の末尾と完全に一致させる(`Id: order-department` → `http://fhir-client.local/StructureDefinition/order-department`)。
- Profile の `Id` は `fc-<resource>-<variant>`、`Name` は `FC_<Resource>_<Variant>`。
- コードが列挙されている CodeSystem は `content = #complete` + 日本語 display + 対の ValueSet(`<id>-vs`)。院内マスタ由来は `content = #not-present`。
- 具象プロファイルには必ず 1 件以上の例を書く(IG Publisher がプロファイルで検証するので、FSH がアプリの出力と合っているかの主な確認手段)。
- 本文・Title・display は日本語。
