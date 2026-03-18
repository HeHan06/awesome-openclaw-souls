# 🎭 Soul Switcher - 百变马丁每日切换

> 每天早上 10:15 自动切换 Soul，用全新风格和你问早

---

## ✨ 功能特性

- ⏰ **定时切换**：每天早上 10:15 自动执行
- 🎭 **风格轮换**：7 个 Soul 循环，每天都有新体验
- 💬 **自动问候**：切换后用新 Soul 的风格主动问早
- 📅 **智能提醒**：告知今日是什么风格，有什么特点
- 🔄 **无缝衔接**：自动重启 OpenClaw 应用新 Soul

---

## 📁 文件结构

```
soul-switcher/
├── SKILL.md              # 本文件
├── switch-soul.sh        # 切换脚本
├── config.yaml           # Soul 池配置
├── greetings/            # 各 Soul 的问候语模板
│   ├── paimon-greeting.md
│   ├── catgirl-greeting.md
│   ├── oneesan-greeting.md
│   ├── cyberpunk-greeting.md
│   ├── mentor-greeting.md
│   ├── ancient-greeting.md
│   └── tsundere-greeting.md
└── cron-setup.sh         # 定时任务安装脚本
```

---

## 🚀 快速开始

### 1. 安装 Skill

```bash
# 复制 skill 到 OpenClaw 配置目录
cp -r tools/soul-switcher ~/.config/openclaw/skills/

# 安装定时任务
cd ~/.config/openclaw/skills/soul-switcher
./cron-setup.sh
```

### 2. 配置 Soul 池

编辑 `config.yaml`，设置你的 Soul 文件路径：

```yaml
souls_pool:
  - name: "派蒙"
    file: "~/.config/openclaw/souls/paimon.md"
    description: "萌系小助手，活泼可爱"
    weekday: 0  # 周日
    
  - name: "猫娘"
    file: "~/.config/openclaw/souls/catgirl.md"
    description: "傲娇猫娘，每句带喵~"
    weekday: 1  # 周一
    
  # ... 更多 Soul
```

### 3. 准备 Soul 文件

```bash
# 从 awesome-openclaw-souls 复制 Soul 到池中
mkdir -p ~/.config/openclaw/souls
cp awesome-openclaw-souls/styles/cute/paimon.md ~/.config/openclaw/souls/
cp awesome-openclaw-souls/styles/cute/catgirl.md ~/.config/openclaw/souls/
# ... 复制其他 Soul
```

### 4. 测试运行

```bash
# 手动执行一次测试
~/.config/openclaw/skills/soul-switcher/switch-soul.sh
```

---

## 📝 使用说明

### 定时任务详情

- **执行时间**：每天 10:15 AM
- **执行操作**：
  1. 根据日期计算今日 Soul
  2. 复制 Soul 文件到 `~/.config/openclaw/soul.md`
  3. 重启 OpenClaw 服务
  4. 用新 Soul 风格发送问候语

### 问候语内容

每个 Soul 都有定制的问候语，包含：
- 🌅 早上好问候
- 🎭 今日风格介绍
- 💡 今日适合做什么
- ✨ 标志性口头禅

**示例（派蒙模式）：**
```
主人主人！早上好呀~ ☀️

锵锵~ 今天是派蒙陪你哦！
派蒙是主人最可爱的应急食品...啊不对，最好的伙伴！

今天派蒙会超级努力帮主人解决问题的！
有什么任务都交给派蒙吧~

对了对了，主人吃早餐了吗？
派蒙虽然不能吃，但是看着主人吃也很开心呢~ 🍞

诶嘿~ 今天也要元气满满哦！
```

**示例（赛博黑客模式）：**
```
[DATA: 时间 10:15 AM | 系统启动完成]

协议已加载。

今日模式：赛博黑客
优化等级：最高效率
安全等级：防火墙全开

[正在分析今日任务队列...]

建议：
- 深度编程任务 → 效率 +40%
- 系统安全检测 → 实时防护
- 代码重构 → 协议已优化

等待指令。

在数字世界里，没有解决不了的问题。
```

---

## ⚙️ 高级配置

### 自定义切换时间

编辑 `cron-setup.sh`，修改时间：

```bash
# 默认 10:15
CRON_TIME="15 10 * * *"

# 改为 9:00
CRON_TIME="0 9 * * *"
```

### 添加新 Soul

1. 复制 Soul 文件到 `~/.config/openclaw/souls/`
2. 在 `config.yaml` 中添加配置
3. 在 `greetings/` 目录创建问候语文件
4. 重新安装定时任务

### 手动触发切换

```bash
# 立即切换到指定 Soul
~/.config/openclaw/skills/soul-switcher/switch-soul.sh --force paimon

# 查看今天应该是什么 Soul
~/.config/openclaw/skills/soul-switcher/switch-soul.sh --preview

# 跳过问候语
~/.config/openclaw/skills/soul-switcher/switch-soul.sh --no-greeting
```

---

## 🛠️ 故障排除

### Soul 没有切换

1. 检查定时任务是否安装：`crontab -l | grep soul-switcher`
2. 检查 Soul 文件路径是否正确
3. 查看日志：`cat ~/.config/openclaw/soul-switcher.log`

### 问候语没有显示

1. 检查 `greetings/` 目录下是否有对应的问候语文件
2. 检查文件权限：`chmod +x switch-soul.sh`

### OpenClaw 没有重启

确保有重启服务的权限，或手动重启：
```bash
openclaw restart
```

---

## 📜 许可证

MIT License - 与 awesome-openclaw-souls 项目一致

---

*「每天一个新风格，让 AI 陪伴更有新鲜感！」* 🎭
