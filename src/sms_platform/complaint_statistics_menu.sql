-- ============================================================
-- v4.8 投诉统计 菜单+角色分配 (2026-07-02)
-- ============================================================

-- 菜单 005012 投诉统计 (005 业务管理，Order=12 紧随 005011)
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('投诉统计','005012','005','/admin/enterprise/complaint_statistics.jsp','menu',12,NOW());

-- 统计数据接口
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('投诉统计数据','005012000','005012','/admin/enterprise_complaintStatisticsData','button',1,NOW());

-- 角色分配 role 1(管理员) 3(审核员) 5(普通管理员)
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code LIKE '005012%'
  AND NOT EXISTS (
    SELECT 1 FROM admin_role_limit arl WHERE arl.Role_Id = r.Role_Id AND arl.Limit_Id = al.Id
  );
