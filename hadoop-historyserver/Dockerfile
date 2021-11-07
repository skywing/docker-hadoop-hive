FROM hadoop-core:latest

LABEL platform="dev-hadoop-hive"

ENV HIVE_HOME=/opt/hive

HEALTHCHECK CMD curl -f http://localhost:8188/ || exit 1

COPY run.sh /run.sh
RUN chmod a+x /run.sh

# history UI
EXPOSE 8188

CMD ["/run.sh"]
