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
terraform workspace select

# terraform ワークスペースの削除
terraform workspace delete <workspace_name>
```
