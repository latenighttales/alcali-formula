# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import alcali with context %}

alcali-user-absent:
  user.absent:
    - name: {{ alcali.deploy.user }}

alcali-group-absent:
  group.absent:
    - name: {{ alcali.deploy.group }}

alcali-directory:
  file.absent:
    - name: {{ alcali.deploy.directory }}
