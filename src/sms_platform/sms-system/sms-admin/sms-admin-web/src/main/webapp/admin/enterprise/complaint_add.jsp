<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<%@ include file="/admin/common/dynamic_data.jsp" %>
<form class="layui-form" action="/admin/enterprise_addComplaint" lay-filter="form" id="dialogFormId" onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <div class="layui-form-item">
        <label class="layui-form-label">企业<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <ht:heroenterpriseselect layVerify="required" name="enterprise_No" id="enterprise_No"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <ht:heroproductselect name="product_No"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">子端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="sub_Code" placeholder="请输入子端口" autocomplete="off" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉号码<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="phone_No" lay-verify="required" placeholder="请输入投诉号码" autocomplete="off" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉来源<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <ht:herocodeselect sortCode="complaintSource" layVerify="required" name="complaint_Source"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉时间<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="complaint_Date" id="complaint_Date" lay-verify="required" placeholder="yyyy-MM-dd HH:mm:ss" autocomplete="off" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">投诉内容<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-block">
            <textarea name="complaint_Content" lay-verify="required" placeholder="请输入投诉内容" class="layui-textarea" style="height:120px;"></textarea>
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
