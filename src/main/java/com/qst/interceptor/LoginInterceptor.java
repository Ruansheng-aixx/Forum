package com.qst.interceptor;

import com.qst.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName:LoginInterceptor
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/7 16:53
 **/
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String uri = request.getRequestURI();

        if(uri.indexOf("toLogin")!=-1||uri.indexOf("login")!=-1||uri.indexOf("login.jsp")!=-1||uri.indexOf("getVerifyCode")!=-1||uri.indexOf("toRegister")!=-1||uri.indexOf("toRegister.jsp")!=-1||uri.indexOf("register")!=-1||uri.indexOf("register")!=-1||uri.indexOf("getRoleList")!=-1){

            return true;

        }

        User userInfo = (User) request.getSession().getAttribute("userInfo");

        if(userInfo==null){

            request.getRequestDispatcher("/user/toLogin").forward(request,response);

            return false;

        }else {

            return true;

        }

    }
}
