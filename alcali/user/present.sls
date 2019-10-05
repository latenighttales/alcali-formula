# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import alcali with context %}

alcali-user-present:
  user.present:
    - name: {{ alcali.deploy.user }}
    - home: {{ alcali.deploy.directory }}
    - system: True

alcali-group-present:
  group.present:
    - name: {{ alcali.deploy.group }}
    - system: True

alcali-directory:
  file.directory:
    - name: {{ alcali.deploy.directory }}
    - user: {{ alcali.deploy.user }}
    - group: {{ alcali.deploy.group }}
    - require:
      - user: alcali-user-present
      - group: alcali-group-present
