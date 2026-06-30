# 短信中间商平台（sms-gateway）

开源短信中间商平台搭建项目。基于 [信通畅邮 liuyanning/sms_platform](https://github.com/liuyanning/sms_platform)。

## 快速上手

**新会话先读 [CONTEXT.md](CONTEXT.md)** —— 包含项目目标、服务器信息、当前进度、部署步骤，读完即可接续工作。

## 项目结构

```
sms-gateway/
├── README.md              # 本文件
├── CONTEXT.md             # ⭐ AI 上下文恢复包（新会话先读这个）
├── CLAUDE.md              # 项目级 AI 指令
├── docs/
│   ├── 01-需求.md         # 需求采访结论
│   ├── 02-选型决策.md     # 为什么选信通畅邮（含项目对比表）
│   ├── 03-服务器部署.md   # 服务器环境 + 部署详情
│   └── 04-对话与进度.md   # 决策时间线
└── src/                   # 源码（clone 用）
```

## 关键事实

- **目标**：短信中间商平台（对下甲方 HTTP，对上运营商 CMPP/HTTP）
- **选型**：信通畅邮（liuyanning/sms_platform）—— 国内协议齐全的完整中间商平台
- **服务器**：`ssh -p 65022 root@36.139.116.238`，部署在 `/tools/sms`
- **当前进度**：playSMS 已弃用，信通畅邮待重新部署（上次卡在 SQL 兼容问题，方案已定）

详见 [CONTEXT.md](CONTEXT.md)。
