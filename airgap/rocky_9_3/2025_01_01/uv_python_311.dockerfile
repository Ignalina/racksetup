ARG UV_INDEX_URL=NONE
FROM rockylinux:9.3
RUN dnf -y install python3.11 pip python3.11-devel gcc-c++; dnf clean all;
RUN pip install uv
#RUN uv init myenv ; cd myenv; uv add  pyarrow
USER root
RUN dnf clean all;
RUN useradd -s /sbin/nologin -m maker -d /home/maker
USER maker
WORKDIR /home/maker
RUN export HOME=/home/maker; pwd; python3.11 -m venv pipvenv;. ./pipvenv/bin/activate ;pwd ; pip install uv ; uv venv --python 3.11 ;ls -lR; pwd ; uv python dir
