package com.hero.wireless.web.entity.send;

import com.hero.wireless.web.entity.base.BaseExample;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 拒收记录查询条件类
 */
public class UnsubscribeLogExample extends BaseExample {
    protected String orderByClause;
    protected boolean distinct;
    protected String dataLock;
    protected List<Criteria> oredCriteria;

    public UnsubscribeLogExample() {
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

        public Criteria andIdEqualTo(Long value) {
            addCriterion("Id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Long> values) {
            addCriterion("Id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andEnterprise_NoIsNull() {
            addCriterion("Enterprise_No is null");
            return (Criteria) this;
        }

        public Criteria andEnterprise_NoEqualTo(String value) {
            addCriterion("Enterprise_No =", value, "enterprise_No");
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

        public Criteria andProduct_NoIsNull() {
            addCriterion("Product_No is null");
            return (Criteria) this;
        }

        public Criteria andProduct_NoEqualTo(String value) {
            addCriterion("Product_No =", value, "product_No");
            return (Criteria) this;
        }

        public Criteria andProduct_NoLike(String value) {
            addCriterion("Product_No like", value, "product_No");
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

        public Criteria andPhone_NoLike(String value) {
            addCriterion("Phone_No like", value, "phone_No");
            return (Criteria) this;
        }

        public Criteria andReject_ContentIsNull() {
            addCriterion("Reject_Content is null");
            return (Criteria) this;
        }

        public Criteria andReject_ContentLike(String value) {
            addCriterion("Reject_Content like", value, "reject_Content");
            return (Criteria) this;
        }

        public Criteria andReject_DateIsNull() {
            addCriterion("Reject_Date is null");
            return (Criteria) this;
        }

        public Criteria andReject_DateEqualTo(Date value) {
            addCriterion("Reject_Date =", value, "reject_Date");
            return (Criteria) this;
        }

        public Criteria andReject_DateBetween(Date value1, Date value2) {
            addCriterion("Reject_Date between", value1, value2, "reject_Date");
            return (Criteria) this;
        }

        public Criteria andInbox_IdIsNull() {
            addCriterion("Inbox_Id is null");
            return (Criteria) this;
        }

        public Criteria andInbox_IdEqualTo(Integer value) {
            addCriterion("Inbox_Id =", value, "inbox_Id");
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

        public Criteria andCreate_DateBetween(Date value1, Date value2) {
            addCriterion("Create_Date between", value1, value2, "create_Date");
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
