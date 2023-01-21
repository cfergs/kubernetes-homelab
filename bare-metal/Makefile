.DEFAULT_GOAL := ansible-requirements

ansible-requirements:
	. ../.venv/bin/activate; pip install -r requirements-frozen.txt
	. ../.venv/bin/activate; ansible-galaxy install -r requirements.yml

ansible-k3s-dev: ansible-requirements
	. ../.venv/bin/activate; ansible-playbook -i ./inventory/inventory-develop.yml k3scluster.yml --ask-pass --ask-become-pass

ansible-k3s-prod: ansible-requirements
	. ../.venv/bin/activate; ansible-playbook -i ./inventory/inventory-prod.yml k3scluster.yml --ask-pass --ask-become-pass

ansible-flux-dev: ansible-requirements
	. ../.venv/bin/activate; ansible-playbook -i ./inventory/inventory-develop.yml localhost.yml --ask-become-pass

ansible-flux-prod: ansible-requirements
	. ../.venv/bin/activate; ansible-playbook -i ./inventory/inventory-prod.yml localhost.yml --ask-become-pass
