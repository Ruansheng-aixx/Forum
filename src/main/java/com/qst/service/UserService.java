package com.qst.service;

import com.qst.mapper.ForumPostMapper;
import com.qst.mapper.UserMapper;
import com.qst.pojo.ForumPost;
import com.qst.pojo.Result;
import com.qst.pojo.User;
import com.qst.query.UserQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * @ClassName:UserService
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/7 18:44
 **/
@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ForumPostMapper forumPostMapper;

    public Result login(String userName, String userPwd, String verityCode, HttpSession session) {

        //非空校验
        if(StringUtils.isEmpty(userName)){

            return new Result(100,"用户名不能为空");

        }
        if(StringUtils.isEmpty(userPwd)){

            return new Result(100,"密码不能为空");

        }
        if(StringUtils.isEmpty(verityCode)){

            return new Result(100,"验证码不能为空");

        }

        //判断验证码是否正确
        String realVerityCode = (String) session.getAttribute("verifyCode");

        if(!verityCode.equalsIgnoreCase(realVerityCode)){

            return new Result(100,"验证码不正确");

        }

        //登录,通过用户名和密码来进行登录，通过用户名和密码来进行查询
        User user = userMapper.login(userName,userPwd);

        if(user==null){

            return new Result(100,"用户名或密码错误");

        }

        //用户名密码正确，登陆成功
        return new Result(200,"登录成功",user);

    }

    public Result register(User user, String verityCode, HttpSession session) {

        //非空校验
        if(StringUtils.isEmpty(user.getUserName())){

            return new Result(100,"用户名不能为空");

        }
        if(StringUtils.isEmpty(user.getUserPwd())){

            return new Result(100,"密码不能为空");

        }
        //判断验证码是否正确
        String realVerityCode = (String) session.getAttribute("verifyCode");

        if(!verityCode.equalsIgnoreCase(realVerityCode)){

            return new Result(100,"验证码不正确");

        }

        User user1 = userMapper.getByUserName(user.getUserName());

        if(user1!=null){

            return new Result(100,"该用户名已被注册");

        }

        int row = userMapper.register(user);

        if(row!=1){

            return new Result(100,"添加失败");

        }

        return new Result(200,"添加成功");


    }

    public User getById(Integer id) {

        return userMapper.getById(id);

    }

    public Result editUser(User user) {

        User user1 = userMapper.getByUserName(user.getUserName());

        if(user1!=null&&user1.getId()!=user.getId()){

            return new Result(100,"该用户名已被注册");

        }
        int row = userMapper.update(user);

        if(row!=1){

            return new Result(100,"修改失败");

        }

        return new Result(200,"修改成功",user);

    }

    public Result addUser(User user) {

        //非空校验
        if(StringUtils.isEmpty(user.getUserName())){

            return new Result(100,"用户名不能为空");

        }
        if(StringUtils.isEmpty(user.getUserPwd())){

            return new Result(100,"密码不能为空");

        }

        User user1 = userMapper.getByUserName(user.getUserName());

        if(user1!=null){

            return new Result(100,"该用户名已被注册");

        }

        int row = userMapper.addUser(user);

        if(row!=1){

            return new Result(100,"添加失败");

        }

        return new Result(200,"添加成功");

    }

    public List<User> getUserList(UserQuery userQuery) {

        return userMapper.getUserList(userQuery);

    }

    public int getCount() {

        List<User> userList = userMapper.getCount();

        return userList.size();

    }

    @Transactional
    public Result deleteOneUser(Integer id) {

        int row = userMapper.deleteOneUser(id);

        Date now = new Date();
        String currentTime = String.format("%tF %<tT", now);

        int row2 = forumPostMapper.deleteForumPostByPublisher(id,currentTime);

        List<ForumPost> forumPostList = forumPostMapper.getForumPostByPublisher(id);

        int num = forumPostList.size();

        if(row==1&&row2==num){

            return new Result(200,"删除成功");

        }else {

            return new Result(100,"出现异常");

        }

    }

    @Transactional
    public Result deleteSelectedUser(Integer[] ids) {

        Date now = new Date();
        String currentTime = String.format("%tF %<tT", now);

        int row = userMapper.deleteSelectedUser(ids);

        int row2 = forumPostMapper.deleteForumPostByPublisherList(ids,currentTime);

        if(row == ids.length){

            return new Result(200,"删除成功");

        }else {

            return new Result(100,"删除出现异常");

        }

    }

    public Result addAdmin(Integer id) {

        int row = userMapper.addAdmin(id);

        if(row == 1){

            return new Result(200,"添加成功");

        }else {

            return new Result(100,"添加失败");

        }

    }

    public List<User> getAdminList(UserQuery userQuery) {

        return userMapper.getAdminList(userQuery);

    }

    public Result deleteAdmin(Integer id) {

        int row = userMapper.deleteAdmin(id);

        if(row == 1){

            return new Result(200,"删除成功");

        }else {

            return new Result(100,"删除失败");

        }

    }
}
