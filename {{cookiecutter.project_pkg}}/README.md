

# Getting Started

Project Build Dependencies:
- gnumake
- curl
- git
- docker
- docker-compose
- pyenv [
- pyenv-virtualenv

Helpful Setup Information:
- https://github.com/pyenv/pyenv
- https://github.com/pyenv/pyenv-virtualenv
- https://github.com/pyenv/pyenv-installer
- for osx: brew install pyenv pyenv-virtualenv


# Project Setup

```
make venv_build
```

Rebuild if needed later after first setup
```
make venv_rebuild
```

## Tox

Reformat Code (runs isort, black) and run tests
```
make tox
```

## Docker

```
make docker_build prod=y
```


## Docker Compose

```
make docker-compose_up prod=y
make docker-compose_down
```

Cleanup local volumn data (if needed)
```
make docker-compose_cleanup
```

## Run local Dev

```
cd {{ cookiecutter.project_pkg }}

python -m pip install -e .

{{ cookiecutter.project_script }} --config=app.dev.yaml --logging=logging.dev.yaml
```
