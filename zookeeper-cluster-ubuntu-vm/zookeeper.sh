#!/bin/bash
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz"
tar -xvf jdk-8*
mkdir /usr/lib/jvm
mv ./jdk1.8* /usr/lib/jvm/jdk1.8.0
update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0/bin/java" 1
update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0/bin/javac" 1
update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0/bin/javaws" 1
chmod a+x /usr/bin/java
chmod a+x /usr/bin/javac
chmod a+x /usr/bin/javaws

cd /usr/local

wget "https://archive.apache.org/dist/zookeeper/zookeeper-3.4.8/zookeeper-3.4.8.tar.gz"
tar -xvf "zookeeper-3.4.8.tar.gz"

touch zookeeper-3.4.8/conf/zoo.cfg

echo "tickTime=2000" >> zookeeper-3.4.8/conf/zoo.cfg
echo "dataDir=/var/lib/zookeeper" >> zookeeper-3.4.8/conf/zoo.cfg
echo "clientPort=2181" >> zookeeper-3.4.8/conf/zoo.cfg
echo "initLimit=5" >> zookeeper-3.4.8/conf/zoo.cfg
echo "syncLimit=2" >> zookeeper-3.4.8/conf/zoo.cfg

ADRR=(${2//,/ })
echo $ADRR
i=0
while [ $i -lt ${#ADRR[@]} ]
do
    echo "server.$(($i+1))=${ADRR[$i]}:2888:3888" >> zookeeper-3.4.8/conf/zoo.cfg
    i=$(($i+1))
done

mkdir -p /var/lib/zookeeper

echo $(($1+1)) >> /var/lib/zookeeper/myid

zookeeper-3.4.8/bin/zkServer.sh start
