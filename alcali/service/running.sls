# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import alcali with context %}

include:
  - {{ sls_config_file }}

alcali-file-managed-service-running:
  file.managed:
    - name: /etc/systemd/system/{{ alcali.deploy.service }}.service
    - context:
        service: {{ alcali.deploy.service }}
        directory: {{ alcali.deploy.directory }}
        user: {{ alcali.deploy.user }}
        group: {{ alcali.deploy.group }}
        name: {{ alcali.gunicorn.name }}
        host: {{ alcali.gunicorn.host }}
        port: {{ alcali.gunicorn.port }}
        workers: {{ alcali.gunicorn.workers }}
    - source: salt://alcali/files/alcali.service.jinja
    - template: jinja
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: alcali-file-managed-service-running

alcali-service-running-service-running:
  service.running:
    - name: {{ alcali.deploy.service }}
    - enable: True
    - restart: True
    - order: last
    - watch:
      - module: alcali-file-managed-service-running
    - require:
        - sls: {{ sls_config_file }}
        - file: alcali-file-managed-service-running
