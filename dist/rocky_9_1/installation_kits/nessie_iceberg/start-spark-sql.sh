export AWS_ACCESS_KEY_ID=labb
export AWS_SECRET_ACCESS_KEY=password
export AWS_REGION=us-east-1

/usr/lib/x14/spark/spark-3.3.2-bin-hadoop3/bin/spark-sql --master spark://10.1.1.93:7077 --packages org.projectnessie:nessie-spark-extensions-3.3_2.12:0.54.0,org.apache.iceberg:iceberg-spark-runtime-3.3_2.12:1.2.0,software.amazon.awssdk:sts:2.20.18,software.amazon.awssdk:s3:2.20.18,software.amazon.awssdk:url-conne>
# use nessie;
# CREATE TABLE demo3 (id bigint, data string) ;
