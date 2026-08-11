
RCLONE_CONF="${RCLONE_CONF:-}"

if [ -n "$RCLONE_CONF" ]; then
  echo  "======================写入rclone配置========================\n"
  echo "$RCLONE_CONF" > ~/.config/rclone/rclone.conf
fi

if [ -n "$RCLONE_CONF" ]; then
  echo "##########同步备份############"
  # 为了防止不存在备份目录报错直接执行创建命令，如果存在也不会受影响
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
      sh /app/sync.sh restore
    fi
  elif [[ "$OUTPUT" == *"directory not found"* ]]; then
    echo "错误：文件夹不存在"
  else
    echo "错误：$OUTPUT"
  fi
else
    echo "没有检测到Rclone配置信息"
fi
