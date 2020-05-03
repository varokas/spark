#!/bin/bash
if [[ -z "${SPARK_WORKER_LOG}" ]]; then
  SPARK_WORKER_LOG="/log"
fi

if [[ "${SPARK_MODE}" == "worker" && -z "${SPARK_MASTER_URL}" ]]; then
  echo "Unspecified SPARK_MASTER_URL"
  exit 1
fi


### Configuration Environments
### https://spark.apache.org/docs/latest/spark-standalone.html

# SPARK_MASTER_HOST, SPARK_MASTER_PORT, SPARK_MASTER_WEBUI_PORT
# SPARK_WORKER_PORT

if [ "$SPARK_MODE" == "master" ]; then
  /spark/bin/spark-class org.apache.spark.deploy.master.Master
elif [ "$SPARK_MODE" == "worker" ]; then
  /spark/bin/spark-class org.apache.spark.deploy.worker.Worker $SPARK_MASTER_URL
else 
  echo "SPARK_MODE not recognized (should be master or worker): $SPARK_MODE"
fi
