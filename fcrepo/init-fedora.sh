#!/bin/ash

#set -vx

source /fedora-env.sh

env | sort -u

if [ ! -d ${FCREPO_DATA_DIR} ] ;
then
  mkdir ${FCREPO_DATA_DIR}
fi

is_empty ${FCREPO_DATA_DIR}

if [ $? -eq 0 ] ;
then
  echo "Initializing Fedora..."
  apk -q --no-progress add curl
  java -jar start.jar -Djetty.http.port=8080 2>/dev/null 1>/dev/null &

  fedora_up 30

  if [ $? -ne 0 ] ;
  then
    echo "Exiting."
    exit 1;
  fi

  sleep 2
  apk -q del curl
  killall java
fi

java -jar start.jar -Djetty.http.port=${JETTY_PORT}