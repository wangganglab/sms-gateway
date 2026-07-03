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
                <div class="layui-card-header">合作期限状态分布</div>
                <div class="layui-card-body">
                    <div id="statusChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">到期时间分布</div>
                <div class="layui-card-body">
                    <div id="timelineChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">到期预警列表</div>
                <div class="layui-card-body">
                    <table class="layui-table">
                        <thead>
                            <tr>
                                <th>合作方</th>
                                <th>到期日期</th>
                                <th>剩余天数</th>
                                <th>状态</th>
                            </tr>
                        </thead>
                        <tbody id="warningList"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    // 模拟数据
    var mockData = {
        status: [
            {name: '有效', value: 20},
            {name: '30 天内到期', value: 3},
            {name: '已过期', value: 2}
        ],
        timeline: [
            {name: '已过期', value: 2},
            {name: '30 天内', value: 3},
            {name: '60 天内', value: 5},
            {name: '90 天内', value: 3},
            {name: '90 天以上', value: 12}
        ],
        warnings: [
            {name: '企业 A - 端口 1069001', date: '2024-01-15', days: -5, status: 'danger'},
            {name: '企业 B - 端口 1069002', date: '2024-01-20', days: 0, status: 'danger'},
            {name: '企业 C - 端口 1069003', date: '2024-02-01', days: 12, status: 'warning'},
            {name: '企业 D - 端口 1069004', date: '2024-02-10', days: 21, status: 'warning'},
            {name: '企业 E - 端口 1069005', date: '2024-03-15', days: 54, status: 'safe'}
        ]
    };

    // 状态饼图
    echarts.init(document.getElementById('statusChart')).setOption({
        tooltip: { trigger: 'item' },
        legend: { bottom: 10 },
        color: ['#16bAA5', '#FFB800', '#FF5722'],
        series: [{ type: 'pie', radius: '65%', data: mockData.status }]
    });

    // 时间轴柱状图
    echarts.init(document.getElementById('timelineChart')).setOption({
        tooltip: { trigger: 'axis' },
        xAxis: { type: 'category', data: mockData.timeline.map(d => d.name) },
        yAxis: { type: 'value' },
        series: [{ type: 'bar', data: mockData.timeline.map(d => d.value), itemStyle: { color: '#1E9FFF' } }]
    });

    // 预警列表
    var warningHtml = '';
    mockData.warnings.forEach(function(item) {
        var statusText = item.days < 0 ? '<span style="color:#FF5722">已过期 ' + Math.abs(item.days) + ' 天</span>' :
                         item.days === 0 ? '<span style="color:#FFB800">今天到期</span>' :
                         '<span style="color:#16bAA5">剩余 ' + item.days + ' 天</span>';
        warningHtml += '<tr><td>' + item.name + '</td><td>' + item.date + '</td><td>' + item.days + '</td><td>' + statusText + '</td></tr>';
    });
    document.getElementById('warningList').innerHTML = warningHtml;
</script>
