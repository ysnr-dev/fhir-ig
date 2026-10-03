### DPC 様式1

DPC 退院患者調査の様式1 は、入院 1 件につき 1 つの **QuestionnaireResponse**([FC_DpcForm1Response](StructureDefinition-fc-dpc-form1-response.html))に保存します。提出ファイル(FF1)は backend がこの QuestionnaireResponse を機械的に行へ展開して作ります。

- `questionnaire` = `http://fhir-client.local/Questionnaire/dpc-form1`(固定。バージョン無し)。対応する Questionnaire リソースは上流に置きません。項目の定義(レコードごとのペイロードの意味・必須条件)はアプリの年度別の定義表が持ちます。
- `encounter` = 入院(FC_InpatientEncounter)。その入院の様式1 は `questionnaire` + `encounter` で検索します。
- `status`: in-progress(下書き)→ completed(確定)→ 確定後の保存は amended(修正済み)。必須の検証は画面側だけが持つので「確定 = 検証を通ったもの」とし、提出ファイルには completed と amended だけを出します。
- 新規作成は「その入院の様式1 がまだ無いこと」を条件にした transaction(`ifNoneExist` = questionnaire + encounter)、更新は ETag(If-Match)で他者の更新を検出します。
- `identifier` / contained Practitioner(`author`)/ `meta.profile` はテンプレートの記入([FC_QuestionnaireResponse](StructureDefinition-fc-questionnaire-response.html))と同じです。カルテの時系列には出しません(`questionnaire:not` で除く)。

### item の構造

提出ファイルは「ヘッダ部 + コード + バージョン + 連番 + ペイロード 1〜9」の縦持ちで、1 行が 1 レコードです。item はその行と 1 対 1 に対応します。値はすべて提出ファイルに書く文字列のまま `valueString` で持ちます(日付は YYYYMMDD、選択肢はコード)。

| linkId | 内容 |
|---|---|
| `header` | ヘッダ部のグループ(1 件)。子は下の 6 つ(値のあるものだけ) |
| `header.facility` | 施設コード(自院の保険医療機関番号 10 桁から点数表の桁を除いた 9 桁) |
| `header.dataId` | データ識別番号(患者番号の 10 桁前ゼロ埋め) |
| `header.admitDate` | 入院年月日 |
| `header.count` | 回数管理番号 |
| `header.summaryNo` | 統括診療情報番号(親様式1 の 0 だけを扱う) |
| `header.fiscalYear` | 使った定義表の年度(作成時の退院日、未退院なら作成日の年度) |
| `{コード}`(A000010 など) | 1 レコードのグループ。`text` = レコード名。連番のあるレコードは同じ linkId のグループを行の数だけ並べる |
| `{コード}.ver` | バージョン(例: 20140401) |
| `{コード}.seq` | 連番(連番のあるレコードは 1 から、無いレコードは 0) |
| `{コード}.p1` 〜 `{コード}.p9` | ペイロード(値のあるものだけ) |
| `{コード}.ref` | 値の元になったリソース(`valueReference`。登録病名から選んだ Condition など) |

### 初期値の元

入院情報(入院経路・予定/救急の区分・紹介の有無・救急車搬送・入院前の在宅医療)は入院 Encounter の [入院の経緯](admin.html) から、そのほかは Patient・バイタル・妊娠の Observation・社会歴テンプレートの抽出 Observation・退院時サマリーの退院時診断・手術の実施記録から集めます。

### 例

- [DPC 様式1(下書き)](QuestionnaireResponse-example-dpc-form1-response.html)
