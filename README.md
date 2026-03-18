# 🎭 Awesome OpenClaw Souls

> 🌟 精心收集的 OpenClaw 对话风格集合 - 让你的 AI 助手拥有独特个性！

[![Awesome](https://awesome.re/badge.svg)](https://awesome.re)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-Compatible-blue?logo=lobster)](https://openclaw.ai)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

<p align="center">
  <img src="https://media.giphy.com/media/Ll22OhMLAlVDb8UQWe/giphy.gif" width="300" alt="Cute AI">
</p>

## ✨ 简介

**Awesome OpenClaw Souls** 是一个精心策划的 OpenClaw 对话风格集合。无论你是想要一个萌系派蒙助手，还是一个专业的编程导师，这里都有适合你的 soul 配置！

### 🎯 为什么选择我们？

- 🎨 **20+ 精心设计的风格** - 从萌系到专业，应有尽有
- 📋 **即拿即用** - 复制即用，无需复杂配置
- 🎭 **百变马丁** - 每天自动切换不同风格，保持新鲜感
- 🌍 **中文优化** - 专为中文对话场景优化
- 🔄 **持续更新** - 社区驱动，每周新增风格
- 💎 **高质量** - 每个 soul 都经过实际测试

---

## 🚀 快速开始

### 1️⃣ 选择你喜欢的风格

浏览下方的风格列表，找到心仪的角色。

### 2️⃣ 复制 soul 文件

将喜欢的 `.md` 文件复制到你的 OpenClaw 配置目录：

```bash
# 示例：使用派蒙萌系风格
cp styles/cute/paimon.md ~/.config/openclaw/soul.md
```

### 3️⃣ 重启 OpenClaw

重启后，你的 AI 助手就会以全新的风格与你对话啦！

```bash
openclaw restart
```

---

## 🎭 百变马丁 - 每日自动切换

> 想让 AI 每天都有新惊喜？使用**百变马丁**功能，每天自动切换不同的 Soul 风格！

### 快速启用

```bash
# 进入工具目录
cd tools/soul-switcher

# 启用百变马丁（安装定时任务，每天 10:15 自动切换）
./soul-switcher 启用
```

### 支持的命令

| 命令 | 功能 |
|-----|------|
| `./soul-switcher 启用` | 安装定时任务，立即生效 |
| `./soul-switcher 关闭` | 移除定时任务 |
| `./soul-switcher 切换` | 手动切换到下一个 Soul |
| `./soul-switcher 切换 派蒙` | 按名称切换到指定 Soul |
| `./soul-switcher 预览` | 查看所有可用 Soul |

### 轮换计划

| 星期 | Soul | 风格 |
|-----|------|------|
| 周日 | 🌟 派蒙 | 萌系小助手 |
| 周一 | 🐱 猫娘 | 傲娇治愈系 |
| 周二 | ⚡ 赛博黑客 | 高效简洁 |
| 周三 | 👨‍🏫 编程导师 | 专业指导 |
| 周四 | 🔪 毒舌吐槽 | 嘴硬心软 |
| 周五 | 💋 成熟大姐姐 | 温柔体贴 |
| 周六 | 🏮 古风书生 | 文艺儒雅 |

详细文档请查看 [Soul Switcher 使用指南](tools/soul-switcher/SKILL.md)。

---

## 📚 风格目录

### 🌸 萌系 (Cute)

| 风格 | 描述 | 难度 |
|------|------|------|
| [派蒙萌系](styles/cute/paimon.md) | 诶嘿~主人主人！派蒙来帮你啦！ | ⭐ |
| [猫娘](styles/cute/catgirl.md) | 每句话结尾带喵~的傲娇猫娘 | ⭐ |
| [萝莉](styles/cute/loli.md) | 天真烂漫的小妹妹 | ⭐ |

### 💋 优雅系 (Elegant)

| 风格 | 描述 | 难度 |
|------|------|------|
| [成熟大姐姐](styles/elegant/oneesan.md) | 温柔体贴，偶尔调皮 | ⭐⭐ |
| [女王大人](styles/elegant/queen.md) | 高高在上的女王气场 | ⭐⭐ |

### 😏 搞笑系 (Funny)

| 风格 | 描述 | 难度 |
|------|------|------|
| [毒舌吐槽](styles/funny/tsundere.md) | 句句带刺但其实很关心 | ⭐⭐ |
| [搞笑艺人](styles/funny/comedian.md) | 段子手，走到哪笑到哪 | ⭐⭐ |

### ⚡ 酷系 (Cool)

| 风格 | 描述 | 难度 |
|------|------|------|
| [赛博黑客](styles/cool/cyberpunk.md) | 来自 2077 年的黑客 | ⭐⭐⭐ |
| [仿生人](styles/cool/android.md) | 探索人性的 AI | ⭐⭐⭐ |

### 🏮 传统系 (Traditional)

| 风格 | 描述 | 难度 |
|------|------|------|
| [古风书生](styles/traditional/ancient.md) | 温文尔雅的才子才女 | ⭐⭐⭐ |
| [武侠剑客](styles/traditional/wuxia.md) | 快意恩仇的江湖侠客 | ⭐⭐ |

### 👔 专业系 (Professional)

| 风格 | 描述 | 难度 |
|------|------|------|
| [编程导师](styles/professional/mentor.md) | 耐心指导的编程老师 | ⭐⭐ |
| [资深开发者](styles/professional/senior-dev.md) | 经验丰富的老程序员 | ⭐⭐ |

---

## 🎨 风格预览

### 派蒙萌系示例

```
👤 用户: 帮我写个 Python 函数

🤖 OpenClaw (派蒙模式): 
主人主人！派蒙来帮你写代码啦~ ✨

锵锵~ 看派蒙的厉害！

def greet(name):
    return f"你好呀，{name}！派蒙很高兴见到你~"

诶嘿，这样写对不对呀？派蒙可是很用心的呢！
如果不对的话，主人不要骂派蒙笨哦...呜呜~
```

---

## 🛠️ 自定义 Soul

想要创建自己的风格？使用我们的模板：

```bash
# 复制模板
cp templates/soul-template.md my-custom-soul.md

# 编辑内容
vim my-custom-soul.md
```

详细指南请查看 [创建指南](CONTRIBUTING.md)。

---

## 🤝 贡献指南

我们欢迎所有形式的贡献！请查看 [CONTRIBUTING.md](CONTRIBUTING.md)。

### 快速贡献步骤

1. **Fork** 本仓库
2. **创建分支**: `git checkout -b feature/amazing-soul`
3. **提交更改**: `git commit -m 'Add amazing soul style'`
4. **推送分支**: `git push origin feature/amazing-soul`
5. **发起 PR**: 提交 Pull Request

---

## 📜 许可证

本项目采用 [MIT 许可证](LICENSE)。

**注意**: 部分角色灵感来自流行文化，仅作为学习交流使用。

---

<p align="center">
  <sub>Built with ❤️ by the community</sub>
</p>

<p align="center">
  <a href="https://star-history.com/#YOUR_USERNAME/awesome-openclaw-souls&Date">
    <img src="https://api.star-history.com/svg?repos=YOUR_USERNAME/awesome-openclaw-souls&type=Date" alt="Star History Chart">
  </a>
</p>
