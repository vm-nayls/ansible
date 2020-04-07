OK_COLOR=\033[32;01m
NO_COLOR=\033[0m

.PHONY: help
help:
	@printf "\n$(OK_COLOR)===$(NO_COLOR) ARCH=amd64 OC=bionic make <command> $(OK_COLOR)===$(NO_COLOR)\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

DOCKER_BUILDKIT?=1
CI_REGISTRY_IMAGE?=naylscloud/ansible
CI_COMMIT_REF_SLUG?=$(shell git symbolic-ref --short -q HEAD | sed 's/\//-/')
CI_PIPELINE_URL?=local-build
CI_COMMIT_SHA?=$(shell git rev-parse -q HEAD)
CI_COMMIT_SHORT_SHA?=$(shell git rev-parse --short=8 -q HEAD)

ANSIBLE_VERSION?=2.9
PYTHON_VERSION?=python3.8
OC_VERSION?=alpine3.11

IMAGE_NAME=${CI_REGISTRY_IMAGE}:${ANSIBLE_VERSION}-${PYTHON_VERSION}-${OC_VERSION}

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
	@printf "OC ${OC}\n"
	@printf "OC_VERSION ${OC_VERSION}\n"


.PHONY: all
all: pull build push ## Pull, Build, Push

.PHONY: images
images: ## Show images
	@printf "${IMAGE_NAME}\n"

.PHONY: pull
pull: env-docker ## Pull
	@docker pull ${IMAGE_NAME} || true

.PHONY: build
build: env-docker ## Build
	@printf "\n${OK_COLOR}==>${NO_COLOR} Build ${OC}\n"
	@docker build --rm --compress --pull \
	--cache-from ${IMAGE_NAME} \
	--tag ${IMAGE_NAME} \
	--file ${DOCKERFILE} \
	${DOCKER_CONTEXT}

.PHONY: push
push: env-docker ## Push
	@docker push ${IMAGE_NAME}