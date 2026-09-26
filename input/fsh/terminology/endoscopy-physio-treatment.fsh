// 内視鏡・生理検査・処置(オーダー・実施)の CodeSystem。いずれも院内マスタ由来。

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
