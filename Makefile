.DEFAULT_GOAL := clean-dev-environment

# pre-setup steps
pre-setup:
	./os-prereq.sh


# pre-commit
PRE_COMMIT_HOOK_STAMP := .git/hooks/pre-commit

${PRE_COMMIT_HOOK_STAMP}: ci-environment
	. .venv/bin/activate; pre-commit install

clean-pre-commit:
	if [ -f .git/hooks/pre-commit ]; then rm .git/hooks/pre-commit; fi

pre-commit:
	. .venv/bin/activate; pre-commit run --all-files

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

dev-environment: ci-environment ${PRE_COMMIT_HOOK_STAMP}

clean-dev-environment: clean dev-environment

clean: clean-venv clean-pre-commit


# Ansible Specific
ansible-env: ci-environment
	cd ansible; make ansible-requirements

ansible-k3s: ci-environment
	cd ansible; make ansible-k3s

ansible-flux: ci-environment
	cd ansible; make ansible-flux

ansible-node-patch: ci-environment
	cd ansible; make ansible-node-patch

ansible-node-reboot: ci-environment
	cd ansible; make ansible-node-reboot

ansible-node-shutdown: ci-environment
	cd ansible; make ansible-node-shutdown
