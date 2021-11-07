FROM centos as base

LABEL platform="dev-hadoop-hive"

ARG TIMEZONE=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

RUN yum update -y
RUN yum install -y java-1.8.0-openjdk.x86_64
RUN yum install -y java-1.8.0-openjdk-devel.x86_64
RUN yum install -y nc
RUN yum install -y perl
RUN yum install -y wget

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
ENV PATH $JAVA_HOME/bin:$PATH


ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
