// 識別子体系。アプリが identifier.system / accessionIdentifier.system / requisition.system に使う URI を NamingSystem として定義する。

RuleSet: FCNamingSystem(name, uri)
* name = "{name}"
* status = #draft
* kind = #identifier
* date = "2026-09-26"
* publisher = "ysnr-dev"
* uniqueId[0].type = #uri
* uniqueId[0].value = "{uri}"
* uniqueId[0].preferred = true

// ---- オーダー明細の連番(IdSystem) ----

Instance: ns-lab-order-item-number
InstanceOf: NamingSystem
Usage: #definition
Title: "検体検査オーダー 明細番号"
Description: "検体検査オーダー明細 ServiceRequest.identifier の system。ヘッダ内の連番を文字列で持つ(並び順)。"
* insert FCNamingSystem(LabOrderItemNumber, http://fhir-client.local/IdSystem/lab-order-item-number)

Instance: ns-micro-order-item-number
InstanceOf: NamingSystem
Usage: #definition
Title: "細菌検査オーダー 明細番号"
Description: "細菌検査オーダー明細 ServiceRequest.identifier の system。検体グループ = 1、検査項目 = 2 以降。"
* insert FCNamingSystem(MicroOrderItemNumber, http://fhir-client.local/IdSystem/micro-order-item-number)

Instance: ns-rad-order-item-number
InstanceOf: NamingSystem
Usage: #definition
Title: "放射線検査オーダー 明細番号"
Description: "放射線検査オーダー 明細番号"
* insert FCNamingSystem(RadOrderItemNumber, http://fhir-client.local/IdSystem/rad-order-item-number)

Instance: ns-endoscopy-order-item-number
InstanceOf: NamingSystem
Usage: #definition
Title: "内視鏡オーダー 明細番号"
Description: "内視鏡オーダー 明細番号"
* insert FCNamingSystem(EndoscopyOrderItemNumber, http://fhir-client.local/IdSystem/endoscopy-order-item-number)

Instance: ns-physio-order-item-number
InstanceOf: NamingSystem
Usage: #definition
Title: "生理検査オーダー 明細番号"
Description: "生理検査オーダー 明細番号"
* insert FCNamingSystem(PhysioOrderItemNumber, http://fhir-client.local/IdSystem/physio-order-item-number)

Instance: ns-patho-order-item-number
InstanceOf: NamingSystem
Usage: #definition
Title: "病理検査オーダー 検体番号"
Description: "病理検査オーダーの検体明細 ServiceRequest.identifier の system。検体番号。"
* insert FCNamingSystem(PathoOrderItemNumber, http://fhir-client.local/IdSystem/patho-order-item-number)

Instance: ns-surgery-order-item-number
InstanceOf: NamingSystem
Usage: #definition
Title: "手術オーダー 術式番号"
Description: "手術オーダーの術式明細 ServiceRequest.identifier の system。1 が主術式。"
* insert FCNamingSystem(SurgeryOrderItemNumber, http://fhir-client.local/IdSystem/surgery-order-item-number)

Instance: ns-treatment-order-item-number
InstanceOf: NamingSystem
Usage: #definition
Title: "処置オーダー 明細番号"
Description: "処置オーダー 明細番号"
* insert FCNamingSystem(TreatmentOrderItemNumber, http://fhir-client.local/IdSystem/treatment-order-item-number)

Instance: ns-transfusion-order-item-number
InstanceOf: NamingSystem
Usage: #definition
Title: "輸血オーダー 製剤番号"
Description: "輸血オーダー 製剤番号"
* insert FCNamingSystem(TransfusionOrderItemNumber, http://fhir-client.local/IdSystem/transfusion-order-item-number)

Instance: ns-lab-label-number
InstanceOf: NamingSystem
Usage: #definition
Title: "検体ラベル番号"
Description: "検体ラベルの Specimen.accessionIdentifier の system。値は上流サーバーが採番する 11 桁(10 桁連番 + M10W3 チェックディジット)。"
* insert FCNamingSystem(LabLabelNumber, http://fhir-client.local/IdSystem/lab-label-number)

// ---- 束ねる識別子(Identifier) ----

Instance: ns-injection-series
InstanceOf: NamingSystem
Usage: #definition
Title: "注射の連日シリーズ"
Description: "1 回の登録で日ごとに展開した注射 ServiceRequest を束ねる requisition の system。値は uuid。"
* insert FCNamingSystem(InjectionSeries, http://fhir-client.local/Identifier/injection-series)

Instance: ns-nursing-order-requisition
InstanceOf: NamingSystem
Usage: #definition
Title: "看護指示の同時入力"
Description: "同時に入力した看護指示 ServiceRequest を束ねる requisition の system。値は uuid。"
* insert FCNamingSystem(NursingOrderRequisition, http://fhir-client.local/Identifier/nursing-order-requisition)

Instance: ns-order-set-instance
InstanceOf: NamingSystem
Usage: #definition
Title: "オーダーセット適用"
Description: "オーダーセットの 1 回の適用で出したオーダーのヘッダ ServiceRequest.identifier(と requisition)の system。値は uuid。"
* insert FCNamingSystem(OrderSetInstance, http://fhir-client.local/Identifier/order-set-instance)

Instance: ns-pathway-instance
InstanceOf: NamingSystem
Usage: #definition
Title: "クリニカルパス適用"
Description: "パスの 1 回の適用で出したオーダーのヘッダ ServiceRequest.identifier(と、空いていれば requisition)の system。値は適用 uuid。"
* insert FCNamingSystem(PathwayInstance, http://fhir-client.local/Identifier/pathway-instance)

Instance: ns-regimen-instance
InstanceOf: NamingSystem
Usage: #definition
Title: "レジメン適用"
Description: "レジメン適用ヘッダ ServiceRequest.identifier と、日オーダーの requisition の system。値は適用ごとの uuid。"
* insert FCNamingSystem(RegimenInstance, http://fhir-client.local/Identifier/regimen-instance)

// ---- 記録の入力単位 ----

Instance: ns-vital-entry
InstanceOf: NamingSystem
Usage: #definition
Title: "バイタル測定の入力単位"
Description: "1 回の測定で入力したバイタル Observation を束ねる identifier の system。値は uuid。"
* insert FCNamingSystem(VitalEntry, http://fhir-client.local/vital-entry)

Instance: ns-nursing-perform-entry
InstanceOf: NamingSystem
Usage: #definition
Title: "看護実施の入力単位"
Description: "1 回の看護ラウンドで入力した Observation / Procedure を束ねる identifier の system。値は uuid。"
* insert FCNamingSystem(NursingPerformEntry, http://fhir-client.local/nursing-perform-entry)

Instance: ns-practitioner-id
InstanceOf: NamingSystem
Usage: #definition
Title: "職員(上流の Practitioner の id)"
Description: "診断群分類の決定の記録で、contained Practitioner(決定者)の identifier の system。値は上流サーバーの Practitioner の論理 id。職員としてログインしていない(管理者)ときは identifier を持たない。"
* insert FCNamingSystem(PractitionerId, http://fhir-client.local/Practitioner)

// ---- レセプトコンピュータ連携(backend が書く) ----

Instance: ns-receipt-computer-coverage
InstanceOf: NamingSystem
Usage: #definition
Title: "レセコン取込 保険"
Description: "レセプトコンピュータから取り込んだ Coverage.identifier の system。値は \"{患者番号}:{外部キー}\"。条件付き PUT のキー。"
* insert FCNamingSystem(ReceiptComputerCoverage, http://fhir-client.local/integrations/receipt-computer/coverage)

Instance: ns-receipt-computer-reception
InstanceOf: NamingSystem
Usage: #definition
Title: "レセコン取込 受付"
Description: "レセプトコンピュータから取り込んだ受付 Appointment.identifier の system。値は受付キー。条件付き PUT のキー。"
* insert FCNamingSystem(ReceiptComputerReception, http://fhir-client.local/integrations/receipt-computer/reception)
