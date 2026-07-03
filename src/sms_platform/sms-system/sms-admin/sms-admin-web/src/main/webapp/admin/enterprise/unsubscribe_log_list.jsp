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
                       &nbsp;&nbsp;号码&nbsp;
                        <div class="layui-input-inline">
                            <input name="phone_No" class="layui-input" placeholder="拒收号码"/>
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
        var h = d.getHours().toString().padStart(2, '0');
        var mi = d.getMinutes().toString().padStart(2, '0');
        var s = d.getSeconds().toString().padStart(2, '0');
        return y + '-' + m + '-' + day + ' ' + h + ':' + mi + ':' + s;
    }

    layui.extend({tableExt: '/layuiadmin/extends/tableExt'}).use(['tableExt'], function () {
        var table = layui.tableExt;
        table.render({
            url: '/admin/enterprise_unsubscribeLogList',
            cols: [[
                {field: 'id', title: 'ID', width: 90, sort: true, type: 'checkbox'}
                ,{field: 'enterprise_No', title: '企业编号', width: 150}
                ,{field: 'product_No', title: '端口', width: 120}
                ,{field: 'sub_Code', title: '子端口', width: 120}
                ,{field: 'phone_No', title: '拒收号码', width: 150}
                ,{field: 'reject_Content', title: '拒收内容', width: 140}
                ,{title: '拒收时间', width: 180, templet: function(d){
                    return handleData(d.reject_Date);
                }}
                ,{field: 'inbox_Id', title: 'Inbox ID', width: 110}
                ,{title: '创建时间', width: 180, templet: function(d){
                    return handleData(d.create_Date);
                }}
            ]],
            toolbar: '#table-toolbar',
            page: true,
            limit: 20
        });
    });
</script>
