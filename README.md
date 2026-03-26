# terraform template

## 事前準備
```
# 作業ディレクトリの初期化
# terraformのリソースを定義したファイル(.tf)が存在することが前提
# .tfにプロバイダーを定義した状態で初期化することも可能(プロバイダーに関連する情報を取得する)
# 利用するプロバイダーが増えるたびにinitの実行が必要
terraform init

# tflintのplugin取得
# AWSやAzureなどのプロバイダーに合わせてpluginを取得する
# .tflint.hclを基に取得
tflint --init
```

## 各種コマンド
```
# 変更内容の確認
terraform plan
terraform plan -out plan-result #差分ファイルの作成
                                #apply時に実行する処理内容を記録
                                #applyコマンドに渡せる)
terraform plan -destory #destory実行時の差分確認

# 環境への適用
terraform apply
terraform apply -auto-approve #自動承認
terraform apply -parrallelism=<int> #並列化
terraform apply plan-result #planで作成した差分ファイルをinputに反映。plan結果を確実に反映することができる)
                            #暗黙的に自動承認される

# 環境の破壊
terraform destroy #terraform apply -destroyのエイリアスなのでapplyのオプションは一通り使用可能

# 構築済みのリソースをTerraform管理配下にインポート
terraform import <state_address> <resource_id>

# ステートに含まれるリソースの一覧表示
terraform state list

# ステートに含まれる個々のリソースの詳細を確認
terraform state show <state_address>

# ステートで管理されているリソースのアドレスを変更
terraform state mv

# ステートに含まれる特定のリソースを削除
terraform state rm

# フォーマット
terraform fmt

# 構文チェック
terraform validate

# 定義チェック
tflint

# terraform ワークスペースの新規作成
terraform workspace new <workspace_name>

# 現在のterraform ワークスペースの表示
terraform workspace show

# terraform ワークスペースのリスト
terraform workspace list

# terraform ワークスペースの切り替え
terraform workspace select <workspace_name>

# terraform ワークスペースの削除
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
- リソース間の依存関係を明示的に記述するためのメタ引数
```
depends_on [
  <resource_type>.<resource_name>
]
```

### lifecycle
- Terraformがリソースを作成、削除、変更する際の挙動に影響を与える
```tf
lifecycle {
  prevent_destroy = true #リソースの削除を禁止(=削除保護)
  create_before_destroy = true #リソースを削除する前に新しいリソースを作成
  ignore_changes = [
    <attribute_name> #変更を無視する内容を記述
  ]
  replace_triggered_by = [
    <resource_path> #リソースの再作成をトリガーするリソースのパスを指定
  ]
}
```

### provider
- クラウドプロバイダー等のAPIを介してリソースを操作するプラグインを定義する
```tf
provider "aws" {
  profile = "sampleprofile"
  alias = "ap_northeast_1"
  region = "ap-northeast-1"
}
```

### data
- Terraform外または別のTerraformステートで定義された情報を参照する
```
data "<data_type>" "<data_name>" {
  <attribute_name> = <value>
}
```
