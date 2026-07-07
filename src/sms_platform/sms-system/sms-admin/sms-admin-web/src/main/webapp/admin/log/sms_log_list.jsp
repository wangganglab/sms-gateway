<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<style>
    /* 页面标题区样式 */
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

    /* 搜索表单区域 */
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
            <button class="layui-btn layui-btn-sm" lay-event="batchImport">
                <i class="layui-icon layui-icon-upload"></i> 批量导入
            </button>
            <button class="layui-btn layui-btn-sm" lay-event="exportList">
                <i class="layui-icon layui-icon-download-circle"></i> 导出列表
            </button>
            <button class="layui-btn layui-btn-sm layui-btn-normal" id="btnRefreshData">
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
                        <label class="layui-form-label">接收手机号</label>
                        <div class="layui-input-block">
                            <input name="phone_Nos" class="layui-input" placeholder="请输入接收手机号"/>
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
            <div class="layui-row layui-col-space10" style="padding: 0 20px;">
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">发送人ID</label>
                        <div class="layui-input-block">
                            <input name="business_User_Id" class="layui-input" placeholder="请输入发送人ID"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">所属地区</label>
                        <div class="layui-input-block">
                            <input name="area" class="layui-input" placeholder="请输入所属地区"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">发送手机号</label>
                        <div class="layui-input-block">
                            <input name="send_Phone" class="layui-input" placeholder="请输入发送手机号"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10" style="padding: 0 20px 15px 20px;">
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 0;">
                        <label class="layui-form-label">拒收内容</label>
                        <div class="layui-input-block">
                            <input name="reject_Content" class="layui-input" placeholder="请输入拒收内容"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 0;">
                        <label class="layui-form-label">拒收时间</label>
                        <div class="layui-input-block">
                            <input name="reject_Time" id="rejectTime" type="text" class="layui-input" placeholder="请选择拒收时间" readonly/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div style="padding: 0;">
                        <button class="layui-btn layui-btn-sm" type="submit" lay-submit="" lay-filter="reload">搜索</button>
                        <button class="layui-btn layui-btn-sm layui-btn-primary" type="button" id="btnReset">重置</button>
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
        laydate.render({
            elem: '#rejectTime',
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
                {field: 'phone_Nos', title: '接收手机号', width: 140},
                {field: 'send_Phone', title: '发送手机号', width: 140},
                {field: 'send_Time', title: '发送时间', width: 170},
                {field: 'content', title: '发送内容', minWidth: 200},
                {field: 'receive_Time', title: '接收时间', width: 170},
                {field: 'receive_Content', title: '接收内容', minWidth: 150},
                {field: 'reject_Time', title: '拒收时间', width: 170},
                {field: 'reject_Content', title: '拒收内容', minWidth: 150},
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
