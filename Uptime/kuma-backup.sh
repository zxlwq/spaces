#!/bin/bash


CONF_DIR="/root/.config/rclone"
CONF_FILE="$CONF_DIR/rclone.conf"


backup() {
    echo "=== 开始备份 ==="
    mkdir -p /tmp/kuma-backup
    cp -a "/app/data" "/tmp/kuma-backup"
    rm -f "/tmp/kuma-backup/kuma.db"
    rm -f "/tmp/kuma-backup/kuma.db-wal"
    rm -f "/tmp/kuma-backup/kuma.db-shm"
    sqlite3 /app/data/kuma.db ".backup /tmp/kuma-backup/kuma.db"
    rclone copy /tmp/kuma-backup $REMOTE_FOLDER -P
    rm -rf /tmp/kuma-backup
}


if [ -n "$RCLONE_CONF" ]; then
    # 如果配置文件不存在
    if [ ! -f "$CONF_FILE" ]; then
        printf "%s\n" "$RCLONE_CONF" > "$CONF_FILE"
        echo "Created $CONF_FILE from \$RCLONE_CONF"
        sleep 1s
    fi
    backup
else
    echo "RCLONE_CONF is empty" 
fi


#whoami >> /root/backup.txt
# echo "$(date '+%Y-%m-%d %H:%M:%S') Backup Triggered" >> /root/backup.txt