#!/bin/bash

APP_DIR=/home/ec2-user/app
JAR_NAME=$(find $APP_DIR -name "*.jar" | head -n 1)

echo "Using jar: $JAR_NAME"

PID=$(pgrep -f java)
if [ -n "$PID" ]; then
  kill -15 $PID
  sleep 5
fi

nohup java -jar $JAR_NAME > $APP_DIR/app.log 2>&1 &