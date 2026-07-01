-- ============================================================
-- 第4批 R5 台账 + R4-A 拒收 数据基础（2026-07-01 执行）
-- 纯 DDL：建 3 新表 + enterprise/product 扩字段。零破坏（不改现有数据/页面）
-- 仿 sms_template 风格：PascalCase 字段 / utf8mb3 / ROW_FORMAT=DYNAMIC / 带 COMMENT
-- ============================================================

-- === R5 合作期限台账（sms_business）===
CREATE TABLE IF NOT EXISTS sms_business.cooperation_period (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `Enterprise_No` varchar(128) NOT NULL DEFAULT '0' COMMENT '合作方企业编号',
  `Product_No` varchar(128) DEFAULT NULL COMMENT '端口号码',
  `Sub_Code` varchar(128) DEFAULT NULL COMMENT '子端口',
  `Start_Date` date DEFAULT NULL COMMENT '合作开始日',
  `End_Date` date DEFAULT NULL COMMENT '合作结束日',
  `Contract_Url` varchar(255) DEFAULT NULL COMMENT '协议合同附件',
  `Status_Code` varchar(32) DEFAULT '1' COMMENT '有效/终止',
  `Remark` varchar(2048) DEFAULT NULL COMMENT '备注',
  `Create_Date` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC COMMENT='合作期限台账';

-- === R5 投诉处理台账（sms_business）===
CREATE TABLE IF NOT EXISTS sms_business.complaint (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `Enterprise_No` varchar(128) NOT NULL DEFAULT '0' COMMENT '涉事合作方',
  `Product_No` varchar(128) DEFAULT NULL COMMENT '端口',
  `Sub_Code` varchar(128) DEFAULT NULL COMMENT '子端口',
  `Phone_No` varchar(128) DEFAULT NULL COMMENT '投诉号码',
  `Complaint_Content` varchar(2048) DEFAULT NULL COMMENT '投诉内容',
  `Complaint_Source` varchar(64) DEFAULT NULL COMMENT '投诉来源:运营商/用户/监管',
  `Complaint_Date` datetime DEFAULT NULL COMMENT '投诉时间',
  `Handle_Status` varchar(32) DEFAULT '0' COMMENT '处理状态:0待处理1处理中2已处理',
  `Handle_User_Id` int(11) DEFAULT NULL COMMENT '处理人',
  `Handle_Result` varchar(2048) DEFAULT NULL COMMENT '处理结果',
  `Handle_Date` datetime DEFAULT NULL COMMENT '处理时间',
  `Create_Date` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC COMMENT='投诉处理台账';

-- === R4-A 拒收/退订台账（sms_send，关联 inbox）===
CREATE TABLE IF NOT EXISTS sms_send.unsubscribe_log (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `Enterprise_No` varchar(128) DEFAULT NULL COMMENT '企业编号',
  `Product_No` varchar(128) DEFAULT NULL COMMENT '端口',
  `Sub_Code` varchar(128) DEFAULT NULL COMMENT '子端口',
  `Phone_No` varchar(128) DEFAULT NULL COMMENT '拒收用户号码',
  `Reject_Content` varchar(2000) DEFAULT NULL COMMENT '拒收信息内容:如TD',
  `Reject_Date` datetime DEFAULT NULL COMMENT '拒收时间',
  `Inbox_Id` int(11) DEFAULT NULL COMMENT '关联inbox原始记录',
  `Create_Date` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=DYNAMIC COMMENT='拒收/退订台账';

-- === R5 enterprise 扩字段（合作方台账）===
ALTER TABLE sms_business.enterprise
  ADD COLUMN Credit_Code varchar(18) DEFAULT NULL COMMENT '统一社会信用代码',
  ADD COLUMN Business_Scope varchar(1024) DEFAULT NULL COMMENT '经营范围',
  ADD COLUMN Qualification_Expiry_Date date DEFAULT NULL COMMENT '资质有效期',
  ADD COLUMN Cooperation_Start_Date date DEFAULT NULL COMMENT '合作开始日',
  ADD COLUMN Cooperation_End_Date date DEFAULT NULL COMMENT '合作结束日',
  ADD COLUMN Contact_Name varchar(64) DEFAULT NULL COMMENT '联系人';

-- === R5 product 扩字段（号码台账）===
ALTER TABLE sms_business.product
  ADD COLUMN Code_Type varchar(64) DEFAULT NULL COMMENT '码号使用类型',
  ADD COLUMN Enterprise_No varchar(128) DEFAULT NULL COMMENT '归属合作方',
  ADD COLUMN Activate_Date date DEFAULT NULL COMMENT '启用日期',
  ADD COLUMN Number_Detail varchar(1024) DEFAULT NULL COMMENT '码号资源详情';
