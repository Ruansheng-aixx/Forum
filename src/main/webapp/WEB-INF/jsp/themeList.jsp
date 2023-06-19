<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/11
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>帖子名称</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<!--
本「综合演示」包含：自定义头部工具栏、获取表格数据、表格重载、自定义模板、单双行显示、单元格编辑、自定义底部分页栏、表格相关事件与操作、与其他组件的结合等相对常用的功能，以便快速掌握 table 组件的使用。
-->
<div style="padding: 16px;">
    <table class="layui-hide" id="themeList" lay-filter="themeList"></table>
</div>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="deleteCheckData">删除选中行数据</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <div class="layui-clear-space">
        <a class="layui-btn layui-btn-xs" lay-event="editSelectedTheme">编辑</a>
        <a class="layui-btn layui-btn-xs" lay-event="deleteSelectedTheme">删除</a>
    </div>
</script>
<script type="text/html" id="avatar">
    <div class="layui-table-cell laytable-cell-1-0"><img src="{{d.avatar}}"/></div>
</script>
<script>
    layui.use(['table', 'dropdown','form'], function(){
        var table = layui.table;
        var dropdown = layui.dropdown;
        var form = layui.form;


        // 创建渲染实例
        table.render({
            elem: '#themeList'
            ,id: 'themeList'
            ,url:'${pageContext.request.contextPath}/forumTheme/getForumThemeListData' // 此处为静态模拟数据，实际使用时需换成真实接口
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
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', fixed: 'left', width:100, title: 'ID', sort: true, totalRowText: '合计：'}
                ,{field:'themeName', width:150, title: '帖子分类名称'}
                ,{fixed: 'right', title:'操作', width: 134, minWidth: 125, toolbar: '#barDemo'}
            ]]
            ,done: function(){
                var id = this.id;
            }
            ,error: function(res, msg){
                console.log(res, msg)
            }
        });




        // 工具栏事件
        table.on('toolbar(themeList)', function(obj){
            var id = obj.config.id;
            var checkStatus = table.checkStatus(id);
            var othis = lay(this);
            switch(obj.event){
                case 'deleteCheckData':
                    // 获取选中行数据
                    var data = checkStatus.data;
                    // 执行删除操作
                    layer.confirm('确定删除选中的'+data.length+'条数据吗？', function(index){
                        // 获取选中数据的id列表
                        var ids = $.map(data, function(item){
                            return item.id;  // 假设每行数据的id为字段id
                        });
                        console.log(ids);
                        // 发送ajax请求，删除选中数据
                        $.ajax({
                            url: '${pageContext.request.contextPath}/forumTheme/deleteSelectedTheme',
                            type: 'POST',
                            data: { ids: ids },
                            success: function(res){
                                if(res.code === 200){
                                    layer.msg('删除成功', { icon: 1 });
                                    // 重新渲染表格
                                    table.reload('themeList');
                                    $('#selectedCount').text(0);
                                }else{
                                    layer.msg('删除失败：'+res.msg, { icon: 2 });
                                }
                            },
                            error: function(){
                                layer.msg('网络错误，请稍后重试', { icon: 2 });
                            }
                        });
                        layer.close(index);
                    });
                    break;
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(layui.util.escape(JSON.stringify(data)));
                    break;
                case 'getData':
                    var getData = table.getData(id);
                    console.log(getData);
                    layer.alert(layui.util.escape(JSON.stringify(getData)));
                    break;
                case 'LAYTABLE_TIPS':
                    layer.alert('自定义工具栏图标按钮');
                    break;
            };
        });

        // 触发单元格工具事件
        table.on('tool(themeList)', function(obj){ // 双击 toolDouble
            var data = obj.data; // 获得当前行数据
            // console.log(obj)
            if(obj.event === 'editSelectedTheme'){
                // 加载并打开弹窗
                $.get("${pageContext.request.contextPath}/forumTheme/toEditTheme?id="+data.id, function (html) {
                    layer.open({
                        type: 1,
                        title: "编辑帖子分类",
                        area: ['80%','80%'],
                        content: html,
                        btn: ["确定", "取消"],
                        yes: function (index, layero) {
                            layer.close(index);
                            table.reload('themeList');
                        },
                        btn2: function (index, layero) {
                            layer.close(index);
                            return false;
                        }

                    });
                });
            } else if(obj.event === 'deleteSelectedTheme'){
                layer.confirm('确认删除', function(index){
                    obj.del(); // 删除对应行（tr）的DOM结构
                    layer.close(index);
                    // 向服务端发送删除指令
                    $.ajax({

                        type:"get",

                        url:"${pageContext.request.contextPath}/forumTheme/deleteOneTheme?id="+data.id,

                        dataType:"json",

                        success:function (result){
                            if(result.code==200){
                                layer.msg('删除成功', {icon: 0, time: 1000});
                            }
                        }

                    })
                });
            }
        });

        // 触发表格复选框选择
        table.on('checkbox(themeList)', function(obj){
            console.log(obj)
        });

        // 触发表格单选框选择
        table.on('radio(themeList)', function(obj){
            console.log(obj)
        });

        // 行单击事件
        table.on('row(themeList)', function(obj){
            //console.log(obj);
            //layer.closeAll('tips');
        });
        // 行双击事件
        table.on('rowDouble(themeList)', function(obj){
            console.log(obj);
        });

        // 单元格编辑事件
        table.on('edit(themeList)', function(obj){
            var field = obj.field; // 得到字段
            var value = obj.value; // 得到修改后的值
            var data = obj.data; // 得到所在行所有键值
            // 值的校验
            if(field === 'email'){
                if(!/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.themeList(obj.value)){
                    layer.tips('输入的邮箱格式不正确，请重新编辑', this, {tips: 1});
                    return obj.reedit(); // 重新编辑 -- v2.8.0 新增
                }
            }
            // 编辑后续操作，如提交更新请求，以完成真实的数据更新
            // …
            layer.msg('编辑成功', {icon: 1});

            // 其他更新操作
            var update = {};
            update[field] = value;
            obj.update(update);
        });
    });
</script>

</body>
</html>


