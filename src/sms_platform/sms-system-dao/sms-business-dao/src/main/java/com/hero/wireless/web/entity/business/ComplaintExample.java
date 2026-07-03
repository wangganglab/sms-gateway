package com.hero.wireless.web.entity.business;

import com.hero.wireless.web.entity.base.BaseExample;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 投诉处理查询条件类
 */
public class ComplaintExample extends BaseExample {
    protected String orderByClause;
    protected boolean distinct;
    protected String dataLock;
    protected List<Criteria> oredCriteria;

    public ComplaintExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public void setDataLock(String dataLock) {
        this.dataLock = dataLock;
    }

    public String getDataLock() {
        return dataLock;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        public void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        public void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        public void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("Id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("Id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(Integer value) {
            addCriterion("Id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(Integer value) {
            addCriterion("Id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Integer> values) {
            addCriterion("Id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<Integer> values) {
            addCriterion("Id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andEnterprise_NoIsNull() {
            addCriterion("Enterprise_No is null");
            return (Criteria) this;
        }

        public Criteria andEnterprise_NoIsNotNull() {
            addCriterion("Enterprise_No is not null");
            return (Criteria) this;
        }

        public Criteria andEnterprise_NoEqualTo(String value) {
            addCriterion("Enterprise_No =", value, "enterprise_No");
            return (Criteria) this;
        }

        public Criteria andEnterprise_NoNotEqualTo(String value) {
            addCriterion("Enterprise_No <>", value, "enterprise_No");
            return (Criteria) this;
        }

        public Criteria andEnterprise_NoLike(String value) {
            addCriterion("Enterprise_No like", value, "enterprise_No");
            return (Criteria) this;
        }

        public Criteria andEnterprise_NoIn(List<String> values) {
            addCriterion("Enterprise_No in", values, "enterprise_No");
            return (Criteria) this;
        }

        public Criteria andEnterprise_NoNotIn(List<String> values) {
            addCriterion("Enterprise_No not in", values, "enterprise_No");
            return (Criteria) this;
        }

        public Criteria andProduct_NoIsNull() {
            addCriterion("Product_No is null");
            return (Criteria) this;
        }

        public Criteria andProduct_NoIsNotNull() {
            addCriterion("Product_No is not null");
            return (Criteria) this;
        }

        public Criteria andProduct_NoEqualTo(String value) {
            addCriterion("Product_No =", value, "product_No");
            return (Criteria) this;
        }

        public Criteria andProduct_NoNotEqualTo(String value) {
            addCriterion("Product_No <>", value, "product_No");
            return (Criteria) this;
        }

        public Criteria andProduct_NoLike(String value) {
            addCriterion("Product_No like", value, "product_No");
            return (Criteria) this;
        }

        public Criteria andProduct_NoIn(List<String> values) {
            addCriterion("Product_No in", values, "product_No");
            return (Criteria) this;
        }

        public Criteria andSub_CodeIsNull() {
            addCriterion("Sub_Code is null");
            return (Criteria) this;
        }

        public Criteria andSub_CodeEqualTo(String value) {
            addCriterion("Sub_Code =", value, "sub_Code");
            return (Criteria) this;
        }

        public Criteria andSub_CodeNotEqualTo(String value) {
            addCriterion("Sub_Code <>", value, "sub_Code");
            return (Criteria) this;
        }

        public Criteria andSub_CodeLike(String value) {
            addCriterion("Sub_Code like", value, "sub_Code");
            return (Criteria) this;
        }

        public Criteria andPhone_NoIsNull() {
            addCriterion("Phone_No is null");
            return (Criteria) this;
        }

        public Criteria andPhone_NoEqualTo(String value) {
            addCriterion("Phone_No =", value, "phone_No");
            return (Criteria) this;
        }

        public Criteria andPhone_NoNotEqualTo(String value) {
            addCriterion("Phone_No <>", value, "phone_No");
            return (Criteria) this;
        }

        public Criteria andPhone_NoLike(String value) {
            addCriterion("Phone_No like", value, "phone_No");
            return (Criteria) this;
        }

        public Criteria andComplaint_ContentIsNull() {
            addCriterion("Complaint_Content is null");
            return (Criteria) this;
        }

        public Criteria andComplaint_ContentLike(String value) {
            addCriterion("Complaint_Content like", value, "complaint_Content");
            return (Criteria) this;
        }

        public Criteria andComplaint_SourceIsNull() {
            addCriterion("Complaint_Source is null");
            return (Criteria) this;
        }

        public Criteria andComplaint_SourceEqualTo(String value) {
            addCriterion("Complaint_Source =", value, "complaint_Source");
            return (Criteria) this;
        }

        public Criteria andComplaint_SourceNotEqualTo(String value) {
            addCriterion("Complaint_Source <>", value, "complaint_Source");
            return (Criteria) this;
        }

        public Criteria andComplaint_SourceIn(List<String> values) {
            addCriterion("Complaint_Source in", values, "complaint_Source");
            return (Criteria) this;
        }

        public Criteria andComplaint_DateIsNull() {
            addCriterion("Complaint_Date is null");
            return (Criteria) this;
        }

        public Criteria andComplaint_DateEqualTo(Date value) {
            addCriterion("Complaint_Date =", value, "complaint_Date");
            return (Criteria) this;
        }

        public Criteria andHandle_StatusIsNull() {
            addCriterion("Handle_Status is null");
            return (Criteria) this;
        }

        public Criteria andHandle_StatusEqualTo(String value) {
            addCriterion("Handle_Status =", value, "handle_Status");
            return (Criteria) this;
        }

        public Criteria andHandle_StatusNotEqualTo(String value) {
            addCriterion("Handle_Status <>", value, "handle_Status");
            return (Criteria) this;
        }

        public Criteria andHandle_StatusIn(List<String> values) {
            addCriterion("Handle_Status in", values, "handle_Status");
            return (Criteria) this;
        }

        public Criteria andHandle_User_IdIsNull() {
            addCriterion("Handle_User_Id is null");
            return (Criteria) this;
        }

        public Criteria andHandle_User_IdEqualTo(Integer value) {
            addCriterion("Handle_User_Id =", value, "handle_User_Id");
            return (Criteria) this;
        }

        public Criteria andHandle_User_IdIn(List<Integer> values) {
            addCriterion("Handle_User_Id in", values, "handle_User_Id");
            return (Criteria) this;
        }

        public Criteria andHandle_ResultIsNull() {
            addCriterion("Handle_Result is null");
            return (Criteria) this;
        }

        public Criteria andHandle_ResultLike(String value) {
            addCriterion("Handle_Result like", value, "handle_Result");
            return (Criteria) this;
        }

        public Criteria andHandle_DateIsNull() {
            addCriterion("Handle_Date is null");
            return (Criteria) this;
        }

        public Criteria andHandle_DateEqualTo(Date value) {
            addCriterion("Handle_Date =", value, "handle_Date");
            return (Criteria) this;
        }

        public Criteria andCreate_DateIsNull() {
            addCriterion("Create_Date is null");
            return (Criteria) this;
        }

        public Criteria andCreate_DateEqualTo(Date value) {
            addCriterion("Create_Date =", value, "create_Date");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {
        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;
        private Object value;
        private Object secondValue;
        private boolean noValue;
        private boolean singleValue;
        private boolean betweenValue;
        private boolean listValue;
        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}
