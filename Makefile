.DEFAULT_GOAL := test

venv:
	python3 -m venv venv ;\
	. ./venv/bin/activate ;\
	pip install --upgrade pip setuptools wheel ;\
	pip install -e .[dev]

check_prereqs: venv
	. ./venv/bin/activate ;\
	python3 --version ;\
	bash -c '[[ $$(python3 --version) == *3.8.* ]] \
		|| [[ $$(python3 --version) == *3.9.* ]] \
		|| [[ $$(python3 --version) == *3.10.* ]]'

test: check_prereqs
	. ./venv/bin/activate ;\
	pylint singer --extension-pkg-whitelist=ciso8601 -d missing-docstring,broad-except,broad-exception-raised,bare-except,too-many-return-statements,too-many-branches,too-many-arguments,no-else-return,too-few-public-methods,fixme,protected-access ;\
	nosetests --with-doctest -v
