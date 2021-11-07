FROM hadoop-core:latest

LABEL platform="dev-hadoop-hive"

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

COPY run.sh /run.sh
RUN chmod a+x /run.sh

# node manager UI
EXPOSE 8042

CMD ["/run.sh"]
