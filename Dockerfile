FROM adoptopenjdk/openjdk11:alpine

RUN apk add --update supervisor bash

ENV ZOOKEEPER_VERSION 3.4.13
ENV ZOOKEEPER_HOME /opt/zookeeper-"$ZOOKEEPER_VERSION"
ENV GRADLE_VERSION 5.4.1
ENV GRADLE_HOME /opt/gradle/gradle-"$GRADLE_VERSION"

# Gradle
RUN mkdir /opt/gradle
RUN wget -q https://services.gradle.org/distributions/gradle-"$GRADLE_VERSION"-bin.zip -O /opt/gradle/gradle-"$GRADLE_VERSION"-bin.zip
RUN unzip -d /opt/gradle /opt/gradle/gradle-"$GRADLE_VERSION"-bin.zip

# Zookeeper

RUN wget http://archive.apache.org/dist/zookeeper/zookeeper-"$ZOOKEEPER_VERSION"/zookeeper-"$ZOOKEEPER_VERSION".tar.gz -O /tmp/zookeeper-"$ZOOKEEPER_VERSION".tgz
RUN ls -l /tmp/zookeeper-"$ZOOKEEPER_VERSION".tgz
RUN tar xfz /tmp/zookeeper-"$ZOOKEEPER_VERSION".tgz -C /opt && rm /tmp/zookeeper-"$ZOOKEEPER_VERSION".tgz
ADD assets/conf/zoo.cfg $ZOOKEEPER_HOME/conf

# Kafka

ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 2.2.1
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"
ENV KAFKA_BIN "$KAFKA_HOME"/bin
ENV KAFKA_DOWNLOAD_URL https://archive.apache.org/dist/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz
ENV PATH="${KAFKA_BIN}:${PATH}"

RUN wget -q $KAFKA_DOWNLOAD_URL -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz
RUN tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

ADD assets/scripts/start-kafka.sh /usr/bin/start-kafka.sh
ADD assets/scripts/start-zookeeper.sh /usr/bin/start-zookeeper.sh

# Supervisor config
ADD assets/supervisor/kafka.ini assets/supervisor/zookeeper.ini /etc/supervisor.d/

# 2181 is zookeeper, 9092 is kafka
EXPOSE 2181 9092

CMD ["supervisord", "-n"]

