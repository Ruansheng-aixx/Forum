<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/7
  Time: 17:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户登录</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />
    <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>

    <script>
        layui.use(['jquery'],function(){
            var $ = layui.$
            var form = layui.form;
            var layer = layui.layer;
            // 提交事件
            form.on('submit(demo-login)', function(data){
                var field = data.field; // 获取表单字段值

                // 此处可执行 Ajax 等操作
                // …
                //发送登录请求
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/user/login",
                    data: field,
                    success: function(result){
                        //登录成功
                        if(result.code==200){
                            location.href="${pageContext.request.contextPath}/user/toIndex";
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

        function change(){
            var img = document.getElementById("img");

            img.src = "${pageContext.request.contextPath}/getVerifyCode?time="+new Date();
        }
        function toAdd(){
            window.location.href="${pageContext.request.contextPath}/user/toRegister"
        }
    </script>
</head>
<body>
<div style="margin-top: 250px">
    <h1 style="text-align: center">用户登录</h1>
    <form class="layui-form">
        <div class="demo-login-container">
            <div class="layui-form-item">
                <div class="layui-input-wrap">
                    <div class="layui-input-prefix">
                        <i class="layui-icon layui-icon-username"></i>
                    </div>
                    <input type="text" name="userName" value="" lay-verify="required" placeholder="用户名" lay-reqtext="请填写用户名" autocomplete="off" class="layui-input" lay-affix="clear">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-wrap">
                    <div class="layui-input-prefix">
                        <i class="layui-icon layui-icon-password"></i>
                    </div>
                    <input type="password" name="userPwd" value="" lay-verify="required" placeholder="密码" lay-reqtext="请填写密码" autocomplete="off" class="layui-input" lay-affix="eye">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-row">
                    <div class="layui-col-xs7">
                        <div class="layui-input-wrap">
                            <div class="layui-input-prefix">
                                <i class="layui-icon layui-icon-vercode"></i>
                            </div>
                            <input type="text" name="verityCode" value="" lay-verify="required" placeholder="验证码" lay-reqtext="请填写验证码" autocomplete="off" class="layui-input" lay-affix="clear">
                        </div>
                    </div>
                    <div class="layui-col-xs5">
                        <div style="margin-left: 10px;">
                            <a href="javascript:change()">
                                <img id="img" width="100px" src="${pageContext.request.contextPath}/getVerifyCode">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="demo-login">登录</button>
            </div>
            <div class="layui-form-item">
                <a href="javascript:toAdd()" style="float: right; margin-top: 7px;">注册帐号</a></span>
            </div>
        </div>
    </form>
</div>
</body>
<style>
    .demo-login-container{width: 320px; margin: 21px auto 0;}
    .demo-login-other .layui-icon{position: relative; display: inline-block; margin: 0 2px; top: 2px; font-size: 26px;}
</style>
</html>
