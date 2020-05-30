# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_user_present = tplroot ~ '.user.present' %}
{%- from tplroot ~ "/map.jinja" import alcali with context %}

include:
  - {{ sls_user_present }}

alcali-config-file-file-managed:
  file.managed:
    - name: {{ alcali.deploy.directory }}/.env
    - user: {{ alcali.deploy.user }}
    - group: {{ alcali.deploy.group }}
    - mode: 0400
    - contents: |
        # Salt managed configuration
        {%- for entry, value in alcali.config.items() %}
        {{ entry | upper }}={{ value }}
        {%- endfor %}
    - require:
      - sls: {{ sls_user_present }}