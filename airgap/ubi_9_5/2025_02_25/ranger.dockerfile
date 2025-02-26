ARG UV_INDEX_URL=NONE
FROM localhost/ignalina/ubi_9_5_maker_base_uv_python_311:v1


#
# Create output folders
#
USER root
RUN dnf -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel maven gcc bzip2 fontconfig diffutils bc tzdata git
RUN wget https://downloads.apache.org/ranger/2.5.0/apache-ranger-2.5.0.tar.gz;tar -zxf apache-ranger-2.5.0.tar.gz;
#RUN cd apache-ranger-2.5.0;export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk;export PATH=$JAVA_HOME/bin:$PATH; export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m";mvn clean compile package install -Dmaven.repo.remote=https://repo1.maven.org/maven2,https://packages.jetbrains.team/maven/p/ij/intellij-dependencies -DskipJSTests -DskipTests -Pranger-admin
RUN cd apache-ranger-2.5.0;export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk;export PATH=$JAVA_HOME/bin:$PATH; export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m";mvn clean compile package install -DskipJSTests -DskipTests -Pranger-admin -am

