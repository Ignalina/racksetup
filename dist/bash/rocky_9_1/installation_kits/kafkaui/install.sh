#needs javac 17
#update-alternatives -config javac 

pushd /tmp

#git clone https://github.com/provectus/kafka-ui.git
#cd kafkaui
#./mvnw install -DskipTests=true
wget https://github.com/provectus/kafka-ui/releases/download/v0.7.0/kafka-ui-api-v0.7.0.jar
java -Dspring.config.additional-location=application-local.yml  --add-opens java.rmi/javax.rmi.ssl=ALL-UNNAMED -jar kafka-ui-api-v0.7.0.jar


popd

