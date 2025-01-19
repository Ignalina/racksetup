from registry.access.redhat.com/ubi9/ubi:9.5
RUN dnf -y install clang git rust cargo unzip wget; dnf clean all;
RUN git clone --recursive https://github.com/indradb/indradb.git
RUN cd indradb;wget https://github.com/protocolbuffers/protobuf/releases/download/v28.2/protoc-28.2-linux-x86_64.zip; unzip protoc-28.2-linux-x86_64.zip; mv include/google /usr/include; mv bin/* /bin
RUN cd indradb;make

