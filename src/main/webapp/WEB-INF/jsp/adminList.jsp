<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/11
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>管理员查询</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<!--
本「综合演示」包含：自定义头部工具栏、获取表格数据、表格重载、自定义模板、单双行显示、单元格编辑、自定义底部分页栏、表格相关事件与操作、与其他组件的结合等相对常用的功能，以便快速掌握 table 组件的使用。
-->
<div style="padding: 16px;">
    <table class="layui-hide" id="addAdmin" lay-filter="addAdmin"></table>
</div>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <form class="layui-form">
            <div class="layui-form-item">
                <label class="layui-form-label">关键字</label>
                <div class="layui-input-inline">
                    <input type="text" id="keyWord1" name="keyWord" placeholder="请输入关键字" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit lay-filter="search"><i class="layui-icon layui-icon-search"></i></button>
                </div>
            </div>
        </form>
    </div>
</script>
<script type="text/html" id="barDemo">
    <div class="layui-clear-space">
        <a class="layui-btn layui-btn-xs" lay-event="addThisAdmin">删除管理员</a>
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

        var keyWord = '';
        var sortOrder = '';
        var sortField = '';

        // 监听表格排序事件
        table.on('sort(addAdmin)', function(obj) {
            sortOrder = obj.type === 'asc' ? 'asc' : 'desc';
            sortField = obj.field;
            // 记录排序规则，保留关键字
            table.reload('addAdmin', {
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
            table.reload('addAdmin', {
                where: {
                    keyWord: keyWord,
                    sortField: sortOrder ? table.cache['addAdmin'].sortField : '',
                    sortOrder: sortOrder ? sortOrder : ''
                }
            });
            document.getElementById("keyWord1").value = keyWord;
            return false;
        });


        // 创建渲染实例
        table.render({
            elem: '#addAdmin'
            ,id: 'addAdmin'
            ,url:'${pageContext.request.contextPath}/user/getAdminList' // 此处为静态模拟数据，实际使用时需换成真实接口
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
                ,{field:'userName', width:150, title: '用户名'}
                ,{field:'userPwd', width:150, title: '密码'}
                ,{field:'avatar', width:150, title: '头像', templet: '#avatar'}
                ,{field:'realName', width:150, title: '真实姓名'}
                ,{field:'gender', width:150, title: '性别'}
                ,{field:'telephone', width:150, title: '电话'}
                ,{field:'mail', width:150, title: '邮箱'}
                ,{field:'address', width:150, title: '地址'}
                ,{fixed: 'right', title:'操作', width: 134, minWidth: 125, toolbar: '#barDemo'}
            ]]
            ,done: function(){
                var id = this.id;

                if (sortOrder) {
                    table.sort('addAdmin', table.cache['addAdmin'].sortField, sortOrder);
                };

            }
            ,error: function(res, msg){
                console.log(res, msg)
            }
        });

        // 触发单元格工具事件
        table.on('tool(addAdmin)', function(obj){ // 双击 toolDouble
            var data = obj.data; // 获得当前行数据
            // console.log(obj)
            if(obj.event === 'addThisAdmin'){
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/user/deleteAdmin?id="+data.id,
                    success: function(result){
                        //添加成功
                        if(result.code==200){
                            table.reload('addAdmin');
                        }else{
                            alert(result.msg);
                        }
                    },
                    error: function(){

                    }
                });
            }
        });

        // 触发表格复选框选择
        table.on('checkbox(addAdmin)', function(obj){
            console.log(obj)
        });

        // 触发表格单选框选择
        table.on('radio(addAdmin)', function(obj){
            console.log(obj)
        });

        // 行单击事件
        table.on('row(addAdmin)', function(obj){
            //console.log(obj);
            //layer.closeAll('tips');
        });
        // 行双击事件
        table.on('rowDouble(addAdmin)', function(obj){
            console.log(obj);
        });

        // 单元格编辑事件
        table.on('edit(addAdmin)', function(obj){
            var field = obj.field; // 得到字段
            var value = obj.value; // 得到修改后的值
            var data = obj.data; // 得到所在行所有键值
            // 值的校验
            if(field === 'email'){
                if(!/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.addAdmin(obj.value)){
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

