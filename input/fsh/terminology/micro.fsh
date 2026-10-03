// 細菌検査(オーダー・結果)の CodeSystem。JANIS 由来のものは院内マスタから取り込む。

CodeSystem: MicroOrderItemCS
Id: micro-order-item
Title: "細菌検査オーダー項目(院内マスタ)"
Description: "code = 院内マスタ master_micro_order_items の項目コード(培養・同定・感受性・塗抹など)。"
* insert MasterCS

CodeSystem: JanisSpecimenTypeCS
Id: janis-specimen-type
Title: "JANIS 検体種別"
Description: "JANIS(院内感染対策サーベイランス)の検体種別コード。院内マスタ master_micro_specimen_types。Specimen.type に使う。"
* insert MasterCS

CodeSystem: JanisOrganismCS
Id: janis-organism
Title: "JANIS 菌種"
Description: "JANIS の菌種コード。院内マスタ master_micro_organisms。目的菌(ServiceRequest.orderDetail)と分離菌(Observation.value)に使う。"
* insert MasterCS

CodeSystem: MicroCollectionSiteCS
Id: micro-collection-site
Title: "採取部位(細菌検査)"
Description: "院内マスタ master_micro_collection_sites。Specimen.collection.bodySite。"
* insert MasterCS

CodeSystem: MicroCollectionMethodCS
Id: micro-collection-method
Title: "採取方法(細菌検査)"
Description: "院内マスタ master_micro_collection_methods。Specimen.collection.method。"
* insert MasterCS

CodeSystem: MicroLateralityCS
Id: micro-laterality
Title: "左右区分(細菌検査)"
Description: "採取部位の左右。Specimen.collection.bodySite に採取部位コードと並べて入れる。"
* insert EnumCS
* #R "右"
* #L "左"
* #B "両側"

ValueSet: MicroLateralityVS
Id: micro-laterality-vs
Title: "左右区分(細菌検査) ValueSet"
Description: "左右区分(細菌検査) ValueSet。"
* insert AllOf(MicroLateralityCS)

CodeSystem: MicroResultItemCS
Id: micro-result-item
Title: "細菌検査結果の項目"
Description: "結果 Observation.code と component.code。culture / smear / sputum-* / pyuria / isolate が Observation.code、colony-* / causative / disk-diameter / susceptibility-grade が component.code。"
* insert EnumCS
* #culture "培養結果"
* #smear "塗抹・鏡検所見"
* #sputum-miller-jones "喀痰品質評価(Miller&Jones分類)"
* #sputum-geckler "喀痰品質評価(Geckler分類)"
* #pyuria "膿尿評価"
* #isolate "分離菌"
* #colony-quantity-type "菌量"
* #colony-count "菌数"
* #causative "起炎性"
* #disk-diameter "阻止円径"
* #susceptibility-grade "判定(+)"

ValueSet: MicroResultItemVS
Id: micro-result-item-vs
Title: "細菌検査結果の項目 ValueSet"
Description: "細菌検査結果の項目 ValueSet。"
* insert AllOf(MicroResultItemCS)

CodeSystem: MicroCultureResultCS
Id: micro-culture-result
Title: "培養結果"
Description: "培養結果のコード。"
* insert EnumCS
* #negative "陰性"
* #positive "陽性"

ValueSet: MicroCultureResultVS
Id: micro-culture-result-vs
Title: "培養結果 ValueSet"
Description: "培養結果 ValueSet。"
* insert AllOf(MicroCultureResultCS)

CodeSystem: MicroMillerJonesCS
Id: micro-miller-jones
Title: "喀痰 Miller & Jones 分類"
Description: "喀痰 Miller & Jones 分類のコード。"
* insert EnumCS
* #P1 "P1"
* #P2 "P2"
* #P3 "P3"
* #M1 "M1"
* #M2 "M2"

ValueSet: MicroMillerJonesVS
Id: micro-miller-jones-vs
Title: "喀痰 Miller & Jones 分類 ValueSet"
Description: "喀痰 Miller & Jones 分類 ValueSet。"
* insert AllOf(MicroMillerJonesCS)

CodeSystem: MicroGecklerCS
Id: micro-geckler
Title: "喀痰 Geckler 分類"
Description: "喀痰 Geckler 分類のコード。"
* insert EnumCS
* #1 "グループ1"
* #2 "グループ2"
* #3 "グループ3"
* #4 "グループ4"
* #5 "グループ5"
* #6 "グループ6"

ValueSet: MicroGecklerVS
Id: micro-geckler-vs
Title: "喀痰 Geckler 分類 ValueSet"
Description: "喀痰 Geckler 分類 ValueSet。"
* insert AllOf(MicroGecklerCS)

CodeSystem: MicroPyuriaMethodCS
Id: micro-pyuria-method
Title: "膿尿の判定方法"
Description: "膿尿 Observation.method。"
* insert EnumCS
* #sediment-wbc "沈渣白血球数"
* #wbc-count "白血球数"
* #esterase "白血球エステラーゼ活性"
* #other "その他"

ValueSet: MicroPyuriaMethodVS
Id: micro-pyuria-method-vs
Title: "膿尿の判定方法 ValueSet"
Description: "膿尿の判定方法 ValueSet。"
* insert AllOf(MicroPyuriaMethodCS)

CodeSystem: MicroPyuriaResultCS
Id: micro-pyuria-result
Title: "膿尿の結果"
Description: "膿尿の結果のコード。"
* insert EnumCS
* #none "なし"
* #intermediate "中間"
* #present "あり"
* #unknown "不明"

ValueSet: MicroPyuriaResultVS
Id: micro-pyuria-result-vs
Title: "膿尿の結果 ValueSet"
Description: "膿尿の結果 ValueSet。"
* insert AllOf(MicroPyuriaResultCS)

CodeSystem: MicroColonyQuantityTypeCS
Id: micro-colony-quantity-type
Title: "菌量(JANIS)"
Description: "JANIS の菌量(半定量 / 定量 / その他)。分離菌 Observation の component(colony-quantity-type)。"
* insert EnumCS
* #1 "半定量"
* #2 "定量"
* #9 "その他"

ValueSet: MicroColonyQuantityTypeVS
Id: micro-colony-quantity-type-vs
Title: "菌量(JANIS) ValueSet"
Description: "菌量(JANIS) ValueSet。"
* insert AllOf(MicroColonyQuantityTypeCS)

CodeSystem: MicroColonyCountCS
Id: micro-colony-count
Title: "菌数(JANIS)"
Description: "JANIS の菌数コード(1〜8)をそのまま使う。分離菌 Observation の component(colony-count)。"
* insert EnumCS
* #1 "10^2/ml以下"
* #2 "10^3/ml"
* #3 "10^4/ml"
* #4 "10^5/ml"
* #5 "10^6/ml"
* #6 "10^7/ml以上"
* #7 "10^3〜10^4/ml"
* #8 "10^5〜10^6/ml"

ValueSet: MicroColonyCountVS
Id: micro-colony-count-vs
Title: "菌数(JANIS) ValueSet"
Description: "菌数(JANIS) ValueSet。"
* insert AllOf(MicroColonyCountCS)

CodeSystem: MicroCausativeCS
Id: micro-causative
Title: "起炎性"
Description: "分離菌の起炎性(起炎菌かどうか)。分離菌 Observation の component(causative)。"
* insert EnumCS
* #none "なし"
* #present "あり"
* #unknown "不明"

ValueSet: MicroCausativeVS
Id: micro-causative-vs
Title: "起炎性 ValueSet"
Description: "起炎性 ValueSet。"
* insert AllOf(MicroCausativeCS)

CodeSystem: MicroSusceptibilityGradeCS
Id: micro-susceptibility-grade
Title: "感受性の判定(+)"
Description: "感受性の判定(− 〜 ＋＋＋)。感受性 Observation の component(susceptibility-grade)。code は半角、display は全角。"
* insert EnumCS
* #- "−"
* #+ "＋"
* #++ "＋＋"
* #+++ "＋＋＋"

ValueSet: MicroSusceptibilityGradeVS
Id: micro-susceptibility-grade-vs
Title: "感受性の判定(+) ValueSet"
Description: "感受性の判定(+) ValueSet。"
* insert AllOf(MicroSusceptibilityGradeCS)

CodeSystem: JanisAntimicrobialCS
Id: janis-antimicrobial
Title: "JANIS 抗菌薬"
Description: "JANIS の抗菌薬コード。院内マスタ master_micro_antimicrobials。感受性 Observation.code。"
* insert MasterCS

CodeSystem: MicroAntimicrobialAbbreviationCS
Id: micro-antimicrobial-abbreviation
Title: "抗菌薬略称"
Description: "感受性 Observation.code.coding に補助的に付く略号。code = JANIS 抗菌薬コード(janis-antimicrobial と同じ値)、display = 略号(例: ABPC)。"
* insert MasterCS

CodeSystem: JanisSusceptibilityMethodCS
Id: janis-susceptibility-method
Title: "JANIS 感受性測定法"
Description: "院内マスタ master_micro_susceptibility_methods。感受性 Observation.method。"
* insert MasterCS
