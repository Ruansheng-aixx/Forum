<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/11
  Time: 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>用户列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<!--
本「综合演示」包含：自定义头部工具栏、获取表格数据、表格重载、自定义模板、单双行显示、单元格编辑、自定义底部分页栏、表格相关事件与操作、与其他组件的结合等相对常用的功能，以便快速掌握 table 组件的使用。
-->
<div style="padding: 16px;">
    <table class="layui-hide" id="userList" lay-filter="userList"></table>
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
        <button class="layui-btn layui-btn-sm" lay-event="deleteCheckData">删除选中行数据</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <div class="layui-clear-space">
        <a class="layui-btn layui-btn-xs" lay-event="editSelectedUser">编辑</a>
        <a class="layui-btn layui-btn-xs" lay-event="more">
            更多
            <i class="layui-icon layui-icon-down"></i>
        </a>
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
        table.on('sort(userList)', function(obj) {
            sortOrder = obj.type === 'asc' ? 'asc' : 'desc';
            sortField = obj.field;
            // 记录排序规则，保留关键字
            table.reload('userList', {
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
            table.reload('userList', {
                where: {
                    keyWord: keyWord,
                    sortField: sortOrder ? table.cache['userList'].sortField : '',
                    sortOrder: sortOrder ? sortOrder : ''
                }
            });
            document.getElementById("keyWord1").value = keyWord;
            return false;
        });


        // 创建渲染实例
        table.render({
            elem: '#userList'
            ,id: 'userList'
            ,url:'${pageContext.request.contextPath}/user/getUserList' // 此处为静态模拟数据，实际使用时需换成真实接口
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
                    table.sort('userList', table.cache['userList'].sortField, sortOrder);
                };

                // 重载测试
                dropdown.render({
                    elem: '#reloaduserList' // 可绑定在任意元素中，此处以上述按钮为例
                    ,data: [{
                        id: 'reload',
                        title: '重载'
                    },{
                        id: 'reload-deep',
                        title: '重载 - 参数叠加'
                    },{
                        id: 'reloadData',
                        title: '仅重载数据'
                    },{
                        id: 'reloadData-deep',
                        title: '仅重载数据 - 参数叠加'
                    }]
                    // 菜单被点击的事件
                    ,click: function(obj){
                        switch(obj.id){
                            case 'reload':
                                // 重载 - 默认（参数重置）
                                table.reload('userList', {
                                    where: {
                                        abc: '123456'
                                        //,userList: '新的 userList2'
                                        //,token: '新的 token2'
                                    }
                                    /*
                                    ,cols: [[ // 重置表头
                                      {type: 'checkbox', fixed: 'left'}
                                      ,{field:'id', title:'ID', width:80, fixed: 'left', unresize: true, sort: true, totalRowText: '合计：'}
                                      ,{field:'sex', title:'性别', width:80, edit: 'text', sort: true}
                                      ,{field:'experience', title:'积分', width:80, sort: true, totalRow: true, templet: '<div>{{= d.experience }} 分</div>'}
                                      ,{field:'logins', title:'登入次数', width:100, sort: true, totalRow: true}
                                      ,{field:'joinTime', title:'加入时间', width:120}
                                    ]]
                                    */
                                });
                                break;
                            case 'reload-deep':
                                // 重载 - 深度（参数叠加）
                                table.reload('userList', {
                                    where: {
                                        abc: 123
                                        ,userList: '新的 userList1'
                                    }
                                    //,defaultToolbar: ['print'] // 重载头部工具栏右侧图标
                                    //,cols: ins1.config.cols
                                }, true);
                                break;
                            case 'reloadData':
                                // 数据重载 - 参数重置
                                table.reloadData('userList', {
                                    where: {
                                        abc: '123456'
                                        //,userList: '新的 userList2'
                                        //,token: '新的 token2'
                                    }
                                    ,scrollPos: 'fixed'  // 保持滚动条位置不变 - v2.7.3 新增
                                    ,height: 2000 // 测试无效参数（即与数据无关的参数设置无效，此处以 height 设置无效为例）
                                    //,url: '404'
                                    //,page: {curr: 1, limit: 30} // 重新指向分页
                                });
                                break;
                            case 'reloadData-deep':
                                // 数据重载 - 参数叠加
                                table.reloadData('userList', {
                                    where: {
                                        abc: 123
                                        ,userList: '新的 userList1'
                                    }
                                }, true);
                                break;
                        }
                        layer.msg('可观察 Network 请求参数的变化');
                    }
                });
            }
            ,error: function(res, msg){
                console.log(res, msg)
            }
        });




        // 工具栏事件
        table.on('toolbar(userList)', function(obj){
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
                            url: '${pageContext.request.contextPath}/user/deleteSelectedUser',
                            type: 'POST',
                            data: { ids: ids },
                            success: function(res){
                                if(res.code === 200){
                                    layer.msg('删除成功', { icon: 1 });
                                    // 重新渲染表格
                                    table.reload('userList');
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
        table.on('tool(userList)', function(obj){ // 双击 toolDouble
            var data = obj.data; // 获得当前行数据
            // console.log(obj)
            if(obj.event === 'editSelectedUser'){
                // 加载并打开弹窗
                $.get("${pageContext.request.contextPath}/user/toEdit?id="+data.id, function (html) {
                    layer.open({
                        type: 1,
                        title: "编辑用户",
                        area: ['80%','80%'],
                        content: html,
                        btn: ["确定", "取消"],
                        yes: function (index, layero) {
                            layer.close(index);
                            table.reload('userList');
                        },
                        btn2: function (index, layero) {
                            layer.close(index);
                            return false;
                        }

                    });
                });
            } else if(obj.event === 'more'){
                // 更多 - 下拉菜单
                dropdown.render({
                    elem: this, // 触发事件的 DOM 对象
                    show: true, // 外部事件触发即显示
                    data: [{
                        title: '查看',
                        id: 'detailThisUser'
                    },{
                        title: '删除',
                        id: 'delThisUser'
                    }],
                    click: function(menudata){
                        if(menudata.id === 'detailThisUser'){
                            $.get("${pageContext.request.contextPath}/user/toUserInfo?id="+data.id, function (html) {
                                layer.open({
                                    type: 1,
                                    title: "用户详情",
                                    area: ['80%','80%'],
                                    content: html,
                                    btn: ["确定", "取消"],
                                    yes: function (index, layero) {
                                        layer.close(index);
                                        table.reload('userList');
                                    },
                                    btn2: function (index, layero) {
                                        layer.close(index);
                                        return false;
                                    }

                                });
                            });
                        } else if(menudata.id === 'delThisUser'){
                            layer.confirm('确认删除', function(index){
                                obj.del(); // 删除对应行（tr）的DOM结构
                                layer.close(index);
                                // 向服务端发送删除指令
                                $.ajax({

                                    type:"get",

                                    url:"${pageContext.request.contextPath}/user/deleteOneUser?id="+data.id,

                                    dataType:"json",

                                    success:function (result){
                                        if(result.code==200){
                                            layer.msg('删除成功', {icon: 0, time: 1000});
                                        }
                                    }

                                })
                            });
                        }
                    },
                    align: 'right', // 右对齐弹出
                    style: 'box-shadow: 1px 1px 10px rgb(0 0 0 / 12%);' // 设置额外样式
                })
            }
        });

        // 触发表格复选框选择
        table.on('checkbox(userList)', function(obj){
            console.log(obj)
        });

        // 触发表格单选框选择
        table.on('radio(userList)', function(obj){
            console.log(obj)
        });

        // 行单击事件
        table.on('row(userList)', function(obj){
            //console.log(obj);
            //layer.closeAll('tips');
        });
        // 行双击事件
        table.on('rowDouble(userList)', function(obj){
            console.log(obj);
        });

        // 单元格编辑事件
        table.on('edit(userList)', function(obj){
            var field = obj.field; // 得到字段
            var value = obj.value; // 得到修改后的值
            var data = obj.data; // 得到所在行所有键值
            // 值的校验
            if(field === 'email'){
                if(!/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.userList(obj.value)){
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

