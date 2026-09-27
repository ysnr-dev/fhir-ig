// 内視鏡・生理検査・処置(オーダー・実施)の CodeSystem は院内マスタ由来。所見レポートのコードは末尾。

CodeSystem: EndoscopyOrderItemCS
Id: endoscopy-order-item
Title: "内視鏡オーダー項目(院内マスタ)"
Description: "院内マスタ master_endoscopy_items。"
* insert MasterCS

CodeSystem: EndoscopyExamTypeCS
Id: endoscopy-exam-type
Title: "内視鏡検査種別(院内マスタ)"
Description: "院内マスタ master_endoscopy_exam_types。明細 ServiceRequest.category。"
* insert MasterCS

CodeSystem: EndoscopyProcedureCodeCS
Id: endoscopy-procedure-code
Title: "内視鏡 手技コード(レセプト)"
Description: "実施記録 Procedure.code のレセプト電算手技コード。"
* insert MasterCS

CodeSystem: PhysioOrderItemCS
Id: physio-order-item
Title: "生理検査オーダー項目(院内マスタ)"
Description: "院内マスタ master_physio_items。"
* insert MasterCS

CodeSystem: PhysioExamTypeCS
Id: physio-exam-type
Title: "生理検査種別(院内マスタ)"
Description: "院内マスタ master_physio_exam_types。明細 ServiceRequest.category。"
* insert MasterCS

CodeSystem: PhysioProcedureCodeCS
Id: physio-procedure-code
Title: "生理検査 手技コード(レセプト)"
Description: "実施記録 Procedure.code のレセプト電算手技コード。"
* insert MasterCS

CodeSystem: TreatmentOrderItemCS
Id: treatment-order-item
Title: "処置オーダー項目(院内マスタ)"
Description: "院内マスタ master_treatment_items。"
* insert MasterCS

CodeSystem: TreatmentProcedureCodeCS
Id: treatment-procedure-code
Title: "処置 手技コード(レセプト)"
Description: "実施記録 Procedure.code のレセプト電算手技コード。"
* insert MasterCS

// ---- 生理検査・内視鏡 所見レポート ----

CodeSystem: ExamReportCS
Id: exam-report
Title: "検査レポートの種類"
Description: "生理検査の所見レポートの DiagnosticReport.code。心電図・超音波・呼吸機能…と文書の種類が分かれ、1 つの LOINC に収まらないため施設コードにしている。"
* insert EnumCS
* #physio "生理検査報告書"

ValueSet: ExamReportVS
Id: exam-report-vs
Title: "検査レポートの種類 ValueSet"
Description: "検査レポートの種類 ValueSet。"
* insert AllOf(ExamReportCS)

CodeSystem: PhysioReportItemCS
Id: physio-report-item
Title: "生理検査 所見レポートの項目"
Description: "生理検査 所見レポートの所見 Observation.code。"
* insert EnumCS
* #findings "所見"

ValueSet: PhysioReportItemVS
Id: physio-report-item-vs
Title: "生理検査 所見レポートの項目 ValueSet"
Description: "生理検査 所見レポートの項目 ValueSet。"
* insert AllOf(PhysioReportItemCS)

CodeSystem: EndoscopyReportItemCS
Id: endoscopy-report-item
Title: "内視鏡 所見レポートの項目"
Description: "内視鏡 所見レポートの所見 Observation.code。"
* insert EnumCS
* #findings "所見"

ValueSet: EndoscopyReportItemVS
Id: endoscopy-report-item-vs
Title: "内視鏡 所見レポートの項目 ValueSet"
Description: "内視鏡 所見レポートの項目 ValueSet。"
* insert AllOf(EndoscopyReportItemCS)
