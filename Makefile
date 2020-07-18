CONF_DIR=conf
SERVER_DIR=server
# import config.
# You can change the default config with `make cnf="config_special.env" build`
cnf ?= $(CONF_DIR)/config.env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

# import deploy config
# You can change the default deploy config with `make cnf="deploy_special.env" release`
dpl ?= $(CONF_DIR)/deploy.env
include $(dpl)
export $(shell sed 's/=.*//' $(dpl))


# DOCKER TASKS
# Build the container
build: ## Build the container
	docker build -t $(APP_NAME) $(SERVER_DIR)

run: ## Run container on port configured in `config.env`
	docker run -it -d --rm --env-file=$(CONF_DIR)/config.env -p=$(PORT):$(PORT) --name="$(APP_NAME)" $(APP_NAME)

status:
	docker ps

stop:
	docker stop $(APP_NAME)


