<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">拒收关键词配置</div>
                <div class="layui-card-body">
                    <form class="layui-form" action="/admin/enterprise_saveUnsubscribeConfig" lay-filter="form" onsubmit="return false;"
                          style="padding: 20px 30px 0 0;">
                        <div class="layui-form-item">
                            <label class="layui-form-label">当前配置</label>
                            <div class="layui-input-block">
                                <input type="text" name="unsubscribe_keywords" id="unsubscribe_keywords" value="${keywords}" placeholder="多个关键词用逗号分隔" autocomplete="off" class="layui-input" style="width: 400px;">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit lay-filter="save">保存</button>
                                <span style="color: #999; margin-left: 20px;">说明：上行短信内容与任一关键词完全匹配时，视为拒收并自动加入黑名单。默认值：T,TD,退订</span>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    layui.use(['form', 'layer'], function(){
        var form = layui.form;
        var layer = layui.layer;

        form.on('submit(save)', function(data){
            $.ajax({
                url: '/admin/enterprise_saveUnsubscribeConfig',
                type: 'POST',
                data: data.field,
                success: function(res) {
                    if (res.code === 0) {
                        layer.msg('保存成功');
                    } else {
                        layer.msg('保存失败：' + res.msg);
                    }
                },
                error: function() {
                    layer.msg('请求失败');
                }
            });
            return false;
        });
    });
</script>
