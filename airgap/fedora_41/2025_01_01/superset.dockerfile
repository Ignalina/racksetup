ARG UV_INDEX_URL=NONE
FROM localhost/ignalina/fedora_41_maker_base_uv_python_311:v1
USER root
RUN dnf -y install gcc-c++
USER maker
WORKDIR /home/maker
RUN export HOME=/home/maker;. ./pipvenv/bin/activate  ;uv pip install setuptools numpy==1.23.5 apache-superset pillow; export FLASK_APP=superset;export DATA_DIR="/home/maker" 
#;superset db upgrade ; superset load_examples

