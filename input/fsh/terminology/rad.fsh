// 放射線検査(オーダー・実施・読影)の CodeSystem。

CodeSystem: RadOrderItemCS
Id: rad-order-item
Title: "放射線検査オーダー項目(院内マスタ)"
Description: "code = 院内マスタ master_rad_items の項目コード(セットを含む)。"
* insert MasterCS

CodeSystem: Jj101732CS
Id: jj1017-32
Title: "JJ1017 32 桁コード"
Description: "JJ1017(日本放射線科専門医会・医会 画像検査コード)の 32 桁コード。院内マスタ master_rad_jj1017_codes から組み立てる。全桁 0 なら省略する。"
* insert MasterCS

CodeSystem: Jj101716mCS
Id: jj1017-16m
Title: "JJ1017 16 桁(前半)"
Description: "JJ1017 32 桁の前半 16 桁(手技)。display は持たない。"
* insert MasterCS

CodeSystem: Jj101716sCS
Id: jj1017-16s
Title: "JJ1017 16 桁(後半)"
Description: "JJ1017 32 桁の後半 16 桁(部位ほか)。"
* insert MasterCS

CodeSystem: Jj1017ModalityCS
Id: jj1017-modality
Title: "モダリティ(JJ1017)"
Description: "JJ1017 のモダリティコード。院内マスタ master_rad_jj1017_codes(element = modality)。明細 ServiceRequest.category。"
* insert MasterCS

CodeSystem: Jj1017pCS
Id: jj1017p
Title: "部位(JJ1017P)"
Description: "JJ1017 の部位コード。院内マスタ master_rad_jj1017_codes(element = part)。bodySite。放射線治療でも使う。"
* insert MasterCS

CodeSystem: RadProcedureCodeCS
Id: rad-procedure-code
Title: "放射線 手技コード(レセプト)"
Description: "実施記録 Procedure.code のレセプト電算手技コード。院内マスタから転記する。"
* insert MasterCS

CodeSystem: RadMaterialCS
Id: rad-material
Title: "放射線 使用材料(院内)"
Description: "院内の材料コード。実施記録 Procedure.usedCode。特定保険医療材料コード(medical-material)と並べて入れる。"
* insert MasterCS

CodeSystem: MedicalMaterialCS
Id: medical-material
Title: "特定保険医療材料コード"
Description: "レセプト電算の特定保険医療材料コード。放射線・内視鏡・生理検査・処置・手術の実施記録 Procedure.usedCode に使う。"
* insert MasterCS

CodeSystem: RadDoseCS
Id: rad-dose
Title: "被ばく線量の項目"
Description: "実施記録の線量 Observation.code。単位は UCUM(ctdivol mGy / dlp mGy.cm / dap Gy.cm2 / fluoroscopy-time s)。"
* insert EnumCS
* #ctdivol "CTDIvol"
* #dlp "DLP"
* #dap "面積線量(DAP)"
* #fluoroscopy-time "透視時間"

ValueSet: RadDoseVS
Id: rad-dose-vs
Title: "被ばく線量の項目 ValueSet"
Description: "被ばく線量の項目 ValueSet。"
* insert AllOf(RadDoseCS)

CodeSystem: RadReportItemCS
Id: rad-report-item
Title: "読影レポートの項目"
Description: "読影レポートの所見 Observation.code。"
* insert EnumCS
* #findings "所見"

ValueSet: RadReportItemVS
Id: rad-report-item-vs
Title: "読影レポートの項目 ValueSet"
Description: "読影レポートの項目 ValueSet。"
* insert AllOf(RadReportItemCS)
