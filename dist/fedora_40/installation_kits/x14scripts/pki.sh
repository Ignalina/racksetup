mesh_create_ca_cert () {
  openssl req -new -x509 -keyout ca.key -out ca.crt -days 3650 -subj $1 -passin pass:$2 -passout pass:$2
}

mesh_create_sub_cert () {
  keytool -genkey -alias x14-$1 -dname $2 -keystore kafka.$1.keystore.jks -keyalg RSA -storepass $3 -keypass $3
  keytool -keystore kafka.$1.keystore.jks -alias x14-$1 -certreq -file kafka-$1.csr -storepass $3 -keypass $3
  openssl x509 -req -CA ca.crt -CAkey ca.key -in kafka-$1.csr -out kafka-$1-ca-signed.crt -days 9999 -CAcreateserial -passin pass:$3

  keytool -keystore kafka.$1.keystore.jks -alias CARoot -import -noprompt -file ca.crt -storepass $3 -keypass $3
  keytool -keystore kafka.$1.keystore.jks -alias x14-$1 -import -noprompt -file kafka-$1-ca-signed.crt -storepass $3 -keypass $3
  keytool -keystore kafka.$1.truststore.jks -alias CARoot -import -noprompt -file ca.crt -storepass $3 -keypass $3
  mkdir -p secrets/$1 
  mv kafka.$1.*.jks secrets/$1/

}

