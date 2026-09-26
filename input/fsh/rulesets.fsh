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
* include codes from system {cs}
