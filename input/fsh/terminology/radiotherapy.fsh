// 放射線治療(処方・照射・コース要約)の CodeSystem。設計は mCODE Radiotherapy を模している。

CodeSystem: RadiotherapyOrderCS
Id: radiotherapy-order
Title: "放射線治療オーダーの種類"
Description: "放射線治療の ServiceRequest.code。"
* insert EnumCS
* #course-prescription "放射線治療処方"

ValueSet: RadiotherapyOrderVS
Id: radiotherapy-order-vs
Title: "放射線治療オーダーの種類 ValueSet"
* insert AllOf(RadiotherapyOrderCS)

CodeSystem: RadiotherapyIntentCS
Id: radiotherapy-intent
Title: "治療目的(放射線治療)"
* insert EnumCS
* #curative "根治"
* #neoadjuvant "術前"
* #adjuvant "術後"
* #palliative "緩和"
* #prophylactic "予防"

ValueSet: RadiotherapyIntentVS
Id: radiotherapy-intent-vs
Title: "治療目的(放射線治療) ValueSet"
* insert AllOf(RadiotherapyIntentCS)

CodeSystem: RadiotherapyConcurrentTherapyCS
Id: radiotherapy-concurrent-therapy
Title: "併用療法(放射線治療)"
* insert EnumCS
* #none "なし"
* #concurrent-chemo "同時化学療法"
* #sequential-chemo "逐次化学療法"
* #hormone "内分泌療法"
* #other "その他"

ValueSet: RadiotherapyConcurrentTherapyVS
Id: radiotherapy-concurrent-therapy-vs
Title: "併用療法(放射線治療) ValueSet"
* insert AllOf(RadiotherapyConcurrentTherapyCS)

CodeSystem: RadiotherapyProtocolCS
Id: radiotherapy-protocol
Title: "放射線治療プロトコル(院内マスタ)"
Description: "院内マスタ master_radiotherapy_protocols。"
* insert MasterCS

CodeSystem: RadiotherapyStopReasonCS
Id: radiotherapy-stop-reason
Title: "放射線治療の中止・休止理由(院内マスタ)"
Description: "院内マスタ master_radiotherapy_stop_reasons。コース拡張の terminationReason / suspensionReason、照射 Procedure.statusReason、コース要約の terminationReason に使う。"
* insert MasterCS

CodeSystem: RadiotherapyVolumeTypeCS
Id: radiotherapy-volume-type
Title: "標的体積の種類"
* insert EnumCS
* #GTV "GTV"
* #CTV "CTV"
* #ITV "ITV"
* #PTV "PTV"
* #other "その他"

ValueSet: RadiotherapyVolumeTypeVS
Id: radiotherapy-volume-type-vs
Title: "標的体積の種類 ValueSet"
* insert AllOf(RadiotherapyVolumeTypeCS)

CodeSystem: RadiotherapyModalityCS
Id: radiotherapy-modality
Title: "照射法(モダリティ)(院内マスタ)"
Description: "院内マスタ master_radiotherapy_modalities。"
* insert MasterCS

CodeSystem: RadiotherapyTechniqueCS
Id: radiotherapy-technique
Title: "照射技術(院内マスタ)"
Description: "院内マスタ master_radiotherapy_techniques。照射 Procedure.code にはこの coding を転記する。"
* insert MasterCS

CodeSystem: RadiotherapyDeviceCS
Id: radiotherapy-device
Title: "治療装置(院内マスタ)"
Description: "院内マスタ master_radiotherapy_devices。"
* insert MasterCS

CodeSystem: RadiotherapyProcedureCS
Id: radiotherapy-procedure
Title: "放射線治療の実施記録の種類"
Description: "実施記録 Procedure.category の 2 番目の coding。order-type#radiotherapy と並べる。"
* insert EnumCS
* #fraction "照射"
* #course-summary "コース要約"

ValueSet: RadiotherapyProcedureVS
Id: radiotherapy-procedure-vs
Title: "放射線治療の実施記録の種類 ValueSet"
* insert AllOf(RadiotherapyProcedureCS)

CodeSystem: RadiotherapyImageGuidanceCS
Id: radiotherapy-image-guidance
Title: "位置照合(IGRT)の方法"
* insert EnumCS
* #none "なし"
* #cbct "CBCT"
* #kv "kV 画像"
* #mv "MV 画像"
* #surface "体表面照合"
* #other "その他"

ValueSet: RadiotherapyImageGuidanceVS
Id: radiotherapy-image-guidance-vs
Title: "位置照合(IGRT)の方法 ValueSet"
* insert AllOf(RadiotherapyImageGuidanceCS)

CodeSystem: RadiotherapyCourseOutcomeCS
Id: radiotherapy-course-outcome
Title: "放射線治療コースの転帰"
* insert EnumCS
* #completed "完遂"
* #discontinued "中止"

ValueSet: RadiotherapyCourseOutcomeVS
Id: radiotherapy-course-outcome-vs
Title: "放射線治療コースの転帰 ValueSet"
* insert AllOf(RadiotherapyCourseOutcomeCS)
