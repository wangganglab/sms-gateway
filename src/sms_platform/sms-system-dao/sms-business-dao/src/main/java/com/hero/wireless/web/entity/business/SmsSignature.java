package com.hero.wireless.web.entity.business;

import com.hero.wireless.web.entity.base.BaseEntity;

import java.util.Date;

public class SmsSignature extends BaseEntity {
    private Integer id;
    private String enterprise_No;
    private String signature_Content;
    private String signature_Type;
    private String approve_Status;
    private Integer approve_User_Id;
    private Date approve_Date;
    private String approve_Remark;
    private String status_Code;
    private Date create_Date;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEnterprise_No() {
        return enterprise_No;
    }

    public void setEnterprise_No(String enterprise_No) {
        this.enterprise_No = enterprise_No;
    }

    public String getSignature_Content() {
        return signature_Content;
    }

    public void setSignature_Content(String signature_Content) {
        this.signature_Content = signature_Content;
    }

    public String getSignature_Type() {
        return signature_Type;
    }

    public void setSignature_Type(String signature_Type) {
        this.signature_Type = signature_Type;
    }

    public String getApprove_Status() {
        return approve_Status;
    }

    public void setApprove_Status(String approve_Status) {
        this.approve_Status = approve_Status;
    }

    public Integer getApprove_User_Id() {
        return approve_User_Id;
    }

    public void setApprove_User_Id(Integer approve_User_Id) {
        this.approve_User_Id = approve_User_Id;
    }

    public Date getApprove_Date() {
        return approve_Date;
    }

    public void setApprove_Date(Date approve_Date) {
        this.approve_Date = approve_Date;
    }

    public String getApprove_Remark() {
        return approve_Remark;
    }

    public void setApprove_Remark(String approve_Remark) {
        this.approve_Remark = approve_Remark;
    }

    public String getStatus_Code() {
        return status_Code;
    }

    public void setStatus_Code(String status_Code) {
        this.status_Code = status_Code;
    }

    public Date getCreate_Date() {
        return create_Date;
    }

    public void setCreate_Date(Date create_Date) {
        this.create_Date = create_Date;
    }
}
