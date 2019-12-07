# Instalação do cluster Kafka



## Clone repo

## Install Docker

```
wget https://raw.githubusercontent.com/allanbatista/infnet-kafka/master/scripts/docker-install.sh && \
chmod +x docker-install.sh && \
sudo ./docker-install.sh
```

## Zookeper

**install zookeper1**

```
sudo docker run -d --name=zookeeper --restart=unless-stopped -p 2181:2181 -p 3888:3888 -p 2888:2888 -p 8080:8080 \
           -e ZOO_MY_ID=1 -e ZOO_SERVERS="server.1=0.0.0.0:2888:3888;2181 server.2=zoo2.infnet.in:2888:3888;2181 server.3=zoo3.infnet.in:2888:3888;2181" \
           zookeeper
```

**install zookeper2**

```
sudo docker run -d --name=zookzookeepereper --restart=unless-stopped -p 2181:2181 -p 3888:3888 -p 2888:2888 -p 8080:8080 \
           -e ZOO_MY_ID=2 -e ZOO_SERVERS="server.1=zoo1.infnet.in:2888:3888;2181 server.2=0.0.0.0:2888:3888;2181 server.3=zoo3.infnet.in:2888:3888;2181" \
           zookeeper
```

**install zookeper3**

```
sudo docker run -d --name=zookeeper --restart=unless-stopped -p 2181:2181 -p 3888:3888 -p 2888:2888 -p 8080:8080 \
           -e ZOO_MY_ID=3 -e ZOO_SERVERS="server.1=zoo1.infnet.in:2888:3888;2181 server.2=zoo2.infnet.in:2888:3888;2181 server.3=0.0.0.0:2888:3888;2181" \
           zookeeper
```

## Kafka


**install kafka1**

```
export KAFKA_LOG_DIR=/kafka/log
sudo mkdir -p ${KAFKA_LOG_DIR}
sudo docker run -d --name=kafka --restart=unless-stopped -p 9092:9092 \
                -e kafka.broker.id=1 \
                -e kafka.zookeeper.connect="zoo1.infnet.in:2181,zoo2.infnet.in:2181,zoo3.infnet.in:2181" \
                -e kafka.advertised.listeners="PLAINTEXT://kafka1.infnet.in:9092" \
                -e kafka.num.partitions=3 \
                -e kafka.offsets.topic.replication.factor=3 \
                -e KAFKA_HEAP_OPTS="-Xmx512M -Xms128M" \
                -v ${KAFKA_LOG_DIR}:/kafka/log \
                allanbatista/kafka:latest
```

**install kafka2**

```
export KAFKA_LOG_DIR=/kafka/log
sudo mkdir -p ${KAFKA_LOG_DIR}
sudo docker run --name=kafka -d -p 9092:9092 \
                -e kafka.broker.id=2 \
                -e kafka.zookeeper.connect="zoo1.infnet.in:2181,zoo2.infnet.in:2181,zoo3.infnet.in:2181" \
                -e kafka.advertised.listeners="PLAINTEXT://kafka2.infnet.in:9092" \
                -e kafka.num.partitions=3 \
                -e kafka.offsets.topic.replication.factor=3 \
                -e KAFKA_HEAP_OPTS="-Xmx512M -Xms128M" \
                allanbatista/kafka:latest
```

**install kafka3**

```
export KAFKA_LOG_DIR=/kafka/log
sudo mkdir -p ${KAFKA_LOG_DIR}
sudo docker run --name=kafka -d -p 9092:9092 \
                -e kafka.broker.id=3 \
                -e kafka.zookeeper.connect="zoo1.infnet.in:2181,zoo2.infnet.in:2181,zoo3.infnet.in:2181" \
                -e kafka.advertised.listeners="PLAINTEXT://kafka3.infnet.in:9092" \
                -e kafka.num.partitions=3 \
                -e kafka.offsets.topic.replication.factor=3 \
                -e KAFKA_HEAP_OPTS="-Xmx512M -Xms128M" \
                allanbatista/kafka:latest
```


**install kafka4**

```
export KAFKA_LOG_DIR=/kafka/log
sudo mkdir -p ${KAFKA_LOG_DIR}
sudo docker run --name=kafka -d -p 9092:9092 \
                -e kafka.broker.id=4 \
                -e kafka.zookeeper.connect="zoo1.infnet.in:2181,zoo2.infnet.in:2181,zoo3.infnet.in:2181" \
                -e kafka.advertised.listeners="PLAINTEXT://kafka4.infnet.in:9092" \
                -e kafka.num.partitions=3 \
                -e kafka.offsets.topic.replication.factor=3 \
                -e KAFKA_HEAP_OPTS="-Xmx512M -Xms128M" \
                allanbatista/kafka:latest
```


```
# create a topic example
sudo docker exec kafka kafka-topics.sh --create --zookeeper=zoo1.infnet.in --topic example --partitions=3 --replication-factor=3

# list
sudo docker exec kafka sh bin/kafka-topics.sh --list --zookeeper=zoo1.infnet.in

# consumer example
sudo docker exec kafka sh kafka-console-consumer.sh --topic example --bootstrap-server=kafka1.infnet.in:9092,kafka2.infnet.in:9092,kafka3.infnet.in:9092,kafka4.infnet.in:9092

# producer console
sudo docker exec kafka sh kafka-console-producer.sh --topic example --broker-list=kafka1.infnet.in:9092,kafka2.infnet.in:9092,kafka3.infnet.in:9092,kafka4.infnet.in:9092
```