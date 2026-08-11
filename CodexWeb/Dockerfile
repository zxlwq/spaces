FROM rclone/rclone:latest AS rclone
FROM ghcr.io/ykxvk8yl5l/codex-web/codex-web:latest

ENV REMOTE_FOLDER="huggingface:/codex-web"
COPY --from=rclone /usr/local/bin/rclone /usr/bin/rclone
RUN rclone config -h
COPY restore.sh /restore.sh
COPY sync.sh /app/sync.sh
RUN chmod +x /app/sync.sh

RUN sed -i '3r /restore.sh' /usr/local/bin/codex-web-start \
  && chmod +x /usr/local/bin/codex-web-start
