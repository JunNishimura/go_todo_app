.PHONY: help build build-local up down logs ps test
.DEFAULT_GOAL := help

DOCKER_TAG := latest
build: ## Build docker image to deploy
	docker build -t JunNishimura/go_todo_app:${DOCKER_TAG} --target deploy ./
build-local: ## Build docker image to local environment
	docker compose build --no-cache
up: ## Do docker compose up with hot reload
	docker compose up -d
down: ## Do docker compose down
	docker compose down 
logs: ## Tail docker compose logs
	docker compose logs -f
ps: ## Check container status
	docker compose ps
test: ## Execute tests
	go test -race -shuffle=on ./...