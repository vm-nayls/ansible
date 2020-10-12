OK_COLOR=\033[32;01m
NO_COLOR=\033[0m

.PHONY: help
help:
	@printf "\n$(OK_COLOR)===$(NO_COLOR) ARCH=amd64 OC_VERSION=bionic make <command> $(OK_COLOR)===$(NO_COLOR)\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

DOCKER_BUILDKIT?=1
CI_REGISTRY_IMAGE?=naylscloud/ansible
CI_COMMIT_REF_SLUG?=$(shell git symbolic-ref --short -q HEAD | sed 's/\//-/')
CI_PIPELINE_URL?=local-build
CI_COMMIT_SHA?=$(shell git rev-parse -q HEAD)
CI_COMMIT_SHORT_SHA?=$(shell git rev-parse --short=8 -q HEAD)

ANSIBLE_VERSION?=2.10
PYTHON_VERSION?=python3.9
OC_VERSION?=alpine3.12

IMAGE_NAME=${CI_REGISTRY_IMAGE}:${ANSIBLE_VERSION}-${PYTHON_VERSION}-${OC_VERSION}
IMAGE_NAME_SHORT=${CI_REGISTRY_IMAGE}:${ANSIBLE_VERSION}-${OC_VERSION}
IMAGE_NAME_SHORT_LATEST=${CI_REGISTRY_IMAGE}:${ANSIBLE_VERSION}-latest

COMMAND?=/bin/ash
DOCKER_CONTEXT?=${PWD}/${ANSIBLE_VERSION}/${PYTHON_VERSION}/${OC_VERSION}
DOCKERFILE?=${DOCKER_CONTEXT}/Dockerfile

.PHONY: env-docker
env-docker:
	@printf "\n${OK_COLOR}===${NO_COLOR} DOCKER ENV ${OK_COLOR}===${NO_COLOR}\n"
	@printf "IMAGE_NAME ${IMAGE_NAME}\n"
	@printf "DOCKERFILE ${DOCKERFILE}\n"
	@printf "DOCKER_CONTEXT ${DOCKER_CONTEXT}\n"
	@printf "ANSIBLE_VERSION ${ANSIBLE_VERSION}\n"
	@printf "PYTHON_VERSION ${PYTHON_VERSION}\n"
	@printf "OC ${OC_VERSION}\n"
	@printf "OC_VERSION ${OC_VERSION}\n"


.PHONY: all
all: pull build push ## Pull, Build, Push


.PHONY: images
images: ## Show images
	@printf "${IMAGE_NAME}\n"

.PHONY: pull
pull: ## Pull
	@docker pull ${IMAGE_NAME} || true

.PHONY: push
push: env-docker ## Push
	@docker push ${IMAGE_NAME}

.PHONY: build
build: ## Build
	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ${ANSIBLE_VERSION} ${PYTHON_VERSION} ${OC_VERSION}\n"
	@docker build --rm --compress --pull \
	--cache-from ${IMAGE_NAME} \
	--tag ${IMAGE_NAME} \
	--file ${DOCKERFILE} \
	${DOCKER_CONTEXT}

.PHONY: short-build
short-build: ## Build
	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ${ANSIBLE_VERSION} ${PYTHON_VERSION} ${OC_VERSION}\n"
	@docker build --rm --compress --pull \
	--cache-from ${IMAGE_NAME} \
	--tag ${IMAGE_NAME_SHORT_LATEST} \
	--tag ${IMAGE_NAME_SHORT} \
	--tag ${IMAGE_NAME} \
	--file ${DOCKERFILE} \
	${DOCKER_CONTEXT}


.PHONY: build-2.9
build-2.9: build-2.9-python3.8 build-2.9-python3.9

.PHONY: build-2.9-python3.8
build-2.9-python3.8: ## Build build-2.9-python3.8
	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ansible 2.9 python3.8 alpine3.12 \n"
	@docker build --rm --compress --pull \
	--tag naylscloud/ansible:2.9-python3.8-alpine3.12 \
	--file 2.9/python3.8/alpine3.12/Dockerfile \
	./2.9/python3.8/alpine3.12

	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ansible 2.9 python3.8 slim-buster \n"
	@docker build --rm --compress --pull \
	--tag naylscloud/ansible:2.9-python3.8-slim-buster \
	--file 2.9/python3.8/slim-buster/Dockerfile \
	./2.9/python3.8/slim-buster

.PHONY: build-2.9-python3.9
build-2.9-python3.9: ## Build build-2.9-python3.9
	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ansible 2.9 python3.9 alpine3.12 \n"
	@docker build --rm --compress --pull \
	--tag naylscloud/ansible:2.9-latest \
	--tag naylscloud/ansible:2.9-alpine \
	--tag naylscloud/ansible:2.9-python3.9-alpine3.12 \
	--file 2.9/python3.9/alpine3.12/Dockerfile \
	./2.9/python3.9/alpine3.12

	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ansible 2.9 python3.9 slim-buster \n"
	@docker build --rm --compress --pull \
	--tag naylscloud/ansible:2.9-slim-buster \
	--tag naylscloud/ansible:2.9-python3.9-slim-buster \
	--file 2.9/python3.9/slim-buster/Dockerfile \
	./2.9/python3.9/slim-buster


.PHONY: build-2.10
build-2.10: build-2.10-python3.8 build-2.10-python3.9

.PHONY: build-2.10-python3.8
build-2.10-python3.8: ## Build build-2.10-python3.8
	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ansible 2.10 python3.8 alpine3.12 \n"
	@docker build --rm --compress --pull \
	--tag naylscloud/ansible:2.10-python3.8-alpine3.12 \
	--file 2.10/python3.8/alpine3.12/Dockerfile \
	./2.10/python3.8/alpine3.12

	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ansible 2.10 python3.8 slim-buster \n"
	@docker build --rm --compress --pull \
	--tag naylscloud/ansible:2.10-python3.8-slim-buster \
	--file 2.10/python3.8/slim-buster/Dockerfile \
	./2.10/python3.8/slim-buster

.PHONY: build-2.10-python3.9
build-2.10-python3.9: ## Build build-2.10-python3.9
	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ansible 2.10 python3.9 alpine3.12 \n"
	@docker build --rm --compress --pull \
	--tag naylscloud/ansible:2.10-latest \
	--tag naylscloud/ansible:2.10-alpine \
	--tag naylscloud/ansible:2.10-python3.9-alpine3.12 \
	--file 2.10/python3.9/alpine3.12/Dockerfile \
	./2.10/python3.9/alpine3.12

	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ansible 2.10 python3.9 slim-buster \n"
	@docker build --rm --compress --pull \
	--tag naylscloud/ansible:2.10-slim-buster \
	--tag naylscloud/ansible:2.10-python3.9-slim-buster \
	--file 2.10/python3.9/slim-buster/Dockerfile \
	./2.10/python3.9/slim-buster