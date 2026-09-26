### 診療記録(Composition)

診療記録は **Composition**([FC_ClinicalNote](StructureDefinition-fc-clinical-note.html))です。

- `type` = LOINC 11506-3 Progress note。他科依頼への回答は 11488-4 Consult note で、`event.code` = `consult-note-event#reply`、`event.detail` = 依頼の ServiceRequest。
- `status`: preliminary / final / amended。final の記録を編集すると必ず amended になります。final 以降は `attester`(mode = legal)。
- `author` 1..*(上流サーバーが必須にする)。`title` は診療記録タイトルマスタの文字列(既定「診療記録」)。依頼科は `order-department`。
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

本文は `text.status = additional` の XHTML で、画像は data URI で埋め込みます。テンプレートで書いたセクションは `clinical-note-section-questionnaire-response` 拡張が QuestionnaireResponse を指し、QR・Binary・抽出した Observation を同じ transaction で登録します。

カルテの時系列では、Composition を LOINC の type で「診療記録」と「退院時サマリー」に分け、日付未定(最上部)と日付なし(最下部)を別に扱います。

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
| バイタル | [FC_VitalObservation](StructureDefinition-fc-vital-observation.html) | LOINC(85354-9 血圧、8310-5 体温、8867-4 脈拍、2708-6 SpO2、9279-1 呼吸数、8302-2 身長、29463-7 体重、39156-5 BMI) | Quantity(UCUM)、identifier = vital-entry、`observation-problem` |
| 有害事象(CTCAE) | [FC_AdverseEventObservation](StructureDefinition-fc-adverse-event-observation.html) | text(CTCAE 用語) | valueInteger = Grade、category = 本 IG の `observation-category#adverse-event`、`treatment-context` |
| テンプレート抽出 | [FC_ExtractedObservation](StructureDefinition-fc-extracted-observation.html) | item.code(`observation-item` など) | derivedFrom = QuestionnaireResponse |

身長・体重・eGFR はプロファイル画面では読むだけで、バイタルと検体検査結果(JLAC11 分析物 C3002 クレアチニン / C3003 シスタチン C)から取ります。

### 患者ファイルと画像

- 患者ファイル: [FC_PatientFile](StructureDefinition-fc-patient-file.html)(DocumentReference)+ Binary。category = ファイル分類(`file-category`、code = UUID)。
- DICOM: backend が取り込み、[FC_ImagingStudy](StructureDefinition-fc-imaging-study.html)を identifier(`urn:dicom:uid`)で条件付き PUT。`imaging-source` に元施設・元患者。DICOM の実体は FHIR には持ちません。

### 例

- [診療記録](Composition-example-clinical-note.html) / [退院時サマリー](Composition-example-discharge-summary.html) / [督促 Task](Task-example-document-due-task.html)
- [血液型](Observation-example-blood-type-observation.html) / [妊娠](Observation-example-pregnancy-observation.html) / [感染症](Observation-example-infection-observation.html) / [バイタル](Observation-example-vital-observation.html)
- [患者ファイル](DocumentReference-example-patient-file.html) / [DICOM スタディ](ImagingStudy-example-imaging-study.html)
