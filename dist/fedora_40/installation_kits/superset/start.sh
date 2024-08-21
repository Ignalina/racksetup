#!/bin/bash
. /usr/lib/x14/superset/venv/bin/activate
export FLASK_APP=superset
superset run -p 8088 -h 10.1.1.93 --with-threads --reload
