package com.hero.wireless.web.entity.business.ext;

import com.hero.wireless.web.entity.business.Complaint;
import com.hero.wireless.web.entity.business.Enterprise;
import com.hero.wireless.web.entity.business.Product;

/**
 * 投诉处理扩展实体类（用于列表显示关联的企业名和产品名）
 */
public class ComplaintExt extends Complaint {

    private Enterprise enterprise;
    private Product product;

    public Enterprise getEnterprise() {
        return enterprise;
    }

    public void setEnterprise(Enterprise enterprise) {
        this.enterprise = enterprise;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
