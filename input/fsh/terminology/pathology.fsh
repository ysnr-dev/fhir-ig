// 病理検査(オーダー・レポート)の CodeSystem。JAHIS 病理診断レポート構造化記述規約の付録コード表を使う。

CodeSystem: JahisPathoExamCategoryCS
Id: jahis-patho-exam-category
Title: "病理検査区分(JAHIS LPATHO001)"
Description: "JAHIS 病理診断レポート構造化記述規約 付録 LPATHO001。病理オーダーのヘッダ ServiceRequest.code。"
* insert EnumCS
* #N000 "組織診"
* #N004 "細胞診"
* #N003 "術中迅速"

ValueSet: JahisPathoExamCategoryVS
Id: jahis-patho-exam-category-vs
Title: "病理検査区分(JAHIS LPATHO001) ValueSet"
Description: "病理検査区分(JAHIS LPATHO001) ValueSet。"
* insert AllOf(JahisPathoExamCategoryCS)

CodeSystem: JahisPathoSpecimenTypeCS
Id: jahis-patho-specimen-type
Title: "病理検体タイプ(JAHIS LPATHO002)"
Description: "JAHIS 付録 LPATHO002。Specimen.type。"
* insert EnumCS
* #201 "生検"
* #211 "手術材料"
* #101 "細胞診材料"

ValueSet: JahisPathoSpecimenTypeVS
Id: jahis-patho-specimen-type-vs
Title: "病理検体タイプ(JAHIS LPATHO002) ValueSet"
Description: "病理検体タイプ(JAHIS LPATHO002) ValueSet。"
* insert AllOf(JahisPathoSpecimenTypeCS)

CodeSystem: JahisPathoOrganCS
Id: jahis-patho-organ
Title: "臓器(JAHIS 病理)"
Description: "JAHIS 付録の臓器コード(533 件)。院内マスタ master_patho_organs に取り込む。Specimen.collection.bodySite。"
* insert MasterCS

CodeSystem: JahisPathoCollectionMethodCS
Id: jahis-patho-collection-method
Title: "採取方法(JAHIS 病理)"
Description: "JAHIS 付録の採取方法コード。院内マスタ master_patho_collection_methods。Specimen.collection.method。"
* insert MasterCS

CodeSystem: PathoLateralityCS
Id: patho-laterality
Title: "左右区分(病理)"
Description: "左右区分(病理)のコード。"
* insert EnumCS
* #R "右"
* #L "左"
* #B "両側"

ValueSet: PathoLateralityVS
Id: patho-laterality-vs
Title: "左右区分(病理) ValueSet"
Description: "左右区分(病理) ValueSet。"
* insert AllOf(PathoLateralityCS)

CodeSystem: PathoCytoJudgementCS
Id: patho-cyto-judgement
Title: "細胞診の判定"
Description: "領域別の分類(ベセスダ等)は持たず、汎用の 5 段階。細胞診の診断 Observation.valueCodeableConcept。"
* insert EnumCS
* #negative "陰性"
* #indeterminate "鑑別困難"
* #suspicious "悪性疑い"
* #malignant "悪性"
* #unsatisfactory "検体不適正"

ValueSet: PathoCytoJudgementVS
Id: patho-cyto-judgement-vs
Title: "細胞診の判定 ValueSet"
Description: "細胞診の判定 ValueSet。"
* insert AllOf(PathoCytoJudgementCS)

CodeSystem: PathoResultItemCS
Id: patho-result-item
Title: "病理レポートの項目"
Description: "細胞診の診断 Observation.component.code。"
* insert EnumCS
* #estimated-lesion "推定病変"

ValueSet: PathoResultItemVS
Id: patho-result-item-vs
Title: "病理レポートの項目 ValueSet"
Description: "病理レポートの項目 ValueSet。"
* insert AllOf(PathoResultItemCS)

CodeSystem: PathoReportImageKindCS
Id: patho-report-image-kind
Title: "病理レポート画像の種類"
Description: "patho-report-image 拡張の kind。表示はこの順。"
* insert EnumCS
* #gross "肉眼写真"
* #cutup "切り出し図"
* #microscopic "鏡検写真"
* #other "その他"

ValueSet: PathoReportImageKindVS
Id: patho-report-image-kind-vs
Title: "病理レポート画像の種類 ValueSet"
Description: "病理レポート画像の種類 ValueSet。"
* insert AllOf(PathoReportImageKindCS)
