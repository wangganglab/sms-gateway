# 项目变更日志
> 唯一真相源。不在此文件的变更 = 没发生。
> v4 起按「版本规划门禁」记录；之前批次（R1 签名/R2 操作员/R3 时限清理）见 `docs/04-对话与进度.md`。

## 大版本 v4：台账/日志合规
### 目标
- 完成态：合作方、合作期限、号码、投诉、拒收全程可追溯、可审计
- 北极星：落实台账/日志合规（信用代码/资质/期限/号码/投诉/拒收）

### 小版本
#### v4.0 数据基础（已交付，2026-07-01，commit 90591cd）
- 建 3 新表：cooperation_period / complaint / unsubscribe_log
- enterprise 扩 6 字段（Credit_Code/Business_Scope/Qualification_Expiry_Date/Cooperation_Start_Date/Cooperation_End_Date/Contact_Name）
- product 扩 4 字段（Code_Type/Enterprise_No/Activate_Date/Number_Detail）
- DDL 脚本：`sql/r4-r5-tables.sql`

#### v4.1 合作方台账（已交付，2026-07-01）
- 完成态：管理员在「业务管理」下打开「合作方台账」，查看/编辑企业的信用代码、资质有效期、合作期限、经营范围、联系人
- 做了：
  - Enterprise.java 加 6 字段+getter/setter
  - EnterpriseMapper.xml 7 处字段列表全改（resultMap/Base_Column_List/insert/insertList/insertSelective/updateByExampleSelective/updateByExample/updateByPrimaryKeySelective/updateByPrimaryKey）
  - edit.jsp 加表单（3 text + 1 textarea + 3 laydate datetime，日期用 fmt:formatDate 回显适配全局 DateFormatter）
  - list.jsp 加列（信用代码/资质有效期/合作期限/联系人/经营范围截断）
  - partner_menu.sql：菜单 005007 + 子按钮（列表/编辑）+ role 1/3/5 分配
- 不做（进 vNext 候选池）：字段强校验、合作方台账独立 JSP
- 后端免改：Controller/EnterpriseManageImpl/EnterpriseExt/DAO/FilterObjectMapper/SmsUIObjectMapper（链路透传已验证）
- 验证：mvn EXIT 0 + 3 实例部署 200 + SQL 6 字段读写正常 + 启动无 ERROR；Web 端到端点验待人工（登录有验证码+RSA，无法 curl 自动化）

### vNext 候选池
- v4.2 合作期限台账 + 到期预警（cooperation_period 表，复用 alarm）
- v4.3 号码台账（product 扩字段）
- v4.4 投诉处理（complaint 表）
- v4.5 业务台账聚合视图
- v4.6 R4-A 拒收识别（unsubscribe_log 表，上行 TD 等关键词）
- 字段强校验（信用代码唯一性、合作期限 Start≤End、资质过期拦截）
- 不可篡改 DB 权限收紧（逐表分析写模式，人工门禁）
- R4-D 字段加密（监管强制才做）
- 更多告警渠道（短信/邮件/微信）
