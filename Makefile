venv:
	./venv-prereq.sh
	pre-commit install
	rm -rf venv
	python3 -m venv .venv
	. .venv/bin/activate; pip3 install wheel
	. .venv/bin/activate; pip install -r requirements-dev.txt

pre-commit:
	pre-commit run --all-files
