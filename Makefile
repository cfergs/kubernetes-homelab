.DEFAULT_GOAL := clean-dev-environment

# pre-setup steps
pre-setup:
	./os-prereq.sh


# pre-commit
PRE_COMMIT_HOOK_STAMP := .git/hooks/pre-commit

install-pre-commit: pre-setup
	pip3 install pre-commit

${PRE_COMMIT_HOOK_STAMP}: install-pre-commit
	pre-commit install

clean-pre-commit:
	pre-commit uninstall

pre-commit:
	pre-commit run --all-files


#python
VENV_DIRECTORY := .venv
DEV_REQUIREMENTS_STAMP := $(VENV_DIRECTORY)/dev-requirements-stamp
FROZEN_DEV_REQUIREMENTS_STAMP := $(VENV_DIRECTORY)/frozen-dev-requirements-stamp

${VENV_DIRECTORY}:
	python3 -m venv ${VENV_DIRECTORY}
	. .venv/bin/activate; pip install -r requirements-pip.txt

${DEV_REQUIREMENTS_STAMP}: ${VENV_DIRECTORY} requirements-dev.txt
	. .venv/bin/activate; pip install -r requirements-dev.txt
	touch $@

${FROZEN_DEV_REQUIREMENTS_STAMP}: ${VENV_DIRECTORY} requirements-dev-frozen.txt
	. .venv/bin/activate; pip install -r requirements-dev-frozen.txt
	touch $@

refreeze-dev-requirements: clean-venv ${DEV_REQUIREMENTS_STAMP}
	. .venv/bin/activate; pip freeze --all --exclude-editable > requirements-dev-frozen.txt

clean-venv:
	rm -rf ${VENV_DIRECTORY}


# environments
ci-environment: ${FROZEN_DEV_REQUIREMENTS_STAMP}

dev-environment: ${PRE_COMMIT_HOOK_STAMP} ci-environment

clean-dev-environment: clean dev-environment

clean: clean-pre-commit clean-venv


# Ansible Specific
ansible-env: ci-environment
	cd bare-metal; make ansible-requirements

ansible-k3s-dev: ansible-env
	cd bare-metal; make ansible-k3s-dev

ansible-k3s-prod: ansible-env
	cd bare-metal; make ansible-k3s-prod

ansible-flux-dev: ansible-env
	cd bare-metal; make ansible-flux-dev

ansible-flux-prod: ansible-env
	cd bare-metal; make ansible-flux-prod
