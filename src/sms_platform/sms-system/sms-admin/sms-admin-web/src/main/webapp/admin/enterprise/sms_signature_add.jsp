<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<%@ include file="/admin/common/dynamic_data.jsp" %>
<form class="layui-form" action="/admin/enterprise_addSmsSignature" lay-filter="form" id="dialogFormId"  onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <div class="layui-form-item">
        <label class="layui-form-label">企业<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <ht:heroenterpriseselect  layVerify = "required" name="enterprise_No" id="enterprise_No"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">签名内容<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-form-item">
            <input type="text" maxlength="64" name="signature_Content" placeholder="请输入带书名号的签名,如【信速应】" autocomplete="off" class="layui-input"  lay-verify="required">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">签名类型</label>
        <div class="layui-input-inline">
            <select name="signature_Type">
                <option value="">请选择</option>
                <option value="企业名">企业名</option>
                <option value="产品名">产品名</option>
                <option value="简称">简称</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="submit" id="layuiadmin-app-form-submit" value="确认">
    </div>
</form>
<%@ include file="/admin/common/layui_bottom.jsp" %>
</body>
