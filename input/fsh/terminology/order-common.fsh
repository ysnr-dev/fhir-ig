// オーダー全種別で共有する CodeSystem / ValueSet。

CodeSystem: OrderTypeCS
Id: order-type
Title: "オーダー種別"
Description: "ServiceRequest.category の先頭要素、および実施記録 Procedure.category.coding の先頭でオーダー種別を識別する。上流サーバーは Procedure・Observation の category を先頭しか索引しないため、必ず先頭に置く(ServiceRequest も同じ並びにする)。"
* insert EnumCS
* #lab "検体検査"
* #micro "細菌検査"
* #rad "放射線検査"
* #radiotherapy "放射線治療"
* #endoscopy "内視鏡"
* #physio "生理検査"
* #pathology "病理検査"
* #surgery "手術"
* #treatment "処置"
* #rehab "リハビリ"
* #consult "他科依頼"
* #team-request "チーム依頼"
* #nursing "看護指示"
* #meal "食事"
* #transfusion "輸血"
* #nutrition-guidance "栄養指導"
* #medication-guidance "服薬指導"
* #injection "注射"
* #chemo-regimen "化学療法"
* #anesthesia-chart "麻酔チャート"
* #prescription "処方"

ValueSet: OrderTypeVS
Id: order-type-vs
Title: "オーダー種別 ValueSet"
Description: "オーダー種別 ValueSet。"
* insert AllOf(OrderTypeCS)

CodeSystem: PrescriptionSettingCS
Id: prescription-setting
Title: "入院・外来区分"
Description: "オーダーの入院・外来区分。ServiceRequest.category の 2 番目に置く。食事・看護指示は常に inpatient。"
* insert EnumCS
* #inpatient "入院"
* #outpatient "外来"

ValueSet: PrescriptionSettingVS
Id: prescription-setting-vs
Title: "入院・外来区分 ValueSet"
Description: "入院・外来区分 ValueSet。"
* insert AllOf(PrescriptionSettingCS)

CodeSystem: PrescriptionCategoryCS
Id: prescription-category
Title: "処方区分"
Description: "処方ヘッダ ServiceRequest.category の 3 番目。入院は regular/continuous/temporary/discharge/emergency、外来は external/internal。brought は持参薬を継続するときに作る院内処方。"
* insert EnumCS
* #regular "定期"
* #continuous "継続"
* #temporary "臨時"
* #discharge "退院"
* #emergency "緊急"
* #external "院外"
* #internal "院内"
* #brought "持参"

ValueSet: PrescriptionCategoryVS
Id: prescription-category-vs
Title: "処方区分 ValueSet"
Description: "処方区分 ValueSet。"
* insert AllOf(PrescriptionCategoryCS)

CodeSystem: TaskCodeCS
Id: task-code
Title: "Task 種別"
Description: "Task.code。部門進捗 Task(オーダーの部門側の進捗)と通知 Task(担当者宛の通知)の両方がこの CodeSystem を使う。"
* insert EnumCS
* #rx-dispense "調剤"
* #injection "注射"
* #lab-exam "検体検査"
* #rad-exam "放射線検査"
* #radiotherapy "放射線治療"
* #endoscopy-exam "内視鏡"
* #physio-exam "生理検査"
* #patho-exam "病理検査"
* #surgery "手術"
* #treatment "処置"
* #rehab "リハビリ"
* #consult "他科依頼"
* #team-request "チーム依頼"
* #nursing "看護指示"
* #transfusion "輸血"
* #nutrition-guidance "栄養指導"
* #medication-guidance "服薬指導"
* #brought-med-review "持参薬鑑別"
* #order-approval "オーダー承認"
* #brought-med-identified "持参薬鑑別済"
* #document-due "文書作成"
* #lab-panic "緊急異常値"
* #result-review "検査結果確認"
* #rad-critical-finding "重要所見"
* #physio-critical-finding "重要所見(生理検査)"
* #endoscopy-critical-finding "重要所見(内視鏡)"
* #pathway-variance "パスのバリアンス"
* #radiotherapy-review-due "放射線治療の診察"
* #nursing-summary-returned "看護サマリー差戻し"
* #note-countersign "カルテ承認"
* #note-returned "カルテ差戻し"
* #dpc-recoding-due "DPC再判定"
* #rx-inquiry "疑義照会"
* #rx-inquiry-answered "疑義照会回答"
* #meal-allergy-check "食事のアレルギー確認"
* #ews-alert "早期警告"
* #antimicrobial-notification "特定抗菌薬の届出"
* #followup-recommendation "フォロー推奨"

ValueSet: TaskCodeVS
Id: task-code-vs
Title: "Task 種別 ValueSet"
Description: "Task 種別 ValueSet。"
* insert AllOf(TaskCodeCS)

CodeSystem: Jj1017LateralityCS
Id: jj1017-laterality
Title: "左右区分(JJ1017)"
Description: "JJ1017 の左右等区分(別表 4)。放射線検査は院内マスタ(JJ1017 部品コード)のコードと名称をそのまま入れるので 13 コードすべてが出うる。放射線治療と手術は R / L / B を同じ名称(右側 / 左側 / 両側)の display で入れる。"
* insert EnumCS
* #0 "指定なし"
* #B "両側"
* #R "右側"
* #L "左側"
* #H "頭側"
* #F "足側"
* #A "前側"
* #P "後側"
* #W "全体"
* #Q "右前側"
* #S "右後側"
* #K "左前側"
* #M "左後側"

ValueSet: Jj1017LateralityVS
Id: jj1017-laterality-vs
Title: "左右区分(JJ1017) ValueSet"
Description: "左右区分(JJ1017) ValueSet。"
* insert AllOf(Jj1017LateralityCS)

CodeSystem: LabItemAbbreviationCS
Id: lab-item-abbreviation
Title: "検査項目略称"
Description: "項目マスタの略称を coding に添えるための system。検体検査・放射線・内視鏡・生理検査・処置・手術のオーダー明細 code.coding では code = 略称文字列そのもの(例: WBC, CRP, CT)。検体検査結果 Observation.code.coding では code = 結果項目コード(無ければ JLAC11、それも無ければ項目名)で、略称は display に入る。コードの集合は院内マスタで決まる。"
* insert MasterCS

CodeSystem: OrderSetCS
Id: order-set
Title: "オーダーセット"
Description: "code = backend の order_sets.code。オーダーセットから出したオーダーのヘッダに付く order-set 拡張の valueCoding.system。"
* insert MasterCS

CodeSystem: PathwayCS
Id: pathway
Title: "クリニカルパス"
Description: "code = パスコード。パス適用から出したオーダーのヘッダに付く pathway-order 拡張の valueCoding.system。"
* insert MasterCS

CodeSystem: FollowUpResolutionCS
Id: followup-resolution
Title: "フォロー推奨への対応"
Description: "フォロー推奨 Task を対応済みにするときの対応の区分(Task.output「対応」)。"
* insert EnumCS
* #ordered "オーダー済"
* #referred "他院へ依頼"
* #declined "患者が希望せず"
* #not-needed "不要と判断"

ValueSet: FollowUpResolutionVS
Id: followup-resolution-vs
Title: "フォロー推奨への対応 ValueSet"
Description: "フォロー推奨への対応 ValueSet。"
* insert AllOf(FollowUpResolutionCS)

CodeSystem: ProvenanceActivityCS
Id: provenance-activity
Title: "来歴の活動(独自)"
Description: "v3-DataOperation に無い来歴の活動。override = オーダーの警告を理由を添えて確認し、そのまま登録した。"
* insert EnumCS
* #override "警告の確認"

ValueSet: ProvenanceActivityVS
Id: provenance-activity-vs
Title: "来歴の活動(独自) ValueSet"
Description: "来歴の活動(独自) ValueSet。"
* insert AllOf(ProvenanceActivityCS)

CodeSystem: AdvisoryOverrideReasonCS
Id: advisory-override-reason
Title: "警告を確認した理由"
Description: "オーダーの警告を確認して登録したときの理由。backend のマスタ(advisory_override_reasons、管理画面「警告の集計と設定」で編集)で、seed は already-addressed 対応済み / not-applicable 該当しない / clinical-judgement 臨床判断で不要 / patient-informed 患者に説明済み / monitored モニタリングしながら使用 / same-as-before 前回も同じ処方で問題なし / benefit-outweighs-risk 有益性が危険性を上回る / other その他。"
* insert MasterCS
