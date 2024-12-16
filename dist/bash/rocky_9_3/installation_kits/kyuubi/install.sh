mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"

   yum install -y java-11-openjdk-headless zip
   useradd -s /sbin/nologin -M kyuubi -g x14

   mkdir -p /var/lib/x14/kyuubi/
   chown kyuubi:x14 /var/lib/x14/kyuubi

   pushd /usr/lib/x14
   mkdir -p kyuubi

   pushd kyuubi
   wget https://dlcdn.apache.org/kyuubi/kyuubi-1.10.0/apache-kyuubi-1.10.0-bin.tgz
   tar -zxf apache-kyuubi-1.10.0-bin.tgz

   popd
   chown -R kyuubi:x14 kyuubi

   popd
fi

cp ranger-spark-security.xml  /usr/lib/x14/spark/spark-3.5.3-bin-hadoop3/conf/
chown spark:x14 /usr/lib/x14/spark/spark-3.5.3-bin-hadoop3/conf/ranger-spark-security.xml

pushd /tmp

wget https://dlcdn.apache.org/kyuubi/kyuubi-1.10.0/apache-kyuubi-1.10.0-source.tgz
tar -zxf apache-kyuubi-1.10.0-source.tgz
cd apache-kyuubi-1.10.0-source
build/mvn clean package -pl :kyuubi-spark-authz_2.12 -DskipTests -Dspark.version=3.5.3 -Dranger.version=2.5.0
#build/mvn clean package -pl :kyuubi-spark-authz-shaded_2.12 -DskipTests -Dspark.version=3.5.0 -Dranger.version=2.4.0
#cp ./extensions/spark/kyuubi-spark-authz-shaded/target/kyuubi-spark-authz-shaded_2.12-1.8.0.jar /usr/lib/x14/spark/spark-3.5.0-bin-hadoop3/jars/
#chown spark:x14 /usr/lib/x14/spark/spark-3.5.0-bin-hadoop3/jars/kyuubi-spark-authz-shaded_2.12-1.8.0.jar

cp ./extensions/spark/kyuubi-spark-authz/target/kyuubi-spark-authz_2.12-1.10.0.jar /usr/lib/x14/spark/spark-3.5.3-bin-hadoop3/jars/
cp ./extensions/spark/kyuubi-spark-authz/target/scala-2.12/jars/* /usr/lib/x14/spark/spark-3.5.3-bin-hadoop3/jars/

chown spark:x14 /usr/lib/x14/spark/spark-3.5.3-bin-hadoop3/jars/*


popd
