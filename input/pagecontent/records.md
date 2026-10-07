### 診療記録(Composition)

診療記録は **Composition**([FC_ClinicalNote](StructureDefinition-fc-clinical-note.html))です。

- `type` = LOINC 11506-3 Progress note。他科依頼への回答は 11488-4 Consult note で、`event.code` = `consult-note-event#reply`、`event.detail` = 依頼の ServiceRequest。
- `status`: preliminary / final / amended。final の記録を編集すると必ず amended になります。final 以降は `attester`(mode = legal)。
- `author` 1..*(上流サーバーが必須にする)。`title` は診療記録タイトルマスタの文字列(既定「診療記録」)。記録した診療科(他科依頼の回答では回答した科)は `order-department`。
- `section`: 任意の問題セクション(LOINC 11450-4、entry = Condition)と本文セクション。

| section.code(LOINC) | 内容 |
|---|---|
| 11450-4 | 問題(entry = Condition、text.status = generated) |
| 61150-9 | S |
| 61149-1 | O |
| 51848-0 | A |
| 18776-5 | P |
| 51847-2 | A/P |
| 77599-9 | 自由記載 |

看護職(看護師・保健師・助産師)が書いた記録は `category` = `clinical-note-category#nursing` を持ちます(新規保存のときに付け、編集では保存済みの値を引き継ぐ)。看護サマリーの「看護記録」の取り込みはこれで検索します。

研修医・学生(Practitioner に `trainee-level`)が書いた記録は `category` = `clinical-note-category#countersign` を持ち、指導医のカウンターサインの対象になります(付け方は nursing と同じ。書いた時点の区分なので、後から研修を終えても外れない)。状態は Composition だけで読みます。

| 状態 | status | attester |
|---|---|---|
| 作成中 | preliminary | なし |
| 承認待ち | final / amended | legal = 研修医 |
| 承認済 | 承認待ちのまま(内容は変えない) | legal + professional = 指導医(time) |
| 差戻し | preliminary | なし。理由は `note-returned` 通知 Task(研修医宛)で、確定し直すと completed |

承認待ちになると、研修医が属する指導医グループの指導医ごとに `note-countersign` 通知 Task を作ります([通知](notifications.html))。承認できるのは、その研修医の指導医で、作成者本人ではない人です。研修医が確定し直すと legal だけになり、また承認待ちになります。

本文は `text.status = additional` の XHTML で、画像は data URI で埋め込みます。テンプレートで書いたセクションは `clinical-note-section-questionnaire-response` 拡張が QuestionnaireResponse を指し、QR・Binary・抽出した Observation を同じ transaction で登録します。

カルテの時系列では、Composition を type で「診療記録」「退院時サマリー」「看護サマリー」([看護計画・看護サマリー](nursing-care-plan.html))に分け、日付未定(最上部)と日付なし(最下部)を別に扱います。

### 退院時サマリー

[FC_DischargeSummary](StructureDefinition-fc-discharge-summary.html): `type` = LOINC 18842-5、`encounter` = 入院 Encounter(入院ごとに 1 件)。section は固定です。

| section.code | タイトル | 内容 |
|---|---|---|
| 11535-2 | 退院時診断 | entry = Condition |
| 8648-8 | 入院経過 | text |
| 47519-4 | 手術・処置 | entry = ヘッダ ServiceRequest |
| 30954-2 | 検査 | text |
| 10183-2 | 退院時処方 | entry = MedicationRequest |
| 10184-0 | 退院時状態 | text |
| 18776-5 | 方針 | text |
| 48765-2 | アレルギー | entry = AllergyIntolerance |

退院先は `Encounter.hospitalization.dischargeDisposition`(discharge-disposition: home / other-hcf / snf / hosp / aadvice / exp / oth)に同じ transaction で PUT します。退院で `document-due` 督促 Task が作られ、確定で completed になります。

### 患者プロファイルの Observation

| 内容 | プロファイル | code | value |
|---|---|---|---|
| 血液型 | [FC_BloodTypeObservation](StructureDefinition-fc-blood-type-observation.html) | LOINC 883-9(ABO)/ 10331-7(RhD) | `transfusion-abo` / `transfusion-rhd`、method = 情報源 |
| 妊娠・授乳 | [FC_PregnancyObservation](StructureDefinition-fc-pregnancy-observation.html) | LOINC 82810-3 / 63895-7 | SNOMED CT、component 11778-8 分娩予定日 |
| 感染症(手入力) | [FC_InfectionObservation](StructureDefinition-fc-infection-observation.html) | `infection-type` + LOINC | `infection-result`、method = 情報源 |
| バイタル | [FC_VitalObservation](StructureDefinition-fc-vital-observation.html) | LOINC(85354-9 血圧、8310-5 体温、8867-4 脈拍、2708-6 SpO2、9279-1 呼吸数、8302-2 身長、29463-7 体重、39156-5 BMI) | Quantity(UCUM)、identifier = vital-entry、`observation-problem`、記録した診療科 `order-department`。病棟の経過表一括入力は encounter = 入院・performer = 測定者を持ち、体重だけのときは最新の身長で BMI も書く |
| 有害事象(CTCAE) | [FC_AdverseEventObservation](StructureDefinition-fc-adverse-event-observation.html) | text(CTCAE 用語) | valueInteger = Grade、category = 本 IG の `observation-category#adverse-event`、`treatment-context` |
| テンプレート抽出 | [FC_ExtractedObservation](StructureDefinition-fc-extracted-observation.html) | item.code(`observation-item` など) | derivedFrom = QuestionnaireResponse |

身長・体重・eGFR はプロファイル画面では読むだけで、バイタルと検体検査結果(JLAC11 分析物 C3002 クレアチニン / C3003 シスタチン C)から取ります。

### 患者ファイルと画像

- 患者ファイル: [FC_PatientFile](StructureDefinition-fc-patient-file.html)(DocumentReference)+ Binary。category = ファイル分類(`file-category`、code = UUID)。
- 文書作成(Word / Excel の文書テンプレートへの差し込み)で作った文書も同じ FC_PatientFile で、`type` = 元の文書テンプレート(`document-template`、code = backend の document_templates の UUID、display / text = テンプレート名)を持ちます。文書テンプレートの本体は backend のマスタにあり、FHIR には持ちません。
- 本体の差し替えは、新しい Binary を作り、同じ id の DocumentReference の `content[0].attachment`(contentType / url / size、拡張子が変われば title)だけを同じ transaction で替えます。元の Binary は消しません(旧版は `_history` から辿れます)。
- DICOM: backend が取り込み、[FC_ImagingStudy](StructureDefinition-fc-imaging-study.html)を identifier(`urn:dicom:uid`)で条件付き PUT。`imaging-source` に元施設・元患者。DICOM の実体は FHIR には持ちません。

### 例

- [診療記録](Composition-example-clinical-note.html) / [看護記録](Composition-example-nursing-clinical-note.html) / [研修医の記録(承認済)](Composition-example-countersign-clinical-note.html) / [退院時サマリー](Composition-example-discharge-summary.html) / [督促 Task](Task-example-document-due-task.html)
- [血液型](Observation-example-blood-type-observation.html) / [妊娠](Observation-example-pregnancy-observation.html) / [感染症](Observation-example-infection-observation.html) / [バイタル](Observation-example-vital-observation.html) / [体重(経過表一括入力)](Observation-example-weight-observation.html)
- [患者ファイル](DocumentReference-example-patient-file.html) / [文書作成で作った文書](DocumentReference-example-patient-document.html) / [DICOM スタディ](ImagingStudy-example-imaging-study.html)
