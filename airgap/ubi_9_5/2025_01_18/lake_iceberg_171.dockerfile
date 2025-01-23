from registry.access.redhat.com/ubi9/ubi:9.5
# Ex run like this: prompt> podman  build -v $PWD/out:/out -f lake.dockerfile .
#
# This dockerfile airgaps Lake 1.7.0 dependencies to the airgap/ directory.
#   Iceberg 1.7.1
#   Spark 3.5.4
#   Nessie 0.102.1
#   Awssdk 2.29.29
#   Hadoop-aws 3.4.1
#   Kyuubi 1.10.1
#   minio 20250118003137
#   Doris 3.0.3
#   TODO Ranger

#
# Create output folders
#

RUN mkdir -p /airgap/archive /airgap/.ivy/cache
#
# Install tools for container
#
RUN dnf -y install wget java-11-openjdk-headless zstd tar; dnf clean all;

#
# Fetch artifacts  
#

RUN wget https://dlcdn.apache.org/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz -O /airgap/archive/spark-3.5.4-bin-hadoop3.tgz
RUN wget https://github.com/projectnessie/nessie/releases/download/nessie-0.102.1/nessie-quarkus-0.102.1-runner.jar -O /airgap/archive/nessie-quarkus-0.102.1-runner.jar
RUN wget https://dlcdn.apache.org/kyuubi/kyuubi-1.10.1/apache-kyuubi-1.10.1-bin.tgz -O /airgap/archive/apache-kyuubi-1.10.1-bin.tgz
RUN wget https://repo1.maven.org/maven2/org/apache/kyuubi/kyuubi-spark-authz_2.12/1.10.1/kyuubi-spark-authz_2.12-1.10.1.jar -O /airgap/archive/kyuubi-spark-authz_2.12-1.10.1.jar
RUN wget https://downloads.apache.org/ranger/2.5.0/apache-ranger-2.5.0.tar.gz -O /airgap/archive/apache-ranger-2.5.0.tar.gz
RUN wget https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar -O /airgap/archive/mysql-connector-j-8.3.0.jar

RUN wget https://www.apache.org/dyn/closer.lua/lucene/solr/8.11.2/solr-8.11.2.tgz?action=download -O  /airgap/archive/solr-8.11.2.tgz
RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio-20250118003137.0.0-1.x86_64.rpm -O /airgap/archive/minio-20250118003137.0.0-1.x86_64.rpm


RUN wget https://apache-doris-releases.oss-accelerate.aliyuncs.com/apache-doris-3.0.3-bin-x64.tar.gz -O /airgap/archive/apache-doris-3.0.3-bin-x64.tar.gz

RUN echo '\
<ivy-module version="2.0">\
   <info organisation="org.apache" module="hello-ivy"/>\
   <dependencies>\
       <dependency org="software.amazon.awssdk" name="bundle" rev="2.29.29" />\
       <dependency org="org.apache.hadoop" name="hadoop-aws" rev="3.4.1" />\
       <dependency org="org.mariadb.jdbc" name="mariadb-java-client" rev="3.1.3" />\
       <dependency org="org.projectnessie.nessie-integrations" name="nessie-spark-extensions-3.5_2.12" rev="0.102.1" />\
       <dependency org="org.apache.iceberg" name="iceberg-spark-runtime-3.5_2.12" rev="1.7.1" />\
       <dependency org="software.amazon.awssdk" name="sts" rev="2.29.29" />\
       <dependency org="software.amazon.awssdk" name="s3" rev="2.29.29" />\
       <dependency org="software.amazon.awssdk" name="url-connection-client" rev="2.29.29" />\
       <dependency org="org.apache.kyuubi" name="kyuubi-spark-authz_2.12" rev="1.10.1" />\
   </dependencies>\
</ivy-module>' >> ivy.xml
RUN wget http://search.maven.org/remotecontent?filepath=org/apache/ivy/ivy/2.4.0/ivy-2.4.0.jar -O ivy-2.4.0.jar
RUN java -jar ivy-2.4.0.jar -ivy ivy.xml -cache /airgap/.ivy/cache
RUN tar --zstd -cf  /airgap/.ivy.tar.zst /airgap/.ivy
