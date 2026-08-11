FROM rclone/rclone:latest AS rclone
FROM docker.io/nikolaik/python-nodejs:python3.11-nodejs23
ENV REMOTE_FOLDER="huggingface:/hermes"


# 2. 基础依赖
RUN apt-get update && apt-get install -y \
    ripgrep ffmpeg git nginx lsof build-essential psmisc \
    && rm -rf /var/lib/apt/lists/*

#RUN curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
RUN pip install --no-cache-dir git+https://github.com/NousResearch/hermes-agent.git

COPY --from=rclone /usr/local/bin/rclone /usr/bin/rclone
COPY entrypoint.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf
COPY apps.conf /etc/nginx/conf.d/apps.conf

RUN chmod +x /entrypoint.sh

RUN npm install -g pnpm pm2 hermes-web-ui

ENV PATH=/root/.local/bin:$PATH

WORKDIR /app
COPY sync.sh .
RUN chmod +x sync.sh

RUN rclone config -h


EXPOSE 5700

ENTRYPOINT ["/entrypoint.sh"]


