mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"

   yum install -y java-11-openjdk-headless zip pip
   pip install pandas matplotlib keras tensorflow pyspark
   pip install pipupgrade
   pipupgrade --verbose --latest --yes

   useradd -s /sbin/nologin -M zeppelin -G x14

   pushd /usr/lib/x14
     mkdir -p /var/lib/x14/zeppelin/
     mkdir -p zeppelin
       pushd zeppelin
       wget https://dlcdn.apache.org/zeppelin/zeppelin-0.10.1/zeppelin-0.10.1-bin-all.tgz
       tar -zxf zeppelin-0.10.1-bin-all.tgz
         pushd zeppelin-0.10.1-bin-all
         echo "export AWS_ACCESS_KEY_ID=labb" >> conf/zeppeline-env.sh
	 echo "export AWS_SECRET_ACCESS_KEY=password" >> conf/zeppeline-env.sh
         echo "export AWS_REGION=us-east-1" >>  conf/zeppeline-env.sh
         echo "export ZEPPELIN_SPARK_ENABLESUPPORTEDVERSIONCHECK=false" >> conf/zeppeline-env.sh
         echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.362.b09-2.el9_1.x86_64/jre" >> conf/zeppeline-env.sh
         echo "export SPARK_MASTER=spark://10.1.1.93:7077" >> conf/zeppeline-env.sh

         echo "export ZEPPELIN_ADDR=10.1.1.93" >> conf/zeppeline-env.sh
         echo "export ZEPPELIN_PORT=8082" >> conf/zeppeline-env.sh
         echo "export ZEPPELIN_LOCAL_IP=10.1.1.9" >> conf/zeppeline-env.sh
         echo "export SPARK_HOME=/usr/lib/x14/spark/spark-3.3.2-bin-hadoop3" >> conf/zeppeline-env.sh

         cp zeppelin.service /etc/systemd/system/zeppelin.service
         systemctl enable zeppelin.serive
        
         popd
       popd
   popd
fi
