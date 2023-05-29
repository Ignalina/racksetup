yum install -y java-17-openjdk-headless

pushd /usr/lib/x14
mkdir -p /var/lib/x14/kafka/apicurio
chown -R kafka:x14 /var/lib/x14/kafka/apicurio

pushd kafka
git clone https://github.com/Apicurio/apicurio-registry.git

pushd apicurio-registry


mesh_machine_nr
nr=$?

./mvnw clean install -Pprod -Pkafkasql -DskipTests
#storage/kafkasql/target/apicurio-registry-storage-kafkasql-2.4.3-SNAPSHOT.jar

popd
popd

chown -R kafka:x14 apicurio
popd

if [[ ${nr} -eq 1 ]]
then 
    echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"
fi

mv -f apicurio.service /etc/systemd/system/
systemctl enable apicurio

