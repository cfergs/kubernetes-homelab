ansible-setup:
	./ansible-setup.sh

ansible-k3s:
	ansible-playbook -i ./inventory/inventory.yml k3scluster.yml --ask-pass --ask-become-pass

ansible-flux:
	ansible-playbook localhost.yml --ask-pass --ask-become-pass
