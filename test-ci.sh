#!/bin/bash

set -ex


echo "$(which python)"
echo "$(which pyenv)"
echo "$PYENV_ROOT"
echo "$PATH"

echo "- -- -"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

echo "$(which python)"
echo "$(which pyenv)"
echo "$PYENV_ROOT"
echo "$PATH"


APP=aio_example

./cookie-test.py "${APP}"


cd "${APP}"
make venv_build

cd "${APP}"


echo "$(which python)"
echo "$(which pyenv)"
echo "$PYENV_ROOT"
echo "$PATH"

pyenv which python
python --version

python -m pip list

tox -e devrun

pyenv uninstall -f "${APP}_project"
pyenv uninstall -f "${APP}"

