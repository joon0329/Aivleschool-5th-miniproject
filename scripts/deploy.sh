#!/bin/bash

APP_DIR=/home/ec2-user/app
JAR_NAME=$(ls $APP_DIR/*.jar | head -n 1)

echo "배포 시작"

PID=$(pgrep -f java)
if [ -n "$PID" ]; then
  kill -15 $PID
  sleep 5
fi

nohup java -jar $JAR_NAME > $APP_DIR/app.log 2>&1 &
## test