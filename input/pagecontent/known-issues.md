### 既知の非準拠パターン

fhir-client の出力のうち、FHIR や JP Core の作法から外れているものを記録します。本 IG は現状をそのまま定義しており、修正するときはこのページとプロファイルの両方を更新してください。

| 項目 | 内容 | 影響 |
|---|---|---|
| 略称を code にする | `lab-item-abbreviation` / `micro-antimicrobial-abbreviation` は略称文字列そのものを code にしている(例: `#CBC`)。 | CodeSystem は not-present。コードの集合は施設ごと。 |
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

### 既知の不具合(アプリ側)

| 項目 | 内容 |
|---|---|
| 細菌検査ヘッダの依頼科・病棟 | `microOrderHelpers.ts` が `micro-prior-antimicrobial` / `micro-exam-purpose` を書くときに `order-department` / `order-ward` を上書きする。`examPurpose` の既定値が diagnostic なので、細菌検査のヘッダはほとんど依頼科・病棟を持たない。本 IG は本来の形を定義している。 |
| 左右区分の display | `jj1017-laterality` の display が放射線治療(右側 / 左側 / 両側)と手術(右 / 左 / 両側)で異なる。 |

### 上流サーバーの制約

- クライアントが送った `meta.profile` を保存しない(meta.tag 以外の meta を落とし、読み出し時にリソース種別ごとの 1 プロファイルを付ける)。
- プロファイル検証は既定 warn(`FHIR_PROFILE_VALIDATION`)。未知の拡張は拒否しない。手書きのバリデータ(Observation の status / code / subject、Procedure の status / subject、CarePlan の status / intent / subject、Composition の author、Questionnaire の JASPEHR 不変条件、QuestionnaireResponse の eCS 施設番号拡張)は常に 422 を返す。
- `category` は先頭要素だけを索引する。ServiceRequest の `occurrence` 検索は occurrenceDateTime だけ(Period は索引しない)。`_elements` は JSON キーの完全一致。未対応の検索パラメータは既定で黙殺される(`Prefer: handling=strict` で拒否)。
- 1 トークンあたり 300 件/分のレート制限。
- タイムゾーン無しの検索値は Asia/Tokyo で解釈する。
