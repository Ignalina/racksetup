

# Use java 11
git clone https://github.com/confluentinc/schema-registry.git
pushd schema-registry
git checkout tags/v7.4.0 -b latest2
mvn compile package -P standalone -DskipTests
mkdir /usr/lib/x14/kafka/schema-registry
mkdir /var/lib/x14/kafka/schema-registry/log

mv -f package-schema-registry/target/kafka-schema-registry-package-7.4.0-standalone.jar /usr/lib/x14/kafka/schema-registry/
echo "kafkastore.bootstrap.servers=10.1.1.93:9092" > schema-registry.json
echo "listeners=http://10.1.1.93:8084" >> schema-registry.json
mv -f schema-registry.json /usr/lib/x14/kafka/schema-registry/
popd

chown -R kafka:x14 /usr/lib/x14/kafka/schema-registry/
chown -R kafka:x14 /var/lib/x14/kafka/schema-registry/
chmod -R g+xwr /var/lib/x14/kafka/schema-registry
mv schema-registry.service /etc/systemd/system/
systemctl enable schema-registry
