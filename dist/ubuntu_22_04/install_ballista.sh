apt install curl build-essential gcc make cmake -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
git clone https://github.com/apache/arrow-ballista.git
cd arrow-ballista
echo "$HOME/.cargo/env"
source "$HOME/.cargo/env"
cargo build --release

#host 1
#RUST_LOG=info ./target/release/ballista-scheduler
#sudo RUST_LOG=info ./target/release/ballista-executor -c 2 -p 50050 --scheduler-host 10.1.1.10

#host2
#sudo RUST_LOG=info ./target/release/ballista-executor -c 2 -p 50050 --scheduler-host 10.1.1.10

#host3
#sudo RUST_LOG=info ./target/release/ballista-executor -c 2 -p 50050 --scheduler-host 10.1.1.10
