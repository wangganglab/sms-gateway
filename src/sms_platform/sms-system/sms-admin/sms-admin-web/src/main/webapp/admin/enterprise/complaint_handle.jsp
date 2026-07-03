<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<%@ include file="/admin/common/dynamic_data.jsp" %>
<body>
<form class="layui-form" action="/admin/enterprise_handleComplaint" lay-filter="form" onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <input name="id" hidden="true" value="<c:out value="${cptBean.id}"/>">
    <!-- 投诉原始信息（只读展示）-->
    <div class="layui-form-item">
        <label class="layui-form-label">企业</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${cptBean.enterprise_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉号码</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${cptBean.phone_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉内容</label>
        <div class="layui-input-block">
            <textarea disabled class="layui-textarea" style="height:80px;"><c:out value="${cptBean.complaint_Content}"/></textarea>
        </div>
    </div>
    <hr/>
    <!-- 处理信息（可编辑）-->
    <div class="layui-form-item">
        <label class="layui-form-label">处理状态<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <ht:herocodeselect sortCode="complaintStatus" layVerify="required" name="handle_Status" selected="${cptBean.handle_Status}"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">处理人 ID</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="number" name="handle_User_Id" value="<c:out value="${cptBean.handle_User_Id}"/>" placeholder="处理人用户 ID" autocomplete="off" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">处理时间</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="handle_Date" id="handle_Date" value="<fmt:formatDate value="${cptBean.handle_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" placeholder="yyyy-MM-dd HH:mm:ss" autocomplete="off" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">处理结果<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-block">
            <textarea name="handle_Result" lay-verify="required" placeholder="请输入处理结果" class="layui-textarea" style="height:120px;"><c:out value="${cptBean.handle_Result}"/></textarea>
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
            elem: '#handle_Date',
            type: 'datetime',
            trigger: 'click'
        });
    });
</script>
</body>
