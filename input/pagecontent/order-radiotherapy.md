### 構造

放射線治療は mCODE Radiotherapy を模した設計で、コース処方を 1 件の ServiceRequest に、標的体積とフェーズを複合拡張で持ちます。

```
ServiceRequest(コース処方、FC_RadiotherapyOrder)
 │  extension: radiotherapy-course(1) / radiotherapy-volume(0..*) / radiotherapy-phase(0..*) / radiotherapy-consult-request
 ├ Task(radiotherapy、FC_RadiotherapyTask)  focus → 処方   ※ ServiceRequest.status と同じ transaction で変える
 ├ Procedure(照射、FC_RadiotherapyFractionProcedure)  basedOn → 処方   ※ 回ごと
 ├ Procedure(コース要約、FC_RadiotherapyCourseSummaryProcedure)  basedOn → 処方
 ├ QuestionnaireResponse(週次診察)  basedOn → 処方
 ├ Observation(有害事象、FC_AdverseEventObservation)  basedOn → 処方
 └ Task(radiotherapy-review-due 通知)  focus → 処方
```

### 処方

- `code` = `radiotherapy-order#course-prescription`。`occurrenceDateTime` = 治療開始予定日。`performer[0]` = 放射線治療医(任意)。`bodySite` = 標的部位(jj1017p + 左右、または text)。
- `status` は Task と連動: active(処方済〜治療中)/ on-hold(休止)/ completed(終了)/ revoked(中止)。
- 放射線治療科への他科依頼から作ったときは `radiotherapy-consult-request` で依頼を指します(`basedOn` は使わない)。

#### radiotherapy-course

courseNumber、intent(根治 / 術前 / 術後 / 緩和 / 予防)、concurrentTherapy(併用療法)、protocol(マスタ)。終了時に endedOn / terminationReason / terminationNote、休止時に suspendedOn / suspensionReason / suspensionNote が加わります。

#### radiotherapy-volume

volumeId、label、type(GTV / CTV / ITV / PTV / other)、bodySite、description。volumeId はフェーズの線量から参照されます。

#### radiotherapy-phase

phaseId、number、label、status(active / revoked)、modalityAndTechnique(modality + technique、いずれもマスタ)、fractionsPrescribed、device(マスタ)、fractionsPerWeek、dosePrescribedToVolume(volume / fractionDose / totalDose、Gy)。

### 照射記録・コース要約

[実施記録](procedures.html) を参照。照射済みの記録の取消は削除ではなく `entered-in-error` にします(照射予定の取消は削除)。照射と治療終了サマリーの登録は Task を変えません。`radiotherapy-fraction` の fractionNumber はフェーズ内の回数です。

### 例

- [処方](ServiceRequest-example-radiotherapy-order.html)
- [Task](Task-example-radiotherapy-task.html)
- [照射](Procedure-example-radiotherapy-fraction-procedure.html) / [コース要約](Procedure-example-radiotherapy-course-summary-procedure.html)
- [診察の通知](Task-example-radiotherapy-review-due-task.html)
