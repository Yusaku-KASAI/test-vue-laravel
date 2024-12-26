# test-vue-laravel

## 環境構築

### development

- vite
- nginx
- php
- mysql

### prpduction

- nginx
- php
- mysql

## プロジェクト作成ログ

- コンテナ起動まで

```
create vue & create laravel
Makefile, docker-compose.yml, .dockerignore, .gitignore, README.md, infra/ でスタート

.dockerignoreのvue/node_modulesをコメントアウトする
make front-first
create vueするときに手動確認あり
プロジェクト名は.(カレントディレクトリ)を指定
パッケージ名はpackage.json
make front-fitstの後、.dockerignoreでvue/node_modulesをアンコメント
vite.config.jsでサーバーオプションのhost:trueを指定
vite.config.jsでサーバーポート変更
vite.config.jsでプロキシ変更

make api-first
create laravelするときに手動確認あるかも
プロジェクト名は.(カレントディレクトリ)を指定
.envと.env.exampleを修正(DB情報)
cors設定(vite側だけでもとりあえず大丈夫そう)

ちなみに、フロントとAPIで若干手順が違うのは、
フロント側のviteサーバーの起動にnode_modulesが必要なためである。

.dockerignoreのアンコメント再確認
make reset
```

- フロント構築

```
npm install vue-router@4
npm install pinia
main.jsへの紐付け
router.js定義とApp.vueへのRouterView反映
storeの定義(例)
ディレクトリ切り分け(components/pages/store/layouts?)
MypageでのAPIアクセスとweb.php直レスポンス(例)
Mypageでの認証リクエストとレスポンス(例)
```

- API 構築

```
php artisan install:api // apiルート作成&sanctumインストール
php artisan config:publish cors // cors設定公開 // allowedOrigins & supportsCredentials
php artisan config:publish hashing // hash設定公開（やっぱしない）

Userモデル use HasApiTokens
api.phpでの認証リクエスト処理(例)
```
