<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<body>
<form class="layui-form" action="/admin/product/editProduct" lay-filter="form" onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <input type="hidden" name="id" value="<c:out value="${product.id}"/>"/>
    <div class="layui-form-item">
        <label class="layui-form-label">名称<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline">
            <input type="text" maxlength="128" name="name" lay-verify="required" placeholder="请输入名称" autocomplete="off"
                   value="<c:out value="${product.name}"/>" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">产品编码</label>
        <div class="layui-input-inline">
            <input type="text" name="code"  placeholder="请输入代码" autocomplete="off"
                   value="<c:out value="${product.no}"/>" class="layui-input" readonly>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">行业类型</label>
        <div class="layui-input-inline">
            <ht:herocodeselect sortCode="trade" selected="${product.trade_Type_Code}" name="trade_Type_Code"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">拦截策略</label>
        <div class="layui-input-inline">
            <ht:herocustomdataselect dataSourceType="interceptStrategy" name="intercept_Strategy_Id" headerValue="-1" selected="${product.intercept_Strategy_Id}"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">码号类型</label>
        <div class="layui-input-inline">
            <input type="text" maxlength="64" name="code_Type" value="<c:out value="${product.code_Type}"/>" placeholder="请输入" autocomplete="off" class="layui-input"/>
        </div>
        <label class="layui-form-label">归属合作方</label>
        <div class="layui-input-inline" style="width:300px;">
            <ht:heroenterpriseselect name="enterprise_No" selected="${product.enterprise_No}"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">启用日期</label>
        <div class="layui-input-inline">
            <input type="text" name="activate_Date" id="activate_Date" value="<fmt:formatDate value="${product.activate_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" placeholder="请选择日期" autocomplete="off" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">详情</label>
        <div class="layui-input-block">
            <textarea maxlength="1024" name="number_Detail" autocomplete="off" class="layui-textarea"><c:out value="${product.number_Detail}"/></textarea>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <input type="submit" lay-submit lay-filter="submit" id="layuiadmin-app-form-submit" value="确认">
    </div>
</form>
<%@ include file="/admin/common/layui_bottom.jsp" %>
<script>
    layui.use(['laydate'], function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#activate_Date',
            type: 'datetime',
            trigger: 'click'
        });
    });
</script>
</body>