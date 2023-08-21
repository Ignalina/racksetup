mesh_create_ca_cert () {
  openssl req -new -x509 -keyout ca.key -out ca.crt -days 3650 -subj ‘/CN=ca.kafka.x14.se/OU=TEST/O=X14/L=Stockholm/C=SE’ -passin pass:changeit -passout pass:changeit
  keytool -genkey -alias x14-server -dname “CN=localhost, OU=TEST, O=X14, L=Stockholm, S=ST, C=SE” -keystore kafka.server.keystore.jks -keyalg RSA -storepass changeit -keypass changeit
  keytool -keystore kafka.server.keystore.jks -alias x14-server -certreq -file kafka-server.csr -storepass changeit -keypass changeit
  openssl x509 -req -CA ca.crt -CAkey ca.key -in kafka-server.csr -out kafka-server-ca1-signed.crt -days 9999 -CAcreateserial -passin pass:changeit

# Import ca cert into keystore
  keytool -keystore kafka.server.keystore.jks -alias CARoot -import -noprompt -file ca.crt -storepass changeit -keypass changeit
  keytool -keystore kafka.server.truststore.jks -alias CARoot -import -noprompt -file ca.crt -storepass changeit -keypass changeit

}

mesh_create_cert () {
# import ca cert into client truststore
  keytool -keystore kafka.client1.truststore.jks -alias CARoot -import -noprompt -file ca.crt -storepass changeit -keypass changeit
  keytool -genkey -alias x14-client1 -dname “CN=client1.kafka.x14.com, OU=TEST, O=X14, L=Stockholm, S=ST, C=SE” -keystore kafka.client1.keystore.jks -keyalg RSA -storepass changeit -keypass changeit
  keytool -keystore kafka.client1.keystore.jks -alias x14-client1 -certreq -file kafka-client1.csr -storepass changeit -keypass changeit
  openssl x509 -req -CA ca.crt -CAkey ca.key -in kafka-client1.csr -out kafka-client1-ca1-signed.crt -days 9999 -CAcreateserial -passin pass:changeit

  keytool -keystore kafka.client1.keystore.jks -alias CARoot -import -noprompt -file ca.crt -storepass changeit -keypass changeit
  keytool -keystore kafka.client1.keystore.jks -alias x14-client1 -import -noprompt -file kafka-client1-ca1-signed.crt -storepass changeit -keypass changeit
  keytool -keystore kafka.client1.truststore.jks -alias CARoot -import -noprompt -file ca.crt -storepass changeit -keypass changeit

}
