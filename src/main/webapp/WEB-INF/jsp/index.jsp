<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/7
  Time: 18:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script>
        function loadPage(url) {
            $("#bottomShow").load(url);
        }
        $(function (){
            loadPage('${pageContext.request.contextPath}/indexPage/toIndexMain')
        })
    </script>
</head>
<body>
<div class="main">
    <div id="topShow" class="topShow">
    <c:import url="top.jsp"></c:import>
    </div>
    <div id="bottomShow" class="bottomShow">

    </div>

</div>

</body>
<style>
    .main {
        text-align: center; /* 水平居中 */
    }

    .bottomShow {
        width: 80%; /* 宽度为页面的80% */
        margin: 0 auto; /* 居中 */
    }
</style>

</html>
