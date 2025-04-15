#!/bin/bash

# Lưu trạng thái Zen Mode vào một file tạm
STATE_FILE="/tmp/sway_zen_mode"

# Lấy ID cửa sổ đang focus
FOCUSED_ID=$(swaymsg -t get_tree | grep -B 10 '"focused": true' | grep '"id":' | awk -F ': ' '{print $2}' | tr -d ',')

# Nếu không tìm thấy ID, thoát
if [ -z "$FOCUSED_ID" ]; then
  exit 1
fi

# Kiểm tra trạng thái Zen Mode
if [[ -f "$STATE_FILE" ]]; then
  # Thoát Zen Mode: Tắt floating, khôi phục viền, bỏ hiệu ứng mờ
  swaymsg "floating disable, border normal"
  swaymsg "[workspace=$WORKSPACE] opacity 1"
  rm "$STATE_FILE"
else
  # Vào Zen Mode: Bật floating, căn giữa, resize, thêm viền
  swaymsg "[con_id=$FOCUSED_ID] floating enable, move position center, resize set 59ppt 99ppt, border pixel 3"

  # Làm mờ tất cả cửa sổ
  swaymsg "[workspace=$WORKSPACE] opacity 0.3"

  # Giữ opacity cửa sổ Zen Mode là 1.0
  swaymsg "[con_id=$FOCUSED_ID] opacity 1.0"

  # Lưu trạng thái
  touch "$STATE_FILE"
fi
