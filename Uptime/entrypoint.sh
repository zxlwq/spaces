#!/bin/bash

echo -e "======================写入rclone配置========================\n"
echo "$RCLONE_CONF" > ~/.config/rclone/rclone.conf


if [ -n "$RCLONE_CONF" ]; then
  echo "##########同步备份############"
  # 为了防止不存在目录报错
  rclone mkdir $REMOTE_FOLDER
  # 使用 rclone ls 命令列出文件夹内容，将输出和错误分别捕获
  OUTPUT=$(rclone ls "$REMOTE_FOLDER" 2>&1)
  # 获取 rclone 命令的退出状态码
  EXIT_CODE=$?
  #echo "rclone退出代码:$EXIT_CODE"
  # 判断退出状态码
  if [ $EXIT_CODE -eq 0 ]; then
    # rclone 命令成功执行，检查文件夹是否为空
    if [ -z "$OUTPUT" ]; then
      #为空不处理
      echo "初次安装"
    else
        echo "远程文件夹不为空开始还原"
        rclone copy "$REMOTE_FOLDER" "/app/data" -P --create-empty-src-dirs
        echo "恢复完成."   
    fi
  elif [[ "$OUTPUT" == *"directory not found"* ]]; then
    echo "错误：文件夹不存在"
  else
    echo "错误：$OUTPUT"
  fi
else
    echo "没有检测到Rclone配置信息"
fi

# 启动 Uptime Kuma
exec node server/server.js