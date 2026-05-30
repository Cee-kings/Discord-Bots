FROM node:20-slim

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g pnpm

WORKDIR /app

COPY flag-quiz/ ./flag-quiz/
RUN cd flag-quiz && pnpm install --frozen-lockfile
RUN cd flag-quiz/artifacts/api-server && node ./build.mjs

COPY scramble/requirements.txt scramble/requirements.txt
RUN pip3 install -r scramble/requirements.txt --break-system-packages
COPY scramble/ ./scramble/

COPY start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
