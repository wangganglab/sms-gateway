# 项目级指令 — sms-gateway

> 本文件补充全局 CLAUDE.md，仅记录本项目特有约定。全局规则以 `~/.claude/CLAUDE.md` 为准。

## 项目背景

短信中间商平台搭建。用户是短信中间商：对下（甲方）HTTP 收短信，对上（运营商/上游）CMPP/SGIP/SMGP/HTTP 发送。基于开源项目 [信通畅邮](https://github.com/liuyanning/sms_platform) 二次部署。

**新会话务必先读 [CONTEXT.md](CONTEXT.md)** 恢复上下文，不要重新询问已确认的需求。

## 环境约定

- **服务器**：`ssh -p 65022 root@36.139.116.238`（Debian 12 / Java 17 / MariaDB 10.11 / Apache / PHP 8.2 / Docker）
- **服务器部署目录**：`/tools/sms`（所有项目统一放 `/tools/`）
- **本地目录**：`/Users/andy/Kali/LeadInfo/项目/sms-gateway`（源码、文档、配置）
- **数据库**：MariaDB 10.11，root 无密码；注意与 MySQL 8.0 的兼容差异（如 ROW_FORMAT）

## 已确认的关键决策（不要重新讨论）

1. 选信通畅邮（非 playSMS / 非 austin）—— 详见 docs/02
2. 通道模式 = C（部分直连运营商 CMPP + 部分 HTTP 上游）
3. 纯开源，接受质量风险
4. playSMS 已部署在 8877 端口但弃用（不支持国内协议）
5. 上次信通畅邮部署卡在 SQL 兼容，解决方案：sed 替换 ROW_FORMAT=COMPACT → DYNAMIC

## 端口约定

服务器公网只开放 SSH 65022 + Web 8877（需阿里云安全组放行）。新端口要先让用户在阿里云控制台放行（入方向，0.0.0.0/0）再使用。

## 工作方式

- 部署在服务器执行（SSH），本地只放源码/文档
- 改动服务器前先检查目录是否已有内容（`/tools/sms` 曾发现已有 `.claude`）
- SQL 兼容问题优先用 sed 预处理，不改服务器全局配置
- 进展同步回 `docs/04-对话与进度.md`
