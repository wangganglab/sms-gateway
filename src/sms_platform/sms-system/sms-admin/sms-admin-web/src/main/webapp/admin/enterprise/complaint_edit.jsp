<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<body>
<form class="layui-form" action="/admin/enterprise_editComplaint" lay-filter="form" onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <input name="id" hidden="true" value="<c:out value="${cptBean.id}"/>">
    <div class="layui-form-item">
        <label class="layui-form-label">企业</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${cptBean.enterprise_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="product_No" value="<c:out value="${cptBean.product_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">子端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="sub_Code" value="<c:out value="${cptBean.sub_Code}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉号码</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="phone_No" value="<c:out value="${cptBean.phone_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉来源</label>
        <div class="layui-input-inline" style="width:300px;">
            <ht:herocodeselect sortCode="complaintSource" name="complaint_Source" selected="${cptBean.complaint_Source}"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉时间</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="complaint_Date" id="complaint_Date" value="<fmt:formatDate value="${cptBean.complaint_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉内容</label>
        <div class="layui-input-block">
            <textarea name="complaint_Content" class="layui-textarea" style="height:120px;"><c:out value="${cptBean.complaint_Content}"/></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-inline" style="width:300px;">
            <ht:herocodeselect sortCode="complaintStatus" name="handle_Status" selected="${cptBean.handle_Status}"/>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="submit" id="layuiadmin-app-form-submit" value="确认">
    </div>
</form>
<%@ include file="/admin/common/layui_bottom.jsp" %>
<script>
    layui.use(['laydate'], function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#complaint_Date',
            type: 'datetime',
            trigger: 'click'
        });
    });
</script>
</body>
