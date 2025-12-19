#!/bin/bash

APP_DIR=/home/ec2-user/app
JAR_NAME=$(ls $APP_DIR/build/libs/*.jar | head -n 1)

echo "배포 시작"

# 기존 실행 중인 앱 종료
PID=$(pgrep -f java)
if [ -n "$PID" ]; then
  kill -15 $PID
  sleep 5
fi

# 새 앱 실행
nohup java -jar $JAR_NAME > app.log 2>&1 &
# ///