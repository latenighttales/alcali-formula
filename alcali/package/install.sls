# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import alcali with context %}

{% if alcali.config.db_backend == 'mysql' %}
{% set db_connector = 'mysqlclient' %}
{% set db_requirements = {
    'RedHat': ['mariadb-devel', 'python3-devel'],
    'Arch': ['libmysqlclient'],
    'Debian': ['default-libmysqlclient-dev', 'python3-dev'],
}.get(grains.os_family) %}
{% elif alcali.config.db_backend == 'postgres' %}
{% set db_connector = 'psycopg2' %}
{% set db_requirements = {
    'RedHat': ['libpq-devel', 'python3-devel'],
    'Arch': ['libmysqlclient'],
    'Debian': ['libpq-dev', 'python3-dev'],
}.get(grains.os_family) %}
{% endif %}

{% set venv_requirements = {
    'RedHat': ['python3-virtualenv'],
    'Arch': ['python-virtualenv'],
    'Debian': ['virtualenv', 'python-pip', 'python3-virtualenv', 'python3-venv'],
}.get(grains.os_family) %}

alcali-package-install-pkg-installed:
  pkg.installed:
    - pkgs:
      - git
      - gcc

{% for pkg in db_requirements %}
{{ pkg }}:
  pkg.installed:
    - name: {{ pkg }}
{% endfor %}

{% for venv_pkg in venv_requirements %}
{{ venv_pkg }}:
  pkg.installed:
    - name: {{ venv_pkg }}
{% endfor %}

alcali-package-install-git-latest:
  git.latest:
    - name: {{ alcali.deploy.repository }}
    - target: {{ alcali.deploy.directory }}/code
    - user: {{ alcali.deploy.user }}
    - branch: {{ alcali.deploy.branch }}

alcali-package-install-virtualenv-managed:
  virtualenv.managed:
    - name: {{ alcali.deploy.directory }}/.venv
    - user: {{ alcali.deploy.user }}
    {% if grains['os'] == 'Ubuntu' %}
    - python: {{ alcali.deploy.runtime }}
    {% endif %}
    - system_site_packages: False
    - requirements: {{ alcali.deploy.directory }}/code/requirements/prod.txt
    - require:
      - git: alcali-package-install-git-latest

alcali-package-install-pip-installed:
  pip.installed:
    - name: {{ db_connector }}
    - user: {{ alcali.deploy.user }}
    - cwd: {{ alcali.deploy.directory }}
    - bin_env: {{ alcali.deploy.directory }}/.venv
    - require:
      - virtualenv: alcali-package-install-virtualenv-managed