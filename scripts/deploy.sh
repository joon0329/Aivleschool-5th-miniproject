# scripts/deploy.sh
#!/bin/bash
set -e

APP_DIR=/home/ec2-user/app
JAR_NAME=$(ls $APP_DIR/build/libs/*.jar | head -n 1)

PID=$(pgrep -f java || true)
if [ -n "$PID" ]; then
  kill -15 $PID
  sleep 5
fi

nohup java -jar "$JAR_NAME" > "$APP_DIR/app.log" 2>&1 &