#!/bin/bash

APP_DIR=/home/ec2-user/app

echo "🚀 배포 시작"

# bootJar만 선택 (plain.jar 제외)
JAR_NAME=$(find "$APP_DIR" -type f -name "*.jar" \
  ! -name "*-plain.jar" \
  ! -name "gradle-wrapper.jar" \
  | head -n 1)

echo "JAR = $JAR_NAME"

if [ -z "$JAR_NAME" ]; then
  echo "❌ 실행 가능한 JAR 파일을 찾지 못함"
  exit 1
fi

PID=$(pgrep -f java)
if [ -n "$PID" ]; then
  echo "기존 프로세스 종료: $PID"
  kill -15 $PID
  sleep 5
fi

nohup java -jar "$JAR_NAME" > "$APP_DIR/app.log" 2>&1 &