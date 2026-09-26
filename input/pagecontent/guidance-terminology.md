### コードシステムの方針

fhir-client が使うコードシステムは 3 種類に分かれます。

| 種類 | 例 | 本 IG での扱い |
|---|---|---|
| アプリのコードに選択肢が列挙されているもの | order-type、task-code、surgery-position、micro-culture-result | `CodeSystem`(content = complete)としてコードと日本語 display をすべて収載し、対の ValueSet(`<id>-vs`)を定義する。プロファイルは required でバインドする。 |
| 院内マスタ由来(backend の DB に取り込んだもの) | lab-order-item、medicine-code、jj1017*、janis-*、meal-type、regimen | `CodeSystem`(content = not-present)として URI と意味だけ定義する。コードの集合は施設ごとに違うので IG には収載しない。プロファイルは `coding.system` を固定するだけでバインドしない。 |
| 外部の標準 | LOINC、SNOMED CT、UCUM、JP Core / MHLW / JAMI / MEDIS / JAHIS / ePath / JASPEHR の CodeSystem | 本 IG では定義せず URI を参照する。 |

### system を持たない code

`valueCode`(code 型)で持つ拡張(細菌検査の目的、食事のタイミング、レジメン中止理由など)は、インスタンスの JSON に system が現れません。
本 IG ではこれらのコードを収載するために `http://fhir-client.local/CodeSystem/<名前>` の CodeSystem を定義していますが、その URI はバインド用で、アプリの出力には現れません(`micro-exam-purpose`、`radiotherapy-phase-status`、`meal-timing`、`meal-fasting-reason`、`meal-order-link-kind`、`meal-order-end-reason`、`brought-medication-substitution`、`regimen-discontinuation-reason`、`treatment-context-type`、`questionnaire-organization-field`、`questionnaire-practitioner-field`)。

### 外部標準の使い方

| 標準 | URI | 用途 |
|---|---|---|
| LOINC | `http://loinc.org` | 報告書の code / category、Composition の type / section、バイタル、血液型・妊娠・感染症、病理レポートのセクション |
| SNOMED CT | `http://snomed.info/sct` | 妊娠・授乳の値 |
| UCUM | `http://unitsofmeasure.org` | 数量の単位(投与日数 d、線量 Gy、mL、% など) |
| HL7 v2 / v3 / terminology.hl7.org | `v2-0074`、`v2-0276`、`v3-ActCode`、`v3-RoleCode`、`v3-DataOperation`、`observation-category`、`condition-category` ほか | 報告の区分、予約種別、Encounter.class、Location.type、来歴の activity、Observation / Condition のカテゴリ |
| JP Core | `http://jpfhir.jp/fhir/core/...` | route-codes(投与経路)、JP_DocumentCodes_CS(画像検査報告書)、JP_MedicalLicenseCertificate_CS、J-FAGY(アレルゲン)、JP_ObservationSocialHistoryCode_CS |
| MHLW(厚労省) | `http://jpfhir.jp/fhir/core/mhlw/...` | RP 番号・RP 内連番の IdSystem、一般名処方コード、医籍登録番号、病名(masterB / ICD10 / masterZ 修飾語) |
| JAMI | `urn:oid:1.2.392.200250.2.2.20.22 / .32 / .40` | 補足用法コード、注射部位、注射手技 |
| MEDIS | `http://medis.or.jp/CodeSystem/...`、`urn:oid:1.2.392.200119.4.704` | 標準病名マスタ、看護実践用語標準マスタ |
| YJ コード | `http://capstandard.jp/iyaku.info/CodeSystem/YJ-code` | 医薬品 |
| JJ1017 | 本 IG の `jj1017-32 / jj1017-16m / jj1017-16s / jj1017-modality / jj1017p / jj1017-laterality` | 放射線検査の手技・モダリティ・部位。原典に FHIR 用 URI が無いためローカル URI を割り当てている |
| JLAC10 / JLAC11 | 本 IG の `jlac10 / jlac11 / jlac11-specimen` | 臨床検査項目・材料。同上 |
| JANIS | 本 IG の `janis-*` | 細菌検査の検体種別・菌種・抗菌薬・測定法。同上 |
| JAHIS | 本 IG の `jahis-patho-*` | 病理の検査区分・検体タイプ・臓器・採取方法。同上 |
| SS-MIX2 | 本 IG の `ssmix2-department-code` | 診療科コード。同上 |
| ePath | `http://e-path.jp/fhir/ePath/...` | クリニカルパスの分類・評価・IdSystem([クリニカルパス](pathway.html)) |
| DICOM | `http://dicom.nema.org/resources/ontology/DCM` | ImagingStudy のモダリティ |

### display の扱い

アプリは coding に日本語の display を付けます。列挙型 CodeSystem の display は本 IG の定義と一致します。院内マスタ由来の coding の display はマスタの名称を転記したものです。
