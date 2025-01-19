ARG UV_INDEX_URL=NONE
#from registry.access.redhat.com/ubi9/ubi:9.5
FROM localhost/ignalina/ubi_9_5_maker_base_uv_python_311:v1
USER maker
WORKDIR /home/maker
RUN export HOME=/home/maker;. ./pipvenv/bin/activate; uv pip install pyarrow
