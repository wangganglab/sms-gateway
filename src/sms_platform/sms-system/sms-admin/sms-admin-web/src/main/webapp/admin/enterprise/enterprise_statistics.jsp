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
                <div class="layui-card-header">合作方状态分布</div>
                <div class="layui-card-body">
                    <div id="statusChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">投诉率分布</div>
                <div class="layui-card-body">
                    <div id="complaintChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">合作方规模分布</div>
                <div class="layui-card-body">
                    <div id="scaleChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">投诉趋势（近 6 个月）</div>
                <div class="layui-card-body">
                    <div id="trendChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">合作方详情排行</div>
                <div class="layui-card-body">
                    <table class="layui-table">
                        <thead>
                            <tr>
                                <th>合作方名称</th>
                                <th>号码数</th>
                                <th>投诉数</th>
                                <th>投诉率</th>
                                <th>合作状态</th>
                            </tr>
                        </thead>
                        <tbody id="enterpriseList"></tbody>
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
            {name: '合作中', value: 28},
            {name: '待审核', value: 4},
            {name: '已终止', value: 3}
        ],
        complaint: [
            {name: '0%', value: 15},
            {name: '<1%', value: 12},
            {name: '1-3%', value: 5},
            {name: '>3%', value: 3}
        ],
        scale: [
            {name: '小型 (<50 号)', value: 12},
            {name: '中型 (50-200 号)', value: 15},
            {name: '大型 (>200 号)', value: 8}
        ],
        trend: [
            {month: '1 月', complaints: 8},
            {month: '2 月', complaints: 12},
            {month: '3 月', complaints: 10},
            {month: '4 月', complaints: 15},
            {month: '5 月', complaints: 13},
            {month: '6 月', complaints: 11}
        ],
        enterprises: [
            {name: '企业 A', numbers: 280, complaints: 2, rate: 0.7, status: '合作中'},
            {name: '企业 B', numbers: 245, complaints: 5, rate: 2.0, status: '合作中'},
            {name: '企业 C', numbers: 198, complaints: 8, rate: 4.0, status: '合作中'},
            {name: '企业 D', numbers: 165, complaints: 1, rate: 0.6, status: '合作中'},
            {name: '企业 E', numbers: 142, complaints: 12, rate: 8.5, status: '合作中'},
            {name: '企业 F', numbers: 128, complaints: 0, rate: 0, status: '合作中'},
            {name: '企业 G', numbers: 115, complaints: 3, rate: 2.6, status: '待审核'},
            {name: '企业 H', numbers: 98, complaints: 0, rate: 0, status: '合作中'},
            {name: '企业 I', numbers: 85, complaints: 6, rate: 7.1, status: '已终止'},
            {name: '企业 J', numbers: 72, complaints: 1, rate: 1.4, status: '合作中'}
        ]
    };

    // 状态饼图
    echarts.init(document.getElementById('statusChart')).setOption({
        tooltip: { trigger: 'item' },
        legend: { bottom: 10 },
        color: ['#16bAA5', '#FFB800', '#FF5722'],
        series: [{ type: 'pie', radius: '65%', data: mockData.status }]
    });

    // 投诉率饼图
    echarts.init(document.getElementById('complaintChart')).setOption({
        tooltip: { trigger: 'item' },
        legend: { bottom: 10 },
        color: ['#16bAA5', '#1E9FFF', '#FFB800', '#FF5722'],
        series: [{ type: 'pie', radius: '65%', data: mockData.complaint }]
    });

    // 规模柱状图
    echarts.init(document.getElementById('scaleChart')).setOption({
        tooltip: { trigger: 'axis' },
        xAxis: { type: 'category', data: mockData.scale.map(d => d.name) },
        yAxis: { type: 'value' },
        series: [{ type: 'bar', data: mockData.scale.map(d => d.value), itemStyle: { color: '#1E9FFF' } }]
    });

    // 趋势折线图
    echarts.init(document.getElementById('trendChart')).setOption({
        tooltip: { trigger: 'axis' },
        xAxis: { type: 'category', data: mockData.trend.map(d => d.month) },
        yAxis: { type: 'value' },
        series: [{ type: 'line', smooth: true, data: mockData.trend.map(d => d.complaints), lineStyle: { color: '#FF5722', width: 3 }, itemStyle: { color: '#FF5722' } }]
    });

    // 合作方列表
    var listHtml = '';
    mockData.enterprises.forEach(function(item) {
        var rateColor = item.rate === 0 ? '#16bAA5' : (item.rate < 3 ? '#16bAA5' : (item.rate < 5 ? '#FFB800' : '#FF5722'));
        listHtml += '<tr><td>' + item.name + '</td><td>' + item.numbers + '</td><td>' + item.complaints + '</td>' +
                    '<td style="color:' + rateColor + '">' + item.rate + '%</td><td>' + item.status + '</td></tr>';
    });
    document.getElementById('enterpriseList').innerHTML = listHtml;
</script>
