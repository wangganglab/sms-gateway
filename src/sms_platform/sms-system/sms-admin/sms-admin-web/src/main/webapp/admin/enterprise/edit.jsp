<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<body>
<form class="layui-form" id="layui-form" action="/admin/enterprise_edit" lay-filter="form" onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <input hidden name="id" value="<c:out value="${eBean.id}"/>"/>
    <div class="layui-form-item">
        <label class="layui-form-label">企业名称<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-block"  style="width: 70%">
            <input type="text" maxlength="128" name="name" value="<c:out value="${eBean.name}"/>"  placeholder="请输入" autocomplete="off"  class="layui-input" >
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">企业联系人</label>
        <div class="layui-input-inline">
            <input type="text" maxlength="128" name="contract" value="<c:out value="${eBean.contract}"/>" placeholder="请输入"
                   autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">联系方式</label>
        <div class="layui-input-inline">
            <input type="text" maxlength="11" name="phone_No" value="<c:out value="${eBean.phone_No}"/>" placeholder="请输入"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">商务</label>
        <div class="layui-input-inline">
            <ht:herocustomdataselect dataSourceType="allBusinessUser" name="business_User_Id" selected="${eBean.business_User_Id}"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">邮箱</label>
        <div class="layui-input-block"  style="width: 70%">
            <input type="text" maxlength="64" name="email" placeholder="请输入" value="<c:out value="${eBean.email}"/>" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">企业地址</label>
        <div class="layui-input-block" style="width: 70%">
            <input type="text" maxlength="256" name="address" value="<c:out value="${eBean.address}"/>" placeholder="请输入"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea type="text" maxlength="2048" name="remark" autocomplete="off" class="layui-textarea">${eBean.remark}</textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">信用代码</label>
        <div class="layui-input-block" style="width: 70%">
            <input type="text" maxlength="18" name="credit_Code" value="<c:out value="${eBean.credit_Code}"/>" placeholder="统一社会信用代码" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">合作方联系人</label>
        <div class="layui-input-inline">
            <input type="text" maxlength="64" name="contact_Name" value="<c:out value="${eBean.contact_Name}"/>" placeholder="请输入" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">资质有效期</label>
        <div class="layui-input-inline">
            <input type="text" name="qualification_Expiry_Date" id="qualification_Expiry_Date" value="<fmt:formatDate value="${eBean.qualification_Expiry_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" placeholder="请选择日期" autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">合作开始日</label>
        <div class="layui-input-inline">
            <input type="text" name="cooperation_Start_Date" id="cooperation_Start_Date" value="<fmt:formatDate value="${eBean.cooperation_Start_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" placeholder="请选择日期" autocomplete="off" class="layui-input">
        </div>
        <label class="layui-form-label">合作结束日</label>
        <div class="layui-input-inline">
            <input type="text" name="cooperation_End_Date" id="cooperation_End_Date" value="<fmt:formatDate value="${eBean.cooperation_End_Date}" pattern="yyyy-MM-dd HH:mm:ss"/>" placeholder="请选择日期" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">经营范围</label>
        <div class="layui-input-block">
            <textarea maxlength="1024" name="business_Scope" autocomplete="off" class="layui-textarea">${eBean.business_Scope}</textarea>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="submit" id="layuiadmin-app-form-submit" value="确认">
    </div>
</form>
<%@ include file="/admin/common/layui_bottom.jsp" %>
<script>
    layui.use(['laydate'], function () {
        var laydate = layui.laydate;
        laydate.render({ elem: '#qualification_Expiry_Date', type: 'datetime', trigger: 'click' });
        laydate.render({ elem: '#cooperation_Start_Date', type: 'datetime', trigger: 'click' });
        laydate.render({ elem: '#cooperation_End_Date', type: 'datetime', trigger: 'click' });
    });
</script>
</body>