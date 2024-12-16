pushd /tmp
yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel

wget https://www.apache.org/dyn/closer.lua/lucene/solr/8.11.2/solr-8.11.2.tgz?action=download -O solr.tar.gz
mkdir -p /usr/lib/x14/solr/solr-8.11.2
mkdir -p /var/lib/x14/solr/solr-8.11.2/data

tar -zxf solr.tar.gz -C  /usr/lib/x14/solr
popd


pushd /usr/lib/x14/solr/solr-8.11.2

echo "SOLR_PID_DIR=\"/var/lib/x14/solr/solr-8.11.2\"
SOLR_INCLUDE=\"/usr/lib/x14/solr/solr-8.11.2/solr.in.sh\"
SOLR_HOME=\"/var/lib/x14/solr/solr-8.11.2/data\"
SOLR_INSTALL_DIR=\"/usr/lib/x14/solr/solr-8.11.2\"
LOG4J_PROPS=\"/var/lib/x14/solr/solr-8.11.2/log4j2.xml\"
SOLR_LOGS_DIR=\"/var/lib/x14/solr/solr-8.11.2/logs\"
SOLR_PORT=\"8983\"
JAVA_HOME=\"/usr/lib/jvm/java-1.8.0-openjdk\"
PATH=\"/usr/lib/jvm/java-1.8.0-openjdk/bin:$PATH\"
ZK_HOST=\"${brokkr_ethext_ip[1]}:2181,${brokkr_ethext_ip[2]}:2181,${brokkr_ethext_ip[3]}:2181/solr\"
" >> "/usr/lib/x14/solr/solr-8.11.2/bin/solr.in.sh"
popd


adduser -m -r -g x14 solr
chown -R solr:x14 /var/lib/x14/solr
chown -R solr:x14 /usr/lib/x14/solr

if [[ ${nr} -eq 1 ]]
then 
    echo "I AM MASTER_HOST EXTETH=${brokkr_exteth_ip[1]}"
# upload solr.xml in choor /solr
    server/scripts/cloud-scripts/zkcli.sh -zkhost ${brokkr_ethext_ip[1]}:2181,${brokkr_ethext_ip[2]}:2181,${brokkr_ethext_ip[3]}:2181/solr -cmd bootstrap -solrhome server/solr
    bin/solr zk cp  server/solr/solr.xml  zk:/solr.xml -z ${brokkr_ethext_ip[1]}:2181,${brokkr_ethext_ip[2]}:2181,${brokkr_ethext_ip[3]}:2181/solr
fi

cp solr.service /etc/systemd/system/
systemctl enable solr
systemctl start solr.service


#
# If we are the first machine configuure solr cloud once enough machines are up.
#

mesh_machine_nr
nr=$?





./solr start -c -m 1g -z "${brokkr_ethext_ip[1]}:2181,${brokkr_ethext_ip[2]}:2181,${brokkr_ethext_ip[3]}:2181/solr"
