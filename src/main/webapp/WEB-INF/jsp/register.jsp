<%--
  Created by IntelliJ IDEA.
  User: 59499
  Date: 2023/6/7
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户注册</title>
  <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui-v2.8.4/layui/css/layui.css" media="all" />
  <script src="${pageContext.request.contextPath}/layui-v2.8.4/layui/layui.js"></script>

  <script>
    layui.use(function(){
      var $ = layui.$;
      var form = layui.form;
      var layer = layui.layer;
      var util = layui.util;

      // 自定义验证规则
      form.verify({
        // 确认密码
        confirmPassword: function(value, item){
          var passwordValue = $('#reg-password').val();
          if(value !== passwordValue){
            return '两次密码输入不一致';
          }
        }
      });

      // 提交事件
      form.on('submit(demo-reg)', function(data){
        var field = data.field; // 获取表单字段值

        // 此处可执行 Ajax 等操作
        // …
        //发送注册请求
        $.ajax({
          type: "POST",
          url: "${pageContext.request.contextPath}/user/register",
          data: field,
          success: function(result){
            //注册成功
            if(result.code==200){
              layer.msg('注册成功', {icon: 0}, function(){
                setTimeout(function(){
                  location.href="${pageContext.request.contextPath}/user/toLogin";
                }, 200);
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

    });

    function change(){
      var img = document.getElementById("img");

      img.src = "${pageContext.request.contextPath}/getVerifyCode?time="+new Date();
    }
  </script>
</head>
<body>
<div style="margin-top: 230px">
  <h1 style="text-align: center">用户注册</h1>
  <form class="layui-form">
    <div class="demo-reg-container">
      <div class="layui-form-item">
        <div class="layui-input-wrap">
          <div class="layui-input-prefix">
            <i class="layui-icon layui-icon-vercode"></i>
          </div>
          <input type="text" name="userName" value="" lay-verify="required" placeholder="用户名" lay-reqtext="请填写用户名" autocomplete="off" class="layui-input">
        </div>
      </div>
      <div class="layui-form-item">
        <div class="layui-input-wrap">
          <div class="layui-input-prefix">
            <i class="layui-icon layui-icon-password"></i>
          </div>
          <input type="password" name="userPwd" value="" lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input" id="reg-password" lay-affix="eye">
        </div>
      </div>
      <div class="layui-form-item">
        <div class="layui-input-wrap">
          <div class="layui-input-prefix">
            <i class="layui-icon layui-icon-password"></i>
          </div>
          <input type="password" name="" value="" lay-verify="required|confirmPassword" placeholder="确认密码" autocomplete="off" class="layui-input" lay-affix="eye">
        </div>
      </div>
      <div class="layui-form-item" pane>
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
          <input type="radio" name="gender" value="男" title="男" checked>
          <input type="radio" name="gender" value="女" title="女">
        </div>
      </div>
      <div class="layui-form-item">
        <div class="layui-row">
          <div class="layui-col-xs7">
            <div class="layui-input-wrap">
              <div class="layui-input-prefix">
                <i class="layui-icon layui-icon-vercode"></i>
              </div>
              <input type="text" name="verityCode" value="" lay-verify="required" placeholder="验证码" lay-reqtext="请填写验证码" autocomplete="off" class="layui-input" lay-affix="clear">
            </div>
          </div>
          <div class="layui-col-xs5">
            <div style="margin-left: 10px;">
              <a href="javascript:change()">
                <img id="img" width="100px" src="${pageContext.request.contextPath}/getVerifyCode">
              </a>
            </div>
          </div>
        </div>
      </div>
      <div class="layui-form-item">
        <button class="layui-btn layui-btn-fluid" lay-submit lay-filter="demo-reg">注册</button>
      </div>
    </div>
  </form>
</div>
</body>
<style>
  .demo-reg-container{width: 320px; margin: 21px auto 0;}
  .demo-reg-other .layui-icon{position: relative; display: inline-block; margin: 0 2px; top: 2px; font-size: 26px;}
</style>
</html>
