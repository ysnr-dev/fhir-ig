### オーダーセットの印

オーダーセット(backend の `order_sets` / `order_set_entries`)を適用して出したオーダーのヘッダ ServiceRequest には、次の印が付きます。

| 要素 | 内容 |
|---|---|
| `identifier`(system = `Identifier/order-set-instance`) | 適用 1 回ぶんの uuid |
| `extension[order-set]` | valueCoding: system = `CodeSystem/order-set`、code = セットのコード、display = セット名 |
| `requisition` | 同じ identifier(空のときだけ) |

セットに含まれる病名(Condition)は適用時に患者に登録され、再適用では重複を除外します。

### パス適用の印

クリニカルパスの適用から出したオーダーのヘッダには、同型の印が付きます。

| 要素 | 内容 |
|---|---|
| `identifier`(system = `Identifier/pathway-instance`) | 適用 uuid |
| `extension[pathway-order]` | valueCoding: system = `CodeSystem/pathway`、code = パスコード |

パスの CarePlan 木は [クリニカルパス](pathway.html) を参照。パスのタスク(Procedure)の `basedOn` が、出したオーダーのヘッダを指します。

### レジメンの印

レジメン適用から出した日オーダー(注射 / 処方)は `requisition`(system = `Identifier/regimen-instance`)と `regimen-order` 拡張を持ちます。[薬剤](medication.html) を参照。
