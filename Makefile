.PHONY: help build build-local up down logs ps test
.DEFAULT_GOAL := help

DOCKER_TAG := latest
build: ## build docker image to deploy
	docker build -t junnishimura/gotodo:${DOCKER_TAG} \
			--target deploy ./
build-local: ## build docker image to local development
	docker compose build --no-cache
up: ## do docker compose up  with hot reload
	docker compose up -d
down: ## do docker compose down
	docker compose down
logs: ## tail docker compose logs
	docker compose logs -f
ps: ## check container status
	docker compose ps
test: ## execute tests
	go test -race -shuffle=on ./...
dry-migrate: ## try migration
	mysqldef -u todo -p todo -h 127.0.0.1 -P 33306 todo --dry-run < ./_tools/mysql/schema.sql
migrate: ## execute migration
	mysqldef -u todo -p todo -h 127.0.0.1 -P 33306 todo < ./_tools/mysql/schema.sql
generate: ## generate codes
	go generate ./...
help: ## show options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'