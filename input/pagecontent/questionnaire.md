### テンプレート(Questionnaire)

診療記録・オーダーの検査目的や特別指示・臨床情報・術前指示・依頼目的・読影レポート・栄養指導記録・パスの評価などで使うテンプレートは **Questionnaire**([FC_Questionnaire](StructureDefinition-fc-questionnaire.html))です。アプリは `meta.profile` に JASPEHR の `jaspehr-questionnaire` を付け、上流サーバーが JASPEHR の不変条件で検証します(本 IG のプロファイルは base から派生)。

- `url` = `http://fhir-client.local/Questionnaire/{id}`(同梱テンプレート: admission-plan-01、plan-01、consult-purpose-01、consult-purpose-radiotherapy-01、endoscopy-*、family-01、ros-01、social-01、sur-*、rad-ct-01、rad-mri-01、radiotherapy-review-01、nutrition-guidance-record-01、nursing-profile-admission-01、nursing-profile-adl-01、nursing-profile-fall-01、nursing-profile-pressure-ulcer-01、oral-function-01、perio-01、perio-summary-01、hf-symptom-01、pressure-ulcer-designr-01、physio-ecg-report-01、hbcr-01、referral-01、nursing-focus-01、intake-general-01、ast-notify-01、ast-round-01)。`version` と `url` の組で一意。
- `subjectType` = Patient。`name` は 15 文字まで。enableWhen は choice の子項目にだけ使えます(上流サーバーが JASPEHR の不変条件を検証)。
- 標準拡張: questionnaire-itemControl(choice には必須)、choiceOrientation、hidden、maxOccurs(repeats には必須)、minValue / maxValue / maxDecimalPlaces、questionnaire-unit(system は UCUM 固定。code には UCUM でない単位文字列も入る — [既知の非準拠](known-issues.html))、regex、designNote、variable、questionnaire-itemMedia(Binary)。SDC: initialExpression、calculatedExpression、sdc-questionnaire-observationExtract、sdc-observationExtract-category。
- 本 IG の拡張:

| 拡張 | 置く場所 | 内容 |
|---|---|---|
| `questionnaire-template-category` | root | 分類(valueCoding、code = backend の分類 UUID) |
| `questionnaire-organization-field` | item | 自院の施設情報を自動入力(name / institutionNumber / addressFull / address / postalCode / phone / fax) |
| `questionnaire-practitioner-field` | item | 医療従事者の情報を自動入力(name / kana / medicalRegistrationNumber / role / organizationName / phone / email) |
| `questionnaire-practitioner-role-default` | item | 医療従事者を選ぶ項目の既定職種 |
| `questionnaire-login-autofill` | item | ログイン中の職員を自動入力 |

- `item.code` にはテンプレート項目コード(`observation-item`: DENT-* / HF-* など)や JP_ObservationSocialHistoryCode_CS を付け、抽出した Observation の code になります。チャート定義はこの code で値を拾います。

### 記入(QuestionnaireResponse)

[FC_QuestionnaireResponse](StructureDefinition-fc-questionnaire-response.html)は、アプリが `meta.profile` に JASPEHR の `jaspehr-questionnaireresponse` を付けるものです(本 IG のプロファイルは base から派生)。

- `questionnaire` = テンプレートの canonical(`url|version`)。`status`: in-progress / completed / amended。
- `author` は contained Practitioner(`#practitioner`、name.text = 記入者名のみ)。
- `identifier.value` = `{施設番号}^{患者ID}^{uuid}`(system 無し。[既知の非準拠](known-issues.html))。
- `basedOn` = 関連するオーダー(放射線治療の週次診察、特定抗菌薬の届出書など)。
- `encounter` = 回答が属する入院(看護プロファイル。[看護計画・看護サマリー](nursing-care-plan.html))。encounter を持つ回答は入院単位の書類として扱い、カルテの時系列には出しません。更新では保存済みの値を引き継ぎます。
- `questionnaire-response-problem` = 対象プロブレム。`order-department` = 記録した診療科(更新では元の値を引き継ぐ)。`intake-source`(valueCode = patient)= 患者が Web 問診で答えた回答を職員が取り込んだもの(`authored` = 患者が答えた日時)。item の `questionnaire-response-annotated-image` = シェーマに書き込んだ画像(Binary)。
- `sdc-questionnaire-observationExtract` が true の項目からは Observation([FC_ExtractedObservation](StructureDefinition-fc-extracted-observation.html)、category = 抽出カテゴリ、derivedFrom = QR)を同じ transaction で作ります。

QR は診療記録のセクション、オーダーの拡張、読影レポート、栄養指導の実施記録、パスの評価などから参照されます。どこからも参照されない QR だけがカルテの時系列に単独のカードとして出ます。

### 様式テンプレート

文書作成の様式テンプレート(PDF / 画像の様式に入力欄を配置したもの。配置は backend のマスタが持つ)は、回答を QR に保存するため、項目の配置から Questionnaire([FC_DocumentFormQuestionnaire](StructureDefinition-fc-document-form-questionnaire.html))を機械的に生成します。

- `url` = `http://fhir-client.local/Questionnaire/document-form/{テンプレートの code}`、`version` = "1" から始まる整数。項目の増減・種類・ラベル・選択肢が変わったときだけ版を上げ、新しい版を新しいリソースとして作ります(旧版は既存の回答が指すので残します)。
- `code` = `questionnaire-kind#document-form` で、通常のテンプレートの選択には出しません(検索で `code:not` に指定して除く)。`questionnaire-document-form` 拡張 = テンプレートの code。
- 項目はすべて最上位に並べ、1 行 string / 複数行 text / 日付 date / 選択 choice(drop-down)/ チェックボックス choice(check-box、選択肢 1 つ)。選択肢は `document-form-option`(code = `{linkId}-{連番}`)。
- 回答([FC_DocumentFormResponse](StructureDefinition-fc-document-form-response.html))は値のある項目だけを持ち、`questionnaire-response-document` 拡張で表示用 PDF の DocumentReference を指します。DocumentReference の `context.related` が回答を指し、両方を 1 つの transaction で作ります([患者ファイルと画像](records.html))。カルテの時系列では回答を「文書作成」のカードとして出します。

### 例

- [テンプレート](Questionnaire-social-01.html) / [様式テンプレート](Questionnaire-example-document-form-questionnaire.html)
- [記入](QuestionnaireResponse-example-questionnaire-response.html) / [看護プロファイルの記入](QuestionnaireResponse-example-nursing-profile-response.html) / [Web 問診の取り込み](QuestionnaireResponse-example-intake-questionnaire-response.html) / [様式文書の回答](QuestionnaireResponse-example-document-form-response.html)
- [抽出した Observation](Observation-example-extracted-observation.html)
