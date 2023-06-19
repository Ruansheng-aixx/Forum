package com.qst.service;

import com.qst.mapper.ForumPostMapper;
import com.qst.mapper.ForumThemeMapper;
import com.qst.pojo.ForumTheme;
import com.qst.pojo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @ClassName:ForumThemeService
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/9 0:30
 **/
@Service
public class ForumThemeService {

    @Autowired
    private ForumThemeMapper forumThemeMapper;

    @Autowired
    private ForumPostMapper forumPostMapper;
    public List<ForumTheme> getForumThemeList() {

        return forumThemeMapper.getForumThemeList();

    }

    public Result addForumTheme(String forumTheme) {

        if(forumTheme == null){

            return new Result(100,"帖子分类名称不能为空");

        }

        int row = forumThemeMapper.addForumTheme(forumTheme);

        if(row == 1){

            return new Result(200,"添加成功");

        }else{

            return new Result(100,"添加失败");

        }

    }

    public ForumTheme getForumThemeById(Integer id) {

        return forumThemeMapper.getForumThemeById(id);

    }

    public Result editForumTheme(ForumTheme forumTheme) {

        int row = forumThemeMapper.editForumTheme(forumTheme);

        if(row == 1){

            return new Result(200,"修改成功");

        }else{

            return new Result(100,"修改失败");

        }

    }

    public Result deleteOneThemeById(Integer id) {

        Date now = new Date();
        String currentTime = String.format("%tF %<tT", now);

        int row = forumThemeMapper.deleteOneThemeById(id);

        int row2 = forumPostMapper.deleteForumPostByThemeId(id,currentTime);

        if(row == 1){

            return new Result(200,"删除成功");

        }else {

            return new Result(100,"删除失败");

        }

    }

    @Transactional
    public Result deleteSelectedTheme(Integer[] ids) {
        Date now = new Date();
        String currentTime = String.format("%tF %<tT", now);

        int row = forumThemeMapper.deleteSelectedTheme(ids);

        int row2 = forumPostMapper.deleteForumPostByThemeList(ids,currentTime);

        if(row == ids.length){

            return new Result(200,"删除成功");

        }else {

            return new Result(100,"删除出现异常");

        }
    }
}
