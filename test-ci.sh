#!/usr/bin/env sh

set -ex

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

APP=aio_example

./cookie-test.py "${APP}"

cd "${APP}"

make venv_build SHELL=/bin/bash

ls -lah .
ls -lah "${APP}"/

cat "${APP}"/.python-version
make tox SHELL=/bin/bash

cd "${APP}"
tox -e devrun

pyenv uninstall -f "${APP}_project"
pyenv uninstall -f "${APP}"

