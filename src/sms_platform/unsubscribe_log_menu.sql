-- ============================================================
-- v4.6 拒收记录 菜单+角色分配 (2026-07-02)
-- ============================================================

-- 注：拒收关键词配置由 DatabaseCache.getStringValueBySystemEnvAndCode("unsubscribe", "T,TD,退订")
-- 的默认值提供，无需在数据库表中插入。如需修改关键词，需在 system_env 配置表中添加。

-- 菜单 005011 拒收记录 (005 业务管理，Order=11 紧随 005010)
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('拒收记录','005011','005','/admin/enterprise/unsubscribe_log_list.jsp','menu',11,NOW());

-- 列表数据接口
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('拒收列表','005011000','005011','/admin/enterprise_unsubscribeLogList','button',1,NOW());

-- 查看详情
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('查看拒收详情','005011001','005011','/admin/enterprise_preUnsubscribeLogDetail','showbutton','<button class="layui-btn layui-btn-sm" lay-event=''{"type":"dialogTodo","url":"/admin/enterprise_preUnsubscribeLogDetail","width":"750","height":"600","title":"拒收详情"}'' title="详情" >详情</button>',2,NOW());

-- 角色分配 role 1(管理员) 3(审核员) 5(普通管理员)
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code LIKE '005011%'
  AND NOT EXISTS (
    SELECT 1 FROM admin_role_limit arl WHERE arl.Role_Id = r.Role_Id AND arl.Limit_Id = al.Id
  );
