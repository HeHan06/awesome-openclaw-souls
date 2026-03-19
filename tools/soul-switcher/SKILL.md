---

name: soul-switcher

description: 百变马丁 - OpenClaw 每日自动切换 Soul 工具。支持每天定时自动切换不同风格的 AI 人格，并提供手动切换、预览、启用/关闭等功能。当用户提到百变马丁、Soul Switcher、切换人格、自动换脸等关键词时激活。

---

# 🎭 Soul Switcher - 百变马丁每日切换

> 每天早上 10:15 自动切换 Soul，用全新风格和你问早

---

## ✨ 功能特性

- 🎮 **交互式 CLI** - 支持命令行直接操作
- ⏰ **定时切换** - 每天早上 10:15 自动执行
- 🎭 **风格轮换** - 7 个 Soul 循环，每天都有新体验
- 💬 **自动问候** - 切换后用新 Soul 的风格主动问早
- 📅 **智能提醒** - 告知今日是什么风格，有什么特点
- 🔄 **无缝衔接** - 自动应用新 Soul 到 OpenClaw

---

## 📁 文件结构

标准 Skill 目录结构：

```
soul-switcher/
├── SKILL.md              # 本文件（Skill 入口）
├── scripts/              # 脚本目录
│   ├── soul-switcher     # 主控 CLI 脚本 ⭐
│   ├── switch-soul.sh    # 定时任务脚本
│   └── cron-setup.sh     # 定时任务安装脚本
└── reference/            # 资源文件目录
    ├── config.yaml       # Soul 池配置
    ├── souls/            # 所有 Soul 文件目录
    │   ├── paimon.md     # 🌟 派蒙
    │   ├── catgirl.md    # 🐱 猫娘
    │   ├── cyberpunk.md  # ⚡ 赛博黑客
    │   ├── mentor.md     # 👨‍🏫 编程导师
    │   ├── tsundere.md   # 🔪 毒舌吐槽
    │   ├── oneesan.md    # 💋 成熟大姐姐
    │   ├── ancient.md    # 🏮 古风书生
    │   └── loli.md       # 🎀 软萌萝莉
    └── greetings/        # 各 Soul 的问候语模板
        ├── paimon-greeting.md
        ├── catgirl-greeting.md
        ├── cyberpunk-greeting.md
        ├── mentor-greeting.md
        ├── oneesan-greeting.md
        ├── ancient-greeting.md
        ├── tsundere-greeting.md
        └── loli-greeting.md
```

---

## 🚀 快速开始

### 方式一：交互式命令（推荐）

OpenClaw 安装好后，在终端输入以下命令：

```bash
# 启用百变马丁（自动安装定时任务）
./scripts/soul-switcher 启用

# 查看所有支持的 Soul
./scripts/soul-switcher 预览

# 手动切换到下一个 Soul
./scripts/soul-switcher 切换

# 切换到指定 Soul（按名称）
./scripts/soul-switcher 切换 派蒙

# 切换到指定 Soul（按索引）
./scripts/soul-switcher 切换 2

# 查看当前状态
./scripts/soul-switcher 状态

# 关闭自动切换
./scripts/soul-switcher 关闭
```

### 方式二：OpenClaw 自然语言命令

安装后，直接在 OpenClaw 输入：

| 自然语言指令 | 执行的操作 |
|------------|-----------|
| "启用百变马丁" / "启动百变龙虾" | 启用自动切换功能 |
| "切换人格" / "下一个" | 切换到下一个 Soul |
| "切换到派蒙" / "换成猫娘" | 切换到指定 Soul |
| "查看人格" / "预览所有风格" | 显示所有可用 Soul |
| "关闭百变马丁" / "停止切换" | 关闭自动切换功能 |

---

## 📋 命令详解

### `soul-switcher 启用`

启动百变马丁功能：
- 安装定时任务（每天 10:15 自动切换）
- 立即切换到今日的 Soul
- 发送问候语

```bash
$ ./scripts/soul-switcher 启用

🎭 欢迎使用百变马丁 (Soul Switcher)
═══════════════════════════════════════════════════

ℹ️  正在安装定时任务...
✅ 定时任务已安装

ℹ️  正在应用今日 Soul...
✅ Soul 已切换为: 赛博黑客

═══════════════════════════════════════════════════
  🎭 百变马丁 - Soul 切换成功
═══════════════════════════════════════════════════

当前人格: ⚡ 赛博黑客

[问候语内容...]

✅ 百变马丁已启用！

提示:
  • 每天 10:15 自动切换 Soul
• 使用 './scripts/soul-switcher 切换' 手动切换
• 使用 './scripts/soul-switcher 预览' 查看所有 Soul
```

### `soul-switcher 切换 [索引/名称]`

手动切换 Soul：

```bash
# 切换到下一个
./scripts/soul-switcher 切换

# 切换到指定索引
./scripts/soul-switcher 切换 3

# 切换到指定名称（支持模糊匹配）
./scripts/soul-switcher 切换 派蒙
./scripts/soul-switcher 切换 猫娘
```

### `soul-switcher 预览`

查看所有可用的 Soul：

```bash
$ ./scripts/soul-switcher 预览

👁️  Soul 预览
═══════════════════════════════════════════════════

📋 可用的 Soul 列表 (8 个):
───────────────────────────────────────────────────

  [0] 🌟 派蒙
      萌系小助手，活泼可爱，偶尔会犯笨

  [1] 🐱 猫娘
      傲娇猫娘，每句话结尾带喵~

  [2] ⚡ 赛博黑客
      来自2077年的黑客，高效简洁

  ...

───────────────────────────────────────────────────

使用方式:
  ./scripts/soul-switcher 切换 [索引/名称]  - 切换到指定 Soul
  ./scripts/soul-switcher 切换              - 切换到下一个
```

### `soul-switcher 关闭`

停止自动切换：

```bash
$ ./scripts/soul-switcher 关闭

🛑 关闭百变马丁
═══════════════════════════════════════════════════

ℹ️  正在移除定时任务...
✅ 定时任务已移除

ℹ️  当前 Soul 保持不变

提示: 百变马丁已关闭，不再自动切换
```

### `soul-switcher 状态`

查看当前运行状态：

```bash
$ ./scripts/soul-switcher 状态

📊 百变马丁状态
═══════════════════════════════════════════════════

运行状态: ● 已启用
定时任务: 每天 10:15 自动切换

当前 Soul: 🌟 派蒙
Soul 数量: 8 个
配置路径: /path/to/config.yaml
日志路径: ~/.config/openclaw/soul-switcher.log
```

---

## 🎭 Soul 轮换表

| 星期 | Soul | 图标 | 风格描述 |
|-----|------|-----|---------|
| 周日 | 派蒙 | 🌟 | 萌系小助手，活泼可爱 |
| 周一 | 猫娘 | 🐱 | 傲娇猫娘，每句带喵~ |
| 周二 | 赛博黑客 | ⚡ | 来自2077年的黑客，高效简洁 |
| 周三 | 编程导师 | 👨‍🏫 | 耐心专业的编程老师 |
| 周四 | 毒舌吐槽 | 🔪 | 嘴硬心软的吐槽专家 |
| 周五 | 成熟大姐姐 | 💋 | 温柔体贴的大姐姐 |
| 周六 | 古风书生 | 🏮 | 温文尔雅的才子 |

---

## ⚙️ 安装步骤

### 1. 复制 Skill 到 OpenClaw

```bash
# 复制整个 soul-switcher 目录到 OpenClaw 配置目录
cp -r tools/soul-switcher ~/.config/openclaw/skills/

# 进入目录
cd ~/.config/openclaw/skills/soul-switcher

# 添加执行权限
chmod +x scripts/soul-switcher scripts/switch-soul.sh
```

### 2. 启用百变马丁

```bash
./soul-switcher 启用
```

### 3. 验证安装

```bash
# 查看状态
./soul-switcher 状态

# 预览所有 Soul
./soul-switcher 预览
```

---

## 🛠️ 高级配置

### 修改切换时间

编辑 `config.yaml`：

```yaml
settings:
  switch_time: "09:00"  # 改为 9:00
```

然后重新启用：

```bash
./scripts/soul-switcher 关闭
./scripts/soul-switcher 启用
```

### 添加新 Soul

1. 将 Soul 文件复制到 `reference/souls/` 目录
2. 在 `reference/config.yaml` 的 `souls_pool` 中添加配置
3. （可选）在 `reference/greetings/` 目录创建问候语文件

示例：

```yaml
souls_pool:
  - name: "新角色"
    file: "./souls/new-character.md"
    description: "描述文字"
    icon: "🎭"
    weekday: 8  # 新的编号
```

### 修改问候语

直接编辑 `reference/greetings/` 目录下对应的文件即可。

---

## 🐛 故障排除

### 命令未找到

```bash
# 确保脚本有执行权限
chmod +x scripts/soul-switcher scripts/switch-soul.sh

# 或使用 bash 直接运行
bash scripts/soul-switcher 启用
```

### Soul 没有切换

1. 检查定时任务：`crontab -l | grep soul-switcher`
2. 检查 Soul 文件是否存在：`ls souls/`
3. 查看日志：`cat ~/.config/openclaw/soul-switcher.log`

### 问候语没有显示

1. 检查 `greetings/` 目录下是否有对应的问候语文件
2. 文件命名格式：`[soul-name]-greeting.md`（小写，空格替换为连字符）

### 配置文件解析失败

安装 `yq` 以获得更好的 YAML 支持：

```bash
# macOS
brew install yq

# Linux
wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq
```

---

## 📝 使用建议

- 💡 首次使用建议先运行 `./soul-switcher 预览` 查看所有 Soul
- 💡 可以在 OpenClaw 中设置别名：`alias 百变="~/.config/openclaw/skills/soul-switcher/soul-switcher"`
- 💡 配合 OpenClaw 的自定义指令，可以实现更自然的交互

---

## 📜 许可证

MIT License - 与 awesome-openclaw-souls 项目一致

---

*「每天一个新风格，让 AI 陪伴更有新鲜感！」* 🎭
