-- ============================================================
-- v4.3 号码台账 菜单 + 角色分配（2026-07-01）
-- 业务管理(005)下新增「号码台账」入口，复用现有产品列表/编辑/新增页做合规视角
-- 字段来源：product 扩 4 字段(Code_Type/Enterprise_No/Activate_Date/Number_Detail)
--   见 sql/r4-r5-tables.sql 第 63-68 行
-- 角色：1 管理员 / 3 审核员 / 5 普通管理员；操作员不给(第1批 R2 已限定操作员白名单)
-- ============================================================

-- 菜单 005009 号码台账 (Up_Code=005 业务管理，Order=9 紧随 005008 合作期限台账)
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('号码台账','005009','005','/admin/product/product_list.jsp','menu',9,NOW());

-- 列表数据接口（仿 004007001 产品列表，权限点必须配，否则表格加载被 RBAC 拦截）
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('号码台账列表','005009001','005009','/admin/product/productList','button',1,NOW());

-- 新增前置（仿 004007002 添加产品）
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('新增产品前置','005009002','005009','/admin/product/addProduct','showbutton','<button class="layui-btn layuiadmin-btn-useradmin layui-btn-sm" lay-event=''{"type":"dialog","url":"/admin/product/product_add.jsp","width":"750","height":"600","title":"新增号码台账"}'' title="新增" >新增</button>',2,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('新增产品保存','005009002001','005009002','/admin/product/addProduct','button',1,NOW());

-- 修改前置（仿 004007006 修改产品前置）
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Button_Action, Order_Id, Create_Date) VALUES
('修改产品前置','005009006','005009','/admin/product/preProductEdit','showbutton','<button class="layui-btn layuiadmin-btn-useradmin layui-btn-sm" lay-event=''{"type":"dialogTodo","url":"/admin/product/preProductEdit","width":"750","height":"600","title":"编辑号码台账"}'' title="编辑" >编辑</button>',3,NOW());
INSERT INTO admin_limit (Name, Code, Up_Code, Url, Type_Code, Order_Id, Create_Date) VALUES
('修改产品','005009006001','005009006','/admin/product/editProduct','button',1,NOW());

-- 角色分配：role 1(管理员) 3(审核员) 5(普通管理员)；操作员不给
INSERT INTO admin_role_limit (Role_Id, Limit_Id, Create_Date)
SELECT r.Role_Id, al.Id, NOW()
FROM (SELECT 1 AS Role_Id UNION SELECT 3 UNION SELECT 5) r
CROSS JOIN admin_limit al
WHERE al.Code LIKE '005009%'
  AND NOT EXISTS (
    SELECT 1 FROM admin_role_limit arl WHERE arl.Role_Id = r.Role_Id AND arl.Limit_Id = al.Id
  );
