// リハビリ・他科依頼・看護指示の CodeSystem。

CodeSystem: RehabDiseaseCategoryCS
Id: rehab-disease-category
Title: "リハビリテーションの疾患別区分"
Description: "リハビリオーダー ServiceRequest.code。診療報酬の疾患別リハビリテーション料の区分。"
* insert EnumCS
* #cardiovascular "心大血管疾患リハビリテーション"
* #cerebrovascular "脳血管疾患等リハビリテーション"
* #disuse "廃用症候群リハビリテーション"
* #musculoskeletal "運動器リハビリテーション"
* #respiratory "呼吸器リハビリテーション"

ValueSet: RehabDiseaseCategoryVS
Id: rehab-disease-category-vs
Title: "リハビリテーションの疾患別区分 ValueSet"
Description: "リハビリテーションの疾患別区分 ValueSet。"
* insert AllOf(RehabDiseaseCategoryCS)

CodeSystem: RehabTherapyTypeCS
Id: rehab-therapy-type
Title: "療法種別"
Description: "リハビリオーダー ServiceRequest.orderDetail と実施記録 Procedure.code。"
* insert EnumCS
* #pt "理学療法(PT)"
* #ot "作業療法(OT)"
* #st "言語聴覚療法(ST)"

ValueSet: RehabTherapyTypeVS
Id: rehab-therapy-type-vs
Title: "療法種別 ValueSet"
Description: "療法種別 ValueSet。"
* insert AllOf(RehabTherapyTypeCS)

CodeSystem: ConsultRequestTypeCS
Id: consult-request-type
Title: "他科依頼の種類"
Description: "他科依頼 ServiceRequest.code。"
* insert EnumCS
* #consult "診察依頼"
* #opinion "意見のみ"
* #exam "検査依頼"
* #transfer "転科相談"

ValueSet: ConsultRequestTypeVS
Id: consult-request-type-vs
Title: "他科依頼の種類 ValueSet"
Description: "他科依頼の種類 ValueSet。"
* insert AllOf(ConsultRequestTypeCS)

CodeSystem: ConsultNoteEventCS
Id: consult-note-event
Title: "診療記録のイベント(他科依頼)"
Description: "他科依頼への回答の Composition.event.code。event.detail が依頼の ServiceRequest を指す。"
* insert EnumCS
* #reply "他科依頼への回答"

ValueSet: ConsultNoteEventVS
Id: consult-note-event-vs
Title: "診療記録のイベント(他科依頼) ValueSet"
Description: "診療記録のイベント(他科依頼) ValueSet。"
* insert AllOf(ConsultNoteEventCS)

CodeSystem: NursingObservationResultCS
Id: nursing-observation-result
Title: "看護観察の結果(MEDIS)"
Description: "code = \"{結果グループコード}-{NN}\"。MEDIS 看護実践用語標準マスタ(看護観察編)の結果選択肢。院内マスタから取り込む。看護観察 Observation.valueCodeableConcept。"
* insert MasterCS
