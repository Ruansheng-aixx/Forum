<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/11
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="utf-8">
  <title>个人中心</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />
  <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>

  <script charset="utf-8" src="${pageContext.request.contextPath}/kindeditor/kindeditor-all.js"></script>
  <script charset="utf-8" src="${pageContext.request.contextPath}/kindeditor/lang/zh-CN.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/kindeditor/themes/default/default.css" />

</head>
<body>
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo layui-hide-xs layui-bg-black" onclick="javascript :history.back(-1)">Forum</div>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item layui-hide layui-show-sm-inline-block">
        <a href="javascript:;">
          <img src="${sessionScope.avatar}" class="layui-nav-img">
          ${sessionScope.userInfo.userName}
        </a>
        <dl class="layui-nav-child">
          <dd><a href="javascript:logout();">退出登录</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
        <a href="javascript:;">
          <i class="layui-icon layui-icon-more-vertical"></i>
        </a>
      </li>
    </ul>
  </div>
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree" lay-filter="test">
        <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;">个人中心</a>
          <dl class="layui-nav-child">
            <dd><a id="userInfo" href="javascript:loadPage('${pageContext.request.contextPath}/user/toUserInfo?id=${sessionScope.userInfo.id}');">个人信息</a></dd>
            <dd><a href="javascript:loadPage('${pageContext.request.contextPath}/user/toEdit?id=${sessionScope.userInfo.id}');">修改个人资料</a></dd>
            <dd><a href="javascript:loadPage('${pageContext.request.contextPath}/collection/toMyCollection');">我的收藏</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;">论坛帖子管理</a>
          <dl class="layui-nav-child">
            <dd><a id="postForum" href="javascript:loadPage('${pageContext.request.contextPath}/forumPost/toPublishForumPost');">论坛贴子发布</a></dd>
            <dd><a id="myForumPost" href="javascript:loadPage('${pageContext.request.contextPath}/forumPost/toMyForumPost');">我发布的帖子</a></dd>
            <dd><a href="javascript:loadPage('${pageContext.request.contextPath}/forumPost/toAllForumPost');">全部帖子</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;">用户管理</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:loadPage('${pageContext.request.contextPath}/user/toAddUser');">用户添加</a></dd>
            <dd><a href="javascript:loadPage('${pageContext.request.contextPath}/user/toUserList');">用户查询</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;">帖子分类管理</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:loadPage('${pageContext.request.contextPath}/forumTheme/toAddForumTheme');">帖子分类添加</a></dd>
            <dd><a href="javascript:loadPage('${pageContext.request.contextPath}/forumTheme/toThemeList');">帖子分类查询</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;">公告管理</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:loadPage('${pageContext.request.contextPath}/notice/toAddNotice');">发布公告</a></dd>
            <dd><a href="javascript:loadPage('${pageContext.request.contextPath}/notice/toNoticeList');">公告查询</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;">数据可视化</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:loadPage('${pageContext.request.contextPath}/eCharts/toECharts');">论坛帖子数据</a></dd>
          </dl>
        </li>
      </ul>
    </div>
  </div>
  <div class="layui-body">
    <!-- 内容主体区域 -->
    <div style="padding: 15px;">
      <%--      <div class="layui-card layui-panel">--%>
      <%--        <div class="layui-card-header">--%>

      <%--        </div>--%>
      <div id="content">

      </div>
      <%--      </div>--%>
      <br><br>
    </div>
  </div>
</div>


<script>
  function logout(){

    parent.location.href="${pageContext.request.contextPath}/user/logout"

  }
  //JS
  layui.use(['element', 'layer', 'util'], function(){
    var element = layui.element;
    var layer = layui.layer;
    var util = layui.util;
    var $ = layui.$;
    //头部事件
    util.event('lay-header-event', {
      menuLeft: function(othis){ // 左侧菜单事件
        layer.msg('展开左侧菜单的操作', {icon: 0});
      },
    });
  });

  function loadPage(url) {
    $("#content").load(url);
  }

</script>
</body>
<style>
  .layui-card-body{
    height: 100%;
  }
</style>
</html>
