<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <form class="layui-form layui-card-header layuiadmin-card-header-auto" onsubmit="return false;">
                   <div class="layui-inline">
                       &nbsp;&nbsp;企业名称&nbsp;
                        <div class="layui-input-inline">
                             <ht:heroenterpriseselect  name="enterprise_No" />
                        </div>
                    </div>
                    <div class="layui-inline">
                        &nbsp;&nbsp;签名内容&nbsp;
                        <div class="layui-input-inline">
                            <input name="signature_Content" class="layui-input"/>
                        </div>
                    </div>&nbsp;&nbsp;
                    <div class="layui-inline">
                        &nbsp;&nbsp;审核状态&nbsp;
                        <div class="layui-input-inline">
                            <ht:herocodeselect sortCode="templateCheckStatus" selected="0" name="approve_Status" />
                        </div>
                    </div>&nbsp;&nbsp;
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm" type="submit" lay-submit="" lay-filter="reload">搜索
                        </button>
                    </div>
                </form>
                <div class="layui-form layui-border-box layui-table-view">
                    <div class="layui-card-body">
                        <table class="layui-hide" id="list_table" lay-filter="list_table"></table>
                        <script type="text/html" id="table-toolbar">
                            <div class="layui-btn-container">
                                <%@include file="/admin/common/button_action_list.jsp" %>
                            </div>
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    layui.extend({tableExt: '/layuiadmin/extends/tableExt'}).use(['tableExt'], function () {
        var table = layui.tableExt;
        table.render({
            url: '/admin/enterprise_smsSignatureList',
            where:{'approve_Status':'0'},
            cols: [[
                {checkbox: true},
                {title: '企业编号/名称',width: 300, width:180,templet:function (d) {
                        return d.enterprise_No+"<br>"+
                            (!d.enterprise_No_ext?'---':handleData(d.enterprise_No_ext.name));
                    }},
                {title: '签名内容', minWidth: 200, templet: function (d) {
                  return handleData(d.signature_Content);
                  }},
                {title: '签名类型', width: 130, templet: function (d) {
                  return handleData(d.signature_Type);
                  }},
                {title: '审核状态', width: 110, templet: function (d) {
                  return d.approve_Status_name;
                  }},
                {title: '启用状态', width: 110, templet: function (d) {
                  return d.status_Code_name;
                  }},
                {field: 'approve_Remark', title: '审核意见', width: 180},
                {field: 'create_Date', title: '创建日期', width: 200,}
            ]]
        });
    });
</script>
