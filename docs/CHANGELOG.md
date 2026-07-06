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

#### v4.4 投诉处理（已交付，2026-07-02）
- 完成态：管理员在「业务管理」下打开「投诉处理」，登记/处理/查询投诉，跟踪处理状态（待处理→处理中→已处理）
- 做了：
  - Complaint 全套（Entity/Example/Mapper/DAO 三件套/Ext Entity+DAO 空壳）仿 CooperationPeriod 模式
  - IEnterpriseManage 加 6 方法（queryComplaintList/queryComplaintById/addComplaint/editComplaint/handleComplaint/deleteComplaintBatch）
  - EnterpriseManageImpl 实现 6 方法（含必填校验：企业/号码/内容；处理时自动更新 handle_Date）
  - BaseEnterpriseManage 注入 complaintExtDAO
  - EnterpriseController 加 7 方法（list/preAdd/add/preEdit/edit/preHandle/handle/preDetail）
  - 5 个 JSP：complaint_list.jsp（5 筛选+状态高亮 templet）+ complaint_add.jsp（必填*+来源字典+时间 laydate）+ complaint_edit.jsp（全部字段可改）+ complaint_handle.jsp（处理专属，投诉信息只读+处理状态/人/结果/时间可编辑）+ complaint_detail.jsp（只读详情）
  - complaint_menu.sql：code 字典 complaintStatus(0 待处理/1 处理中/2 已处理)+ complaintSource(operator 运营商/user 用户/regulator 监管) + 菜单 005010（Order=10）+ 9 子项（1 列表 button + 4 操作 showbutton + 4 保存 button）+ role 1/3/5 分配（27 条 admin_role_limit）
- 不做（进 vNext 候选池）：投诉统计报表、自动预警、附件上传、投诉分类字典细化、不可篡改审计日志
- 测试数据：5 条投诉（覆盖 3 状态 × 3 来源 × 不同企业/端口）
- 验证：mvn EXIT 0 + 3 实例部署 0 ERROR + 菜单 9 项入库 + 字典 6 项入库 + 角色 27 条分配 + 5 条测试数据就绪 + JSP 5 文件部署到 Tomcat；Web 端到端点验待人工

#### v4.6 拒收识别（已交付，2026-07-02）
- 完成态：上行短信含 T/TD/退订 关键词时，自动识别拒收并写入 `sms_send.unsubscribe_log` 表（同时保持现有 black_list 逻辑）；管理员在「业务管理」→「拒收记录」查看列表/详情
- 做了：
  - UnsubscribeLog 全套（sms-send-dao 模块，因表在 sms_send 库）：Entity(bigInteger Id)/Example/Mapper/DAO + Ext 三件套
  - 修改 AbstractSenderService.autoAddBlack：识别到拒收时先写 unsubscribe_log（try/catch 包裹，失败不影响主流程），再走原 black_list 逻辑
  - 注入 unsubscribeLogExtDAO（@Resource）
  - IEnterpriseManage 加 2 方法（queryUnsubscribeLogList/queryUnsubscribeLogById）
  - EnterpriseManageImpl 实现 2 方法（企业/端口/号码筛选，id desc 排序）
  - BaseEnterpriseManage 注入 unsubscribeLogExtDAO
  - EnterpriseController 加 2 方法（list/detail）
  - 2 个 JSP：unsubscribe_log_list.jsp（3 筛选 + 表格）+ unsubscribe_log_detail.jsp（只读 8 字段）
  - unsubscribe_log_menu.sql：菜单 005011（Order=11）+ 3 子项（列表 button + 详情 showbutton）+ role 1/3/5 分配（9 条 admin_role_limit）
- 关键决策：
  - Product_No 留空（避免 join 查 channel，简单方案优先；后续需要再补）
  - 企业未绑定端口的拒收不记录（保持 saveMO 现状，enterprise_user_id==0 直接返回）
  - 拒收关键词用 DatabaseCache 默认值 "T,TD,退订"（system_env 表不存在，无需数据库配置）
  - **无企业级访问控制**（admin 平台操作员需查看全量数据做合规审计；如未来扩展到 enterprise 平台需加 enterprise_No 过滤）
- 不做（进 vNext）：拒收关键词动态配置 UI、拒撤恢复/二次发送、导出 Excel、图表
- 测试数据：5 条拒收记录（sms_send.unsubscribe_log，覆盖 T/TD/退订 三种关键词 × 不同企业）
- 验证：mvn EXIT 0 + 3 实例重启 0 ERROR + 菜单 3 项入库 + 角色 9 条分配 + 5 条测试数据就绪 + JSP 2 文件部署；Web 端到端点验待人工
- 踩坑：僵尸进程堆积（多次 deploy 未停干净），`bash /tools/restart-sms.sh` 一次性重启解决

#### v4.7 字段强校验（已交付，2026-07-02）
- 完成态：企业新增/编辑时校验信用代码唯一性；合作期限新增时校验日期逻辑 + 拦截资质过期企业
- 做了：
  - **信用代码唯一性**：EnterpriseManageImpl.addEnterprise/editEnterprise 加校验（查询 enterprise 表 credit_Code 字段，重复则抛 ServiceException）
  - **EnterpriseExample 扩展**：手动加 andCredit_CodeEqualTo 方法（v4.1 漏掉，导致 Example 类无法查询 credit_Code）
  - **合作期限日期校验**：addCooperationPeriod 已有 Start_Date < End_Date 校验（无需修改）
  - **资质过期拦截**：addCooperationPeriod 加校验（查询企业的 qualification_Expiry_Date，已过期则禁止新增合作期限）
- 不做：前端校验（仅后端，简单方案）
- 验证：mvn EXIT 0 + 3 实例部署 0 ERROR

#### v4.10 前端优化（已交付，2026-07-02）
- 完成态：统一美化所有台账页面 + 新增 3 个智能统计页面
- 做了：
  - **业务看板**（005001）：渐变紫色背景 + 4 个 KPI 卡片（数字滚动动画）+ 4 个 ECharts 图表（趋势/效率仪表盘/排行/来源饼图）+ 8 个快捷入口
  - **投诉统计页**（005012）：3 个 ECharts 图表（合作方柱状图/来源饼图/状态饼图）+ 合作方投诉排行表
  - **合作期限统计页**（005014）：4 个 KPI 卡片 + 2 个图表（状态分布/到期时间分布）+ 到期预警列表（颜色分级）
  - **号码统计页**（005015）：4 个 KPI 卡片 + 4 个图表（类型/状态/合作方分布/使用率趋势）+ TOP 5 排行
  - **合作方统计页**（005016）：4 个 KPI 卡片 + 4 个图表（状态/投诉率/规模/趋势）+ 合作方详情排行
  - **统一美化**：合作方台账、合作期限台账、号码台账列表页（渐变背景 + 卡片布局 + hover 动效 + 圆角按钮）
- 设计风格：现代化渐变背景 + 玻璃态效果 + ECharts 图表 + 数字动画 + 响应式布局
- 菜单：005014/005015/005016 已添加，role 1/3/5 分配
- 验证：mvn EXIT 0 + 3 实例部署 0 ERROR

## 大版本 v5：导航整合
> ⚠️ 北极星/完成态待开发 session 回填——本段由部署 session 按部署事实记录。开发 session 在 SQL 注释/commit 命名为 v5.0。

### v5.0 台账/日志一级菜单壳页面（已交付，2026-07-07）
- 完成态：管理员侧边栏新增两个一级菜单「日志管理」(020)、「台账管理」(021)，点进去是列表页 UI；数据接口为桩（返回空），TODO 后续对接联合查询
- 做了：
  - `EnterpriseController` +`account_ledgerList()`、`SendedController` +`sms_logList()`（桩接口，`asSuccessString(new ArrayList<>(), 0)`）
  - 2 JSP：`admin/enterprise/account_ledger_list.jsp`、`admin/log/sms_log_list.jsp`（搜索表单 + layui 表格 + 静态 UI）
  - 2 菜单 SQL：020 日志管理 + 021 台账管理（各 1 menu + 3 button/showbutton + role 1/3/5 分配，导入 `sms_business`）
- 不做（进 vNext）：列表数据接口对接（input_log+inbox / enterprise+product+signature 联合查询）、批量导入 jsp+接口、导出
- 验证：mvn BUILD SUCCESS + 3 实例部署（admin 200、新接口 302 已注册非 404）+ 菜单 8 limit 入库 + role 各 8 权限；Web 端到端待人工冒烟

### 附：netway ROW_FORMAT 运行时坑修复（2026-07-07，部署副作用，与 v5.0 无关）
- `deploy-sms.sh` 全重启触发 netway 崩溃：`createTableTask` 建 `input_log20260713` 时 `ROW_FORMAT=COMPACT` 致 row size>8126 → `BeanCreationException` → context 关闭
- 修：4 个 send-dao mapper（`InputLog`/`Submit`/`Report`/`ReportNotify` `ExtMapper.xml`）`COMPACT→DYNAMIC` + 重建 netway war + 只重部署 netway（`/tools/deploy-netway-only.sh`）
- 详见 `docs/04-对话与进度.md` 阶段 10 + memory `sms-platform-deployed`

### vNext 候选池
- v4.5 业务台账聚合视图 → **已交付（业务看板 005001）**
- v4.6 R4-A 拒收识别 → **已提前交付**
- v4.7 字段强校验 → **已交付**
- v4.8 投诉统计报表 → **已交付**
- v4.9 拒收关键词配置 UI → **已交付**
- v4.10 前端优化 → **已交付（3 个统计页面 + 3 个台账美化）**
- 投诉附件上传（独立 RequestMapping，见 memory `sms-project-no-upload-endpoint`）
- 拒撤恢复/二次发送逻辑
- 不可篡改 DB 权限收紧（逐表分析写模式，人工门禁）
- R4-D 字段加密（监管强制才做）
- 更多告警渠道（短信/邮件/微信）
