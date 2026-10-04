// 薬剤(処方・注射・持参薬・レジメン)の CodeSystem。

CodeSystem: MedicineCodeCS
Id: medicine-code
Title: "医薬品コード(レセプト電算)"
Description: "レセプト電算処理システムの医薬品コード(9 桁、先頭 6)。院内の医薬品マスタから転記し、YJ コード(http://capstandard.jp/iyaku.info/CodeSystem/YJ-code)と並べて入れる。"
* insert MasterCS

CodeSystem: MedicineUsageCS
Id: medicine-usage
Title: "用法コード(JAMI 16 桁)"
Description: "JAMI 標準用法コード(16 桁)。院内の用法マスタから転記する。3 桁目が 5 なら頓用(asNeededBoolean = true、timing.repeat.count = 回数)。"
* insert MasterCS

CodeSystem: MedicineUsageBasicCategoryCS
Id: medicine-usage-basic-category
Title: "用法の基本区分"
Description: "code = 用法マスタの basic_usage_category_code、display = 内服 / 外用 / 注射 / 注入。"
* insert MasterCS

CodeSystem: InjectionCategoryCS
Id: injection-category
Title: "注射区分"
Description: "注射オーダー ServiceRequest.category の 3 番目。入院は regular / temporary / emergency、外来は outpatient。"
* insert EnumCS
* #regular "定時"
* #temporary "臨時"
* #emergency "緊急"
* #outpatient "外来"

ValueSet: InjectionCategoryVS
Id: injection-category-vs
Title: "注射区分 ValueSet"
Description: "注射区分 ValueSet。"
* insert AllOf(InjectionCategoryCS)

CodeSystem: InjectionUsageTypeCS
Id: injection-usage-type
Title: "注射の投与形態"
Description: "注射の投与形態のコード。"
* insert EnumCS
* #drip "点滴"
* #one-shot "ワンショット"

ValueSet: InjectionUsageTypeVS
Id: injection-usage-type-vs
Title: "注射の投与形態 ValueSet"
Description: "注射の投与形態 ValueSet。"
* insert AllOf(InjectionUsageTypeCS)

CodeSystem: InjectionLineCS
Id: injection-line
Title: "注射ルート"
Description: "JP Core の JP_MedicationDosage_Line 拡張の valueCodeableConcept。"
* insert EnumCS
* #peripheral "末梢ルート"
* #peripheral-side "末梢ルート(側管)"
* #central "中心静脈ルート"
* #central-side "中心静脈ルート(側管)"

ValueSet: InjectionLineVS
Id: injection-line-vs
Title: "注射ルート ValueSet"
Description: "注射ルート ValueSet。"
* insert AllOf(InjectionLineCS)

CodeSystem: BroughtMedicationDecisionCS
Id: brought-medication-decision
Title: "持参薬の判断"
Description: "持参薬 MedicationStatement.statusReason。continue → status active、hold → on-hold、stop → stopped。"
* insert EnumCS
* #continue "継続"
* #hold "休止"
* #stop "中止"

ValueSet: BroughtMedicationDecisionVS
Id: brought-medication-decision-vs
Title: "持参薬の判断 ValueSet"
Description: "持参薬の判断 ValueSet。"
* insert AllOf(BroughtMedicationDecisionCS)

CodeSystem: RegimenCS
Id: regimen
Title: "化学療法レジメン(院内マスタ)"
Description: "code = backend のレジメンマスタの regimen_code。レジメン適用 ServiceRequest.code。"
* insert MasterCS

CodeSystem: InsulinScaleKindCS
Id: insulin-scale-kind
Title: "インスリンスケールの種別"
Description: "insulin-scale 拡張の kind。glucose = 血糖(mg/dL)、meal = 食事量(主食の摂取量 %)で、測った値で行が決まる。free = フリースケール(行ごとの条件を文で書き、実施入力で行を選ぶ)。"
* insert EnumCS
* #glucose "血糖"
* #meal "食事量"
* #free "フリー"

ValueSet: InsulinScaleKindVS
Id: insulin-scale-kind-vs
Title: "インスリンスケールの種別 ValueSet"
Description: "インスリンスケールの種別 ValueSet。"
* insert AllOf(InsulinScaleKindCS)

CodeSystem: InsulinScaleSetCS
Id: insulin-scale-set
Title: "インスリンスケールセット(院内マスタ)"
Description: "code = backend のスケールセットの id、display = セット名。insulin-scale 拡張の set(セットから写したまま行を直していないときだけ付く)。"
* insert MasterCS
