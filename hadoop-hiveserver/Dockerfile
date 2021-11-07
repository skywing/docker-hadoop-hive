FROM hadoop-hive-base:latest

LABEL platform="dev-hadoop-hive"

ENV TEST_DATA_DIR=/opt/test-data

COPY run.sh /run.sh
RUN chmod a+x /run.sh \
    && mkdir -pv ${TEST_DATA_DIR}

# Resolve the hive query class not found problem
RUN cp /opt/tez/lib/commons-collections4-4.1.jar /opt/hive/lib/commons-collections4-4.1.jar 

COPY data/array-test.csv ${TEST_DATA_DIR}
COPY data/array-test.sql ${TEST_DATA_DIR}
COPY data/data-type-test.csv ${TEST_DATA_DIR}
COPY data/data-type-test.sql ${TEST_DATA_DIR}
COPY data/date-time-test.csv ${TEST_DATA_DIR}
COPY data/date-time-test.sql ${TEST_DATA_DIR}
COPY data/map-test.csv ${TEST_DATA_DIR}
COPY data/map-test.sql ${TEST_DATA_DIR}
COPY data/struct-test.csv ${TEST_DATA_DIR}
COPY data/struct-test.sql ${TEST_DATA_DIR}

CMD ["/run.sh"]
