<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<body>
<form class="layui-form" action="/admin/enterprise_checkSmsSignature" lay-filter="form" onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <input name="id" hidden="true" value="<c:out value="${smsSignature.id}"/>">
    <div class="layui-form-item">
        <label class="layui-form-label">企业编号</label>
        <div class="layui-input-block">
            <input type="text" name="" readonly value="<c:out value="${smsSignature.enterprise_No}"/>" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">签名内容<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-block">
            <input type="text" name="" readonly value="<c:out value="${smsSignature.signature_Content}"/>" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">签名类型</label>
        <div class="layui-input-block">
            <input type="text" name="" readonly value="<c:out value="${smsSignature.signature_Type}"/>" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">审核<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline">
            <ht:herocodeselect sortCode="templateCheckStatus" selected="${smsSignature.approve_Status}" name="approve_Status"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">启用状态</label>
        <div class="layui-input-inline">
            <ht:herocodeselect sortCode="signatureStatus" selected="${smsSignature.status_Code}" name="status_Code"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">审核意见</label>
        <div class="layui-input-block">
            <textarea type="text" maxlength="512" name="approve_Remark" autocomplete="off" class="layui-textarea"></textarea>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="submit" id="layuiadmin-app-form-submit" value="确认">
    </div>
</form>
<%@ include file="/admin/common/layui_bottom.jsp" %>
</body>
