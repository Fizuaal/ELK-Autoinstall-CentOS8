cat > /etc/yum.repos.d/elasticstack.repo << EOL
[elasticstack]
name=Elastic repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOL

dnf update

dnf -y install elasticsearch

sed -i 's/#network.host: 0.0.0.0/network.host: 0.0.0.0/' /etc/elasticsearch/elasticsearch.yml

systemctl daemon-reload
systemctl enable --now elasticsearch

yum -y install kibana

systemctl enable --now kibana

firewall-cmd --add-port=5601/tcp --permanent

firewall-cmd --reload

yum -y install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel

yum -y install logstash
