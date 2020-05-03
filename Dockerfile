FROM ubuntu:18.04

ENV SPARK_VERSION=2.4.5
ENV HADOOP_VERSION=2.7
ENV SPARK_HOME=/spark

RUN apt-get update \ 
    && apt-get install -y openjdk-8-jdk \
    && apt-get install -y curl

RUN curl -O https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME} \
    && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz 

RUN apt install -y python3-pip 

COPY start.sh /
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]

# SPARK_MODE = (master,worker)
# SPARK_MASTER_URL = spark://<master_ip>:<master_port> (when SPARK_MODE = worker)

# other envs: https://spark.apache.org/docs/latest/spark-standalone.html
