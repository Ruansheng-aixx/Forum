<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/11
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改个人资料</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

</head>
<body>
<div style="margin-left: 450px;margin-top: 50px">
    <h1 style="margin-left: 110px">修改个人资料</h1>
    <br>
    <form class="layui-form" id="addUserForm">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-inline layui-input-wrap">
                <input type="text" name="userName" lay-verify="required" autocomplete="off" lay-affix="clear" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">真实姓名</label>
            <div class="layui-input-inline layui-input-wrap">
                <input type="text" name="realName" lay-verify="required" autocomplete="off" lay-affix="clear" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-inline layui-input-wrap">
                <input type="password" name="userPwd" lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input" id="reg-password" lay-affix="eye">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-inline layui-input-wrap">
                <input type="password" name="" lay-verify="required|confirmPassword" placeholder="确认密码" autocomplete="off" class="layui-input" lay-affix="eye">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="gender" value="男" title="男" >
                <input type="radio" name="gender" value="女" title="女" >
            </div>
        </div>
        <div style="margin-left: 110px">
            <input id="avatar" name="avatar" hidden>
            <button type="button" class="layui-btn" id="ID-upload-demo-btn">
                <i class="layui-icon layui-icon-upload"></i> 头像上传
            </button>
            <div style="width: 132px;">
                <div class="layui-upload-list">
                    <img class="layui-upload-img" id="ID-upload-demo-img" style="width: 100%; height: 92px;">
                    <div id="ID-upload-demo-text"></div>
                </div>
                <div class="layui-progress layui-progress-big" lay-showPercent="yes" lay-filter="filter-demo">
                    <div class="layui-progress-bar" lay-percent=""></div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">电话</label>
            <div class="layui-input-inline layui-input-wrap">
                <input type="text" name="telephone" lay-verify="required" autocomplete="off" lay-affix="clear" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline layui-input-wrap">
                <input type="text" name="mail" lay-verify="required" autocomplete="off" lay-affix="clear" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">地址</label>
            <div class="layui-input-inline layui-input-wrap">
                <input type="text" name="address" lay-verify="required" autocomplete="off" lay-affix="clear" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn" lay-submit lay-filter="addUser">添加</button>
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

        // 自定义验证规则
        form.verify({
            // 确认密码
            confirmPassword: function(value, item){
                var passwordValue = $('#reg-password').val();
                if(value !== passwordValue){
                    return '两次密码输入不一致';
                }
            }
        });

        // 提交事件
        form.on('submit(addUser)', function(data){
            var field = data.field; // 获取表单字段值

            // 此处可执行 Ajax 等操作
            // …
            //发送修改请求
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/user/addUser",
                data: field,
                success: function(result){
                    //修改成功
                    if(result.code==200){
                        layer.msg('添加成功', {icon:0,time: 500},function (){
                            loadPage('${pageContext.request.contextPath}/user/toAddUser')
                        });
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

    layui.use(function(){
        var upload = layui.upload;
        var layer = layui.layer;
        var element = layui.element;
        var $ = layui.$;
        // 单图片上传
        var uploadInst = upload.render({
            elem: '#ID-upload-demo-btn',
            url: '${pageContext.request.contextPath}/user/uploadAvatar', // 此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
            before: function(obj){
                // 预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    console.log("file = " + file)
                    console.log("file = " + result)
                    console.log("file = " + index)
                    $('#ID-upload-demo-img').attr('src', result); // 图片链接（base64）
                });

                element.progress('filter-demo', '0%'); // 进度条复位
                layer.msg('上传中', {icon: 16, time: 0});
            },
            done: function(res){
                // 若上传失败
                if(res.code != 200){
                    return layer.msg('上传失败');
                }
                // 上传成功的一些操作
                // …
                // 获取 input 元素的引用
                var inputElement = document.getElementById('avatar');
                // 更改输入框的值
                inputElement.value = res.msg;

                $('#ID-upload-demo-text').html(''); // 置空上传失败的状态
            },
            error: function(){
                // 演示失败状态，并实现重传
                var demoText = $('#ID-upload-demo-text');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            },
            // 进度条
            progress: function(n, elem, e){
                element.progress('filter-demo', n + '%'); // 可配合 layui 进度条元素使用
                if(n == 100){
                    layer.msg('上传完毕', {icon: 1});
                }
            }
        });

    });

</script>
</body>

</html>

