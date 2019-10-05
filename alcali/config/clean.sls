# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import alcali with context %}

alcali-config-clean-file-absent:
  file.absent:
    - name: {{ alcali.deploy.directory }}/.env
