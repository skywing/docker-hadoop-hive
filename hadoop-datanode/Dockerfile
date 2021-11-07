FROM hadoop-core:latest

LABEL platform="dev-hadoop-hive"

ENV HADOOP_HOME=/opt/hadoop

HEALTHCHECK CMD curl -f http://localhost:9864/ || exit 1

COPY run.sh /run.sh
RUN chmod a+x /run.sh

# # datanode ui
EXPOSE 9864

CMD ["/run.sh"]
