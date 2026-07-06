-- ============================================================
-- v5.0 日志管理 一级菜单 + 角色分配（2026-07-06）
-- 新增一级分类「日志管理」，包含发送/接收信息日志页面
-- 角色：1 管理员 / 3 审核员 / 5 普通管理员
-- ============================================================

-- 一级菜单 020 日志管理 (Up_Code='00' 表示顶级分类)
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Icon, Order_Id, Create_Date) VALUES
('日志管理','020','00','/admin/log/sms_log_list.jsp','menu','layui-icon-log',20,NOW());

-- 列表数据接口权限（必须配，否则表格加载被 RBAC 拦截）
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('短信日志列表','020000','020','/admin/sms_logList','button',1,NOW());

-- 批量导入
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('批量导入日志','020001','020','/admin/sms_logBatchImport','showbutton','<button class="layui-btn layui-btn-sm" lay-event=''{"type":"dialog","url":"/admin/log/sms_log_import.jsp","width":"750","height":"500","title":"批量导入日志"}'' title="批量导入" >批量导入</button>',2,NOW());

-- 导出列表
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('导出日志列表','020002','020','/admin/sms_logExport','showbutton','<button class="layui-btn layui-btn-sm" lay-event=''{"type":"ajaxTodo","url":"/admin/sms_logExport"}'' title="导出日志列表" >导出列表</button>',3,NOW());

-- 角色分配：role 1(管理员) 3(审核员) 5(普通管理员)
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code LIKE '020%'
  AND NOT EXISTS (
    SELECT 1 FROM admin_role_limit arl WHERE arl.Role_Id = r.Role_Id AND arl.Limit_Id = al.Id
  );
