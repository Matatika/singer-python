.DEFAULT_GOAL := test

venv:
	python3 -m venv venv ;\
	. ./venv/bin/activate ;\
	pip install --upgrade pip setuptools wheel

check_prereqs: venv
	. ./venv/bin/activate ;\
	python3 --version ;\
	bash -c '[[ $$(python3 --version) == *3.8.* ]] \
		|| [[ $$(python3 --version) == *3.9.* ]] \
		|| [[ $$(python3 --version) == *3.10.* ]]'

install: check_prereqs
	python3 -m pip install -e '.[dev]'

test: install
	pylint singer --extension-pkg-whitelist=ciso8601 -d missing-docstring,broad-except,bare-except,too-many-return-statements,too-many-branches,too-many-arguments,no-else-return,too-few-public-methods,fixme,protected-access
	nosetests --with-doctest -v
