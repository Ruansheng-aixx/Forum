package com.qst.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qst.pojo.Result;
import com.qst.pojo.User;
import com.qst.query.UserQuery;
import com.qst.service.UserService;
import com.qst.util.OssUtil;
import com.qst.vo.UserForumPostVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * @ClassName:UserController
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/7 17:20
 **/
@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("toLogin")
    public String toLogin(){

        return "login";

    }

    @PostMapping("login")
    @ResponseBody
    public Result login(String userName, String userPwd, String verityCode, HttpSession session, Model model){

        Result result = userService.login(userName,userPwd,verityCode,session);

        if(result.getCode()==200){

            //登录成功
            User userInfo = (User) result.getData();

            session.setAttribute("userInfo",userInfo);

            session.setAttribute("avatar",userInfo.getAvatar());

            return result;

        }else {

            //登录失败

            return result;

        }

    }

    @RequestMapping("toIndex")
    public String toIndex(){

        return "index";

    }

    @RequestMapping("toRegister")
    public String toRegister(){

        return "register";

    }

    @PostMapping("register")
    @ResponseBody
    public Result register(User user,String verityCode,HttpSession session,Model model){

        user.setRoleId(3);

        return userService.register(user,verityCode,session);

    }

    @RequestMapping("logout")
    public String logout(HttpSession session){

        //清除session
        session.invalidate();

        return "login";

    }

    @RequestMapping("toEdit")
    public String toEdit(Integer id,Model model){

        User user = userService.getById(id);

        model.addAttribute("user",user);

        return "editUser";

    }

    @RequestMapping("/uploadAvatar")
    @ResponseBody
    public Result uploadAvatar(@RequestParam("file") MultipartFile upload) throws IOException {

        //获取上传的文件名
        String fileName = upload.getOriginalFilename();

        //产生新的文件名，时间戳+原先文件名后缀
        String newFileName = System.currentTimeMillis()+fileName.substring(fileName.lastIndexOf("."));

        String path = "avatar/";

        String avatar = OssUtil.upload(newFileName, upload.getInputStream(),path);

        return new Result(200,avatar);

    }

    @RequestMapping("editUser")
    @ResponseBody
    public Result editUser(User user,HttpSession session){

        Result result = userService.editUser(user);

        if(result.getCode()==200){

            session.setAttribute("avatar",user.getAvatar());

        }

        return result;

    }

    @RequestMapping("toPersonCenter")
    public String toPersonCenter(){

        return "personCenter";

    }

    @RequestMapping("toUserInfo")
    public String toUserInfo(Integer id,Model model){

        User user = userService.getById(id);

        model.addAttribute("user",user);

        return "userInfo";

    }

    @RequestMapping("toAdminCenter")
    public String toAdminCenter(){

        return "adminCenter";

    }

    @RequestMapping("toAddUser")
    public String toAddUser(){

        return "addUser";

    }

    @RequestMapping("addUser")
    @ResponseBody
    public Result addUser(User user){

        user.setRoleId(3);

        return userService.addUser(user);

    }

    @RequestMapping("toUserList")
    public String toUserList(){

        return "userList";

    }

    @RequestMapping("getUserList")
    @ResponseBody
    public Result getUserList(UserQuery userQuery){
        //开启分页
        PageHelper.startPage(userQuery.getPage(),userQuery.getLimit());

        List<User> userList = userService.getUserList(userQuery);

        //当前页，下一页，上一页，首页，尾页。。。。需要一个类进行封装，
        PageInfo<User> userPageInfo = new PageInfo<>(userList);

        List<User> data = userPageInfo.getList();

        int count = userService.getCount();

        return new Result(0,"",data,count);

    }

    @RequestMapping("deleteOneUser")
    @ResponseBody
    public Result deleteOneUser(Integer id){

        return userService.deleteOneUser(id);

    }

    @RequestMapping("deleteSelectedUser")
    @ResponseBody
    public Result deleteSelectedUser(@RequestParam(name="ids[]")Integer[] ids){

        return userService.deleteSelectedUser(ids);

    }

    @RequestMapping("toSuperAdminCenter")
    public String toSuperAdminCenter(){

        return "superAdminCenter";

    }

    @RequestMapping("toAddAdmin")
    public String toAddAdmin(){

        return "addAdmin";

    }

    @RequestMapping("addAdmin")
    @ResponseBody
    public Result addAdmin(Integer id){

        return userService.addAdmin(id);

    }

    @RequestMapping("toAdminList")
    public String toAdminList(){

        return "adminList";

    }

    @RequestMapping("getAdminList")
    @ResponseBody
    public Result getAdminList(UserQuery userQuery){

        //开启分页
        PageHelper.startPage(userQuery.getPage(),userQuery.getLimit());

        List<User> userList = userService.getAdminList(userQuery);

        //当前页，下一页，上一页，首页，尾页。。。。需要一个类进行封装，
        PageInfo<User> userPageInfo = new PageInfo<>(userList);

        List<User> data = userPageInfo.getList();

        int count = userService.getCount();

        return new Result(0,"",data,count);

    }

    @RequestMapping("deleteAdmin")
    @ResponseBody
    public Result deleteAdmin(Integer id){

        return userService.deleteAdmin(id);

    }
}
