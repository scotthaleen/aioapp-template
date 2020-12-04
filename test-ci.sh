#!/usr/bin/env sh

set -ex

APP=aio_example

./cookie-test.py "${APP}"

cd "${APP}"

make venv_build
make tox

cd "${APP}"
tox -e devrun

pyenv uninstall -f "${APP}_project"
pyenv uninstall -f "${APP}"

