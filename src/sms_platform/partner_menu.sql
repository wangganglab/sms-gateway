-- ============================================================
-- v4.1 合作方台账 菜单 + 角色分配（2026-07-01）
-- 业务管理(005)下新增「合作方台账」入口，复用现有企业列表/编辑页做合规视角
-- 字段来源：enterprise 扩 6 字段(Credit_Code/Business_Scope/Qualification_Expiry_Date/
--   Cooperation_Start_Date/Cooperation_End_Date/Contact_Name)，见 sql/r4-r5-tables.sql
-- 角色：1 管理员 / 3 审核员 / 5 普通管理员；操作员不给(第1批 R2 已限定操作员白名单)
-- ============================================================

-- 菜单 005007 合作方台账 (Up_Code=005 业务管理，Order=7 紧随 005006 号码路由)
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('合作方台账','005007','005','/admin/enterprise/list.jsp','menu',7,NOW());

-- 列表数据接口（仿 003004015 企业管理列表，权限点必须配，否则表格加载被 RBAC 拦截）
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('合作方台账列表','005007015','005007','/admin/enterprise_list','button',1,NOW());

-- 修改前置（仿 003004009 修改企业前置，弹窗打开 enterprise/edit.jsp）
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('修改合作方前置','005007009','005007','/admin/enterprise_preEdit','showbutton','<button class="layui-btn layuiadmin-btn-useradmin layui-btn-sm" lay-event=''{"type":"dialogTodo","url":"/admin/enterprise_preEdit","width":"750","height":"600","title":"编辑合作方台账"}'' title="编辑" >编辑</button>',2,NOW());

-- 修改保存
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('修改合作方','005007009001','005007009','/admin/enterprise_edit','button',1,NOW());

-- 角色分配：role 1(管理员) 3(审核员) 5(普通管理员)；操作员不给
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code LIKE '005007%';
