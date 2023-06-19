<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/12
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>数据可视化</title>
  <script src="${pageContext.request.contextPath}/js/echarts.js"></script>
</head>
<body>
<!-- 为 ECharts 准备一个定义了宽高的 DOM -->
<div id="main" style="width: 600px;height:400px;"></div>

<script>
  $(function (){
      var data=getData();

      var chartDom = document.getElementById('main');
      var myChart = echarts.init(chartDom);
      var option;

    option = {
      title: {
        text: 'Referer of a Website',
        subtext: 'Fake Data',
        left: 'center'
      },
      tooltip: {
        trigger: 'item'
      },
      legend: {
        orient: 'vertical',
        left: 'left'
      },
      series: [
        {
          name: 'Access From',
          type: 'pie',
          radius: '50%',
          data: data,
          emphasis: {
            itemStyle: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }
      ]
    };
      option && myChart.setOption(option);
  })


  //将发送ajax封装成一个方法获取数据
  function getData(){
      var jsonData;
      $.ajax({
          type:"post",
          url:"${pageContext.request.contextPath}/forumPost/getEChartsData",
          dataType:"json",
          async:false,
          //这里的data是controller拿到的集合
          success:function (data){
              jsonData=data;

          }
      })

      return jsonData;
  }
</script>
</body>
</html>
