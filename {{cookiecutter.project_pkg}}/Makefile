# Dependencies

VERSION := {{cookiecutter.version}}

PYTHON_VERSION := {{cookiecutter.python_version}}

DEV ?= $(strip $(if $(findstring y,$(prod)),,dev))

VERSION := ${VERSION}$(DEV:dev=-dev)

CMD_ARGUMENTS ?= $(cmd)

.DEFAULT_GOAL := help

check-%:
	@: $(if $(value $*),,$(error $* is undefined))

.PHONY: yN
yN:
		@echo "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ] || (echo "aborted."; exit 1;)

.PHONY: all
all: tox

help:
	@echo ""
	@echo "By default make targets assume DEV to run production pass in prod=y as a command line argument"
	@echo ""
	@echo "Targets:"
	@echo ""
	@grep -E '^([a-zA-Z_-])+%*:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-40s\033[0m %s\n", $$1, $$2}'

tox-%:
	@echo "tox $*"
	(cd $* && echo "$SHELL" && echo "$(which tox)" && tox -e format && tox)

.PHONY: tox
tox: tox-{{cookiecutter.project_pkg}}


docker_build-%:
	@echo "docker build $*"
	(cd $* && ./build-docker.sh)


.PHONY: docker_build
docker_build: docker_build_{{cookiecutter.project_pkg}}


.PHONY: venv_base_install
venv_base_install:| check-PYTHON_VERSION ## Create pyenv virtual environments for base project
	(pyenv virtualenv ${PYTHON_VERSION} {{cookiecutter.project_pkg}}_project && \
	 pyenv local {{cookiecutter.project_pkg}}_project && \
	 python -m pip install -r requirements-project.txt)

.PHONY: venv_base_reinstall
venv_base_reinstall:| check-PYTHON_VERSION ## Re-create pyenv virtual environments for base project
	(pyenv uninstall {{cookiecutter.project_pkg}}_project && \
	 pyenv virtualenv ${PYTHON_VERSION} {{cookiecutter.project_pkg}}_project && \
	 pyenv local {{cookiecutter.project_pkg}}_project && \
	 python -m pip install -r requirements-project.txt)


venv_install-%:| check-PYTHON_VERSION ## Create pyenv virtual environments for project
	(cd $* && \
		pyenv virtualenv ${PYTHON_VERSION} $* && \
		pyenv local $* && \
		python -m pip install -r requirements-dev.txt)

venv_reinstall-%:| check-PYTHON_VERSION ## Re-create pyenv virtual environment for project
	(cd $* && \
		pyenv uninstall $* && \
		pyenv virtualenv ${PYTHON_VERSION} $* && \
		pyenv local $* && \
		python -m pip install -r requirements-dev.txt)


.PHONY: venv_build
venv_build: venv_base_install venv_install-{{cookiecutter.project_pkg}} ## Create pyenv virtual environments for project

.PHONY: venv-rebuild
venv_rebuild: venv_base_reinstall venv_reinstall-{{cookiecutter.project_pkg}} ## Recreate pyenv virtual environments for project


## Docker Compose directories
DOCKER_COMPOSE_DIRS := ./data/logs

$(DOCKER_COMPOSE_DIRS):
		@mkdir -p $@

.PHONY: docker-compose_up
docker-compose_up: $(DOCKER_COMPOSE_DIRS)  ## Start docker-compose instance local
	HOSTNAME=$(shell hostname) docker-compose up -d

.PHONY: docker-compose_down
docker-compose_down:| check-IP_ADDRESS ## Stop docker instance local
	HOSTNAME=$(shell hostname) docker-compose down

.PHONY: docker-compose_cleanup
docker-compose_cleanup:| yN ## Remove data directories for local
	rm -rf ./data
