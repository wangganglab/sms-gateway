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
                       &nbsp;&nbsp;企业&nbsp;
                        <div class="layui-input-inline">
                             <ht:heroenterpriseselect name="enterprise_No" />
                        </div>
                    </div>
                    <div class="layui-inline">
                        &nbsp;&nbsp;端口&nbsp;
                        <div class="layui-input-inline">
                            <input name="product_No" class="layui-input" placeholder="端口号码"/>
                        </div>
                    </div>
                    <div class="layui-inline">
                        &nbsp;&nbsp;状态&nbsp;
                        <div class="layui-input-inline">
                            <ht:herocodeselect sortCode="cooperationStatus" selected="1" name="status_Code" />
                        </div>
                    </div>&nbsp;&nbsp;
                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-sm" type="submit" lay-submit="" lay-filter="reload">搜索</button>
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
    function handleData(dateStr) {
        if (!dateStr) return '---';
        var d = new Date(dateStr);
        var y = d.getFullYear();
        var m = (d.getMonth() + 1).toString().padStart(2, '0');
        var day = d.getDate().toString().padStart(2, '0');
        return y + '-' + m + '-' + day;
    }

    layui.extend({tableExt: '/layuiadmin/extends/tableExt'}).use(['tableExt'], function () {
        var table = layui.tableExt;
        table.render({
            url: '/admin/enterprise_cooperationPeriodList',
            where:{'status_Code':'1'},
            cols: [[
                {field: 'id', title: 'ID', width: 70, sort: true, type: 'checkbox'}
                ,{field: 'enterprise_No', title: '企业编号', width: 150}
                ,{title: '企业名称', width: 180, templet: function(d){
                    return d.enterprise ? handleData(d.enterprise.name) : '---';
                }}
                ,{field: 'product_No', title: '端口', width: 120}
                ,{field: 'sub_Code', title: '子端口', width: 120}
                ,{title: '合作期限', width: 200, templet: function(d){
                    return handleData(d.start_Date) + ' ~ ' + handleData(d.end_Date);
                }}
                ,{title: '距到期天数', width: 130, templet: function(d){
                    if(!d.end_Date) return '---';
                    var end = new Date(d.end_Date);
                    var today = new Date();
                    var days = Math.floor((end - today) / 86400000);
                    if(days < 0) return '<span style="color:red;font-weight:bold">已过期 ' + Math.abs(days) + '天</span>';
                    if(days <= 30) return '<span style="color:red">即将到期 ' + days + '天</span>';
                    if(days <= 90) return '<span style="color:orange">临近到期 ' + days + '天</span>';
                    return '<span style="color:green">正常 ' + days + '天</span>';
                }}
                ,{title: '状态', width: 80, templet: function(d){
                    return d.status_Code == '1' ? '<span style="color:green">有效</span>' : '<span style="color:gray">终止</span>';
                }}
                ,{field: 'contract_Url', title: '合同', width: 100, templet: function(d){
                    return d.contract_Url ? '<a href="' + d.contract_Url + '" target="_blank" class="layui-table-link">查看</a>' : '---';
                }}
                ,{field: 'create_Date', title: '创建时间', width: 180}
            ]],
            toolbar: '#table-toolbar',
            page: true,
            limit: 20
        });
    });
</script>
