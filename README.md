# terraform template

## 事前準備

### 作業ディレクトリの初期化

- terraformのリソースを定義したファイル(.tf)が存在することが前提
- .tfにプロバイダーを定義した状態で初期化することも可能(プロバイダーに関連する情報を取得する)
- 利用するプロバイダーが増えるたびにinitの実行が必要

```sh
terraform init
```

### tflintのplugin取得

- AWSやAzureなどのプロバイダーに合わせてpluginを取得する
- `.tflint.hcl`を基に取得

```sh
tflint --init
```

## 各種コマンド

### 変更内容の確認

```sh
terraform plan

# 差分ファイルの作成(apply時に実行する処理内容を記録し、applyコマンドに渡せる)
terraform plan -out plan-result

# destroy実行時の差分確認
terraform plan -destroy
```

### 環境への適用

```sh
terraform apply

# 自動承認
terraform apply -auto-approve

# 並列化
terraform apply -parallelism=<int>

# planで作成した差分ファイルをinputに反映(plan結果を確実に反映でき、暗黙的に自動承認される)
terraform apply plan-result
```

### 環境の破壊

`terraform apply -destroy`のエイリアスなので、applyのオプションは一通り使用可能。

```sh
terraform destroy
```

### インポート

構築済みのリソースをTerraform管理配下にインポートする。

```sh
terraform import <state_address> <resource_id>
```

### ステート管理

```sh
# リソースの一覧表示
terraform state list

# 個々のリソースの詳細を確認
terraform state show <state_address>

# リソースのアドレスを変更
terraform state mv <source> <destination>

# 特定のリソースを削除
terraform state rm <state_address>
```

### フォーマット・検証

```sh
# フォーマット
terraform fmt

# 構文チェック
terraform validate

# 定義チェック
tflint
```

### ワークスペース

```sh
# 新規作成
terraform workspace new <workspace_name>

# 現在のワークスペースの表示
terraform workspace show

# ワークスペースのリスト
terraform workspace list

# ワークスペースの切り替え
terraform workspace select <workspace_name>

# ワークスペースの削除
terraform workspace delete <workspace_name>
```

## 文法

### resource

```tf
resource "<resource_type>" "<resource_name>" {
  <attribute_name> = <value>

  <block_name> {
    <block_attribute_name> = <value>
  }
}
```

### depends_on

リソース間の依存関係を明示的に記述するためのメタ引数。

```tf
depends_on = [
  <resource_type>.<resource_name>
]
```

### lifecycle

Terraformがリソースを作成、削除、変更する際の挙動に影響を与える。

```tf
lifecycle {
  # リソースの削除を禁止(=削除保護)
  prevent_destroy = true

  # リソースを削除する前に新しいリソースを作成
  create_before_destroy = true

  # 変更を無視する属性を指定
  ignore_changes = [
    <attribute_name>
  ]

  # リソースの再作成をトリガーするリソースのパスを指定
  replace_triggered_by = [
    <resource_path>
  ]
}
```

### provider

クラウドプロバイダー等のAPIを介してリソースを操作するプラグインを定義する。

```tf
provider "aws" {
  profile = "sampleprofile"
  alias   = "ap_northeast_1"
  region  = "ap-northeast-1"
}
```

### data

Terraform外または別のTerraformステートで定義された情報を参照する。

```tf
data "<data_type>" "<data_name>" {
  <attribute_name> = <value>
}
```
