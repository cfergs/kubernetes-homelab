.DEFAULT_GOAL := ansible-requirements

ansible-requirements:
	. ../.venv/bin/activate; pip install -r requirements-frozen.txt
	. ../.venv/bin/activate; ansible-galaxy install -r requirements.yml

# OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES is needed when running on macos
# https://stackoverflow.com/questions/50168647/multiprocessing-causes-python-to-crash-and-gives-an-error-may-have-been-in-progr

ansible-k3s: ansible-requirements
	. ../.venv/bin/activate; export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES; ansible-playbook -i ./inventory/inventory.yml k3scluster.yml --ask-pass --ask-become-pass

ansible-flux: ansible-requirements
	. ../.venv/bin/activate; export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES; ansible-playbook -i ./inventory/inventory.yml localhost.yml --ask-become-pass

ansible-node-patch: ansible-requirements
	. ../.venv/bin/activate; export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES; ansible-playbook -i ./inventory/inventory.yml os_patch.yml --ask-pass  --ask-become-pass

ansible-node-reboot: ansible-requirements
	. ../.venv/bin/activate; export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES; ansible-playbook -i ./inventory/inventory.yml os_patch.yml  --extra-vars '{"just_reboot":"true"}' --ask-pass  --ask-become-pass
