<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js"></script>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">按合作方统计</div>
                <div class="layui-card-body">
                    <div id="enterpriseChart" style="height: 400px;"></div>
                </div>
            </div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">按来源统计</div>
                <div class="layui-card-body">
                    <div id="sourceChart" style="height: 400px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">按状态统计</div>
                <div class="layui-card-body">
                    <div id="statusChart" style="height: 400px;"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var sourceMap = { 'operator': '运营商', 'user': '用户', 'regulator': '监管' };
    var statusMap = { '0': '待处理', '1': '处理中', '2': '已处理' };

    $.ajax({
        url: '/admin/enterprise_complaintStatisticsData',
        type: 'GET',
        success: function(res) {
            var data = typeof res === 'string' ? JSON.parse(res) : res;
            var enterprise = data.byEnterprise || {};
            var source = data.bySource || {};
            var status = data.byStatus || {};

            // 按合作方柱状图
            var entKeys = Object.keys(enterprise), entVals = entKeys.map(function(k){ return enterprise[k]; });
            echarts.init(document.getElementById('enterpriseChart')).setOption({
                tooltip: { trigger: 'axis' },
                xAxis: { type: 'category', data: entKeys },
                yAxis: { type: 'value' },
                series: [{ type: 'bar', data: entVals, itemStyle: { color: '#1E9FFF' } }]
            });

            // 按来源饼图
            var srcData = [];
            for (var k in source) srcData.push({ name: sourceMap[k] || k, value: source[k] });
            echarts.init(document.getElementById('sourceChart')).setOption({
                tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
                legend: { bottom: 10 },
                color: ['#1E9FFF', '#FF5722', '#16bAA5', '#FFB800'],
                series: [{ type: 'pie', radius: '65%', data: srcData }]
            });

            // 按状态饼图
            var statusColors = { '0': '#FF5722', '1': '#FFB800', '2': '#16bAA5' };
            var stData = [];
            for (var k in status) stData.push({ name: statusMap[k] || k, value: status[k], itemStyle: { color: statusColors[k] || '#999' } });
            echarts.init(document.getElementById('statusChart')).setOption({
                tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
                legend: { bottom: 10 },
                series: [{ type: 'pie', radius: '65%', data: stData }]
            });
        }
    });
</script>
