#!/bin/bash
# 🎭 Soul Switcher - 定时任务安装脚本

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SWITCH_SCRIPT="$SCRIPT_DIR/switch-soul.sh"
CRON_TIME="15 10 * * *"  # 默认 10:15

echo "🎭 Soul Switcher - 定时任务安装"
echo "═══════════════════════════════════════"
echo ""

# 检查脚本是否存在
if [[ ! -f "$SWITCH_SCRIPT" ]]; then
    echo "❌ 错误: 找不到切换脚本 $SWITCH_SCRIPT"
    exit 1
fi

# 添加执行权限
chmod +x "$SWITCH_SCRIPT"
echo "✓ 已添加执行权限"

# 创建 crontab 条目
CRON_JOB="$CRON_TIME $SWITCH_SCRIPT # Soul Switcher - 每日自动切换"

# 检查是否已存在
crontab -l 2>/dev/null | grep -q "soul-switcher" && {
    echo "⚠️  检测到已存在 Soul Switcher 定时任务"
    echo ""
    read -p "是否重新安装? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "已取消"
        exit 0
    fi
    # 删除旧的
    crontab -l 2>/dev/null | grep -v "soul-switcher" | crontab -
}

# 安装新的定时任务
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo ""
echo "✅ 定时任务已安装！"
echo ""
echo "───────────────────────────────────────"
echo "执行时间: 每天 10:15 AM"
echo "执行脚本: $SWITCH_SCRIPT"
echo "───────────────────────────────────────"
echo ""
echo "查看定时任务:"
echo "  crontab -l | grep soul-switcher"
echo ""
echo "手动测试运行:"
echo "  $SWITCH_SCRIPT --preview"
echo ""
echo "═══════════════════════════════════════"
