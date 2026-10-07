### Task の 2 つの使い方

Task は同じ CodeSystem(`task-code`)を使う 2 つの系統があります。

| 系統 | 共通プロファイル | intent | focus | owner |
|---|---|---|---|---|
| 部門進捗 Task | [FC_DepartmentTask](StructureDefinition-fc-department-task.html) | filler-order | ヘッダ ServiceRequest | 無し(看護指示は看護師、服薬指導は担当薬剤師) |
| 通知 Task | [FC_NotificationTask](StructureDefinition-fc-notification-task.html) | filler-order | 通知の対象(Provenance / Encounter / DiagnosticReport / Observation / ServiceRequest) | 宛先の職員 |

持参薬鑑別([FC_BroughtMedReviewTask](StructureDefinition-fc-brought-med-review-task.html))は intent = order の作業 Task で、どちらにも属しません。

### 部門進捗 Task

| code | 種別 | 状態(code: 表示) |
|---|---|---|
| lab-exam | 検体検査 | requested 依頼済 / accepted 受付済 / completed 実施済 / cancelled 中止 |
| rad-exam | 放射線検査 | 同上 |
| endoscopy-exam | 内視鏡 | 同上 |
| physio-exam | 生理検査 | 同上 |
| patho-exam | 病理検査 | requested 依頼済 / accepted 受付済 / completed 検査済 / cancelled 中止 |
| treatment | 処置 | requested / accepted / completed / cancelled |
| surgery | 手術 | requested 申込済 / accepted 受付済 / in-progress 入室中 / completed 実施済 / cancelled 中止 |
| transfusion | 輸血 | requested 依頼済 / accepted 受付済 / in-progress 出庫済 / completed 実施済 / cancelled 中止 |
| radiotherapy | 放射線治療 | requested 処方済 / accepted 計画中 / in-progress 治療中 / on-hold 休止 / completed 終了 / cancelled 中止 |
| rehab | リハビリ | requested 依頼済 / accepted 実施中 / completed 終了 / cancelled 中止 |
| nutrition-guidance | 栄養指導 | 同上 |
| medication-guidance | 服薬指導 | 同上(owner = 担当薬剤師) |
| consult | 他科依頼 | requested 依頼済 / accepted 対応中 / completed 回答済 / cancelled 取消 |
| nursing | 看護指示 | requested 指示受け待ち / accepted 指示受け済 / cancelled 中止 |
| rx-dispense | 調剤 | requested 依頼済 / accepted 受付済 / in-progress 調剤済 / completed 実施済 / cancelled 中止 |
| injection | 注射 | requested 依頼済 / accepted 受付済 / in-progress 払出済 / completed 実施済 / cancelled 中止 |

- Task が無い = requested。最初の状態変更で作られます(看護指示は登録時に requested で作る。放射線検査の即時実施・処置の即実施は completed、日程未定のまま入室した手術は in-progress で、最初からその状態で作る)。
- `executionPeriod`: accepted / in-progress / on-hold で start(最初に受け付けた時刻を保つ)、completed で end が加わります。requested / cancelled では持ちません。
- リハビリ・栄養指導・服薬指導・看護行為・与薬・放射線治療の実施記録は Task を変えません(期間中は accepted / in-progress のまま)。
- レジメンの日オーダーを中止したとき、調剤・注射の Task は cancelled になり `statusReason.text` に中止理由を持ちます。
- `priority` / `requester` はオーダーから複製。`authoredOn` / `lastModified`。
- 上流サーバーの Task は inv-1(lastModified ≥ authoredOn)を検証します。

### 通知 Task

通知の種別はアプリのレジストリ(`notificationRegistry.tsx`)に 1 要素ずつ登録され、種別を足すのはレジストリへの追加です。

| code | 種別 | 重要度(priority) | focus | input(type.text) | プロファイル |
|---|---|---|---|---|---|
| order-approval | オーダー承認 | info(routine) | Provenance | 活動 / 種別(prescription / injection / lab-order / rad-order / chemo-regimen などカルテのカード種別)/ 対象オーダー / 開始日 / 依頼 / セット / 研修医 | [FC_OrderApprovalTask](StructureDefinition-fc-order-approval-task.html) |
| brought-med-identified | 持参薬鑑別済 | info | Encounter | 入院 / 入院日 / 剤数 / 判断待ち | [FC_BroughtMedIdentifiedTask](StructureDefinition-fc-brought-med-identified-task.html) |
| document-due | 文書作成 | info、期限あり | Encounter | 文書 / 文書名 / 入院 / 退院日 / 期限 | [FC_DocumentDueTask](StructureDefinition-fc-document-due-task.html) |
| lab-panic | 緊急異常値 | alert(stat) | DiagnosticReport | 検体採取日 + 項目ごとの値 | [FC_LabPanicTask](StructureDefinition-fc-lab-panic-task.html) |
| result-review | 検査結果確認 | info | DiagnosticReport | 種別 / 対象日 / 内容 | [FC_ResultReviewTask](StructureDefinition-fc-result-review-task.html) |
| rad-critical-finding | 重要所見 | alert(stat) | DiagnosticReport | 撮影日 / 撮影内容 / 要点 | [FC_RadCriticalFindingTask](StructureDefinition-fc-rad-critical-finding-task.html) |
| physio-critical-finding | 重要所見(生理検査) | alert(stat) | DiagnosticReport | 検査日 / 検査内容 / 要点 | [FC_PhysioCriticalFindingTask](StructureDefinition-fc-physio-critical-finding-task.html) |
| endoscopy-critical-finding | 重要所見(内視鏡) | alert(stat) | DiagnosticReport | 検査日 / 検査内容 / 要点 | [FC_EndoscopyCriticalFindingTask](StructureDefinition-fc-endoscopy-critical-finding-task.html) |
| pathway-variance | パスのバリアンス | caution(urgent) | 評価 Observation | パス名 / 適用 / 病日 / 病日の表示 / 対象日 / アウトカム | [FC_PathwayVarianceTask](StructureDefinition-fc-pathway-variance-task.html) |
| radiotherapy-review-due | 放射線治療の診察 | info | ServiceRequest | 治療コース / 前回の診察 | [FC_RadiotherapyReviewDueTask](StructureDefinition-fc-radiotherapy-review-due-task.html) |
| nursing-summary-returned | 看護サマリー差戻し | info | 看護サマリー Composition | 看護サマリ / 理由 | [FC_NursingSummaryReturnedTask](StructureDefinition-fc-nursing-summary-returned-task.html) |
| note-countersign | カルテ承認 | info | 診療記録 Composition | 記録 / 研修医 | [FC_NoteCountersignTask](StructureDefinition-fc-note-countersign-task.html) |
| note-returned | カルテ差戻し | info | 診療記録 Composition | 記録 / 理由 | [FC_NoteReturnedTask](StructureDefinition-fc-note-returned-task.html) |

- `status`: requested 未対応 / completed 対応済 / cancelled 取消。`owner` = 宛先の職員、`requester` = 発生させた職員、`basedOn` = 関連するオーダー。`description` = 人が読める要約 1 行、`code.text` = 種別名、`authoredOn` / `lastModified` は常に持ちます。
- 宛先が決まらないときは `owner` を持ちません: オーダーに紐付かない結果の緊急異常値・検査結果確認、主治医のいない入院の持参薬鑑別済・文書作成の督促、主治医のいない入院や入院外のバリアンス。
- 日付の input は `valueDate` です(退院日 / 期限 / 対象日 / 検体採取日 / 撮影日 / 検査日 / 入院日 / 前回の診察)。
- 内容が変わると同じ Task を書き換えて未対応に戻します(前の対応記録の `note` / `executionPeriod` は消す)。
- 検査結果確認は、同じ報告の緊急異常値・重要所見が未対応の間は作りません([検査結果・報告](results.html))。パスのバリアンスは、重要アウトカム(CriticalIndicator = Y)を未達成にしたときだけ作り、未達成でなくなれば cancelled にします。
- `restriction.period.end` = 期限(日付のみ)。対応済みにすると `executionPeriod` と `note`(authorReference / time / text)が付きます。
- backend もオーダー承認 Task を backfill します(`notifications.rake`)。
- 研修医・学生(Practitioner に `trainee-level`)の活動は指導医のカウンターサインの対象です。オーダー承認・カルテ承認は、その研修医が属する指導医グループの指導医ごとに 1 件ずつ作り(1 通知 = 1 宛先。指導医が登録されていなければ作らない)、誰かが承認すると、その人の Task を completed、残りを cancelled にします。カルテ承認の `note` には指導医のコメント(`task-note-comment` = true)が積まれ、対応済みにしても残ります。指導医グループは backend のマスタで、FHIR リソースではありません。

### Provenance

- オーダーの来歴([FC_OrderProvenance](StructureDefinition-fc-order-provenance.html)): オーダーの登録・変更に 1 件(ログイン中のアカウントに紐付く医療従事者が無いとき、またはヘッダに requester が無いときは付かない)。`target` = ヘッダ ServiceRequest(同じ Bundle の MedicationRequest も。明細 ServiceRequest は含めない。パス適用では根の CarePlan、フェーズ単位の追加適用ではそのフェーズ最初の病日の CarePlan)。中止・完了・休止・再開の来歴は、別の transaction で `ServiceRequest/{id}` を target に作ることがあります。`activity` = v3-DataOperation(CREATE / UPDATE / CANCEL / REACTIVATE / COMPLETE / SUSPEND / RESUME)。`agent` = author(依頼医)と enterer(ログイン中の職員、onBehalfOf = 依頼医)。enterer ≠ author が代行入力で、承認依頼の通知が依頼医に届き(パス適用の来歴には通知を作らない)、承認で verifier の agent と signature(Verification Signature、data 無し)が加わります。研修医・学生が自分を依頼医として入れた活動は author.role = `trainee-level#resident` / `#student` を持ち、承認依頼は指導医に届きます。
- 結果確認の来歴([FC_ReviewProvenance](StructureDefinition-fc-review-provenance.html)): verifier と signature だけで activity は持ちません。
- 単一ヘッダの Bundle でも fullUrl が必須です。fullUrl が無いと来歴とパスの参照が付きません。

### 例

- [オーダーの来歴](Provenance-example-order-provenance.html) / [オーダーの来歴(研修医)](Provenance-example-trainee-order-provenance.html) / [結果確認の来歴](Provenance-example-review-provenance.html)
- [オーダー承認](Task-example-order-approval-task.html) / [持参薬鑑別済](Task-example-brought-med-identified-task.html) / [文書作成](Task-example-document-due-task.html) / [緊急異常値](Task-example-lab-panic-task.html) / [検査結果確認](Task-example-result-review-task.html) / [重要所見](Task-example-rad-critical-finding-task.html) / [重要所見(生理検査)](Task-example-physio-critical-finding-task.html) / [重要所見(内視鏡)](Task-example-endoscopy-critical-finding-task.html) / [バリアンス](Task-example-pathway-variance-task.html) / [放射線治療の診察](Task-example-radiotherapy-review-due-task.html) / [看護サマリー差戻し](Task-example-nursing-summary-returned-task.html) / [オーダー承認(研修医)](Task-example-trainee-order-approval-task.html) / [カルテ承認](Task-example-note-countersign-task.html) / [カルテ差戻し](Task-example-note-returned-task.html)
