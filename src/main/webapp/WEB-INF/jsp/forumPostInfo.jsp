<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/10
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>帖子详情</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />
    <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>
</head>
<body>
<div style="margin: 0 auto;width: 50%;">
    <button type="button" class="layui-btn" onclick="javascript :history.back(-1)">返回</button>
    <button type="button" class="layui-btn" onclick="javascript :addCollection()">收藏</button>
    <div style="text-align: center;">
        <h1>${requestScope.userForumPostVo.postName}</h1>
        <p>作者：${requestScope.userForumPostVo.userName}</p>
        <p>主题：${requestScope.userForumPostVo.themeName}</p>
        <p>发布时间：${requestScope.userForumPostVo.releaseTime}</p>
        <p>浏览量：${requestScope.userForumPostVo.postViews}</p>
        <img src="${requestScope.userForumPostVo.postPicture}">
    </div>
    <div id="forumContext"></div>
</div>


<script>
    var data = `${requestScope.userForumPostVo.postContext}`; // 保留数据中的换行符和空格
    // 其他js操作
    document.getElementById("forumContext").innerHTML = data;


    function addCollection(){
        $.ajax({
            url: '${pageContext.request.contextPath}/collection/addCollection',
            type: 'POST',
            data: {
                userId: '${sessionScope.userInfo.id}',
                postId: '${requestScope.userForumPostVo.id}'
            },
            success: function(result){
                console.log(result.code)
                if(result.code === 200){
                    layer.msg('收藏成功', { icon: 1,time: 500 });
                    alert(result.msg)
                }else{
                    layer.msg('收藏失败：'+result.msg, { icon: 2 ,time: 500});
                }
            },
            error: function(){
                layer.msg('网络错误，请稍后重试', { icon: 2,time: 500 });
            }
        });

    }
</script>


</body>

</html>
