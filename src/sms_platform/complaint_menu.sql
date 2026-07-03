-- ============================================================
-- v4.4 投诉处理 字典+菜单+角色分配 (2026-07-02)
-- ============================================================

-- 状态字典 complaintStatus
INSERT INTO code (Sort_Code, Code, Name, Value, Create_Date) VALUES
('complaintStatus','0','待处理','0',NOW()),
('complaintStatus','1','处理中','1',NOW()),
('complaintStatus','2','已处理','2',NOW());

-- 来源字典 complaintSource
INSERT INTO code (Sort_Code, Code, Name, Value, Create_Date) VALUES
('complaintSource','operator','运营商','operator',NOW()),
('complaintSource','user','用户','user',NOW()),
('complaintSource','regulator','监管','regulator',NOW());

-- 菜单 005010 投诉处理 (005 业务管理，Order=10 紧随 005009)
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('投诉处理','005010','005','/admin/enterprise/complaint_list.jsp','menu',10,NOW());

-- 列表数据接口
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('投诉列表','005010000','005010','/admin/enterprise_complaintList','button',1,NOW());

-- 新增前置
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('新增投诉前置','005010001','005010','/admin/enterprise_preAddComplaint','showbutton','<button class="layui-btn layuiadmin-btn-useradmin layui-btn-sm" lay-event=''{"type":"dialog","url":"/admin/enterprise/complaint_add.jsp","width":"750","height":"600","title":"新增投诉"}'' title="新增" >新增</button>',2,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('新增投诉保存','005010001001','005010001','/admin/enterprise_addComplaint','button',1,NOW());

-- 编辑前置
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('修改投诉前置','005010002','005010','/admin/enterprise_preComplaintEdit','showbutton','<button class="layui-btn layuiadmin-btn-useradmin layui-btn-sm" lay-event=''{"type":"dialogTodo","url":"/admin/enterprise_preComplaintEdit","width":"750","height":"600","title":"修改投诉"}'' title="编辑" >编辑</button>',3,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('修改投诉保存','005010002001','005010002','/admin/enterprise_editComplaint','button',1,NOW());

-- 处理投诉（更新状态/处理人/处理结果/处理时间）
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('处理投诉','005010003','005010','/admin/enterprise_preComplaintHandle','showbutton','<button class="layui-btn layui-btn-warm layui-btn-sm" lay-event=''{"type":"dialogTodo","url":"/admin/enterprise_preComplaintHandle","width":"750","height":"600","title":"处理投诉"}'' title="处理" >处理</button>',4,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('处理投诉保存','005010003001','005010003','/admin/enterprise_handleComplaint','button',1,NOW());

-- 查看详情
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('查看投诉详情','005010004','005010','/admin/enterprise_preComplaintDetail','showbutton','<button class="layui-btn layui-btn-sm" lay-event=''{"type":"dialogTodo","url":"/admin/enterprise_preComplaintDetail","width":"750","height":"600","title":"投诉详情"}'' title="详情" >详情</button>',5,NOW());

-- 角色分配 role 1(管理员) 3(审核员) 5(普通管理员)；操作员不给
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code LIKE '005010%'
  AND NOT EXISTS (
    SELECT 1 FROM admin_role_limit arl WHERE arl.Role_Id = r.Role_Id AND arl.Limit_Id = al.Id
  );
