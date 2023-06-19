<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/12
  Time: 0:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
</head>
<body>
<div class="layui-carousel" id="ID-carousel-demo-image">
    <div carousel-item>
        <div><img src="https://unpkg.com/outeres/demo/carousel/720x360-1.jpg" style="width: 100%"></div>
        <div><img src="https://unpkg.com/outeres/demo/carousel/720x360-2.jpg" style="width: 100%"></div>
        <div><img src="https://unpkg.com/outeres/demo/carousel/720x360-3.jpg" style="width: 100%"></div>
        <div><img src="https://unpkg.com/outeres/demo/carousel/720x360-4.jpg" style="width: 100%"></div>
        <div><img src="https://unpkg.com/outeres/demo/carousel/720x360-5.jpg" style="width: 100%"></div>
    </div>
</div>
<script>
    layui.use(function(){
        var carousel = layui.carousel;
        // 渲染 - 图片轮播
        carousel.render({
            elem: '#ID-carousel-demo-image',
            width: '100%',
            height: '100%',
            interval: 3000
        });
    });
</script>

</body>

</html>
