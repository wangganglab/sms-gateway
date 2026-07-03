package com.hero.wireless.web.entity.business;

import com.hero.wireless.web.entity.base.BaseEntity;

import java.util.Date;

/**
 * 投诉处理实体类
 */
public class Complaint extends BaseEntity {
    private Integer id;
    private String enterprise_No;
    private String product_No;
    private String sub_Code;
    private String phone_No;
    private String complaint_Content;
    private String complaint_Source;
    private Date complaint_Date;
    private String handle_Status;
    private Integer handle_User_Id;
    private String handle_Result;
    private Date handle_Date;
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

    public String getProduct_No() {
        return product_No;
    }

    public void setProduct_No(String product_No) {
        this.product_No = product_No;
    }

    public String getSub_Code() {
        return sub_Code;
    }

    public void setSub_Code(String sub_Code) {
        this.sub_Code = sub_Code;
    }

    public String getPhone_No() {
        return phone_No;
    }

    public void setPhone_No(String phone_No) {
        this.phone_No = phone_No;
    }

    public String getComplaint_Content() {
        return complaint_Content;
    }

    public void setComplaint_Content(String complaint_Content) {
        this.complaint_Content = complaint_Content;
    }

    public String getComplaint_Source() {
        return complaint_Source;
    }

    public void setComplaint_Source(String complaint_Source) {
        this.complaint_Source = complaint_Source;
    }

    public Date getComplaint_Date() {
        return complaint_Date;
    }

    public void setComplaint_Date(Date complaint_Date) {
        this.complaint_Date = complaint_Date;
    }

    public String getHandle_Status() {
        return handle_Status;
    }

    public void setHandle_Status(String handle_Status) {
        this.handle_Status = handle_Status;
    }

    public Integer getHandle_User_Id() {
        return handle_User_Id;
    }

    public void setHandle_User_Id(Integer handle_User_Id) {
        this.handle_User_Id = handle_User_Id;
    }

    public String getHandle_Result() {
        return handle_Result;
    }

    public void setHandle_Result(String handle_Result) {
        this.handle_Result = handle_Result;
    }

    public Date getHandle_Date() {
        return handle_Date;
    }

    public void setHandle_Date(Date handle_Date) {
        this.handle_Date = handle_Date;
    }

    public Date getCreate_Date() {
        return create_Date;
    }

    public void setCreate_Date(Date create_Date) {
        this.create_Date = create_Date;
    }
}
