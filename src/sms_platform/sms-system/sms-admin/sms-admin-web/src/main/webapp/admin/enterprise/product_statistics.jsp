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
                <div class="layui-card-header">号码类型分布</div>
                <div class="layui-card-body">
                    <div id="typeChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">状态分布</div>
                <div class="layui-card-body">
                    <div id="statusChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">合作方号码分布 TOP 10</div>
                <div class="layui-card-body">
                    <div id="enterpriseChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    // 模拟数据
    var mockData = {
        types: [
            {name: '移动号码', value: 680},
            {name: '联通号码', value: 520},
            {name: '电信号码', value: 380}
        ],
        status: [
            {name: '已启用', value: 1250},
            {name: '待激活', value: 200},
            {name: '已停用', value: 130}
        ],
        enterprises: [
            {name: '企业 A', value: 280},
            {name: '企业 B', value: 245},
            {name: '企业 C', value: 198},
            {name: '企业 D', value: 165},
            {name: '企业 E', value: 142},
            {name: '企业 F', value: 128},
            {name: '企业 G', value: 115},
            {name: '企业 H', value: 98},
            {name: '企业 I', value: 85},
            {name: '企业 J', value: 72}
        ]
    };

    // 类型饼图
    echarts.init(document.getElementById('typeChart')).setOption({
        tooltip: { trigger: 'item' },
        legend: { bottom: 10 },
        color: ['#1E9FFF', '#16bAA5', '#FFB800'],
        series: [{ type: 'pie', radius: '65%', data: mockData.types }]
    });

    // 状态饼图
    echarts.init(document.getElementById('statusChart')).setOption({
        tooltip: { trigger: 'item' },
        legend: { bottom: 10 },
        color: ['#16bAA5', '#FFB800', '#FF5722'],
        series: [{ type: 'pie', radius: '65%', data: mockData.status }]
    });

    // 合作方柱状图
    echarts.init(document.getElementById('enterpriseChart')).setOption({
        tooltip: { trigger: 'axis' },
        grid: { left: 80, right: 20, top: 20, bottom: 50 },
        xAxis: { type: 'category', data: mockData.enterprises.map(d => d.name) },
        yAxis: { type: 'value' },
        series: [{ type: 'bar', data: mockData.enterprises.map(d => d.value), itemStyle: { color: '#1E9FFF' } }]
    });
</script>
