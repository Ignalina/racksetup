ARG UV_INDEX_URL=NONE
FROM localhost/ignalina/ubi_9_5_maker_base_uv_python_311:v1
USER root
RUN dnf -y install cargo gcc cmake m4 automake  libtool autoconf  gcc-c++ openssl-devel libstdc++-static diffutils cmake3

RUN cd /tmp; build_dir=$(mktemp -d); cd $build_dir; wget -q -O peg.tar.gz https://github.com/gpakosz/peg/archive/0.1.19.tar.gz; tar xzf peg.tar.gz; cd peg-0.1.19; make; make install MANDIR=.; cd /tmp; rm -rf $build_dir
RUN git clone --recurse-submodules -j8 https://github.com/FalkorDB/FalkorDB.git
RUN cd FalkorDB;make

