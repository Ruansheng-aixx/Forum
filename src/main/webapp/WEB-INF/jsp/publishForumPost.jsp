<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/8
  Time: 23:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Date now = new Date();
    String current_time = String.format("%tF %<tT", now);
%>
<html>
<head>
    <title>发表论坛帖子</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<form class="layui-form" id="postForum">
    <h1 style="margin-left: 115px">发布论坛帖子</h1>
    <br>
    <input hidden name="publisher" value="${sessionScope.userInfo.id}">
    <input hidden name="releaseTime" value="<%= current_time %>">
    <input hidden name="postViews" value="0">
    <input hidden name="target" value="1">
    <div class="layui-form-item">
        <label class="layui-form-label">分类</label>
        <div class="layui-input-inline">
            <select name="themeId" lay-filter="forumTheme" id="forumTheme" lay-verify="required">
                <option value=""></option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">帖子名称</label>
        <div class="layui-input-inline layui-input-wrap">
            <input type="text" name="postName" lay-verify="required" autocomplete="off" lay-affix="clear" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">图片</label>
        <div class="layui-input-inline layui-input-wrap">
            <input id="postPicture" name="postPicture" hidden>
            <button type="button" class="layui-btn" id="ID-upload-demo-btn">
                <i class="layui-icon layui-icon-upload"></i> 图片上传
            </button>
            <div style="width: 132px;">
                <div class="layui-upload-list">
                    <img class="layui-upload-img" id="ID-upload-demo-img" style="width: 100%; height: 92px;">
                    <div id="ID-upload-demo-text"></div>
                </div>
                <div class="layui-progress layui-progress-big" lay-showPercent="yes" lay-filter="filter-demo">
                    <div class="layui-progress-bar" lay-percent=""></div>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">帖子内容</label>
        <div class="layui-input-block">
            <textarea name="postContext" id="postContext123123" lay-verify="required"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button type="submit" class="layui-btn" lay-submit lay-filter="demo1">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>


<script>
    $(function() {
        var editor1 = KindEditor.create('#postContext123123', {
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
        });
        $.ajax({

            type:"post",

            url:"${pageContext.request.contextPath}/forumTheme/getForumThemeList",

            dataType:"json",

            async:false,

            success:function (data){

                var option="";

                $.each(data,function (i,n){

                    option+="<option value="+n.id+">"+n.themeName+"</option>"

                })

                $("#forumTheme").append(option);

                layui.form.render();

            }

        })
        editor1.sync()
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
        form.on('submit(demo1)', function(data){

            var field = data.field; // 获取表单字段值

            // 此处可执行 Ajax 等操作
            // …
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/forumPost/addForumPost",
                data: field,
                success: function(result){
                    //发布成功
                    if(result.code==200){
                        layer.msg('发布成功', {icon: 0, time: 500},function (){
                            loadPage('${pageContext.request.contextPath}/forumPost/toPublishForumPost')
                        });
                    }else{
                        alert(result.msg);
                    }
                },
                error: function(){

                }
            });
            return false; // 阻止默认 form 跳转
        });


        // 单图片上传
        var uploadInst = upload.render({
            elem: '#ID-upload-demo-btn',
            url: '${pageContext.request.contextPath}/forumPost/uploadPostPicture', // 此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
            before: function(obj){
                // 预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#ID-upload-demo-img').attr('src', result); // 图片链接（base64）
                });

                element.progress('filter-demo', '0%'); // 进度条复位
                layer.msg('上传中', {icon: 16, time: 0});
            },
            done: function(res){
                // 若上传失败
                if(res.code != 200){
                    return layer.msg('上传失败');
                }
                // 上传成功的一些操作
                // …
                // 获取 input 元素的引用
                var inputElement = document.getElementById('postPicture');
                // 更改输入框的值
                inputElement.value = res.msg;

                $('#ID-upload-demo-text').html(''); // 置空上传失败的状态
            },
            error: function(){
                // 演示失败状态，并实现重传
                var demoText = $('#ID-upload-demo-text');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            },
            // 进度条
            progress: function(n, elem, e){
                element.progress('filter-demo', n + '%'); // 可配合 layui 进度条元素使用
                if(n == 100){
                    layer.msg('上传完毕', {icon: 1});
                }
            }
        });

    });




</script>
</body>
</html>
