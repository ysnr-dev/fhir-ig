// 手術(オーダー・実施)の CodeSystem。

CodeSystem: SurgeryOrderItemCS
Id: surgery-order-item
Title: "術式(院内マスタ)"
Description: "院内マスタ master_surgery_items。明細 ServiceRequest.code。"
* insert MasterCS

CodeSystem: SurgeryProcedureCodeCS
Id: surgery-procedure-code
Title: "手術 手技コード(レセプト K / L 章)"
Description: "レセプト電算の手術・麻酔手技コード(9 桁)。オーダー明細では術式コード(surgery-order-item)と並べて display 無しで入れ、実施記録 Procedure.code では単独で display(手技名)を付けて入れる。"
* insert MasterCS

CodeSystem: SurgeryPositionCS
Id: surgery-position
Title: "体位"
Description: "体位のコード。"
* insert EnumCS
* #supine "仰臥位"
* #lithotomy "砕石位"
* #lateral "側臥位"
* #prone "腹臥位"
* #jackknife "ジャックナイフ位"
* #sitting "座位"

ValueSet: SurgeryPositionVS
Id: surgery-position-vs
Title: "体位 ValueSet"
Description: "体位 ValueSet。"
* insert AllOf(SurgeryPositionCS)

CodeSystem: SurgeryStaffRoleCS
Id: surgery-staff-role
Title: "手術スタッフの役割"
Description: "オーダーの surgery-staff 拡張の role、実施記録 Procedure.performer.function、麻酔チャートの performer.function。"
* insert EnumCS
* #surgeon "執刀医"
* #assistant "助手"
* #anesthetist "麻酔科医"
* #scrub-nurse "器械出し"
* #circulating-nurse "外回り"
* #ce "臨床工学技士"

ValueSet: SurgeryStaffRoleVS
Id: surgery-staff-role-vs
Title: "手術スタッフの役割 ValueSet"
Description: "手術スタッフの役割 ValueSet。"
* insert AllOf(SurgeryStaffRoleCS)

CodeSystem: SurgeryAnesthesiaMethodCS
Id: surgery-anesthesia-method
Title: "麻酔方法"
Description: "麻酔方法のコード。"
* insert EnumCS
* #general-inhalation "全身麻酔(吸入)"
* #general-tiva "全身麻酔(TIVA)"
* #spinal "脊椎くも膜下麻酔"
* #epidural "硬膜外麻酔"
* #nerve-block "伝達麻酔"
* #local "局所浸潤麻酔"
* #iv-sedation "静脈鎮静"
* #topical "表面麻酔"

ValueSet: SurgeryAnesthesiaMethodVS
Id: surgery-anesthesia-method-vs
Title: "麻酔方法 ValueSet"
Description: "麻酔方法 ValueSet。"
* insert AllOf(SurgeryAnesthesiaMethodCS)

CodeSystem: SurgeryAnesthesiaManagementCS
Id: surgery-anesthesia-management
Title: "麻酔管理"
Description: "麻酔管理のコード。"
* insert EnumCS
* #anesthesiologist "麻酔科管理"
* #surgeon "執刀医管理"

ValueSet: SurgeryAnesthesiaManagementVS
Id: surgery-anesthesia-management-vs
Title: "麻酔管理 ValueSet"
Description: "麻酔管理 ValueSet。"
* insert AllOf(SurgeryAnesthesiaManagementCS)

CodeSystem: SurgeryBloodPreparationCS
Id: surgery-blood-preparation
Title: "輸血準備"
Description: "輸血準備のコード。"
* insert EnumCS
* #none "不要"
* #type-screen "T&S"
* #crossmatch "交差適合試験"
* #autologous "自己血"

ValueSet: SurgeryBloodPreparationVS
Id: surgery-blood-preparation-vs
Title: "輸血準備 ValueSet"
Description: "輸血準備 ValueSet。"
* insert AllOf(SurgeryBloodPreparationCS)

CodeSystem: SurgeryEquipmentCS
Id: surgery-equipment
Title: "使用機器"
Description: "other のときは自由記載を display に入れる。"
* insert EnumCS
* #microscope "手術用顕微鏡"
* #navigation "ナビゲーション"
* #c-arm "C-arm(術中透視)"
* #ultrasonic-scalpel "超音波凝固切開装置"
* #stapler "自動縫合器"
* #robot "手術支援ロボット"
* #neuro-monitoring "術中神経モニタリング"
* #intraop-us "術中エコー"
* #other "その他"

ValueSet: SurgeryEquipmentVS
Id: surgery-equipment-vs
Title: "使用機器 ValueSet"
Description: "使用機器 ValueSet。"
* insert AllOf(SurgeryEquipmentCS)

CodeSystem: SurgerySpecimenPlanCS
Id: surgery-specimen-plan
Title: "検体の予定"
Description: "検体の予定のコード。"
* insert EnumCS
* #frozen-section "術中迅速病理"
* #permanent "永久標本"
* #culture "細菌培養"

ValueSet: SurgerySpecimenPlanVS
Id: surgery-specimen-plan-vs
Title: "検体の予定 ValueSet"
Description: "検体の予定 ValueSet。"
* insert AllOf(SurgerySpecimenPlanCS)

CodeSystem: SurgeryConsentCS
Id: surgery-consent
Title: "同意書"
Description: "同意書のコード。"
* insert EnumCS
* #surgery "手術同意書"
* #anesthesia "麻酔同意書"
* #transfusion "輸血同意書"

ValueSet: SurgeryConsentVS
Id: surgery-consent-vs
Title: "同意書 ValueSet"
Description: "同意書 ValueSet。"
* insert AllOf(SurgeryConsentCS)

CodeSystem: SurgeryApproachCS
Id: surgery-approach
Title: "アプローチ"
Description: "アプローチのコード。"
* insert EnumCS
* #open "開腹・開胸(直視下)"
* #laparoscopic "腹腔鏡"
* #thoracoscopic "胸腔鏡"
* #robotic "ロボット支援"
* #endoscopic-open "鏡視下(開腹移行ありうる)"
* #percutaneous "経皮・経管"
* #other "その他"

ValueSet: SurgeryApproachVS
Id: surgery-approach-vs
Title: "アプローチ ValueSet"
Description: "アプローチ ValueSet。"
* insert AllOf(SurgeryApproachCS)

CodeSystem: SurgeryWoundClassCS
Id: surgery-wound-class
Title: "創分類"
Description: "創分類のコード。"
* insert EnumCS
* #clean "清潔"
* #clean-contaminated "準清潔"
* #contaminated "汚染"
* #dirty "感染・不潔"

ValueSet: SurgeryWoundClassVS
Id: surgery-wound-class-vs
Title: "創分類 ValueSet"
Description: "創分類 ValueSet。"
* insert AllOf(SurgeryWoundClassCS)

CodeSystem: SurgeryCountCheckCS
Id: surgery-count-check
Title: "カウント確認"
Description: "カウント確認のコード。"
* insert EnumCS
* #verified "合致"
* #discrepancy "不一致"

ValueSet: SurgeryCountCheckVS
Id: surgery-count-check-vs
Title: "カウント確認 ValueSet"
Description: "カウント確認 ValueSet。"
* insert AllOf(SurgeryCountCheckCS)

CodeSystem: SurgeryOutcomeCS
Id: surgery-outcome
Title: "手術の転帰"
Description: "実施記録 Procedure.outcome。"
* insert EnumCS
* #good "良好"
* #complicated "合併症あり"
* #death "死亡"

ValueSet: SurgeryOutcomeVS
Id: surgery-outcome-vs
Title: "手術の転帰 ValueSet"
Description: "手術の転帰 ValueSet。"
* insert AllOf(SurgeryOutcomeCS)

CodeSystem: SurgeryObservationCS
Id: surgery-observation
Title: "手術中の測定項目"
Description: "手術実施記録にぶら下がる Observation.code。値は mL(UCUM)。"
* insert EnumCS
* #blood-loss "出血量"
* #urine-output "尿量"
* #transfusion-volume "輸血量"

ValueSet: SurgeryObservationVS
Id: surgery-observation-vs
Title: "手術中の測定項目 ValueSet"
Description: "手術中の測定項目 ValueSet。"
* insert AllOf(SurgeryObservationCS)

CodeSystem: AnesthesiaEventCS
Id: anesthesia-event
Title: "麻酔チャートのイベント"
Description: "麻酔チャートのイベント Observation.code。"
* insert EnumCS
* #anesthesia-start "麻酔開始"
* #intubation "挿管"
* #incision-start "執刀開始"
* #incision-end "執刀終了"
* #extubation "抜管"
* #anesthesia-end "麻酔終了"
* #other "その他"

ValueSet: AnesthesiaEventVS
Id: anesthesia-event-vs
Title: "麻酔チャートのイベント ValueSet"
Description: "麻酔チャートのイベント ValueSet。"
* insert AllOf(AnesthesiaEventCS)
