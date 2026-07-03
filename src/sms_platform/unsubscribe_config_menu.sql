-- ============================================================
-- v4.9 拒收关键词配置 菜单+角色分配 (2026-07-02)
-- ============================================================

-- 菜单 005013 拒收关键词配置 (005 业务管理，Order=13 紧随 005012)
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('拒收关键词配置','005013','005','/admin/enterprise/unsubscribe_config.jsp','menu',13,NOW());

-- 保存配置接口
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('保存拒收关键词','005013000','005013','/admin/enterprise_saveUnsubscribeConfig','button',1,NOW());

-- 角色分配 role 1(管理员) 3(审核员) 5(普通管理员)
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code LIKE '005013%'
  AND NOT EXISTS (
    SELECT 1 FROM admin_role_limit arl WHERE arl.Role_Id = r.Role_Id AND arl.Limit_Id = al.Id
  );
