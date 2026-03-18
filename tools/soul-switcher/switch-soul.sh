#!/bin/bash
# 🎭 Soul Switcher - 每日自动切换 Soul 脚本
# 每天早上 10:15 执行，切换 Soul 并发送问候

set -e

# 配置路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.yaml"
SOULS_DIR="$SCRIPT_DIR/souls"
OPENCLAW_CONFIG_DIR="${HOME}/.config/openclaw"
SOUL_TARGET="$OPENCLAW_CONFIG_DIR/soul.md"
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
        # 手动解析 yaml
        awk "/weekday: $weekday/{flag=1} flag && /$field:/{print \$2; exit}" "$CONFIG_FILE" | tr -d '"'
    fi
}

# 获取 Soul 文件路径（转换为绝对路径）
get_soul_file() {
    local weekday=$1
    local filename=$(get_soul_info "file" "$weekday")
    # 转换为绝对路径
    echo "$SOULS_DIR/$(basename "$filename")"
}

# 获取 Soul 名称
get_soul_name() {
    local weekday=$1
    get_soul_info "name" "$weekday"
}

# 获取 Soul 描述
get_soul_description() {
    local weekday=$1
    get_soul_info "description" "$weekday"
}

# 获取 Soul 图标
get_soul_icon() {
    local weekday=$1
    get_soul_info "icon" "$weekday"
}

# 保存当前 Soul 索引
save_current_index() {
    local index=$1
    echo "$index" > "$SCRIPT_DIR/.current_soul"
}

# 执行 Soul 切换
switch_soul() {
    local weekday=$(get_today_weekday)
    local soul_file=$(get_soul_file $weekday)
    local soul_name=$(get_soul_name $weekday)
    local soul_icon=$(get_soul_icon $weekday)

    log "${BLUE}开始切换 Soul...${NC}"
    log "今天是星期 $weekday，今日 Soul: $soul_name"

    # 检查源文件是否存在
    if [[ ! -f "$soul_file" ]]; then
        log "${RED}错误: Soul 文件不存在: $soul_file${NC}"
        exit 1
    fi

    # 确保 OpenClaw 配置目录存在
    mkdir -p "$OPENCLAW_CONFIG_DIR"

    # 备份当前 Soul
    if [[ -f "$SOUL_TARGET" ]]; then
        cp "$SOUL_TARGET" "$SOUL_TARGET.backup.$(date +%Y%m%d)"
        log "已备份当前 Soul"
    fi

    # 复制新 Soul
    cp "$soul_file" "$SOUL_TARGET"

    # 保存当前索引
    save_current_index "$weekday"

    log "${GREEN}✓ Soul 已切换为: $soul_name $soul_icon${NC}"

    # 发送问候语
    send_greeting $weekday
}

# 发送问候语
send_greeting() {
    local weekday=$1
    local soul_name=$(get_soul_name $weekday)
    local soul_description=$(get_soul_description $weekday)
    local soul_icon=$(get_soul_icon $weekday)
    local greeting_file="$SCRIPT_DIR/greetings/$(echo $soul_name | tr '[:upper:]' '[:lower:]' | tr ' ' '-')-greeting.md"

    log "准备发送问候语..."

    echo ""
    echo "═══════════════════════════════════════════════════"
    echo "  🎭 百变马丁 - 今日 Soul 已切换"
    echo "═══════════════════════════════════════════════════"
    echo ""
    echo -e "${MAGENTA}今日人格: $soul_icon $soul_name ${NC}"
    echo ""

    # 检查是否有自定义问候语文件
    if [[ -f "$greeting_file" ]]; then
        cat "$greeting_file"
        log "使用自定义问候语"
    else
        # 使用默认问候语模板
        generate_default_greeting "$soul_name" "$soul_description" "$soul_icon"
    fi

    echo ""
    echo "═══════════════════════════════════════════════════"

    log "问候语已发送"
}

# 生成默认问候语
generate_default_greeting() {
    local name=$1
    local description=$2
    local icon=$3
    local weekday=$(get_today_weekday)
    local weeknames=("周日" "周一" "周二" "周三" "周四" "周五" "周六")
    local weekname=${weeknames[$weekday]}

    cat << EOF
🌟 早上好！今天是 ${weekname}，我是 **${name}**！

${description}

我已经准备好陪你度过今天了~
有什么需要尽管告诉我哦！

祝你今天有个美好的一天！✨
EOF
}

# 预览模式（不执行切换）
preview_mode() {
    local weekday=$(get_today_weekday)
    local weeknames=("周日" "周一" "周二" "周三" "周四" "周五" "周六")
    local weekname=${weeknames[$weekday]}

    echo ""
    echo "🎭 Soul Switcher - 本周 Soul 安排"
    echo "═══════════════════════════════════════════════════"
    echo ""
    echo "今天是: ${weekname} (星期 $weekday)"
    echo ""

    # 显示本周 Soul 安排
    echo "本周 Soul 轮换表:"
    echo "───────────────────────────────────────────────────"
    for i in {0..6}; do
        local name=$(get_soul_name $i)
        local icon=$(get_soul_icon $i)
        local desc=$(get_soul_description $i)
        local marker=""
        [[ $i -eq $weekday ]] && marker=" ← 今天"
        printf "  %s %s: %-10s %s%s\n" "$icon" "${weeknames[$i]}" "$name" "$desc" "$marker"
    done
    echo ""
    echo "═══════════════════════════════════════════════════"
}

# 显示帮助
show_help() {
    cat << EOF
🎭 Soul Switcher - 百变马丁每日切换

用法:
  ./switch-soul.sh [选项]

选项:
  --preview, -p      预览本周 Soul 安排（不执行切换）
  --force <name>     强制切换到指定 Soul
  --no-greeting, -n  切换但不发送问候语
  --help, -h         显示帮助

示例:
  ./switch-soul.sh                    # 正常执行切换
  ./switch-soul.sh --preview          # 预览本周安排
  ./switch-soul.sh --force paimon     # 强制切换到派蒙

EOF
}

# 强制切换到指定 Soul
force_switch() {
    local target_name=$1
    log "强制切换到: $target_name"

    # 在配置中查找 Soul
    local soul_file=""
    local soul_desc=""
    local soul_icon=""
    local target_weekday=""

    for i in {0..6}; do
        local name=$(get_soul_name $i)
        if [[ "$name" == *"$target_name"* ]]; then
            soul_file=$(get_soul_file $i)
            soul_desc=$(get_soul_description $i)
            soul_icon=$(get_soul_icon $i)
            target_weekday=$i
            break
        fi
    done

    if [[ -z "$soul_file" ]]; then
        log "${RED}错误: 找不到 Soul '$target_name'${NC}"
        log "可用的 Soul:"
        for i in {0..6}; do
            log "  - $(get_soul_name $i)"
        done
        exit 1
    fi

    # 执行切换
    mkdir -p "$OPENCLAW_CONFIG_DIR"
    cp "$soul_file" "$SOUL_TARGET"
    save_current_index "$target_weekday"
    log "${GREEN}✓ 已强制切换为: $target_name $soul_icon${NC}"

    # 发送问候语
    send_greeting $target_weekday
}

# 主函数
main() {
    case "${1:-}" in
        --preview|-p)
            preview_mode
            ;;
        --force)
            if [[ -z "${2:-}" ]]; then
                log "${RED}错误: --force 需要指定 Soul 名称${NC}"
                exit 1
            fi
            force_switch "$2"
            ;;
        --no-greeting|-n)
            # 切换但不发送问候语
            local weekday=$(get_today_weekday)
            local soul_file=$(get_soul_file $weekday)
            mkdir -p "$OPENCLAW_CONFIG_DIR"
            cp "$soul_file" "$SOUL_TARGET"
            save_current_index "$weekday"
            log "${GREEN}✓ Soul 已切换（无问候）${NC}"
            ;;
        --help|-h)
            show_help
            ;;
        "")
            # 正常执行
            switch_soul
            ;;
        *)
            log "${RED}未知选项: $1${NC}"
            show_help
            exit 1
            ;;
    esac
}

# 运行主函数
main "$@"
