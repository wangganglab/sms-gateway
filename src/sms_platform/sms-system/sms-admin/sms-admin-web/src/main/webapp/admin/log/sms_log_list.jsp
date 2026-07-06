<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<style>
    /* 页面标题区样式 - 匹配截图风格 */
    .page-header-bar {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 15px;
        padding: 0 5px;
    }
    .page-header-left {
        border-left: 4px solid #5B6ABF;
        padding-left: 12px;
    }
    .page-header-left h2 {
        margin: 0;
        font-size: 20px;
        font-weight: 700;
        color: #333;
        line-height: 1.3;
    }
    .page-header-left p {
        margin: 4px 0 0 0;
        font-size: 13px;
        color: #999;
    }
    .page-header-right {
        display: flex;
        gap: 10px;
        padding-top: 5px;
    }
    .page-header-right .btn-action {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 7px 16px;
        border: 1px solid #d9d9d9;
        border-radius: 4px;
        background: #fff;
        color: #666;
        font-size: 13px;
        cursor: pointer;
        transition: all 0.3s;
    }
    .page-header-right .btn-action:hover {
        color: #5B6ABF;
        border-color: #5B6ABF;
    }
    .page-header-right .btn-action i {
        font-size: 14px;
    }
    .page-header-right .btn-refresh {
        background: #5B6ABF;
        color: #fff;
        border-color: #5B6ABF;
    }
    .page-header-right .btn-refresh:hover {
        background: #4a59a8;
        color: #fff;
    }

    /* 搜索表单区域 */
    .search-card .layui-card-header {
        padding: 20px 20px 10px 20px;
        border-bottom: 1px solid #f0f0f0;
    }
    .search-card .layui-form-item {
        margin-bottom: 10px;
    }
    .search-card .layui-form-label {
        width: 80px;
        padding: 9px 10px 9px 0;
        text-align: right;
        font-size: 13px;
        color: #333;
    }
    .search-card .layui-input-block {
        margin-left: 90px;
    }
    .search-card .layui-input {
        height: 36px;
        line-height: 36px;
        font-size: 13px;
    }
    .search-card .search-btn-row {
        padding: 10px 20px 15px 90px;
    }
    .search-card .btn-search {
        padding: 0 30px;
        height: 36px;
        line-height: 36px;
        background: #2c3e6b;
        color: #fff;
        border: none;
        border-radius: 4px;
        font-size: 14px;
        cursor: pointer;
    }
    .search-card .btn-search:hover {
        background: #1e2d52;
    }
    .search-card .btn-reset {
        padding: 0 20px;
        height: 36px;
        line-height: 36px;
        background: #f5f5f5;
        color: #666;
        border: 1px solid #d9d9d9;
        border-radius: 4px;
        font-size: 14px;
        cursor: pointer;
        margin-left: 10px;
    }
    .search-card .btn-reset:hover {
        color: #5B6ABF;
        border-color: #5B6ABF;
    }

    /* 数据表格区域 */
    .data-card .layui-card-body {
        padding: 15px 20px;
    }
    .data-card .table-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 0 5px 0;
        font-size: 13px;
        color: #999;
    }
    .data-card .table-footer .pagination {
        display: flex;
        align-items: center;
        gap: 5px;
    }
    .data-card .table-footer .pagination button {
        padding: 4px 12px;
        border: 1px solid #d9d9d9;
        border-radius: 3px;
        background: #fff;
        color: #666;
        font-size: 12px;
        cursor: pointer;
    }
    .data-card .table-footer .pagination button.active {
        background: #5B6ABF;
        color: #fff;
        border-color: #5B6ABF;
    }
    .data-card .table-footer .pagination button:hover:not(.active) {
        border-color: #5B6ABF;
        color: #5B6ABF;
    }
</style>
<body>
<div class="layui-fluid" style="padding: 15px 20px;">

    <!-- 页面标题区 -->
    <div class="page-header-bar">
        <div class="page-header-left">
            <h2>日志管理</h2>
            <p>发送/接收信息日志</p>
        </div>
        <div class="page-header-right">
            <button class="btn-action" lay-event="batchImport">
                <i class="layui-icon layui-icon-upload"></i> 批量导入
            </button>
            <button class="btn-action" lay-event="exportList">
                <i class="layui-icon layui-icon-download-circle"></i> 导出列表
            </button>
            <button class="btn-action btn-refresh" id="btnRefreshData">
                <i class="layui-icon layui-icon-refresh"></i> 刷新数据
            </button>
        </div>
    </div>

    <!-- 搜索表单 -->
    <div class="layui-card search-card">
        <form class="layui-form" id="searchForm" onsubmit="return false;">
            <div class="layui-row layui-col-space10" style="padding: 15px 20px 0 20px;">
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">端口号码</label>
                        <div class="layui-input-block">
                            <input name="product_No" class="layui-input" placeholder="请输入端口号码"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">子端口号码</label>
                        <div class="layui-input-block">
                            <input name="sub_Code" class="layui-input" placeholder="请输入子端口号码"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">用户名</label>
                        <div class="layui-input-block">
                            <input name="userName" class="layui-input" placeholder="请输入用户名"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10" style="padding: 0 20px;">
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">手机号</label>
                        <div class="layui-input-block">
                            <input name="phone_Nos" class="layui-input" placeholder="请输入手机号"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">发送时间</label>
                        <div class="layui-input-block">
                            <input name="send_Time" id="sendTime" type="text" class="layui-input" placeholder="请选择发送时间" readonly/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">发送内容</label>
                        <div class="layui-input-block">
                            <input name="content" class="layui-input" placeholder="请输入发送内容"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10" style="padding: 0 20px;">
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">接收时间</label>
                        <div class="layui-input-block">
                            <input name="receive_Time" id="receiveTime" type="text" class="layui-input" placeholder="请选择接收时间" readonly/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">接收内容</label>
                        <div class="layui-input-block">
                            <input name="receive_Content" class="layui-input" placeholder="请输入接收内容"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">发送状态</label>
                        <div class="layui-input-block">
                            <input name="send_Status" class="layui-input" placeholder="请输入发送状态"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10" style="padding: 0 20px 15px 20px;">
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 0;">
                        <label class="layui-form-label">发送人ID</label>
                        <div class="layui-input-block">
                            <input name="business_User_Id" class="layui-input" placeholder="请输入发送人ID"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 0;">
                        <label class="layui-form-label">所属地区</label>
                        <div class="layui-input-block">
                            <input name="area" class="layui-input" placeholder="请输入所属地区"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="search-btn-row" style="padding-left: 0;">
                        <button class="btn-search" type="submit" lay-submit="" lay-filter="reload">搜索</button>
                        <button class="btn-reset" type="button" id="btnReset">重置</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- 数据表格 -->
    <div class="layui-card data-card" style="margin-top: 15px;">
        <div class="layui-card-body">
            <table class="layui-hide" id="list_table" lay-filter="list_table"></table>
            <script type="text/html" id="table-toolbar">
                <div class="layui-btn-container">
                    <%@include file="/admin/common/button_action_list.jsp" %>
                </div>
            </script>
            <div class="table-footer">
                <span id="totalCount">共计 0 条记录</span>
                <div class="pagination" id="pagination"></div>
            </div>
        </div>
    </div>

</div>
</body>
<script>
    layui.extend({tableExt: '/layuiadmin/extends/tableExt'}).use(['tableExt', 'laydate'], function () {
        var table = layui.tableExt
            , laydate = layui.laydate
            , $ = layui.$;

        // 日期选择器
        laydate.render({
            elem: '#sendTime',
            type: 'datetime',
            trigger: 'click'
        });
        laydate.render({
            elem: '#receiveTime',
            type: 'datetime',
            trigger: 'click'
        });

        // 表格渲染
        table.render({
            url: '/admin/sms_logList',
            elem: '#list_table',
            toolbar: '#table-toolbar',
            page: true,
            limit: 20,
            height: 'full-280',
            cols: [[
                {field: 'product_No', title: '端口', width: 120},
                {field: 'sub_Code', title: '子端口', width: 120},
                {field: 'userName', title: '用户名', width: 100},
                {field: 'phone_Nos', title: '手机号', width: 140},
                {field: 'send_Time', title: '发送时间', width: 170},
                {field: 'content', title: '发送内容', minWidth: 200},
                {field: 'receive_Time', title: '接收时间', width: 170},
                {field: 'receive_Content', title: '接收内容', minWidth: 150},
                {field: 'send_Status', title: '发送状态', width: 100},
                {field: 'business_User_Id', title: '发送人ID', width: 100},
                {field: 'area', title: '所属地区', width: 120},
                {title: '操作', width: 120, toolbar: '#operateTpl', fixed: 'right'}
            ]],
            done: function (res) {
                var count = res.count || 0;
                $('#totalCount').text('共计 ' + count + ' 条记录');
            }
        });

        // 搜索
        layui.form.on('submit(reload)', function (data) {
            table.reload('list_table', {
                where: data.field,
                page: {curr: 1}
            });
            return false;
        });

        // 重置
        $('#btnReset').on('click', function () {
            $('#searchForm')[0].reset();
            table.reload('list_table', {
                where: {},
                page: {curr: 1}
            });
        });

        // 刷新数据
        $('#btnRefreshData').on('click', function () {
            table.reload('list_table');
        });
    });
</script>
<script type="text/html" id="operateTpl">
    <a class="layui-btn layui-btn-xs" lay-event="detail">详情</a>
</script>
