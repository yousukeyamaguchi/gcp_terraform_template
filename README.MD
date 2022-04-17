# terraform for google cloud run
cloud runに立てたコンテナと連携して、cloud schedulerで1日1回の定期実行、cloud tasksで非同期実行することを想定したアーキテクチャをterraformで設計しました。

# はじめに
プロジェクトの作成と、tfstateファイルを保存するためのバケットを作成するのは手作業です。
## GCPコンソールでの操作
プロジェクトを作成します。プロジェクト名は`params.tf`の`customer`に代入してください。
### APIの有効化
以下のAPIを有効にしてください。
- Cloud Run APIを有効にする
- Cloud Scheduler APIを有効にする
- Cloud Tasks APIを有効にする
- Cloud Build APIを有効にする
### tfstateファイルの保存バケットを作成
Cloud Storageでtfstateファイルを保管するためのバケットを作成してください。バケット名は`<customer>-<surfix>-tfstate`にしてください。もしものために備えてバージョニングは有効にしておきましょう。

# terraformでリソースを作成
```
$ cd gcp_terraform_template
$ terraform init -backend-config="bucket=<customer>-<surfix>-tfstate"  # tfstateファイルがgcsバケットに保存される。
$ terraform apply
```
# CDの設定
cloud runのコンソールで「継続的デプロイを設定」で利用したいimageのCDを設定しましょう。自動的にcloud buildも設定されます。terraformへの反映は試行錯誤しながら・・・

# 課題
- providerでサービスアカウントを指定していない
- .git_ignore
- プロジェクトやバケットの作成もコマンドで実行すべき
- cloud runとcloud buildの連携が未実装。
