#needs javac 17
yum install -y java-17-openjdk-devel.x86_64

cp kafkaui.service /tmp
mkdir /usr/lib/x14/kafka/kafkaui
mkdir /var/lib/x14/kafka/kafkaui
pushd /usr/lib/x14/kafka/kafkaui
#git clone https://github.com/provectus/kafka-ui.git
#cd kafkaui
#./mvnw install -DskipTests=true
wget https://github.com/provectus/kafka-ui/releases/download/v0.7.1/kafka-ui-api-v0.7.1.jar
#/usr/lib/jvm/java-17-openjd/java -Dspring.config.additional-location=application-local.yml  --add-opens java.rmi/javax.rmi.ssl=ALL-UNNAMED -jar kafka-ui-a>
mv -f /tmp/kafkaui.serve /etc/systemd/system/
mv kafkaui.service /etc/systemd/system
chown -R kafka:x14 /usr/lib/x14/kafka/kafkaui
chown -R kafka:x14 /var/lib/x14/kafka/kafkaui

systemctl enable kafkaui
systemctl start kafkaui
popd
