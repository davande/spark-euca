#!/bin/bash

pushd /root

echo "Setting up Kafka..."

tar -xzf kafka_${KAFKA_SCALA_BINARY}.tgz
rm kafka_${KAFKA_SCALA_BINARY}.tgz
mv kafka_${KAFKA_SCALA_BINARY} kafka
cd kafka

cp /etc/kafka/config/server.properties ./config/

#add command to init.d
cp /root/spark-euca/kafka/kafka-server.sh ./bin
cp /root/spark-euca/kafka/kafka-restart.sh ./bin

chmod +x bin/kafka-server.sh
ln -s /root/kafka/bin/kafka-server.sh /etc/init.d/kafka-server
update-rc.d kafka-server defaults

#add restart command to init.d with lower priority - avoids issue with starting zoo first
#TODO: Might not needed after the new zoo setup on 12/23/2014
chmod +x bin/kafka-restart.sh
ln -s /root/kafka/bin/kafka-restart.sh /etc/init.d/kafka-restart
update-rc.d kafka-restart defaults 91

#creating log dir
mkdir /mnt/kafka-logs/

popd

