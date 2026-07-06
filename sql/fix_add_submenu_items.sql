-- ============================================================
-- v5.0 快速修复：补充二级菜单项（2026-07-07）
-- 问题：一级菜单已创建，但缺少二级菜单项（type_Code='menu'）
-- 导致侧边栏只有一级标题，没有可点击的页面入口
-- 使用：直接在数据库中执行此脚本
-- ============================================================

-- 日志管理(020) 下的二级菜单：短信日志
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date)
SELECT '短信日志','020010','020','/admin/log/sms_log_list.jsp','menu',1,NOW()
WHERE NOT EXISTS (SELECT 1 FROM admin_limit WHERE Code = '020010');

-- 台账管理(021) 下的二级菜单：企业台账
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date)
SELECT '企业台账','021010','021','/admin/enterprise/account_ledger_list.jsp','menu',1,NOW()
WHERE NOT EXISTS (SELECT 1 FROM admin_limit WHERE Code = '021010');

-- 为二级菜单分配角色权限（role 1/3/5）
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code IN ('020010', '021010')
  AND NOT EXISTS (
    SELECT 1 FROM admin_role_limit arl WHERE arl.Role_Id = r.Role_Id AND arl.Limit_Id = al.Id
  );

-- 验证：查看新菜单是否创建成功
SELECT Code, Name, Up_Code, Url, Type_Code, Order_Id
FROM admin_limit
WHERE Code IN ('020', '020010', '021', '021010')
ORDER BY Code;
