FROM node:20-slim

RUN apt-get update && apt-get install -y \
    python3 python3-pip git \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g pnpm

WORKDIR /app

# cache-bust: 2026-06-20-1
RUN git clone https://github.com/Cee-kings/Flag-Quiz-Bot flag-quiz && echo "build-2026-06-25-1"
RUN git clone https://github.com/Cee-kings/Scramble-bot scramble && echo "build-2026-06-20-1"
RUN cd flag-quiz && pnpm install --frozen-lockfile
RUN cd flag-quiz/artifacts/api-server && node ./build.mjs

RUN pip3 install -r scramble/requirements.txt --break-system-packages

COPY start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
