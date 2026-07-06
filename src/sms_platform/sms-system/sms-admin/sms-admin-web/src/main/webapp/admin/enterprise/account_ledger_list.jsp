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
        padding: 10px 0 15px 0;
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

    /* 合作状态标签样式 */
    .status-active {
        color: #52c41a;
    }
    .status-inactive {
        color: #f5222d;
    }
</style>
<body>
<div class="layui-fluid" style="padding: 15px 20px;">

    <!-- 页面标题区 -->
    <div class="page-header-bar">
        <div class="page-header-left">
            <h2>台账管理</h2>
            <p>在管企业台账信息</p>
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
                        <label class="layui-form-label">账号名称</label>
                        <div class="layui-input-block">
                            <input name="account_Name" class="layui-input" placeholder="请输入账号名称"/>
                        </div>
                    </div>
                </div>
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
            </div>
            <div class="layui-row layui-col-space10" style="padding: 0 20px;">
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">企业名称</label>
                        <div class="layui-input-block">
                            <input name="enterprise_Name" class="layui-input" placeholder="请输入企业名称"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">负责人</label>
                        <div class="layui-input-block">
                            <input name="contact_Name" class="layui-input" placeholder="请输入负责人"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">签名</label>
                        <div class="layui-input-block">
                            <input name="signature" class="layui-input" placeholder="请输入签名"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10" style="padding: 0 20px 15px 20px;">
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 0;">
                        <label class="layui-form-label">业务类型</label>
                        <div class="layui-input-block">
                            <input name="trade_Type" class="layui-input" placeholder="请输入业务类型"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 0;">
                        <label class="layui-form-label">合作状态</label>
                        <div class="layui-input-block">
                            <input name="cooperation_Status" class="layui-input" placeholder="请输入合作状态"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="search-btn-row">
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
    layui.extend({tableExt: '/layuiadmin/extends/tableExt'}).use(['tableExt'], function () {
        var table = layui.tableExt
            , $ = layui.$;

        // 表格渲染
        table.render({
            url: '/admin/account_ledgerList',
            elem: '#list_table',
            toolbar: '#table-toolbar',
            page: true,
            limit: 20,
            height: 'full-280',
            cols: [[
                {field: 'account_Name', title: '账号名称', width: 150},
                {field: 'enterprise_Name', title: '企业名称', width: 180},
                {field: 'signature', title: '签名', width: 120},
                {field: 'contact_Name', title: '负责人', width: 100},
                {field: 'product_No', title: '端口号码', width: 130},
                {field: 'sub_Code', title: '子端口号码', width: 130},
                {field: 'trade_Type', title: '业务类型', width: 120},
                {title: '合作起/止日期', width: 200, templet: function(d){
                    var start = d.cooperation_Start_Date || '---';
                    var end = d.cooperation_End_Date || '---';
                    return start + ' / ' + end;
                }},
                {title: '合作状态', width: 100, templet: function(d){
                    var status = d.cooperation_Status;
                    if (status === '1' || status === 'active' || status === '有效') {
                        return '<span class="status-active">有效</span>';
                    } else if (status === '0' || status === 'inactive' || status === '终止') {
                        return '<span class="status-inactive">终止</span>';
                    }
                    return status || '---';
                }},
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
    <a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="edit">编辑</a>
</script>
