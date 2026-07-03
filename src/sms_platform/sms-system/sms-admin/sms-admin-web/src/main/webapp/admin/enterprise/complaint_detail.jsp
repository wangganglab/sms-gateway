<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<body>
<c:set var="sourceDisplay" value=""/>
<c:choose>
    <c:when test="${cptBean.complaint_Source == 'operator'}"><c:set var="sourceDisplay" value="运营商"/></c:when>
    <c:when test="${cptBean.complaint_Source == 'user'}"><c:set var="sourceDisplay" value="用户"/></c:when>
    <c:when test="${cptBean.complaint_Source == 'regulator'}"><c:set var="sourceDisplay" value="监管"/></c:when>
    <c:otherwise><c:set var="sourceDisplay" value="${cptBean.complaint_Source}"/></c:otherwise>
</c:choose>
<c:set var="statusDisplay" value=""/>
<c:choose>
    <c:when test="${cptBean.handle_Status == '0'}"><c:set var="statusDisplay" value="待处理"/></c:when>
    <c:when test="${cptBean.handle_Status == '1'}"><c:set var="statusDisplay" value="处理中"/></c:when>
    <c:when test="${cptBean.handle_Status == '2'}"><c:set var="statusDisplay" value="已处理"/></c:when>
    <c:otherwise><c:set var="statusDisplay" value="未知"/></c:otherwise>
</c:choose>
<form class="layui-form" onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <div class="layui-form-item">
        <label class="layui-form-label">企业</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${cptBean.enterprise_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${cptBean.product_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">子端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${cptBean.sub_Code}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉号码</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${cptBean.phone_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉来源</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${sourceDisplay}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉时间</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<fmt:formatDate value="${cptBean.complaint_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉内容</label>
        <div class="layui-input-block">
            <textarea disabled class="layui-textarea" style="height:100px;"><c:out value="${cptBean.complaint_Content}"/></textarea>
        </div>
    </div>
    <hr/>
    <div class="layui-form-item">
        <label class="layui-form-label">处理状态</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${statusDisplay}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">处理人 ID</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${cptBean.handle_User_Id}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">处理时间</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<fmt:formatDate value="${cptBean.handle_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">处理结果</label>
        <div class="layui-input-block">
            <textarea disabled class="layui-textarea" style="height:100px;"><c:out value="${cptBean.handle_Result}"/></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">创建时间</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<fmt:formatDate value="${cptBean.create_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="layui-input"/>
        </div>
    </div>
</form>
<%@ include file="/admin/common/layui_bottom.jsp" %>
</body>
