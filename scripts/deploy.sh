#!/bin/bash

APP_DIR=/home/ec2-user/app
JAVA_BIN=/usr/bin/java

echo "🚀 배포 시작"

JAR_NAME=$(ls $APP_DIR/*.jar | head -n 1)

if [ -z "$JAR_NAME" ]; then
  echo "❌ JAR 파일을 찾지 못함"
  exit 1
fi

echo "▶ 실행 JAR: $JAR_NAME"

PID=$(pgrep -f "$JAR_NAME")
if [ -n "$PID" ]; then
  echo "🔴 기존 프로세스 종료: $PID"
  kill -15 $PID
  sleep 5
fi

echo "🟢 서버 실행"
nohup $JAVA_BIN -jar $JAR_NAME > $APP_DIR/app.log 2>&1 &