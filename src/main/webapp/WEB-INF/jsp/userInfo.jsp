<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/8
  Time: 19:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户信息</title>
<%--    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>--%>
<%--    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />--%>
<%--    <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>--%>
</head>
<body>
<div style="margin-top: 50px;text-align: center">
    <h1>用户信息</h1>
    <form class="layui-form">
        <div class="demo-reg-container">
            <div class="layui-form-item">
                <label class="layui-form-label">头像</label>
                <div class="layui-input-inline layui-input-wrap">
                    <img id="avatar" src="${requestScope.user.avatar}" class="layui-nav-img avatar">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-inline layui-input-wrap">
                    <input type="text" name="userName" value="${requestScope.user.userName}" lay-verify="" autocomplete="off" class="layui-input" readonly>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">真实姓名</label>
                <div class="layui-input-inline layui-input-wrap">
                    <input type="text" name="userName" value="${requestScope.user.realName}" lay-verify="" autocomplete="off" class="layui-input" readonly>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-inline layui-input-wrap">
                    <input type="text" name="gender" value="${requestScope.user.gender}" lay-verify="" autocomplete="off" class="layui-input" readonly>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">电话</label>
                <div class="layui-input-inline layui-input-wrap">
                    <input type="text" name="telephone" value="${requestScope.user.telephone}" lay-verify="" autocomplete="off" class="layui-input" readonly>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-inline layui-input-wrap">
                    <input type="text" name="mail" value="${requestScope.user.mail}" lay-verify="" autocomplete="off" class="layui-input" readonly>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">地址</label>
                <div class="layui-input-inline layui-input-wrap">
                    <input type="text" name="address" value="${requestScope.user.address}" lay-verify="" autocomplete="off" class="layui-input" readonly>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
<style>
    .demo-reg-container{width: 320px; margin: 21px auto 0;}
    .demo-reg-other .layui-icon{position: relative; display: inline-block; margin: 0 2px; top: 2px; font-size: 26px;}
    .avatar{
        height: 75px;
        width: 75px;
    }
</style>
</html>

