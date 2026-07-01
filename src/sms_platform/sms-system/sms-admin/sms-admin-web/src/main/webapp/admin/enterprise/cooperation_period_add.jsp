<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/admin/common/common.jsp" %>
<%@ include file="/admin/common/layui_head.html" %>
<%@ include file="/admin/common/dynamic_data.jsp" %>
<form class="layui-form" action="/admin/enterprise_addCooperationPeriod" lay-filter="form" id="dialogFormId" onsubmit="return false;"
      style="padding: 20px 30px 0 0;">
    <div class="layui-form-item">
        <label class="layui-form-label">企业<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <ht:heroenterpriseselect layVerify="required" name="enterprise_No" id="enterprise_No"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <ht:heroproductselect name="product_No"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">子端口</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="sub_Code" placeholder="请输入子端口" autocomplete="off" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">开始日期<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="start_Date" id="start_Date" placeholder="yyyy-MM-dd HH:mm:ss" autocomplete="off" class="layui-input" lay-verify="required"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">结束日期<font color="red">&nbsp;&nbsp;*</font></label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" name="end_Date" id="end_Date" placeholder="yyyy-MM-dd HH:mm:ss" autocomplete="off" class="layui-input" lay-verify="required"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">合同 URL</label>
        <div class="layui-input-inline" style="width:300px;">
            <input type="text" maxlength="255" name="contract_Url" placeholder="合同附件 URL(可选)" autocomplete="off" class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea name="remark" placeholder="请输入备注" class="layui-textarea"></textarea>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="submit" id="layuiadmin-app-form-submit" value="确认">
    </div>
</form>
<%@ include file="/admin/common/layui_bottom.jsp" %>
<script>
    layui.use(['laydate'], function(){
        var laydate = layui.laydate;

        // 日期时间选择器
        laydate.render({
            elem: '#start_Date',
            type: 'datetime',
            trigger: 'click'
        });
        laydate.render({
            elem: '#end_Date',
            type: 'datetime',
            trigger: 'click',
            done: function(value, date, endDate){
                // 校验结束日期必须大于开始日期
                if (value && $('#start_Date').val() && value <= $('#start_Date').val()) {
                    layer.msg('结束日期必须大于开始日期');
                    this.elem.val('');
                }
            }
        });
    });
</script>
</body>
