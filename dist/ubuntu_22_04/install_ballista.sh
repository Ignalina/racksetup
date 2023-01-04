apt install -y curl build-essential gcc make cmake 

export PROTO_ZIP="protoc-21.4-linux-x86_64.zip"
curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v21.4/$PROTO_ZIP
unzip $PROTO_ZIP
export PATH=$PATH:$PWD/bin
export PROTOC=$PWD/bin/protoc


curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y



source "$HOME/.cargo/env"
git clone https://github.com/apache/arrow-ballista.git
cd arrow-ballista
echo "$HOME/.cargo/env"
source "$HOME/.cargo/env"
cargo build --release

#host 1
RUST_LOG=info ./target/release/ballista-scheduler
sudo RUST_LOG=info ./target/release/ballista-executor -c 2 -p 50050 --scheduler-host 10.1.1.10

#host2
#sudo RUST_LOG=info ./target/release/ballista-executor -c 2 -p 50050 --scheduler-host 10.1.1.10

#host3
#sudo RUST_LOG=info ./target/release/ballista-executor -c 2 -p 50050 --scheduler-host 10.1.1.10
