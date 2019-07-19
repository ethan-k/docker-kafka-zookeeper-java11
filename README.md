# Docker Kafka Zookeeper ![Build Status](https://travis-ci.org/hey-johnnypark/docker-kafka-zookeeper.svg?branch=master)

Docker image for Kafka message broker including Zookeeper

## Build

```
$ docker build .
[...]
Successfully built 9b382d40bccc
```

## Run container

```
docker run -p 2181:2181 -p 9092:9092 -e ADVERTISED_HOST=localhost 9b382d40bccc
```

## Test

Run Kafka console consumer

```
kafka-console-consumer --bootstrap-server localhost:9092 --topic test
```

Run Kafka console producer

```
kafka-console-producer --broker-list localhost:9092 --topic test
test1
test2
test3
```

Verify that messages have been received in console consumer

```
test1
test2
test3
```

Options

```
LOG_FLUSH_INTERVAL_MESSAGES
LOG_FLUSH_INTERVAL_MS
ADVERTISED_LISTENERS
LISTENERS
NUM_PARTITIONS
ADVERTISED_PORT
ADVERTISED_HOST
AUTO_CREATE_TOPICS
```

## Get from Dockerhub

https://hub.docker.com/r/johnnypark/kafka-zookeeper/

## Credits

Originally cloned and inspired by https://github.com/spotify/docker-kafka
