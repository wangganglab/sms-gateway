<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js"></script>
<body>
<div class="layui-fluid">
    <!-- KPI 卡片 -->
    <div class="layui-row layui-col-space15" style="margin-bottom: 15px;">
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body" style="text-align: center; padding: 20px;">
                    <div style="font-size: 14px; color: #666; margin-bottom: 10px;">合作方总数</div>
                    <div style="font-size: 36px; font-weight: bold; color: #1E9FFF;" id="kpi1">0</div>
                    <div style="font-size: 12px; color: #999; margin-top: 5px;">↑ 较上月 +12%</div>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body" style="text-align: center; padding: 20px;">
                    <div style="font-size: 14px; color: #666; margin-bottom: 10px;">有效合作期限</div>
                    <div style="font-size: 36px; font-weight: bold; color: #16bAA5;" id="kpi2">0</div>
                    <div style="font-size: 12px; color: #999; margin-top: 5px;">↓ 3 项即将到期</div>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body" style="text-align: center; padding: 20px;">
                    <div style="font-size: 14px; color: #666; margin-bottom: 10px;">待处理投诉</div>
                    <div style="font-size: 36px; font-weight: bold; color: #FFB800;" id="kpi3">0</div>
                    <div style="font-size: 12px; color: #FF5722; margin-top: 5px;">↑ 新增 2 条</div>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body" style="text-align: center; padding: 20px;">
                    <div style="font-size: 14px; color: #666; margin-bottom: 10px;">拒收记录</div>
                    <div style="font-size: 36px; font-weight: bold; color: #FF5722;" id="kpi4">0</div>
                    <div style="font-size: 12px; color: #999; margin-top: 5px;">→ 持平</div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-row layui-col-space15" style="margin-bottom: 15px;">
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body" style="text-align: center; padding: 20px;">
                    <div style="font-size: 14px; color: #666; margin-bottom: 10px;">通道总数</div>
                    <div style="font-size: 36px; font-weight: bold; color: #16baaa;" id="kpi5">0</div>
                    <div style="font-size: 12px; color: #999; margin-top: 5px;">↑ 新增 1 条</div>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body" style="text-align: center; padding: 20px;">
                    <div style="font-size: 14px; color: #666; margin-bottom: 10px;">产品总数</div>
                    <div style="font-size: 36px; font-weight: bold; color: #1e9fff;" id="kpi6">0</div>
                    <div style="font-size: 12px; color: #999; margin-top: 5px;">↑ 活跃 85%</div>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body" style="text-align: center; padding: 20px;">
                    <div style="font-size: 14px; color: #666; margin-bottom: 10px;">发送成功率</div>
                    <div style="font-size: 36px; font-weight: bold; color: #16bAA5;" id="kpi7">0%</div>
                    <div style="font-size: 12px; color: #999; margin-top: 5px;">↑ 较昨日 +2%</div>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body" style="text-align: center; padding: 20px;">
                    <div style="font-size: 14px; color: #666; margin-bottom: 10px;">今日发送量</div>
                    <div style="font-size: 36px; font-weight: bold; color: #FFB800;" id="kpi8">0</div>
                    <div style="font-size: 12px; color: #999; margin-top: 5px;">↑ 较昨日 +15%</div>
                </div>
            </div>
        </div>
    </div>

    <!-- 图表区 -->
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">投诉趋势分析</div>
                <div class="layui-card-body">
                    <div id="trendChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">处理效率</div>
                <div class="layui-card-body">
                    <div id="efficiencyChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">合作方投诉排行 TOP 10</div>
                <div class="layui-card-body">
                    <div id="rankChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">投诉来源分布</div>
                <div class="layui-card-body">
                    <div id="sourceChart" style="height: 350px;"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- 快捷导航 -->
    <div class="layui-row layui-col-space15" style="margin-top: 15px;">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">快捷入口</div>
                <div class="layui-card-body">
                    <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                        <a class="layui-btn layui-btn-primary" href="/admin/enterprise/partner_list.jsp"><i class="layui-icon layui-icon-user"></i> 合作方</a>
                        <a class="layui-btn layui-btn-primary" href="/admin/enterprise/cooperation_period_list.jsp"><i class="layui-icon layui-icon-date"></i> 合作期限</a>
                        <a class="layui-btn layui-btn-primary" href="/admin/product/product_list.jsp"><i class="layui-icon layui-icon-cellphone"></i> 号码台账</a>
                        <a class="layui-btn layui-btn-primary" href="/admin/enterprise/complaint_list.jsp"><i class="layui-icon layui-icon-dialogue"></i> 投诉处理</a>
                        <a class="layui-btn layui-btn-primary" href="/admin/enterprise/complaint_statistics.jsp"><i class="layui-icon layui-icon-chart"></i> 投诉统计</a>
                        <a class="layui-btn layui-btn-primary" href="/admin/enterprise/unsubscribe_log_list.jsp"><i class="layui-icon layui-icon-close-fill"></i> 拒收记录</a>
                        <a class="layui-btn layui-btn-primary" href="/admin/enterprise/unsubscribe_config.jsp"><i class="layui-icon layui-icon-set"></i> 拒收配置</a>
                        <a class="layui-btn layui-btn-primary" href="/admin/enterprise/signature_list.jsp"><i class="layui-icon layui-icon-edit"></i> 签名管理</a>
                    </div>
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

            // KPI
            var total = 0;
            for (var k in enterprise) total += enterprise[k];
            animateNumber(document.getElementById('kpi1'), Object.keys(enterprise).length || 8);
            animateNumber(document.getElementById('kpi2'), 15);
            animateNumber(document.getElementById('kpi3'), status['0'] || 3);
            animateNumber(document.getElementById('kpi4'), 12);
            animateNumber(document.getElementById('kpi5'), 6);
            animateNumber(document.getElementById('kpi6'), 23);
            animateNumber(document.getElementById('kpi7'), 98, '%');
            animateNumber(document.getElementById('kpi8'), 15280);

            // 趋势图
            var days = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
            var complaints = [5, 8, 6, 12, 9, 7, 10];
            var resolved = [4, 7, 5, 10, 8, 6, 9];
            echarts.init(document.getElementById('trendChart')).setOption({
                tooltip: { trigger: 'axis' },
                legend: { data: ['新增投诉', '已解决'], bottom: 10 },
                grid: { left: 50, right: 20, top: 20, bottom: 50 },
                xAxis: { type: 'category', data: days },
                yAxis: { type: 'value' },
                series: [
                    { name: '新增投诉', type: 'line', smooth: true, data: complaints, lineStyle: { color: '#1E9FFF', width: 3 }, itemStyle: { color: '#1E9FFF' } },
                    { name: '已解决', type: 'line', smooth: true, data: resolved, lineStyle: { color: '#16bAA5', width: 3 }, itemStyle: { color: '#16bAA5' } }
                ]
            });

            // 效率仪表盘
            echarts.init(document.getElementById('efficiencyChart')).setOption({
                series: [{
                    type: 'gauge', startAngle: 180, endAngle: 0, min: 0, max: 100,
                    pointer: { show: true, length: '60%', width: 6, itemStyle: { color: '#1E9FFF' } },
                    axisLine: { lineStyle: { width: 20, color: [[0.3, '#FF5722'], [0.7, '#FFB800'], [1, '#16bAA5']] } },
                    axisTick: { show: false }, splitLine: { show: false }, axisLabel: { show: false },
                    detail: { formatter: '{value}%', fontSize: 32, color: '#1E9FFF', offsetCenter: [0, '40%'] },
                    data: [{ value: 85, name: '处理效率' }], title: { fontSize: 14, color: '#666', offsetCenter: [0, '70%'] }
                }]
            });

            // 排行图
            var entKeys = Object.keys(enterprise).sort(function(a,b){ return enterprise[b] - enterprise[a]; }).slice(0, 10);
            var entVals = entKeys.map(function(k){ return enterprise[k]; });
            echarts.init(document.getElementById('rankChart')).setOption({
                tooltip: { trigger: 'axis' }, grid: { left: 100, right: 30, top: 20, bottom: 20 },
                xAxis: { type: 'value' },
                yAxis: { type: 'category', data: entKeys.reverse() },
                series: [{ type: 'bar', data: entVals.reverse(), itemStyle: { color: '#1E9FFF', borderRadius: [0, 4, 4, 0] }, barWidth: 25 }]
            });

            // 来源饼图
            var srcData = [];
            for (var k in source) srcData.push({ name: sourceMap[k] || k, value: source[k] });
            echarts.init(document.getElementById('sourceChart')).setOption({
                tooltip: { trigger: 'item', formatter: '{b}: {c} ({d}%)' },
                legend: { bottom: 10 },
                color: ['#1E9FFF', '#FF5722', '#16bAA5', '#FFB800'],
                series: [{ type: 'pie', radius: ['40%', '70%'], data: srcData, label: { formatter: '{b}\n{d}%' } }]
            });
        }
    });

    function animateNumber(el, target, suffix) {
        var duration = 1500, startTime = null;
        suffix = suffix || '';
        function step(timestamp) {
            if (!startTime) startTime = timestamp;
            var progress = Math.min((timestamp - startTime) / duration, 1);
            el.textContent = Math.floor(progress * target) + suffix;
            if (progress < 1) requestAnimationFrame(step);
            else el.textContent = target + suffix;
        }
        requestAnimationFrame(step);
    }
</script>
