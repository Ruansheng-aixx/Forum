<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/11
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>公告详情</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />
    <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>
</head>
<body>
<div style="margin: 0 auto;width: 50%;">
    <button type="button" class="layui-btn" onclick="javascript :history.back(-1)">返回</button>
    <div style="text-align: center;">
        <h1>${requestScope.userNoticeVo.noticeName}</h1>
        <p>作者：${requestScope.userNoticeVo.userName}</p>
        <p>发布时间：${requestScope.userNoticeVo.releaseTime}</p>
    </div>
    <div id="noticeContext"></div>
</div>


<script>
    var data = `${requestScope.userNoticeVo.noticeContext}`; // 保留数据中的换行符和空格
    // 其他js操作
    document.getElementById("noticeContext").innerHTML = data;
</script>


</body>

</html>

