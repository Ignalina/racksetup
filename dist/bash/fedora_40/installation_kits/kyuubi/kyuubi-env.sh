#!/usr/bin/env bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
# - JAVA_HOME               Java runtime to use. By default use "java" from PATH.
#
#
# - KYUUBI_CONF_DIR         Directory containing the Kyuubi configurations to use.
#                           (Default: $KYUUBI_HOME/conf)
# - KYUUBI_LOG_DIR          Directory for Kyuubi server-side logs.
#                           (Default: $KYUUBI_HOME/logs)
# - KYUUBI_PID_DIR          Directory stores the Kyuubi instance pid file.
#                           (Default: $KYUUBI_HOME/pid)
# - KYUUBI_MAX_LOG_FILES    Maximum number of Kyuubi server logs can rotate to.
#                           (Default: 5)
# - KYUUBI_JAVA_OPTS        JVM options for the Kyuubi server itself in the form "-Dx=y".
#                           (Default: none).
# - KYUUBI_CTL_JAVA_OPTS    JVM options for the Kyuubi ctl itself in the form "-Dx=y".
#                           (Default: none).
# - KYUUBI_BEELINE_OPTS     JVM options for the Kyuubi BeeLine in the form "-Dx=Y".
#                           (Default: none)
# - KYUUBI_NICENESS         The scheduling priority for Kyuubi server.
#                           (Default: 0)
# - KYUUBI_WORK_DIR_ROOT    Root directory for launching sql engine applications.
#                           (Default: $KYUUBI_HOME/work)
# - HADOOP_CONF_DIR         Directory containing the Hadoop / YARN configuration to use.
# - YARN_CONF_DIR           Directory containing the YARN configuration to use.
#
# - SPARK_HOME              Spark distribution which you would like to use in Kyuubi.
# - SPARK_CONF_DIR          Optional directory where the Spark configuration lives.
#                           (Default: $SPARK_HOME/conf)
# - FLINK_HOME              Flink distribution which you would like to use in Kyuubi.
# - FLINK_CONF_DIR          Optional directory where the Flink configuration lives.
#                           (Default: $FLINK_HOME/conf)
# - FLINK_HADOOP_CLASSPATH  Required Hadoop jars when you use the Kyuubi Flink engine.
# - HIVE_HOME               Hive distribution which you would like to use in Kyuubi.
# - HIVE_CONF_DIR           Optional directory where the Hive configuration lives.
#                           (Default: $HIVE_HOME/conf)
# - HIVE_HADOOP_CLASSPATH   Required Hadoop jars when you use the Kyuubi Hive engine.
#


## Examples ##

# export JAVA_HOME=/usr/jdk64/jdk1.8.0_152
export SPARK_HOME=/usr/lib/x14/spark/spark-3.5.3-bin-hadoop3
# export FLINK_HOME=/opt/flink
# export HIVE_HOME=/opt/hive
# export FLINK_HADOOP_CLASSPATH=/path/to/hadoop-client-runtime-3.3.2.jar:/path/to/hadoop-client-api-3.3.2.jar
# export HIVE_HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/common/lib/commons-collections-3.2.2.jar:${HADOOP_HOME}/share/hadoop/client/hadoop-client-runtime-3.1.0.jar:${HADOOP_HOME}/share/hadoop/client/hadoop-client-api-3.1.0.jar:${HADOOP_HOME}/share/hadoop/common/lib/htrace-core4-4.1.0-incubating.jar
# export HADOOP_CONF_DIR=/usr/ndp/current/mapreduce_client/conf
# export YARN_CONF_DIR=/usr/ndp/current/yarn/conf
# export KYUUBI_JAVA_OPTS="-Xmx10g -XX:MaxMetaspaceSize=512m -XX:MaxDirectMemorySize=1024m -XX:+UseG1GC -XX:+UseStringDeduplication -XX:+UnlockDiagnosticVMOptions -XX:+UseCondCardMark -XX:+UseGCOverheadLimit -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./logs -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintTenuringDistribution -verbose:gc -Xloggc:./logs/kyuubi-server-gc-%t.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=20M"
# export KYUUBI_BEELINE_OPTS="-Xmx2g -XX:+UseG1GC -XX:+UnlockDiagnosticVMOptions -XX:+UseCondCardMark"
