ARG UV_INDEX_URL=NONE
FROM localhost/ignalina/fedora_40_maker_base_uv_python_311:v1
USER maker
WORKDIR /home/maker
RUN export HOME=/home/maker;. ./pipvenv/bin/activate; uv pip install pyarrow
