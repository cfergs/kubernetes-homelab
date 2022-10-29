setup:
	./venv-prereq.sh
	python3 -m pip install --upgrade pip setuptools wheel --user
	pip install pre-commit

venv:
	pre-commit install
	rm -rf venv
	python3 -m venv .venv
	. .venv/bin/activate; pip install -r requirements-dev-frozen.txt

pre-commit:
	pre-commit run --all-files
