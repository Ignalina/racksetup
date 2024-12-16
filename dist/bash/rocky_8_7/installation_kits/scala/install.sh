pushd /usr/lib/x14
mkdir scala
pushd scala
curl -s "https://get.sdkman.io" | bash
source /root/.sdkman/bin/sdkman-init.sh
sdk install scala 2.13.8


popd


