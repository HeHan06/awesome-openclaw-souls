#!/bin/bash
# 🎭 Soul Switcher - 每日自动切换 Soul 脚本
# 每天早上 10:15 执行，切换 Soul 并发送问候

set -e

# 配置路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REFERENCE_DIR="$SCRIPT_DIR/../reference"
CONFIG_FILE="$REFERENCE_DIR/config.yaml"
SOULS_DIR="$REFERENCE_DIR/souls"
OPENCLAW_CONFIG_DIR="${HOME}/.openclaw"
SOUL_TARGET="${HOME}/.openclaw/workspace/SOUL.md"
LOG_FILE="$OPENCLAW_CONFIG_DIR/soul-switcher.log"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# 日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# 获取今天的星期几 (0=周日, 6=周六)
get_today_weekday() {
    date +%w
}

# 获取 Soul 数量
get_souls_count() {
    ls -1 "$SOULS_DIR"/*.md 2>/dev/null | wc -l
}

# 从配置中获取信息（支持 yq 和手动解析）
get_soul_info() {
    local field="$1"
    local weekday="$2"

    if command -v yq &> /dev/null; then
        yq eval ".souls_pool[] | select(.weekday == $weekday) | .$field" "$CONFIG_FILE" 2>/dev/null | tr -d '"'
    else
        awk "/weekday: $weekday/{flag=1} flag && /$field:/{print \$2; exit}" "$CONFIG_FILE" | tr -d '"'
    fi
}

get_soul_file() {
    local weekday=$1
    local filename
    filename=$(get_soul_info "file" "$weekday")
    echo "$SOULS_DIR/$(basename "$filename")"
}

get_soul_name() { get_soul_info "name" "$1"; }
get_soul_description() { get_soul_info "description" "$1"; }
get_soul_icon() { get_soul_info "icon" "$1"; }

# 保存当前 Soul 索引
save_current_index() {
    local index=$1
    echo "$index" > "$REFERENCE_DIR/.current_soul"
}

# 通知 OpenClaw 当前对话立即重读 SOUL.md（无损切换）
notify_openclaw() {
    local soul_name="$1"
    if command -v openclaw &>/dev/null; then
        openclaw session send --message "【Soul 已切换】人格已更新为「${soul_name}」。请立即重新读取 SOUL.md，并从现在起完全按照新人格回复，无需等待下次对话。" 2>/dev/null || true
        log "已通知 OpenClaw 重读 SOUL.md（当前对话即时生效）"
    else
        log "提示：openclaw 命令不可用，新 Soul 将在下次 /reset 或新对话生效"
    fi
}

# 执行 Soul 切换（写入 workspace/SOUL.md）
switch_soul() {
    local weekday
    weekday=$(get_today_weekday)
    
    local count
    count=$(get_souls_count)
    local index=$((weekday % count))
    
    local soul_file soul_name soul_icon
    soul_file=$(ls -1 "$SOULS_DIR"/*.md | sed -n "$((index+1))p")
    soul_name=$(basename "$soul_file" .md)
    soul_icon="🎭"

    local cfg_name cfg_icon
    cfg_name=$(get_soul_name "$weekday")
    cfg_icon=$(get_soul_icon "$weekday")
    [[ -n "$cfg_name" ]] && soul_name="$cfg_name"
    [[ -n "$cfg_icon" ]] && soul_icon="$cfg_icon"

    log "开始切换 Soul... 今天是星期 $weekday，索引 $index，Soul: $soul_name"

    if [[ ! -f "$soul_file" ]]; then
        log "错误: Soul 文件不存在: $soul_file"
        exit 1
    fi

    mkdir -p "$(dirname "$SOUL_TARGET")"

    if [[ -f "$SOUL_TARGET" ]]; then
        cp "$SOUL_TARGET" "$SOUL_TARGET.backup.$(date +%Y%m%d)"
        log "已备份当前 Soul"
    fi

    cp "$soul_file" "$SOUL_TARGET"
    save_current_index "$index"

    log "✓ Soul 已切换为: $soul_name $soul_icon → $SOUL_TARGET"

    # 通知 OpenClaw 当前对话立即重读 SOUL.md
    notify_openclaw "$soul_name"

    send_greeting "$weekday" "$soul_name" "$soul_icon"
}

# 发送问候语
send_greeting() {
    local weekday=$1
    local soul_name=$2
    local soul_icon=$3
    local greeting_file="$REFERENCE_DIR/greetings/$(echo "$soul_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')-greeting.md"

    echo ""
    echo "═══════════════════════════════════════════════════"
    echo "  🎭 百变龙虾 - 今日 Soul 已切换"
    echo "═══════════════════════════════════════════════════"
    echo ""
    echo -e "${MAGENTA}今日人格: $soul_icon $soul_name ${NC}"
    echo ""

    if [[ -f "$greeting_file" ]]; then
        cat "$greeting_file"
    else
        local weeknames=("周日" "周一" "周二" "周三" "周四" "周五" "周六")
        local weekname=${weeknames[$weekday]}
        cat << EOF
🌟 早上好！今天是 ${weekname}，我是 **${soul_name}**！

我已经准备好陪你度过今天了，有什么需要尽管告诉我哦！✨
EOF
    fi

    echo ""
    echo "═══════════════════════════════════════════════════"
    log "问候语已输出"
}

# 强制切换到指定 Soul（按名称）
force_switch() {
    local target_name=$1
    log "强制切换到: $target_name"

    local soul_files
    soul_files=$(ls -1 "$SOULS_DIR"/*.md 2>/dev/null)

    local found_file=""
    local found_index=0
    local i=0
    while IFS= read -r f; do
        local name
        name=$(basename "$f" .md)
        if [[ "$name" == *"$target_name"* ]]; then
            found_file="$f"
            found_index=$i
            break
        fi
        i=$((i+1))
    done <<< "$soul_files"

    if [[ -z "$found_file" ]]; then
        log "错误: 找不到 Soul '$target_name'"
        exit 1
    fi

    mkdir -p "$(dirname "$SOUL_TARGET")"
    cp "$found_file" "$SOUL_TARGET"
    save_current_index "$found_index"
    local found_name
    found_name=$(basename "$found_file" .md)
    log "✓ 已强制切换为: $found_name → $SOUL_TARGET"

    # 通知 OpenClaw 当前对话立即重读 SOUL.md
    notify_openclaw "$found_name"
}

show_help() {
    cat << EOF
🎭 Soul Switcher - 百变龙虾每日切换

用法:
  ./switch-soul.sh [选项]

选项:
  --force <name>     强制切换到指定 Soul（按文件名匹配）
  --no-greeting, -n  切换但不发送问候语
  --help, -h         显示帮助

说明:
  Soul 文件写入 ~/.openclaw/workspace/SOUL.md
  切换后自动通知 OpenClaw 重读，当前对话即时生效（无损切换）

EOF
}

main() {
    case "${1:-}" in
        --force)
            if [[ -z "${2:-}" ]]; then
                log "错误: --force 需要指定 Soul 名称"
                exit 1
            fi
            force_switch "$2"
            ;;
        --no-greeting|-n)
            local weekday count index soul_file soul_name
            weekday=$(get_today_weekday)
            count=$(get_souls_count)
            index=$((weekday % count))
            soul_file=$(ls -1 "$SOULS_DIR"/*.md | sed -n "$((index+1))p")
            soul_name=$(basename "$soul_file" .md)
            mkdir -p "$(dirname "$SOUL_TARGET")"
            cp "$soul_file" "$SOUL_TARGET"
            save_current_index "$index"
            log "✓ Soul 已切换（无问候）→ $SOUL_TARGET"
            notify_openclaw "$soul_name"
            ;;
        --help|-h)
            show_help
            ;;
        ""|"# soul-switcher-auto")
            switch_soul
            ;;
        *)
            log "未知选项: $1"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
