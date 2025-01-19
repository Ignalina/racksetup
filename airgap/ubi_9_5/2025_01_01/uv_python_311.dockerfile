ARG UV_INDEX_URL=NONE
FROM registry.access.redhat.com/ubi9/python-311:9.5
USER root
RUN dnf clean all;
RUN useradd -s /sbin/nologin -m maker -d /home/maker
USER maker
WORKDIR /home/maker
RUN export HOME=/home/maker; pwd; python3 -m venv pipvenv;. ./pipvenv/bin/activate ;pwd ; pip install uv ; uv venv --python 3.11 ;ls -lR; pwd ; uv python dir
