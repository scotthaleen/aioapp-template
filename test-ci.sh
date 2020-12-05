#!/bin/bash

set -ex

APP=aio_example

./cookie-test.py "${APP}"

cd "${APP}"

make venv_build SHELL=/bin/bash

cd "${APP}"
tox -e devrun

pyenv uninstall -f "${APP}_project"
pyenv uninstall -f "${APP}"

