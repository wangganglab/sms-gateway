<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<body>
<form class="layui-form" onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <div class="layui-form-item">
        <label class="layui-form-label">企业</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${unsubBean.enterprise_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${unsubBean.product_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">子端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${unsubBean.sub_Code}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">拒收号码</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${unsubBean.phone_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">拒收内容</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${unsubBean.reject_Content}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">拒收时间</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<fmt:formatDate value="${unsubBean.reject_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">Inbox ID</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${unsubBean.inbox_Id}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">创建时间</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<fmt:formatDate value="${unsubBean.create_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="layui-input"/>
        </div>
    </div>
</form>
<%@ include file="/admin/common/layui_bottom.jsp" %>
</body>
