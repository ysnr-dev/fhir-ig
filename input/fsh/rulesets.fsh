// 全アーティファクト共通のメタデータ。
RuleSet: FCMeta
* ^status = #draft
* ^experimental = false
* ^publisher = "ysnr-dev"

// コードをすべて収載する CodeSystem(アプリのコードに選択肢が列挙されているもの)。
RuleSet: EnumCS
* insert FCMeta
* ^caseSensitive = true
* ^content = #complete

// 院内マスタ由来で、コードを IG に収載しない CodeSystem。
RuleSet: MasterCS
* insert FCMeta
* ^caseSensitive = true
* ^content = #not-present

// CodeSystem と対の ValueSet(complete な CodeSystem の全コード)。
// 使い方: * insert AllOf(OrderTypeCS)
RuleSet: AllOf(cs)
* insert FCMeta
* ^description = "CodeSystem {cs} のすべてのコード。"
* include codes from system {cs}

// 所見レポートのフォロー推奨(推奨と期限の複合拡張)。
RuleSet: FollowUpExtension
* insert FCMeta
* extension contains
    recommendation 1..1 and
    due 1..1
* extension[recommendation].value[x] only string
* extension[recommendation] ^short = "推奨の内容"
* extension[due].value[x] only date
* extension[due] ^short = "期限"
