### 識別子体系

fhir-client が `identifier.system` / `accessionIdentifier.system` / `requisition.system` に使う URI の一覧です。それぞれ NamingSystem として定義しています(Artifacts の「Naming Systems」)。

#### オーダー明細の連番(`http://fhir-client.local/IdSystem/...`)

| URI 末尾 | 置く場所 | 値 |
|---|---|---|
| `lab-order-item-number` | 検体検査 明細 ServiceRequest.identifier | ヘッダ内の連番(文字列) |
| `micro-order-item-number` | 細菌検査 明細 | 検体グループ = 1、検査項目 = 2 以降 |
| `rad-order-item-number` | 放射線検査 明細 | 連番 |
| `endoscopy-order-item-number` | 内視鏡 明細 | 連番 |
| `physio-order-item-number` | 生理検査 明細 | 連番 |
| `patho-order-item-number` | 病理検査 検体明細 | 検体番号 |
| `surgery-order-item-number` | 手術 術式明細 | 1 = 主術式 |
| `treatment-order-item-number` | 処置 明細 | 連番 |
| `transfusion-order-item-number` | 輸血 製剤明細 | 連番 |
| `lab-label-number` | 検体ラベルの Specimen.accessionIdentifier | 上流サーバーが採番する 11 桁(10 桁連番 + M10W3 チェックディジット) |

#### 束ねる識別子(`http://fhir-client.local/Identifier/...`)

| URI 末尾 | 置く場所 | 値 |
|---|---|---|
| `injection-series` | 注射 ServiceRequest.requisition | 1 回の登録で展開した日ごとの ServiceRequest を束ねる uuid |
| `nursing-order-requisition` | 看護指示 ServiceRequest.requisition | 同時入力した指示を束ねる uuid |
| `order-set-instance` | ヘッダ ServiceRequest.identifier(と requisition) | オーダーセット適用 1 回の uuid |
| `pathway-instance` | ヘッダ ServiceRequest.identifier(と、空いていれば requisition) | パス適用 1 回の uuid |
| `regimen-instance` | レジメン適用 ServiceRequest.identifier、日オーダーの requisition | レジメン適用ごとの uuid |

#### 記録の入力単位

| URI | 置く場所 | 値 |
|---|---|---|
| `http://fhir-client.local/vital-entry` | バイタル Observation.identifier | 1 回の測定で入力した項目を束ねる uuid |
| `http://fhir-client.local/nursing-perform-entry` | 看護観察 Observation / 看護行為 Procedure の identifier | 1 回のラウンドの記録を束ねる uuid |

#### 職員

| URI | 置く場所 | 値 |
|---|---|---|
| `http://fhir-client.local/Practitioner` | 診断群分類の決定の記録の contained Practitioner(決定者)の identifier | 上流サーバーの Practitioner の論理 id |

#### 外部標準の識別子

| URI | 置く場所 |
|---|---|
| `urn:oid:1.2.392.100495.20.3.51` | 患者番号(Patient.identifier)。空で登録すると上流の `Patient/$next-identifier` が採番する |
| `http://jpfhir.jp/fhir/core/IdSystem/insurance-medical-institution-no` | 保険医療機関番号(Organization.identifier) |
| `http://fhir-client.local/CodeSystem/ssmix2-department-code` | 診療科コード(診療科 Organization.identifier。CodeSystem の URI を identifier.system として使っている) |
| `http://jpfhir.jp/fhir/core/mhlw/IdSystem/medicalRegistrationNumber` | 医籍登録番号(Practitioner.qualification.identifier) |
| `http://jpfhir.jp/fhir/core/mhlw/IdSystem/Medication-RPGroupNumber` / `MedicationAdministrationIndex` | RP 番号・RP 内連番(MedicationRequest.identifier) |
| `urn:oid:1.2.392.100495.20.3.61` | 保険者番号(Coverage.payor.identifier) |
| `urn:dicom:uid` | StudyInstanceUID(ImagingStudy.identifier、値は `urn:oid:...`) |
| `http://e-path.jp/fhir/ePath/IdSystem/...` | クリニカルパスの各階層の ID([クリニカルパス](pathway.html)) |

#### レセプトコンピュータ連携(backend が書く)

| URI | 置く場所 | 値 |
|---|---|---|
| `http://fhir-client.local/integrations/receipt-computer/coverage` | Coverage.identifier | `{患者番号}:{外部キー}`。条件付き PUT のキー |
| `http://fhir-client.local/integrations/receipt-computer/reception` | Appointment.identifier | 受付キー。条件付き PUT のキー |

#### system を持たない identifier

QuestionnaireResponse.identifier は system を持たず、value = `{施設番号}^{患者ID}^{uuid}` です([既知の非準拠](known-issues.html))。

DICOM 取込の ImagingStudy のアクセッション番号も system を持たず、`type` = v2-0203#ACSN と value だけです。
