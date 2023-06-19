<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/12
  Time: 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>全部帖子</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<!--
本「综合演示」包含：自定义头部工具栏、获取表格数据、表格重载、自定义模板、单双行显示、单元格编辑、自定义底部分页栏、表格相关事件与操作、与其他组件的结合等相对常用的功能，以便快速掌握 table 组件的使用。
-->
<div style="padding: 16px;">
    <table class="layui-hide" id="allForumPost" lay-filter="allForumPost"></table>
</div>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <form class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">关键字</label>
                <div class="layui-input-inline">
                    <input type="text" id="keyWord" name="keyWord" placeholder="请输入关键字" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit lay-filter="search"><i class="layui-icon layui-icon-search"></i></button>
                </div>
            </div>
        </form>
    </div>
</script>
<script type="text/html" id="postPicture">
    <div class="layui-table-cell laytable-cell-1-0"><img src="{{d.postPicture}}"/></div>
</script>
<script>
    layui.use(['table', 'dropdown','form'], function(){
        var table = layui.table;
        var dropdown = layui.dropdown;
        var form = layui.form;

        var keyWord = '';
        var sortOrder = '';
        var sortField = '';

        // 监听表格排序事件
        table.on('sort(allForumPost)', function(obj) {
            sortOrder = obj.type === 'asc' ? 'asc' : 'desc';
            sortField = obj.field;
            // 记录排序规则，保留关键字
            table.reload('allForumPost', {
                where: {
                    keyWord: keyWord,
                    sortField: sortField,
                    sortOrder: sortOrder
                }
            });
        });

        // 监听表单提交事件
        form.on('submit(search)', function(data){
            keyWord = data.field.keyWord || '';
            // 重新加载表格，并传递查询条件
            table.reload('allForumPost', {
                where: {
                    keyWord: keyWord,
                    sortField: sortOrder ? table.cache['allForumPost'].sortField : '',
                    sortOrder: sortOrder ? sortOrder : ''
                }
            });
            document.getElementById("keyWord").value = keyWord;
            return false;
        });


        // 创建渲染实例
        table.render({
            elem: '#allForumPost'
            ,id: 'allForumPost'
            ,url:'${pageContext.request.contextPath}/forumPost/getAllForumPostList' // 此处为静态模拟数据，实际使用时需换成真实接口
            ,toolbar: '#toolbarDemo'
            ,defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示'
                ,layEvent: 'LAYTABLE_TIPS'
                ,icon: 'layui-icon-tips'
            }]
            ,height: 'full-90' // 最大高度减去其他容器已占有的高度差
            ,css: [ // 重设当前表格样式
                '.layui-table-tool-temp{padding-right: 145px;}'
            ].join('')
            ,cellMinWidth: 80
            ,totalRow: true // 开启合计行
            ,page: true
            ,lineStyle: 'height: 95px;'
            ,limit:5
            ,limits:[5,10,15]
            ,cols: [[
                {field:'id', fixed: 'left', width:100, title: 'ID', sort: true, totalRowText: '合计：'}
                ,{field:'themeName', width:160, title: '帖子分类'}
                ,{field:'postName', width:160, title: '帖子名称'}
                ,{field:'postPicture', width:160, title: '帖子图片',templet: '#postPicture'}
                ,{field:'userName', width:130, title: '发布人'}
                ,{field:'releaseTime', width:160, title: '发布时间'}
                ,{field:'postViews', title:'浏览量', width: 130, sort: true, totalRow: '{{= parseInt(d.TOTAL_NUMS) }} 次'}
            ]]
            ,done: function(){
                var id = this.id;

                if (sortOrder) {
                    table.sort('allForumPost', table.cache['allForumPost'].sortField, sortOrder);
                };


            }
            ,error: function(res, msg){
                console.log(res, msg)
            }
        });


        // 行单击事件
        table.on('row(allForumPost)', function(obj){
            var data = obj.data; // 获得当前行数据
            window.location.href="${pageContext.request.contextPath}/forumPost/toForumPostInfo?forumId="+data.id;
        });

    });
</script>

</body>
</html>
