

# Use java 11
git clone https://github.com/confluentinc/schema-registry.git
cd schema-registry
git checkout tags/v7.4.0 -b latest2
mvn compile package -P standalone -DskipTests
mv -f package-schema-registry/target/kafka-schema-registry-package-7.4.0-standalone.jar /usr/lib/x14/kafka/schema-registry/
echo "kafkastore.bootstrap.servers=10.1.1.93:9092" > schema-registry.json
echo "listeners=http://localhost:8084" > schema-registry.json



java -jar package-schema-registry/target/kafka-schema-registry-package-7.4.0-standalone.jar  schema-registry.json

# From doc:
#To migrate from ZooKeeper based to Kafka based primary election, make the following configuration changes in all Schema Registry nodes:

#Remove kafkastore.connection.url.
#Remove schema.registry.zk.namespace if it is configured.
#Configure kafkastore.bootstrap.servers.
#Configure schema.registry.group.id if you originally had schema.registry.zk.namespace for multiple Schema Registry clusters.
#If both kafkastore.connection.url and kafkastore.bootstrap.servers are configured, Kafka will be used for leader election.
