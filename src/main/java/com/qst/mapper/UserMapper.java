package com.qst.mapper;

import com.qst.pojo.User;
import com.qst.query.UserQuery;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName:UserMapper
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/7 17:27
 **/
public interface UserMapper {
    User login(@Param("userName") String userName, @Param("userPwd") String userPwd);

    User getByUserName(String userName);

    int register(User user);

    User getById(Integer id);

    int update(User user);

    int addUser(User user);

    List<User> getUserList(UserQuery userQuery);

    List<User> getCount();

    int deleteOneUser(Integer id);

    int deleteSelectedUser(Integer[] ids);

    int addAdmin(Integer id);

    List<User> getAdminList(UserQuery userQuery);

    int deleteAdmin(Integer id);
}
