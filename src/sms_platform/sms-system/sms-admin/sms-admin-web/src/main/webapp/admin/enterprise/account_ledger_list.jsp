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
            <div class="layui-row layui-col-space10" style="padding: 0 20px;">
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">业务类型</label>
                        <div class="layui-input-block">
                            <input name="trade_Type" class="layui-input" placeholder="请输入业务类型"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">合作状态</label>
                        <div class="layui-input-block">
                            <input name="cooperation_Status" class="layui-input" placeholder="请输入合作状态"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 10px;">
                        <label class="layui-form-label">协议合同文本</label>
                        <div class="layui-input-block">
                            <input name="contract_Url" class="layui-input" placeholder="请输入协议合同文本"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10" style="padding: 0 20px 15px 20px;">
                <div class="layui-col-md4">
                    <div class="layui-form-item" style="margin-bottom: 0;">
                        <label class="layui-form-label">营业执照/法人证书</label>
                        <div class="layui-input-block">
                            <input name="business_License" class="layui-input" placeholder="请输入营业执照/事业单位法人证书"/>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md4"></div>
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
                {field: 'contract_Url', title: '协议合同文本', width: 160, templet: function(d){
                    return d.contract_Url ? '<a href="' + d.contract_Url + '" target="_blank" style="color:#01AAED;">查看</a>' : '---';
                }},
                {field: 'business_License', title: '营业执照/事业单位法人证书', width: 200, templet: function(d){
                    return d.business_License ? '<a href="' + d.business_License + '" target="_blank" style="color:#01AAED;">查看</a>' : '---';
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
