<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/7
  Time: 22:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>top</title>
  <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />
  <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>
  <script>
    function logout(){

      parent.location.href="${pageContext.request.contextPath}/user/logout"

    }
    function toPersonCenter(){
      if(${sessionScope.userInfo.roleId==3}){
        window.location.href="${pageContext.request.contextPath}/user/toPersonCenter"
      }
      if(${sessionScope.userInfo.roleId==2}){
        window.location.href="${pageContext.request.contextPath}/user/toAdminCenter"
      }
      if(${sessionScope.userInfo.roleId==1}){
        window.location.href="${pageContext.request.contextPath}/user/toSuperAdminCenter"
      }
    }
    $(function (){
      if(${sessionScope.avatar!=null}){
        // 获取 img 元素的引用
        var imgElement = document.getElementById('avatar');

        // 更改图像的 src 属性
        imgElement.src = "${sessionScope.avatar}";
      }
    })
  </script>
</head>
<body>
<div class="container">
  <div class="top">
    <ul class="layui-nav layui-nav-child-c">
      <li class="layui-nav-item layui-this"><a href="javascript:loadPage('${pageContext.request.contextPath}/indexPage/toIndexMain');">主页</a></li>
      <li class="layui-nav-item"><a href="javascript:loadPage('${pageContext.request.contextPath}/forumPost/toShowAllPost');">论坛帖子</a></li>
      <li class="layui-nav-item"><a href="javascript:loadPage('${pageContext.request.contextPath}/notice/toShowAllNotice');">公告</a></li>
      <li class="layui-nav-item" lay-unselect>
        <a href="javascript:;">
          <img id="avatar" src="https://unpkg.com/outeres@0.0.10/demo/avatar/1.jpg" class="layui-nav-img">
        </a>
        <dl class="layui-nav-child">
          <dd><a href="javascript:toPersonCenter(${sessionScope.userInfo.id});">个人中心</a></dd>
          <hr>
          <dd style="text-align: center;"><a href="javascript:logout()">退出登录</a></dd>
        </dl>
      </li>
    </ul>
  </div>
  <div class="body">

  </div>
</div>
</body>
<style>
  .layui-nav-item{
    margin-right: 40px;  /* 控制菜单项之间的右边距 */
    margin-left: 20px;   /* 控制菜单项之间的左边距 */
  }
</style>
</html>
