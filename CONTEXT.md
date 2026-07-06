# 项目上下文（AI 恢复包）

> **新会话读这个文件即可恢复全部上下文。** 本文件记录项目目标、关键决策、服务器现状、当前进度。

## 一句话定位

搭建一个**开源短信中间商平台**：对下（甲方客户）提供 HTTP 接口收短信 + 客户端 Web 平台，对上（运营商/上游通道）用 CMPP/SGIP/SMGP 或 HTTP 连接发送，中间做路由、计费、客户管理。用户本人是短信中间商，赚差价。

## 用户角色与商业模式

```
甲方（企业客户）──HTTP──> 【本平台】──CMPP/HTTP──> 运营商 / 上游通道
   (给钱)                 (中间商)                   (实际发送)
```

- **上游**：甲方客户，用 HTTP 协议对接提交短信
- **下游**：运营商 + 上游 MSP（混合通道，C 方案）
  - 部分直连运营商（CMPP/SGIP/SMGP）
  - 部分走 HTTP 上游 MSP
- **平台职责**：客户管理、路由分拣、黑白名单、计费、状态报告回推

## 服务器信息

| 项 | 值 |
|----|-----|
| SSH | `ssh -p 65022 root@36.139.116.238` |
| 公网 IP | 36.139.116.238（阿里云，36.139 段） |
| OS | Debian 12 (bookworm) |
| Java | OpenJDK 17 |
| Docker | 20.10.24 |
| 数据库 | MariaDB 10.11（root 无密码） |
| Web | Apache 2.4.67 + PHP 8.2（已切默认） |
| 内存 | 16G（可用约 13G） |
| 磁盘 | 79G（已用 59G，剩 17G，偏紧） |

**部署目录约定**：服务器端项目统一放 `/tools/`。本项目用 `/tools/sms`（已存在、空，含一个 `.claude` 目录）。

## 已部署现状（playSMS，已弃用）

| 项 | 值 |
|----|-----|
| 软件 | playSMS 1.4.8（PHP） |
| 位置 | `/var/www/playsms`，数据 `/opt/playsms-data`，源码 `/opt/playsms` |
| 访问 | http://36.139.116.238:8877/ （admin / admin123） |
| 状态 | ✅ 可运行，❌ **已弃用** |
| 弃用原因 | 不支持国内协议（CMPP/SGIP/SMGP），只能 HTTP/SMPP，不适合国内中间商业务 |

> playSMS 文件还在服务器上，未清理。如需清理见 `docs/03-服务器部署.md`。

## 已部署：信通畅邮（liuyanning/sms_platform）✅

2026-06-29 部署成功，3 平台公网可访问。完整踩坑与决策见 `docs/04-对话与进度.md` 阶段 8。

### 访问方式
| 平台 | URL | 端口/账号 |
|------|-----|------|
| 运营管理 | http://36.139.116.238:8889/public/admin/login.jsp | 8889（admin/123456）|
| 客户端 | http://36.139.116.238:8890/ | 8890 |
| 发送网关 | http://36.139.116.238:8888/ | 8888 |

### 关键部署事实（新会话必读，避免重踩坑）
- **Java**：用 **Temurin Java 8**（`/tools/jdk8`），非服务器默认 Java 17。Java 17 与项目不兼容（javax.xml.bind/JAX-WS/sun.misc 移除）。构建+运行都用 Java 8。
- **Tomcat**：9.0.119 binary（`/tools/tomcat9`），3 份实例 `/tools/tms-{netway,admin,enterprise}`，各 `bin/setenv.sh` 指向 Java 8
- **DB 用户**：`sms/smsGateway2026`（root 仅 socket 免密，JDBC 走 TCP 必须用 sms 用户）。库 sms_business(41表)/sms_send(11表)
- **配置文件**：`datasource.properties`（**非** README 写的 database.properties），3 个 webapp 的 `src/main/resources/` 下
- **私有依赖**：sms-quick 1.0.15（`com.drondea.sms`），已 mvn install 到 `/root/.m2`；主 pom 版本号已改 1.0.9→1.0.15
- **SQL 导入坑**：business.sql 须 `mysql --force` 导入到干净库（DROP 重建），否则只建 24/41 表；导入前 sed 替换 `ROW_FORMAT=COMPACT`→`DYNAMIC`
- **运维**：`bash /tools/restart-sms.sh` 重启、`/tools/deploy-sms.sh` 重部署、日志 `/tools/tms-<name>/logs/catalina.out`

## 关键约束

- **纯开源**：用户坚持纯开源方案，接受风险
- **大规模**：日发千万级目标（先小流量验证）
- **环境**：MariaDB 10.11（非 MySQL 8.0），注意兼容性
- **网络**：服务器只对公网开放 SSH 65022 + Web 8877；新端口需在阿里云安全组放行（入方向，来源 0.0.0.0/0）

## 下一步（当前任务）

**信通畅邮已部署上线**（admin/123456 @ 8889，品牌"信速应"，3 实例 0 错误）。

**台账/日志合规定制开发进行中**（方案 `docs/05` 已审批，4 批次约8-10天）：
- ✅ 第1批 R2 操作员角色（2026-06-30）—— `operator_test/123456`，菜单白名单 4 项（账户/短信/报表/财务）
- ✅ 第2批 R1 短信签名管理（2026-07-01）—— sms_signature 表 + CRUD + 菜单 006038 + 发送校验
- 🔄 第3批 R3：时限清理定时任务 ✅（扩展 DropTableTask + code 表配置项）+ 管理员设置 ✅（复用 015003）；不可篡改(DB权限收紧) ⏸ 留人工门禁
- 🔄 第4批 R5/R4-A：数据基础 ✅（3 新表 + enterprise 扩 6 字段/product 扩 4 字段）；**v4.1 合作方台账 ✅**（2026-07-01，enterprise 扩字段展示/录入+菜单 005007）；**v4.2 合作期限台账 ✅**（2026-07-01，独立 cooperation_period CRUD+菜单 005008+列表高亮+状态代替删除；合同附件留 vNext）；**v4.3 号码台账 ✅**（2026-07-02，product 扩 4 字段展示/录入+菜单 005009；仿 v4.1 模式 Controller/Service 免改）；**v4.4 投诉处理 ✅**（2026-07-02，complaint 独立 CRUD+菜单 005010+5 JSP 列表/新增/编辑/处理/详情+状态三态流转+来源三字典+role 1/3/5；5 条测试数据）；**v4.5 跳过**（4 个独立台账已有列表页，ROI 低）；**v4.6 拒收识别 ✅**（2026-07-02，修改 AbstractSenderService.autoAddBlack 写入 sms_send.unsubscribe_log+菜单 005011+2 JSP 列表/详情+role 1/3/5；5 条测试数据；默认关键词 T,TD,退订）；**v4.7 字段强校验 ✅**（2026-07-02，信用代码唯一性+合作期限日期校验+资质过期拦截；EnterpriseExample 补 andCredit_CodeEqualTo）；**v4.8 投诉统计报表 ✅**（2026-07-02，按企业/来源/状态 3 维度统计）；**v4.9 拒收关键词配置 UI ✅**（2026-07-02，管理界面配置拒收关键词，写入 code 表 system_env）；vNext 候选池：投诉附件上传 / 拒撤恢复（见 `docs/CHANGELOG.md`）

- ✅ **v5.0 台账/日志菜单壳页面已部署**（2026-07-07）：菜单 020 日志管理 + 021 台账管理 + 2 JSP（sms_log_list / account_ledger_list）+ 2 桩接口（`sms_logList`/`account_ledgerList`，返回空，TODO 后续对接联合查询）；导入 2 个菜单 SQL 到 sms_business（role 1/3/5 各 8 权限）。半成品：菜单 SQL 声明的 import/export 按钮 jsp 与接口未实现
- ✅ **netway ROW_FORMAT 运行时坑修复**（2026-07-07）：deploy 重启 netway 时 `createTableTask` 建 `input_log20260713` 失败（COMPACT row size>8126）→ Bean 初始化失败 → netway 崩溃；改 4 个 send-dao mapper（InputLog/Submit/Report/ReportNotify `*ExtMapper.xml`）COMPACT→DYNAMIC + 重部署 netway，3 实例恢复 200/200/302

**本地开发工作流**：`sms-gateway/` git 仓库（main），源码基线在 `src/sms_platform/`，本地改 → `deploy-sms.sh` 部署。权限改动无需重启（实时查库）。

- 日常运维：配上游通道(CMPP/HTTP)打通发送 / playSMS(8877) 弃用后按 docs/03 清理

## 文档导航

- [README.md](README.md) — 项目总览
- [docs/01-需求.md](docs/01-需求.md) — 完整需求采访结论
- [docs/02-选型决策.md](docs/02-选型决策.md) — 为什么选信通畅邮
- [docs/03-服务器部署.md](docs/03-服务器部署.md) — 服务器环境 + 部署详情
- [docs/04-对话与进度.md](docs/04-对话与进度.md) — 对话决策时间线（含阶段8部署成功/阶段9品牌+定制方案）
- [docs/05-台账日志定制方案.md](docs/05-台账日志定制方案.md) — 台账/日志合规定制开发方案（待审批）
