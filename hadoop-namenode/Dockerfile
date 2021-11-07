FROM hadoop-core:latest

LABEL platform="dev-hadoop-hive"

ENV HADOOP_HOME=/opt/hadoop

HEALTHCHECK CMD curl -f http://localhost:9870/ || exit 1

COPY run.sh /run.sh
RUN chmod a+x /run.sh

# namenode ui
EXPOSE 9870

CMD ["/run.sh"]
