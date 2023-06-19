<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/11
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改帖子分类</title>
</head>
<body>
<div style="margin-left: 450px;margin-top: 50px">
    <h1 style="margin-left: 110px">修改帖子分类</h1>
    <br>
    <form class="layui-form" id="editUserForm">
        <input hidden name="id" value="${requestScope.forumTheme.id}">
        <div class="layui-form-item">
            <label class="layui-form-label">分类名</label>
            <div class="layui-input-inline layui-input-wrap">
                <input value="${requestScope.forumTheme.themeName}" type="text" name="themeName" lay-verify="required" autocomplete="off" lay-affix="clear" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" lay-submit lay-filter="addTheme">修改</button>
            </div>
        </div>
    </form>
</div>


<script>
    layui.use(function(){
        var $ = layui.$;
        var form = layui.form;
        var layer = layui.layer;
        var util = layui.util;


        // 提交事件
        form.on('submit(addTheme)', function(data){
            var field = data.field; // 获取表单字段值

            // 此处可执行 Ajax 等操作
            // …
            //发送修改请求
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/forumTheme/editForumTheme",
                data: field,
                success: function(result){
                    //修改成功
                    if(result.code==200){
                        layer.msg('添加成功', {icon:0,time: 500});
                    }else{
                        alert(result.msg);
                    }
                },
                error: function(){

                }
            });

            return false; // 阻止默认 form 跳转
        });

    });


</script>
</body>

</html>
