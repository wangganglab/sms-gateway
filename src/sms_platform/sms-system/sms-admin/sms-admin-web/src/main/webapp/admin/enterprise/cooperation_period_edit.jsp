<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<body>
<form class="layui-form" action="/admin/enterprise_editCooperationPeriod" lay-filter="form" onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <input name="id" hidden="true" value="<c:out value="${cpBean.id}"/>">
    <div class="layui-form-item">
        <label class="layui-form-label">企业</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" disabled value="<c:out value="${cpBean.enterprise_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="product_No" value="<c:out value="${cpBean.product_No}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">子端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="sub_Code" value="<c:out value="${cpBean.sub_Code}"/>" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">开始日期<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="start_Date" id="start_Date" value="<fmt:formatDate value="${cpBean.start_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" placeholder="yyyy-MM-dd HH:mm:ss" autocomplete="off" class="layui-input" lay-verify="required"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">结束日期<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="end_Date" id="end_Date" value="<fmt:formatDate value="${cpBean.end_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" placeholder="yyyy-MM-dd HH:mm:ss" autocomplete="off" class="layui-input" lay-verify="required"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">合同 URL</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" maxlength="255" name="contract_Url" value="<c:out value="${cpBean.contract_Url}"/>" placeholder="合同附件 URL(可选)" autocomplete="off" class="layui-input"/>
        </div>
        <c:if test="${not empty cpBean.contract_Url}">
            <a href="<c:out value="${cpBean.contract_Url}"/>" target="_blank" class="layui-btn layui-btn-sm layui-btn-normal" style="margin-left:10px;">查看合同</a>
        </c:if>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-inline">
            <ht:herocodeselect sortCode="cooperationStatus" name="status_Code" selected="${cpBean.status_Code}"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea name="remark" placeholder="请输入备注" class="layui-textarea"><c:out value="${cpBean.remark}"/></textarea>
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

        // 日期时间选择器
        laydate.render({
            elem: '#start_Date',
            type: 'datetime',
            trigger: 'click'
        });
        laydate.render({
            elem: '#end_Date',
            type: 'datetime',
            trigger: 'click',
            done: function(value, date, endDate){
                if (value && $('#start_Date').val() && value <= $('#start_Date').val()) {
                    layer.msg('结束日期必须大于开始日期');
                    this.elem.val('');
                }
            }
        });
    });
</script>
</body>
