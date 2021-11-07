FROM hadoop-base:latest

LABEL platform="dev-hadoop-hive"

ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH=$HADOOP_HOME/bin/:$PATH

ARG HADOOP_VERSION=2.10.1
ARG TMP_DIR=/tmp/hadoop

RUN mkdir -pv ${TMP_DIR} \
    && mkdir -pv ${HADOOP_HOME}

RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -P /tmp/hadoop


RUN tar -xvf ${TMP_DIR}/hadoop-${HADOOP_VERSION}.tar.gz -C ${HADOOP_HOME} --strip-components=1 \
    && rm -rfv ${TMP_DIR}/hadoop-${HADOOP_VERSION}.tar.gz \
    && rm -rf ${HADOOP_HOME}/share/doc \
    && cd ${HADOOP_HOME} \
    && tar -zcvf ${TMP_DIR}/hadoop.tar.gz . \
    && cp ${TMP_DIR}/hadoop.tar.gz ${HADOOP_HOME} \
    && rm -rvf ${TMP_DIR}/hadoop.tar.gz


# Custom configuration goes here
COPY ./conf/httpfs-log4j.properties ${HADOOP_CONF_DIR}
COPY ./conf/kms-log4j.properties ${HADOOP_CONF_DIR}
COPY ./conf/log4j.properties ${HADOOP_CONF_DIR}
COPY ./conf/log4j-timeline.properties ${HADOOP_CONF_DIR}/timelineserver-config/log4j.properties
COPY ./conf/log4j-nodemanager.properties ${HADOOP_CONF_DIR}/nm-config/log4j.properties
COPY ./conf/log4j-resourcemanager.properties ${HADOOP_CONF_DIR}/rm-config/log4j.properties
COPY ./conf/logging.properties ${JAVA_HOME}/jre/lib
