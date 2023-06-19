<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/11
  Time: 19:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>发布公告</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<form class="layui-form" id="editNotice">
  <h1 style="margin-left: 115px">修改公告</h1>
  <br>
  <input hidden name="id" value="${requestScope.notice.id}">
  <div class="layui-form-item">
    <label class="layui-form-label">公告名称</label>
    <div class="layui-input-inline layui-input-wrap">
      <input value="${requestScope.notice.noticeName}" type="text" name="noticeName" lay-verify="required" autocomplete="off" lay-affix="clear" class="layui-input">
    </div>
  </div>
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label">公告</label>
    <div class="layui-input-block">
      <textarea  name="noticeContext" id="noticeContext4324" lay-verify="required"></textarea>
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block">
      <button type="submit" class="layui-btn" lay-submit lay-filter="demo123">立即提交</button>
      <button type="reset" class="layui-btn layui-btn-primary">重置</button>
    </div>
  </div>
</form>


<script>
  $(function() {
    var editor3 = KindEditor.create('#noticeContext4324', {
      filterMode: false,
      width:'75%',
      height:'400px',
      items: ['source', '|', 'bold', 'italic', 'underline', 'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist', 'insertunorderedlist', '|', 'image', 'link'],
      htmlTags: {
        font: ['color', 'size', 'face', '.background-color'],
        span: ['style'],
        div: ['class', 'align', 'style'],
        table: ['class', 'border', 'cellspacing', 'cellpadding', 'width', 'height', 'align', 'style'],
        'td,th': ['class', 'align', 'valign', 'width', 'height', 'colspan', 'rowspan', 'bgcolor', 'style'],
        a: ['class', 'href', 'target', 'name', 'style'],
        embed: ['src', 'width', 'height', 'type', 'loop', 'autostart', 'quality', 'style'],
        img: ['src', 'width', 'height', 'border', 'alt', 'title', 'align', 'style', '/'],
        hr: ['class', '/'],
        br: ['/'],
        'p,ol,ul,li,blockquote,h1,h2,h3,h4,h5,h6': ['align', 'style'],
        'tbody,tr,strong,b,sub,sup,em,i,u,strike': []
      },
      cssData: 'body {font-size: 14px; line-height: 1.6em; font-family: "Microsoft YaHei",Arial,Helvetica,sans-serif;}',
      afterCreate : function() { this.sync(); }, //关键是这两个
      afterBlur: function(){this.sync();},//关键是这两个
      afterBrush: function(){this.sync();},
      afterSetHtml: function(){this.sync();},
    });
    var initialData = `${requestScope.notice.noticeContext}`;
    editor3.html(initialData);
    editor3.sync();

  });

  layui.use(['form', 'laydate', 'util'], function(){
    var form = layui.form;
    var layer = layui.layer;
    var laydate = layui.laydate;
    var util = layui.util;
    var upload = layui.upload;
    var element = layui.element;
    var $ = layui.$;

    // 提交事件
    form.on('submit(demo123)', function(data){

      var field = data.field; // 获取表单字段值

      // 此处可执行 Ajax 等操作
      // …
      $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/notice/editNotice",
        data: field,
        success: function(result){
          //发布成功
          if(result.code==200){
            layer.msg('修改成功', {icon: 0, time: 500});
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




</script>
</body>
</html>

