package com.hero.wireless.web.entity.send;

import com.hero.wireless.web.entity.base.BaseEntity;

import java.util.Date;

/**
 * 拒收记录实体类
 */
public class UnsubscribeLog extends BaseEntity {
    private Long id;
    private String enterprise_No;
    private String product_No;
    private String sub_Code;
    private String phone_No;
    private String reject_Content;
    private Date reject_Date;
    private Integer inbox_Id;
    private Date create_Date;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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

    public String getReject_Content() {
        return reject_Content;
    }

    public void setReject_Content(String reject_Content) {
        this.reject_Content = reject_Content;
    }

    public Date getReject_Date() {
        return reject_Date;
    }

    public void setReject_Date(Date reject_Date) {
        this.reject_Date = reject_Date;
    }

    public Integer getInbox_Id() {
        return inbox_Id;
    }

    public void setInbox_Id(Integer inbox_Id) {
        this.inbox_Id = inbox_Id;
    }

    public Date getCreate_Date() {
        return create_Date;
    }

    public void setCreate_Date(Date create_Date) {
        this.create_Date = create_Date;
    }
}
