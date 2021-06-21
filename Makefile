VENV_BIN=.venv/bin/
PIP_COMMAND=pip3

.venv/timestamp:
	python3 -m venv .venv
	touch $@

.venv/requirements-timestamp: .venv/timestamp requirements.txt
	$(VENV_BIN)/$(PIP_COMMAND) install --upgrade pip setuptools wheel
	$(VENV_BIN)/$(PIP_COMMAND) install -r requirements.txt
	touch $@

clean:
	rm -rf .build
	rm -rf presentation

clean-all: clean
	rm -rf .venv

build: .venv/requirements-timestamp slides/main.rst
	$(VENV_BIN)/hovercraft slides/main.rst presentation
