---
title: Codex Web
emoji: 📊
colorFrom: green
colorTo: pink
sdk: docker
pinned: false
app_port: 5173
---

Check out the configuration reference at https://huggingface.co/docs/hub/spaces-config-reference   
# Space secrets(Private)说明:   
RCLONE_CONF:rclone配置内容

## 备份脚本请使用backup.sh
## 由于使用编程语言不一样rust版本的数据目录和ts版的不一样
rust:/app/data   
ts:/app/apps/api/data   
### 如需从ts迁移到rust版，在迁移前执行：
```
rclone copy $REMOTE_FOLDER/app/apps/api/data $REMOTE_FOLDER/app/data
```
