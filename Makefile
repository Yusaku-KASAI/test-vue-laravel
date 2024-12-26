### development
.PHONY: up
up:
	docker compose up -d

.PHONY: down
down:
	docker compose down

.PHONY: stop
stop:
	docker compose stop

.PHONY: setup
setup:
	docker compose build --no-cache
	mkdir vue/node_modules
	make up
	docker compose exec -it app composer install
	docker compose exec -it app php artisan key:generate
	docker compose exec -it app php artisan migrate

.PHONY: init
init:
	docker compose down --rmi all --volumes --remove-orphans
	rm -rf vue/node_modules
	rm -rf laravel/vendor

.PHONY: reset
reset:
	make init
	make setup

# pullしてきたとき
# cp ./laravel/.env.example ./laravel/.env
# make setup

### front
.PHONY: front-up
front-up:
	docker compose up vite -d

.PHONY: front-down
front-down:
	docker compose rm -fsv vite

.PHONY: front-setup
front-setup:
	docker compose build --no-cache vite
	mkdir vue/node_modules
	make front-up

.PHONY: front-init
front-init:
	docker compose rm -fsv vite
	rm -rf vue/node_modules

.PHONY: front-reset
front-reset:
	make front-init
	make front-setup

### api
.PHONY: api-clear
api-clear:
	docker compose exec -it app php artisan config:clear
	docker compose exec -it app php artisan cache:clear
	docker compose exec -it app php artisan route:clear
	docker compose exec -it app php artisan view:clear

.PHONY: api-up
api-up:
	docker compose up app -d

.PHONY: api-down
api-down:
	docker compose rm -fsv app

.PHONY: api-setup
api-setup:
	docker compose build --no-cache app
	make api-up
	docker compose exec -it app composer install
	docker compose exec -it app php artisan key:generate
	docker compose exec -it app php artisan migrate

.PHONY: api-init
api-init:
	docker compose rm -fsv app
	rm -rf laravel/vendor

.PHONY: api-reset
api-reset:
	make api-init
	make api-setup

### front first
.PHONY: front-first
front-first:
	rm -rf vue
	mkdir -p vue
	docker build -t test-vue-first-image --no-cache -f ./infra/development/vite/Dockerfile .
	@echo "$(pwd)"
	@echo "$(shell pwd)"
	docker run -d --name test-vue-first-container -it --mount type=bind,source=$(shell pwd)/vue,target=/opt/app/vue -p 5173:5173 test-vue-first-image
	docker exec -it test-vue-first-container npm create vue . -- --default
	docker exec -it test-vue-first-container npm install
	docker stop test-vue-first-container
	docker rm test-vue-first-container
	docker rmi test-vue-first-image

# npm installいらないかも?

# create vueする備忘録
# Makefile, docker-compose.yml, Dockerfile, .dockerignore, .gitignoreを用意
# .dockerignoreのvue/node_modulesをコメントアウトする
# make first
# create vueするときに手動確認あり
# プロジェクト名は.(カレントディレクトリ)を指定
# パッケージ名はpackage.json
# make fitstの後、.dockerignoreでvue/node_modulesをアンコメント
# vite.config.jsでサーバーオプションのhost:trueを指定
# vite.config.jsでサーバーポート変更
# make reset
# 
# pullしてきたとき
# make reset


### api-first
.PHONY: api-first
api-first:
	rm -rf laravel
	mkdir -p laravel
	docker build -t test-laravel-first-image ./infra/development/php --no-cache
	@echo "$(pwd)"
	@echo "$(shell pwd)"
	docker run -d --name test-laravel-first-container -it --mount type=bind,source=$(shell pwd)/laravel,target=/var/www/html -p 9000:9000 test-laravel-first-image
	docker exec -it test-laravel-first-container composer create-project laravel/laravel .
	docker stop test-laravel-first-container
	docker rm test-laravel-first-container
	docker rmi test-laravel-first-image

# create laravelする備忘録
# Makefile, docker-compose.yml, infra/, .gitignoreを用意
# make api-first
# create laravelするときに手動確認あるかも
# プロジェクト名は.(カレントディレクトリ)を指定
# make api-reset
#
# pullしてきたとき
# cp ./laravel/.env.example ./laravel/.env
# make setup


### all

# create vue & create laravel
# Makefile, docker-compose.yml, .dockerignore, .gitignore, README.md, infra/ でスタート
#
# .dockerignoreのvue/node_modulesをコメントアウトする
# make front-first
# create vueするときに手動確認あり
# プロジェクト名は.(カレントディレクトリ)を指定
# パッケージ名はpackage.json
# make front-fitstの後、.dockerignoreでvue/node_modulesをアンコメント
# vite.config.jsでサーバーオプションのhost:trueを指定
# vite.config.jsでサーバーポート変更
# vite.config.jsでプロキシ変更
#
# make api-first
# create laravelするときに手動確認あるかも
# プロジェクト名は.(カレントディレクトリ)を指定
# .envと.env.exampleを修正(DB情報)
# cors設定(vite側だけでもとりあえず大丈夫そう)
#
# ちなみに、フロントとAPIで若干手順が違うのは、
# フロント側のviteサーバーの起動にnode_modulesが必要なためである。
#
# .dockerignoreのアンコメント再確認
# make reset

### production
.PHONY: puroduction-up
production-up:
	docker compose -f docker-compose-prod.yml up -d

.PHONY: puroduction-setup
production-setup:
	docker compose -f docker-compose-prod.yml build --no-cache
	make production-up
	docker compose -f docker-compose-prod.yml exec -it app composer install
	docker compose -f docker-compose-prod.yml exec -it app php artisan key:generate
	docker compose -f docker-compose-prod.yml exec -it app php artisan migrate
production-down:
	docker compose -f docker-compose-prod.yml down --rmi all --volumes --remove-orphans

# 開発環境でdocker compose exec -it vite npm run build
# make init
# make production-setup
#
# 終了時
# make production-down
# make init