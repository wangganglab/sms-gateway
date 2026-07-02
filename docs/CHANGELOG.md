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

#### v4.2 合作期限台账（已交付，2026-07-01）
- 完成态：管理员在「业务管理」下打开「合作期限台账」，查看/新增/编辑/终止合作期限记录（企业+端口+子端口维度），列表按"距到期天数"高亮，合同 URL 字段可填
- 做了：
  - CooperationPeriod 全套（Entity/Example/Mapper/DAO 三件套/Ext Entity/Service 6 方法/Controller 6 方法）仿 commit a95a164 签名管理模式
  - cooperation_period_list/add/edit.jsp 三页面（列表含 30/90 天高亮 templet，add/edit 含企业下拉 `ht:heroenterpriseselect` + 产品下拉 `ht:heroproductselect` + 状态字典 `ht:herocodeselect cooperationStatus` + 3 日期 fmt+laydate datetime + 合同 URL 手填）
  - cooperation_period_menu.sql：code 字典 cooperationStatus(1 有效/0 终止) + 菜单 005008 + 7 子按钮 + role 1/3/5 分配
  - 状态代替删除：列表默认筛选 Status_Code='1'，"终止"按钮 update Status_Code='0'
- 调整（实现中发现）：
  - 合同附件降级为 URL 手填（项目无独立上传接口，留 vNext 做独立 RequestMapping，见 memory `sms-project-no-upload-endpoint`）
  - CooperationPeriodExample 补 `import java.util.Date`（MBG Example 含 Date 字段 Criteria 必须 import，见 memory `sms-mbg-example-import-date`）
- 不做（进 vNext 候选池）：alarm 体系接入（用户决策"仅高亮"）、定时任务扫描、邮件/短信通知、自动终止
- 后端仿签名管理全手写（非 v4.1 扩字段模式，因 cooperation_period 是新表）
- 验证：mvn EXIT 0 + 3 实例部署 200 + 启动无 ERROR + 菜单 7 项入库 + 4 条测试数据就绪；Web 端到端点验待人工

#### v4.3 号码台账（已交付，2026-07-02）
- 完成态：管理员在「业务管理」下打开「号码台账」，查看/新增/编辑号码的码号类型、归属合作方、启用日期、详情
- 做了：
  - Product.java 加 4 字段（code_Type/enterprise_No/activate_Date/number_Detail）+ getter/setter
  - ProductMapper.xml 9 处字段列表全改（保持 MBG 一致性）
  - product_list.jsp 加 4 列（码号类型/归属合作方/启用日期/详情截断）
  - product_edit.jsp + product_add.jsp 加 4 字段表单（码号类型 text + 归属合作方 `ht:heroenterpriseselect` + 启用日期 `fmt:formatDate` 回显 + laydate datetime + 详情 textarea）
  - number_menu.sql：菜单 005009（业务管理下 Order=9）+ 6 子按钮（列表/新增前置+保存/编辑前置+保存）+ role 1/3/5 分配
- 模式：仿 v4.1 enterprise 扩字段（不是 v4.2 独立 CRUD），Controller/Service 免改（productList/addProduct/preProductEdit/editProduct 通用）
- 不做（进 vNext 候选池）：Enterprise_No → enterprise.Name 翻译、码号类型字典、到期预警
- 验证：mvn EXIT 0 + 3 实例部署 200 + 启动无 ERROR + 菜单 6 项入库 + 3 条测试数据就绪；Web 冒烟点验通过

### vNext 候选池
- v4.4 投诉处理（complaint 表）
- v4.5 业务台账聚合视图
- v4.6 R4-A 拒收识别（unsubscribe_log 表，上行 TD 等关键词）
- 字段强校验（信用代码唯一性、合作期限 Start≤End、资质过期拦截）
- 不可篡改 DB 权限收紧（逐表分析写模式，人工门禁）
- R4-D 字段加密（监管强制才做）
- 更多告警渠道（短信/邮件/微信）
