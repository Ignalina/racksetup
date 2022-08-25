sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys d0a112e067426ab2
sudo wget -O /etc/apt/sources.list.d/scylla.list http://downloads.scylladb.com/deb/debian/scylla-5.0.list
sudo apt-get update
sudo apt-get install -y scylla 
scylla_setup --no-raid-setup --online-discard --nic eth2 \
      --no-coredump-setup --io-setup 1 --no-memory-setup \
      --no-rsyslog-setup

#sudo apt-get update
#sudo apt-get install -y openjdk-8-jre-headless
#sudo update-java-alternatives --jre-headless -s java-1.8.0-openjdk-amd64


#git clone https://github.com/scylladb/scylla.git/
#cd scylla
#git submodule update --init --recursive
#sudo ./install-dependencies.sh
#./configure.py --mode=release
#ninja-build ./build/release/scylla
#./build/release/scylla --datadir tmp --commitlog-directory tmp --hits-directory tmp --view-hints-directory tmp --smp 1
#./build/release/scylla --help


