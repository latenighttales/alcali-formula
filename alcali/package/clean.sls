# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import alcali with context %}

alcali-package-clean-pkg-removed:
  pkg.removed:
    - pkgs:
      - git
      - gcc
      - virtualenv
      - python-pip
      - python3-pip
      - python3-virtualenv

{% set db_requirements = {
    'RedHat': ['mysql-devel', 'python3-devel'],
    'Debian': ['default-libmysqlclient-dev', 'python3-dev'],
}.get(grains.os_family) %}

{% for pkg in db_requirements %}
{{ pkg }}:
  pkg.removed:
    - name: {{ pkg }}
{% endfor %}

alcali-package-clean-git-latest-file-absent:
  file.absent:
    -name: {{ alcali.deploy.directory }}/code

alcali-package-clean-virtualenv-absent:
  file.absent:
    -name: {{ alcali.deploy.directory }}/.venv


