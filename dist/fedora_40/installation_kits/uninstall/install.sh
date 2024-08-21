systemctl stop ranger
systemctl stop solr
systemctl stop zk

rm -rf /var/lib/x14/zookeeper
rm -rf /var/lib/x14/solr
rm -rf /var/lib/x14/ranger

rm -rf /usr/lib/x14/zookeeper
rm -rf /usr/lib/x14/solr
rm -rf /usr/lib/x14/ranger

