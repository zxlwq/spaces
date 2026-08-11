---
title: Hermes
emoji: 🤖
colorFrom: green
colorTo: blue
sdk: docker
pinned: false
app_port: 5700
short_description: Hermes
---

Check out the configuration reference at https://huggingface.co/docs/hub/spaces-config-reference   
Secrets：   
RCLONE_CONF:rclone配置内容    
AUTH_TOKEN:登陆验证Token   

# 目前最新代码default用户的网关无法运行成功，暂时解决办法：用户-创建配置-从当前配置克隆，然后切换到新用户使用。

# 关于备份可以让AI建立定时任务执行以下代码
```
bash /app/sync.sh backup
```
## 备份文件要注意 sync.sh里的文件夹要以/结尾

