venv:
	rm -rf .venv
	python3 -m venv .venv
	. .venv/bin/activate; pip3 install wheel #wheel required BEFORE installing requirements
	. .venv/bin/activate; pip install -r requirements-frozen.txt

	. .venv/bin/activate; ansible-galaxy install -r requirements.yml

ansible-k3s-dev:
	ansible-playbook -i ./inventory/inventory-develop.yml k3scluster.yml --ask-pass --ask-become-pass

ansible-k3s-prod:
	ansible-playbook -i ./inventory/inventory-prod.yml k3scluster.yml --ask-pass --ask-become-pass

ansible-flux-dev:
	ansible-playbook -i ./inventory/inventory-develop.yml localhost.yml --ask-pass --ask-become-pass

ansible-flux-prod:
	ansible-playbook -i ./inventory/inventory-prod.yml localhost.yml --ask-pass --ask-become-pass
