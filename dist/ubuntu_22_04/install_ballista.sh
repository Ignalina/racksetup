apt install curl build-essential gcc make cmake -y
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
git clone https://github.com/apache/arrow-ballista.git
cd arrow-ballista
echo "$HOME/.cargo/env"
source "$HOME/.cargo/env"
cargo build --release
#RUST_LOG=info ./target/release/ballista-scheduler
#RUST_LOG=info ./target/release/ballista-executor -c 2 -p 50051
#RUST_LOG=info ./target/release/ballista-executor -c 2 -p 50052

