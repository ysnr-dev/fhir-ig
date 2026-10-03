### 既知の非準拠パターン

fhir-client の出力のうち、FHIR や JP Core の作法から外れているものを記録します。本 IG は現状をそのまま定義しており、修正するときはこのページとプロファイルの両方を更新してください。

| 項目 | 内容 | 影響 |
|---|---|---|
| 略称の coding | `lab-item-abbreviation` は、オーダー明細では略称文字列そのものを code にし(例: `#CBC`)、検体検査結果では code = 結果項目コード・display = 略称にする。`micro-antimicrobial-abbreviation` は code = JANIS 抗菌薬コード・display = 略号。 | CodeSystem は not-present。同じ system でも code の意味が場所で違う。 |
| category の先頭ルール | 上流サーバーが category の先頭しか索引しないため、種別を表す coding を必ず先頭に置く。 | プロファイルは `^slicing.ordered = true` で表現。 |
| QuestionnaireResponse.identifier に system が無い | value = `{施設番号}^{患者ID}^{uuid}`。 | value 必須として定義。 |
| JSON 文字列の拡張 | `schedule-slot-pattern` は Slot の生成パターンを JSON 文字列で valueString に持つ。 | 拡張の Description に JSON の形を記載。 |
| 独自 system の observation-category | 有害事象の category は本 IG の `CodeSystem/observation-category#adverse-event` で、HL7 の observation-category ではない。 | 読むときは system で区別する。 |
| JP_Observation_* に準拠しない Observation | アプリは検体検査結果に `meta.profile` = JP_Observation_LabResult を付けるが、category の system が HL7 observation-category(JP Core 1.2.0 は JP_SimpleObservationCategory_CS)なので準拠しない。上流サーバーは読み出し時に JP_Observation_Common を付ける。 | 本 IG の Observation プロファイルは base から派生。 |
| JP_DiagnosticReport_LabResult に準拠しない報告 | category(v2-0074#LAB)と code(LOINC 11502-2)の持ち方が JP Core の定義(LOINC LP29693-6 / JP_DocumentCodes_CS#11502-2)と異なる。 | JP_DiagnosticReport_Common から派生。 |
| JP_MedicationRequest に準拠しない薬剤行 | RP 番号・RP 内連番の identifier は JP Core どおりだが、doseQuantity に UCUM の code を持たない(unit 文字列のみ)。注射は medicationCodeableConcept を使う(JP_MedicationRequest_Injection は Reference(JP_Medication)を要求)。 | base から派生。 |
| JP_MedicationDispense / JP_MedicationAdministration に準拠しない | RP 内連番の identifier を持たない。 | base から派生。 |
| JP_MedicationStatement に準拠しない持参薬 | dosage の doseQuantity に UCUM の code を持たない。 | base から派生。 |
| Questionnaire / QuestionnaireResponse のプロファイル | JASPEHR の jaspehr-questionnaire / -questionnaireresponse。JASPEHR パッケージは公開レジストリに無く、jaspehr.jp から取得する。 | 本 IG の依存パッケージとして手動で展開。 |
| ePath の定義 | クリニカルパスの拡張・CodeSystem・IdSystem は ePath IG の URL を使うが、パッケージ依存にはしていない(JP Core 1.1.2 依存で衝突するため)。 | インスタンスの検証では未知の拡張として警告になる。 |
| orderDetail と code(prr-1) | 処方・注射のヘッダ ServiceRequest は orderDetail(薬剤行への参照)を持つが code を持たないため、FHIR 基本の不変条件 prr-1(orderDetail SHALL only be present if code is present)に反する。 | 例の検証でエラーになる。code.text(例: 処方 / 注射)を付ければ解消する。 |
| バイタルの LOINC コードを持つ Observation の category | LOINC のバイタルコード(8310-5 / 8867-4 など)を持つ Observation は FHIR 基本の Vital Signs プロファイルで自動検証され、category = vital-signs が必須になる。麻酔チャートのバイタルは category を持たず、看護観察の記録は category[0] = order-type#nursing なので、どちらも準拠しない。 | 例は EtCO2(19889-5)や LOINC 対応の無い観察項目にして回避している。 |
| JP_Procedure の nurse スライス | JP_Procedure は看護行為の coding の system を medis.or.jp の URL に固定しつつ、ValueSet(JP_ProcedureCodesNurse_VS)は urn:oid:1.2.392.200119.4.701 だけを含むため、どのコードも準拠できない。 | 看護行為の実施記録は base から派生。 |
| jpfhir-terminology の部分的な CodeSystem | jpfhir-terminology 1.4.0 は J-FAGY(食物 2 件)や MEDIS 看護観察(270 件)などを content = complete で収載しており、アプリが使う実コードが「未知のコード」になる。 | 例は収載されているコードを使う(食事摂取量の 31003419 / 31003420 は例外)。 |
| 単一ヘッダの Bundle の fullUrl | 単一ヘッダの transaction でも fullUrl が必須。漏れると来歴とパスの参照が付かない。 | |
| 処方の用量(doseQuantity)の意味 | 内服(頓用以外)は 1 日量、頓用は 1 回量、外用などは全量。JP Core の処方は 1 回量を基本にしている。持参薬(MedicationStatement)の doseQuantity は 1 回量。 | 読む側は用法コードで意味を判定する。 |
| questionnaire-itemControl の system | アプリと同梱テンプレートは `http://hl7.org/fhir/CodeSystem/questionnaire-item-control` を使う。HL7 の正式な system は `http://hl7.org/fhir/questionnaire-item-control`。 | 例の検証で未知の CodeSystem の警告になる。 |
| questionnaire-unit の code | system は UCUM(`http://unitsofmeasure.org`)固定のまま、code に「回」「本/日」など UCUM でない単位文字列を入れる。 | UCUM として解釈できない code がある。 |
| 通知 Task の input | 一覧に出す内容を `Task.input`(type.text をキーにした値)に構造化して持つ。type に coding を持たない。 | プロファイルは type.text でスライスする。 |

### 2026-10-03 より前に書かれたデータ

アプリの次の不具合は 2026-10-03 に直しましたが、それより前に上流へ書かれたリソースは古い形のまま残っています。古いデータを読む側は次の形もありうるものとして扱ってください。

| 項目 | 古いデータの形 |
|---|---|
| 細菌検査ヘッダの依頼科・病棟 | 先行抗菌薬・検査目的の拡張を書くときに `order-department` / `order-ward` を消していたため、ほとんどの細菌検査ヘッダが依頼科・病棟を持たない。 |
| 手術明細の左右 | `jj1017-laterality` の display と `bodySite.text` の頭が「右 / 左」(現在は JJ1017 の名称「右側 / 左側」)。 |
| 報告の入院・外来区分 | 検体検査・細菌検査・病理の DiagnosticReport は、区分が未選択でも category の 2 つ目を書いていたため、code が空文字の Coding がありうる(現在は category ごと省く)。 |
| 与薬記録の用量 | 与薬 1 回の MedicationAdministration.dosage.dose に処方の用量(内服は 1 日量)を複製していた(現在はその枠の 1 回量)。 |
| 持参薬からの継続処方 | 持参薬の 1 回量を処方の用量(内服は 1 日量)の初期値にそのまま写していたため、人が直さなかった処方は用量が 1 日量になっていない。 |
| 手術明細の予定日時 | 日程確定・カレンダーでの移動・日程未定のままの入室でヘッダだけを書き換えていたため、術式明細の occurrenceDateTime が古いまま(または無いまま)。 |
| Observation 抽出カテゴリの拡張 URL | テンプレートが SDC に無い `sdc-observationExtract-category` を使っていた(現在は SDC の `sdc-questionnaire-observation-extract-category`)。アプリは両方を読む。編集して保存し直すと新しい URL になる。 |
| 持参薬の用法 | 用法を入れなかった持参薬が空の `dosage.timing.code`(`{}`)を持つ。 |

### 上流サーバーの制約

- クライアントが送った `meta.profile` を保存しない(meta.tag 以外の meta を落とし、読み出し時にリソース種別ごとの 1 プロファイルを付ける)。
- プロファイル検証は既定 warn(`FHIR_PROFILE_VALIDATION`)。未知の拡張は拒否しない。手書きのバリデータ(Observation の status / code / subject、Procedure の status / subject、CarePlan の status / intent / subject、Composition の author、Questionnaire の JASPEHR 不変条件、QuestionnaireResponse の eCS 施設番号拡張)は常に 422 を返す。
- `category` は先頭要素だけを索引する。ServiceRequest の `occurrence` 検索は occurrenceDateTime だけ(Period は索引しない)。`_elements` は JSON キーの完全一致。未対応の検索パラメータは既定で黙殺される(`Prefer: handling=strict` で拒否)。
- 1 トークンあたり 300 件/分のレート制限。
- タイムゾーン無しの検索値は Asia/Tokyo で解釈する。
