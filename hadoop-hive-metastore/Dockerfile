FROM hadoop-hive-base:latest

LABEL platform="dev-hadoop-hive"

COPY run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 9083

CMD ["/run.sh"]
