// 診療記録・退院時サマリー(Composition)、Questionnaire / QuestionnaireResponse、ファイル、画像。

Profile: FC_ClinicalNote
Parent: Composition
Id: fc-clinical-note
Title: "診療記録"
Description: """診療記録(SOAP 等)。

- type = LOINC 11506-3 Progress note。他科依頼への回答は 11488-4 Consult note で、event.code = consult-note-event#reply、event.detail = 依頼の ServiceRequest。
- status: preliminary / final / amended(final の記録を編集すると必ず amended)。final 以降は attester(mode legal、time、party)。
- author 1..*(上流サーバーが必須にする)。title は診療記録タイトルマスタの文字列(既定「診療記録」)。order-department。
- section: 任意の問題セクション(LOINC 11450-4、entry = Condition)と本文セクション(61150-9 S / 61149-1 O / 51848-0 A / 18776-5 P / 51847-2 A/P / 77599-9 自由記載)。本文は text.status = additional の XHTML で、画像は data URI で埋め込む。
- テンプレートで書いたセクションは clinical-note-section-questionnaire-response が QuestionnaireResponse を指す(QR・Binary・抽出 Observation は同じ transaction)。"""
* insert FCMeta
* subject 1..1
* subject only Reference(FC_Patient)
* type.coding 1..1
* type.coding.system = $loinc
* author 1..*
* author only Reference(FC_Practitioner)
* attester.party only Reference(FC_Practitioner)
* event.code.coding.system = "http://fhir-client.local/CodeSystem/consult-note-event"
* event.detail only Reference(FC_ConsultOrder)
* section.code.coding.system = $loinc
* section.entry only Reference(FC_Condition)
* section.extension contains ClinicalNoteSectionQuestionnaireResponse named questionnaireResponse 0..1
* extension contains OrderDepartment named orderDepartment 0..1

Profile: FC_DischargeSummary
Parent: Composition
Id: fc-discharge-summary
Title: "退院時サマリー"
Description: """退院時サマリー。入院(Encounter)ごとに 1 件。

- type = LOINC 18842-5。encounter = 入院 Encounter(必須)。title = 退院時サマリー。status / attester / author は診療記録と同じ。
- section は固定: 11535-2 退院時診断(entry = Condition)/ 8648-8 入院経過 / 47519-4 手術・処置(entry = ヘッダ ServiceRequest)/ 30954-2 検査 / 10183-2 退院時処方(entry = MedicationRequest)/ 10184-0 退院時状態 / 18776-5 方針 / 48765-2 アレルギー(entry = AllergyIntolerance)。entry を持つセクションは text.status = generated で、空なら「なし」。
- 退院先は Encounter.hospitalization.dischargeDisposition に同じ transaction で PUT する。確定で document-due 督促 Task が completed になる。"""
* insert FCMeta
* subject 1..1
* subject only Reference(FC_Patient)
* type = $loinc#18842-5
* encounter 1..1 MS
* encounter only Reference(FC_InpatientEncounter)
* author 1..*
* author only Reference(FC_Practitioner)
* attester.party only Reference(FC_Practitioner)
* section ^slicing.discriminator[0].type = #pattern
* section ^slicing.discriminator[0].path = "code"
* section ^slicing.rules = #open
* section contains
    diagnosis 0..1 and
    course 0..1 and
    procedures 0..1 and
    tests 0..1 and
    medications 0..1 and
    conditionAtDischarge 0..1 and
    plan 0..1 and
    allergies 0..1
* section[diagnosis].code = $loinc#11535-2
* section[diagnosis].entry only Reference(FC_Condition)
* section[course].code = $loinc#8648-8
* section[procedures].code = $loinc#47519-4
* section[procedures].entry only Reference(ServiceRequest)
* section[tests].code = $loinc#30954-2
* section[medications].code = $loinc#10183-2
* section[medications].entry only Reference(FC_PrescriptionMedicationRequest)
* section[conditionAtDischarge].code = $loinc#10184-0
* section[plan].code = $loinc#18776-5
* section[allergies].code = $loinc#48765-2
* section[allergies].entry only Reference(FC_AllergyIntolerance)

Profile: FC_Questionnaire
Parent: Questionnaire
Id: fc-questionnaire
Title: "テンプレート(Questionnaire)"
Description: """診療記録・オーダー・報告書などで使うテンプレート。アプリは meta.profile に JASPEHR の jaspehr-questionnaire を付け、上流サーバーは JASPEHR の不変条件で検証する。JASPEHR パッケージは公開レジストリに無く、IG Publisher でのスナップショット生成にも問題があるため、本 IG では base から派生し JASPEHR への準拠は本文で述べる。

- url / version / name / title / status / subjectType = Patient。url は `http://fhir-client.local/Questionnaire/{id}` など。
- 標準拡張: questionnaire-itemControl、choiceOrientation、hidden、maxOccurs、minValue、maxValue、maxDecimalPlaces、questionnaire-unit(UCUM)、regex、designNote、variable、questionnaire-itemMedia(Binary)。SDC: initialExpression、calculatedExpression、observationExtract、observationExtract-category。
- 本 IG の拡張: questionnaire-template-category(分類)、item に questionnaire-organization-field / questionnaire-practitioner-field / questionnaire-practitioner-role-default / questionnaire-login-autofill。
- item.code = observation-item や JP_ObservationSocialHistoryCode_CS(抽出 Observation の code になる)。
- 上流サーバーは JASPEHR の不変条件(choice には itemControl、repeats には maxOccurs など)を検証する。"""
* insert FCMeta
* url 1..1
* version 1..1
* title 1..1
* extension contains QuestionnaireTemplateCategory named templateCategory 0..1 MS
* item.extension contains
    QuestionnaireOrganizationField named organizationField 0..1 and
    QuestionnairePractitionerField named practitionerField 0..1 and
    QuestionnairePractitionerRoleDefault named practitionerRoleDefault 0..1 and
    QuestionnaireLoginAutofill named loginAutofill 0..1

Profile: FC_QuestionnaireResponse
Parent: QuestionnaireResponse
Id: fc-questionnaire-response
Title: "テンプレートの記入(QuestionnaireResponse)"
Description: """テンプレートの記入。アプリは meta.profile に JASPEHR の jaspehr-questionnaireresponse を付ける(本 IG では base から派生)。

- questionnaire = テンプレートの canonical(url|version)。status: in-progress / completed / amended。authored。
- contained Practitioner(id = practitioner)を author で参照する。
- identifier.value = \"{施設番号}^{患者ID}^{uuid}\"(system 無し。既知の非準拠)。
- basedOn = 関連するオーダー(放射線治療の週次診察など)。
- questionnaire-response-problem = 対象プロブレム。item の questionnaire-response-annotated-image = シェーマに書き込んだ画像(Binary)。
- 診療記録のセクション、オーダーの検査目的・特別指示・臨床情報・術前指示・依頼目的、読影レポート、栄養指導記録、パスの評価から参照される。"""
* insert FCMeta
* subject only Reference(FC_Patient)
* questionnaire 1..1
* identifier.value 1..1
* extension contains QuestionnaireResponseProblem named problem 0..1
* item.extension contains QuestionnaireResponseAnnotatedImage named annotatedImage 0..1

Profile: FC_PatientFile
Parent: DocumentReference
Id: fc-patient-file
Title: "患者ファイル"
Description: "患者に取り込んだファイル(画像・PDF など)。Binary(contentType + data、7 MB まで)と同じ transaction で 1 件ずつ作る。status = current。date = 診察日(00:00、オフセット付き)。content[0].attachment = {contentType, url = Binary/{id}, title, size}。category = ファイル分類(file-category、code = UUID、display / text = 分類名)。author = 職員。"
* insert FCMeta
* status = #current
* subject 1..1
* subject only Reference(FC_Patient)
* date 1..1
* content 1..1
* content.attachment.url 1..1
* content.attachment.contentType 1..1
* category 1..1 MS
* category.coding.system = "http://fhir-client.local/CodeSystem/file-category"
* author only Reference(FC_Practitioner)

Profile: FC_ImagingStudy
Parent: $JP_ImagingStudy_Radiology
Id: fc-imaging-study
Title: "DICOM スタディ(取込)"
Description: "DICOM ファイルの取込で backend が作る ImagingStudy(identifier で条件付き PUT)。identifier = urn:dicom:uid(urn:oid:{StudyInstanceUID})と ACSN(アクセッション番号)。status = available、started(+09:00)。modality / series.modality = DCM(無ければ OT)。series(uid / number / description / numberOfInstances / bodySite.display)、instance(uid / sopClass(urn:ietf:rfc:3986)/ number)。imaging-source = 元施設と元患者。DICOM の実体は backend が保持し FHIR には持たない。"
* insert FCMeta
* subject only Reference(FC_Patient)
* identifier 1..*
* status = #available
* extension contains ImagingSource named source 0..1
