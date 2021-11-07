####################################
#   Multi-stage build
#       1. build tez
#       2. build hive base
####################################

# Stage 1 - Build Tez

FROM hadoop-base:latest as tez-builder

LABEL platform="dev-hadoop-hive"

ARG TEZ_VERSION=0.9.2
ARG HADOOP_VERSION=2.10.1
ARG PROTOBUF_VERSION=2.5.0

RUN yum install -y autoconf automake libtool make unzip maven
RUN yum groupinstall -y "Development Tools"


RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-${PROTOBUF_VERSION}.tar.gz -O ./protobuf-${PROTOBUF_VERSION}.tar.gz

RUN tar -xvf protobuf-${PROTOBUF_VERSION}.tar.gz \
    && cd protobuf-${PROTOBUF_VERSION} \
    && ./configure --prefix=/usr \
    && make \
    && make check \
    && make install \
    && ldconfig


RUN wget https://dlcdn.apache.org/tez/${TEZ_VERSION}/apache-tez-${TEZ_VERSION}-src.tar.gz -O /opt/apache-tez-${TEZ_VERSION}-src.tar.gz
RUN tar -xvf /opt/apache-tez-${TEZ_VERSION}-src.tar.gz -C /opt \
    && mv /opt/apache-tez-${TEZ_VERSION}-src /opt/tez
RUN cd /opt/tez \
    && mvn clean package -Phadoop28 -Dhadoop.version=${HADOOP_VERSION} -Dprotobuf.version=${PROTOBUF_VERSION} -DskipTests=true -Dmaven.javadoc.skip=true -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true -Dmaven.wagon.http.ssl.ignore.validity.dates=true  --projects "!tez-ui" \
    && mkdir -pv /tmp/tez \
    && tar -xvf /opt/tez/tez-dist/target/tez-${TEZ_VERSION}-minimal.tar.gz -C /tmp/tez \
    && cp /opt/tez/tez-dist/target/tez-${TEZ_VERSION}-minimal.tar.gz /tmp/tez/tez-${TEZ_VERSION}-minimal.tar.gz


# Stage 2 - Build Hive base
FROM hadoop-core:latest

LABEL platform="dev-hadoop-hive"

ENV HIVE_HOME=/opt/hive
ENV PATH=${HIVE_HOME}/bin:$PATH
ENV HIVE_CONF_DIR=${HIVE_HOME}/conf
ENV TEZ_CONF_DIR=/etc/tez/conf
ENV TEZ_LIB_DIR=/opt/tez
ENV HADOOP_CLASSPATH="${TEZ_CONF_DIR}:${TEZ_LIB_DIR}/*:${TEZ_CONF_DIR}/lib/*"

ARG HIVE_VERSION=2.3.9
ARG HIVE_DOWNLOAD_DIR=/tmp/hive
ARG POSTGRESQL_JDBC_VERSION=42.2.23

RUN wget https://downloads.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz -O /tmp/hive.tar.gz

# Install Hive and PostgreSQL JDBC
RUN mkdir -pv ${HIVE_DOWNLOAD_DIR} \
    && mkdir -pv ${TEZ_CONF_DIR} \
    && mkdir -pv ${TEZ_LIB_DIR} \
    && mkdir -pv ${TEZ_LIB_DIR}/lib


RUN tar -xvf /tmp/hive.tar.gz -C ${HIVE_DOWNLOAD_DIR} --strip-components=1 \
    && mv -v ${HIVE_DOWNLOAD_DIR} /opt \
    && rm -rfv /tmp/hive.tar.gz \
    && rm -rfv ${HIVE_HOME}/lib/postgresql-*.jre*.jar

RUN wget https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_JDBC_VERSION}.jar -O ${HIVE_HOME}/lib/postgresql-jdbc.jar

COPY --from=tez-builder /tmp/tez/*.jar ${TEZ_LIB_DIR}/
COPY --from=tez-builder /tmp/tez/lib/*.jar ${TEZ_LIB_DIR}/lib/
COPY --from=tez-builder /tmp/tez/*.gz ${TEZ_LIB_DIR}/

# Custom configuration goes here
ADD conf/hive-site.xml ${HIVE_CONF_DIR}
ADD conf/metastore-site.xml ${HIVE_CONF_DIR}
ADD conf/metastore-log4j2.properties ${HIVE_CONF_DIR}
ADD conf/beeline-log4j2.properties ${HIVE_CONF_DIR}
ADD conf/hive-exec-log4j2.properties ${HIVE_CONF_DIR}
ADD conf/hive-log4j2.properties ${HIVE_CONF_DIR}
ADD conf/llap-daemon-log4j2.properties ${HIVE_CONF_DIR}
ADD conf/llap-cli-log4j2.properties ${HIVE_CONF_DIR}
ADD conf/tez-site.xml ${TEZ_CONF_DIR}

EXPOSE 10000
EXPOSE 10002
