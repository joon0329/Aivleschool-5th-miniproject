#!/bin/bash

APP_DIR=/home/ec2-user/app
JAR_NAME=$(ls $APP_DIR/*.jar | head -n 1)

echo "배포 시작"
echo "JAR = $JAR_NAME"

if [ -z "$JAR_NAME" ]; then
  echo "❌ JAR 파일을 찾지 못함"
  exit 1
fi

PID=$(pgrep -f java)
if [ -n "$PID" ]; then
  echo "기존 프로세스 종료: $PID"
  kill -15 $PID
  sleep 5
fi

nohup java -jar $JAR_NAME > $APP_DIR/app.log 2>&1 &