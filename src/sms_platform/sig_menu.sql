-- 签名状态字典 signatureStatus
INSERT INTO code (Sort_Code, Code, Name, Value, Create_Date) VALUES
('signatureStatus','Start','启用','Start',NOW()),
('signatureStatus','Stop','停用','Stop',NOW());

-- 菜单 006038 短信签名管理 (Up_Code=006)
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('短信签名管理','006038','006','/admin/enterprise/sms_signature_list.jsp','menu',38,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('签名审核前置','006038001','006038','/admin/enterprise_preCheckSmsSignature','showbutton','<button class="layui-btn layuiadmin-btn-useradmin layui-btn-sm" lay-event=''{"type":"dialogTodo","url":"/admin/enterprise_preCheckSmsSignature","width":"750","height":"550","title":"签名审核"}''  title="签名审核" >签名审核</button>',1,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('签名审核','006038001001','006038001','/admin/enterprise_checkSmsSignature','button',2,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('添加短信签名','006038002','006038','/admin/enterprise_addSmsSignature','showbutton','<button class="layui-btn layuiadmin-btn-useradmin layui-btn-sm" lay-event=''{"type":"dialog","url":"/admin/enterprise/sms_signature_add.jsp","width":"600","height":"450","title":"添加签名"}'' title="添加签名" >添加</button>',2,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('修改短信签名前置','006038003','006038','/admin/enterprise_preSmsSignatureEdit','showbutton','<button class="layui-btn layuiadmin-btn-useradmin layui-btn-sm" lay-event=''{"type":"dialogTodo","url":"/admin/enterprise_preSmsSignatureEdit","title":"修改签名"}'' title="修改" >修改</button>',3,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('修改短信签名','006038003001','006038003','/admin/enterprise_editSmsSignature','button',1,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('批量删除短信签名','006038004','006038','/admin/enterprise_delSmsSignature','showbutton','<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event=''{"type":"selectedTodo","url":"/admin/enterprise_delSmsSignature","width":"800","height":"500"}''  title="确实要删除这些记录吗?" >批量删除</button>',5,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('短信签名列表','006038005','006038','/admin/enterprise_smsSignatureList','button',1,NOW());

-- 角色分配: role 1(管理员) 3(审核员) 5(普通管理员); 操作员 23 不给
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code LIKE '006038%'
  AND NOT EXISTS (
    SELECT 1 FROM admin_role_limit arl WHERE arl.Role_Id = r.Role_Id AND arl.Limit_Id = al.Id
  );
