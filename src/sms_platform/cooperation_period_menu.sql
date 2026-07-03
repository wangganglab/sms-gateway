-- ============================================================
-- v4.2 合作期限台账 字典+菜单+角色分配 (2026-07-01)
-- ============================================================

-- 状态字典 cooperationStatus
INSERT INTO code (Sort_Code, Code, Name, Value, Create_Date) VALUES
('cooperationStatus','1','有效','1',NOW()),
('cooperationStatus','0','终止','0',NOW());

-- 菜单 005008 合作期限台账 (005 业务管理，Order=8 紧随 005007)
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('合作期限台账','005008','005','/admin/enterprise/cooperation_period_list.jsp','menu',8,NOW());

-- 列表数据接口
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('合作期限列表','005008000','005008','/admin/enterprise_cooperationPeriodList','button',1,NOW());

-- 新增前置
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('新增合作期限前置','005008001','005008','/admin/enterprise_preAddCooperationPeriod','showbutton','<button class="layui-btn layuiadmin-btn-useradmin layui-btn-sm" lay-event=''{"type":"dialog","url":"/admin/enterprise/cooperation_period_add.jsp","width":"750","height":"600","title":"新增合作期限"}'' title="新增" >新增</button>',2,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('新增合作期限保存','005008001001','005008001','/admin/enterprise_addCooperationPeriod','button',1,NOW());

-- 编辑前置
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('修改合作期限前置','005008002','005008','/admin/enterprise_preCooperationPeriodEdit','showbutton','<button class="layui-btn layuiadmin-btn-useradmin layui-btn-sm" lay-event=''{"type":"dialogTodo","url":"/admin/enterprise_preCooperationPeriodEdit","width":"750","height":"600","title":"修改合作期限"}'' title="编辑" >编辑</button>',3,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('修改合作期限保存','005008002001','005008002','/admin/enterprise_editCooperationPeriod','button',1,NOW());

-- 终止（状态代替删除，批量）
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('终止合作期限','005008003','005008','/admin/enterprise_terminateCooperationPeriod','showbutton','<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event=''{"type":"selectedTodo","url":"/admin/enterprise_terminateCooperationPeriod","width":"600","height":"300"}'' title="确认终止所选记录?" >终止</button>',5,NOW());

-- 角色分配 role 1(管理员) 3(审核员) 5(普通管理员)；操作员不给
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code LIKE '005008%'
  AND NOT EXISTS (
    SELECT 1 FROM admin_role_limit arl WHERE arl.Role_Id = r.Role_Id AND arl.Limit_Id = al.Id
  );
