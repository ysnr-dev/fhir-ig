// 検体検査(オーダー・検体・結果)の CodeSystem。

CodeSystem: LabOrderItemCS
Id: lab-order-item
Title: "検体検査オーダー項目(院内マスタ)"
Description: "code = 院内マスタ master_lab_order_items の項目コード(セット項目を含む)。"
* insert MasterCS

CodeSystem: Jlac11CS
Id: jlac11
Title: "JLAC11 コード"
Description: "日本臨床検査医学会 臨床検査項目分類コード JLAC11(17 桁)。院内マスタ master_jlac_items から転記する。分析物コードの先頭 5 桁で検査項目を同定する(例: C3002 クレアチニン)。"
* insert MasterCS

CodeSystem: Jlac10CS
Id: jlac10
Title: "JLAC10 コード"
Description: "JLAC10(17 桁)。院内マスタ master_jlac_items に JLAC10 がある項目だけ付く。"
* insert MasterCS

CodeSystem: Jlac11SpecimenCS
Id: jlac11-specimen
Title: "検体材料コード(JLAC11)"
Description: "JLAC11 の材料コード(3 桁)。院内マスタ master_lab_specimens。Specimen.type に使う。"
* insert MasterCS

CodeSystem: LabContainerCS
Id: lab-container
Title: "採血管・容器"
Description: "院内マスタ master_lab_containers の容器コード。Specimen.container.type に使う。"
* insert MasterCS

CodeSystem: LabResultItemCS
Id: lab-result-item
Title: "検体検査結果項目(院内マスタ)"
Description: "code = 院内マスタ lab_result_items.result_item_code。結果 Observation.code.coding の先頭。"
* insert MasterCS

CodeSystem: LabResultSettingCS
Id: lab-result-setting
Title: "検査報告の入院・外来区分"
Description: "検体検査・細菌検査・病理・放射線の DiagnosticReport.category に付ける入院・外来区分。"
* insert EnumCS
* #inpatient "入院"
* #outpatient "外来"

ValueSet: LabResultSettingVS
Id: lab-result-setting-vs
Title: "検査報告の入院・外来区分 ValueSet"
* insert AllOf(LabResultSettingCS)
