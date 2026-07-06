-- ============================================================
-- v5.0 台账管理 一级菜单 + 角色分配（2026-07-06）
-- 新增一级分类「台账管理」，包含在管企业台账信息页面
-- 角色：1 管理员 / 3 审核员 / 5 普通管理员
-- ============================================================

-- 一级菜单 021 台账管理 (Up_Code='00' 表示顶级分类)
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Icon, Order_Id, Create_Date) VALUES
('台账管理','021','00','/admin/enterprise/account_ledger_list.jsp','menu','layui-icon-template-1',21,NOW());

-- ★ 二级菜单 021010 企业台账（侧边栏实际点击入口，type_Code='menu'）
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('企业台账','021010','021','/admin/enterprise/account_ledger_list.jsp','menu',1,NOW());

-- 列表数据接口权限（必须配，否则表格加载被 RBAC 拦截）
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('台账列表','021000','021','/admin/account_ledgerList','button',1,NOW());

-- 批量导入
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('批量导入台账','021001','021','/admin/account_ledgerBatchImport','showbutton','<button class="layui-btn layui-btn-sm" lay-event=''{"type":"dialog","url":"/admin/enterprise/account_ledger_import.jsp","width":"750","height":"500","title":"批量导入台账"}'' title="批量导入" >批量导入</button>',2,NOW());

-- 导出列表
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('导出台账列表','021002','021','/admin/account_ledgerExport','showbutton','<button class="layui-btn layui-btn-sm" lay-event=''{"type":"ajaxTodo","url":"/admin/account_ledgerExport"}'' title="导出台账列表" >导出列表</button>',3,NOW());

-- 角色分配：role 1(管理员) 3(审核员) 5(普通管理员)
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code LIKE '021%'
  AND NOT EXISTS (
    SELECT 1 FROM admin_role_limit arl WHERE arl.Role_Id = r.Role_Id AND arl.Limit_Id = al.Id
  );
