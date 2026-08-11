FROM rclone/rclone:latest AS rclone
FROM louislam/uptime-kuma:2

ENV REMOTE_FOLDER="huggingface:/uptime"

COPY --from=rclone /usr/local/bin/rclone /usr/bin/rclone
COPY patch-backup.js /app/server/patch-backup.js
COPY kuma-backup.sh /root/kuma-backup.sh
RUN chmod a+x /root/kuma-backup.sh
RUN rclone config -h

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 启动时自动 preload
ENV NODE_OPTIONS="-r /app/server/patch-backup.js"

EXPOSE 3001
ENTRYPOINT ["/entrypoint.sh"]