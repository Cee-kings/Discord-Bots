#!/bin/bash
set -e

echo "Starting Flag-Quiz-Bot..."
cd /app/flag-quiz/artifacts/api-server && node --enable-source-maps ./dist/index.mjs &

echo "Starting Scramble-bot..."
cd /app/scramble && python3 bot.py &

wait -n
echo "A bot process exited. Stopping container."
exit 1
