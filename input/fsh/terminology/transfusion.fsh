// 輸血と血液型の CodeSystem。

CodeSystem: TransfusionTestTypeCS
Id: transfusion-test-type
Title: "輸血前検査の種類"
Description: "輸血オーダー ヘッダ ServiceRequest.code。"
* insert EnumCS
* #crossmatch "交差適合試験"
* #type-screen "T&S(タイプ&スクリーン)"

ValueSet: TransfusionTestTypeVS
Id: transfusion-test-type-vs
Title: "輸血前検査の種類 ValueSet"
Description: "輸血前検査の種類 ValueSet。"
* insert AllOf(TransfusionTestTypeCS)

CodeSystem: TransfusionProductCS
Id: transfusion-product
Title: "輸血製剤(院内マスタ)"
Description: "院内マスタ master_transfusion_products。製剤明細 ServiceRequest.code、投与 MedicationAdministration.medication。"
* insert MasterCS

CodeSystem: TransfusionAboCS
Id: transfusion-abo
Title: "ABO 血液型"
Description: "輸血オーダーの transfusion-abo 拡張と血液型 Observation(LOINC 883-9)の valueCodeableConcept。"
* insert EnumCS
* #A "A"
* #B "B"
* #O "O"
* #AB "AB"

ValueSet: TransfusionAboVS
Id: transfusion-abo-vs
Title: "ABO 血液型 ValueSet"
Description: "ABO 血液型 ValueSet。"
* insert AllOf(TransfusionAboCS)

CodeSystem: TransfusionRhdCS
Id: transfusion-rhd
Title: "RhD 血液型"
Description: "輸血オーダーの transfusion-rhd 拡張と血液型 Observation(LOINC 10331-7)の valueCodeableConcept。"
* insert EnumCS
* #positive "＋"
* #negative "－"

ValueSet: TransfusionRhdVS
Id: transfusion-rhd-vs
Title: "RhD 血液型 ValueSet"
Description: "RhD 血液型 ValueSet。"
* insert AllOf(TransfusionRhdCS)

CodeSystem: TransfusionObservationCS
Id: transfusion-observation
Title: "輸血実施の観察項目"
Description: "輸血実施記録にぶら下がる Observation.code。"
* insert EnumCS
* #reaction "輸血副作用"

ValueSet: TransfusionObservationVS
Id: transfusion-observation-vs
Title: "輸血実施の観察項目 ValueSet"
Description: "輸血実施の観察項目 ValueSet。"
* insert AllOf(TransfusionObservationCS)

CodeSystem: TransfusionReactionCS
Id: transfusion-reaction
Title: "輸血副作用の有無"
Description: "輸血副作用の有無のコード。"
* insert EnumCS
* #none "なし"
* #present "あり"

ValueSet: TransfusionReactionVS
Id: transfusion-reaction-vs
Title: "輸血副作用の有無 ValueSet"
Description: "輸血副作用の有無 ValueSet。"
* insert AllOf(TransfusionReactionCS)
