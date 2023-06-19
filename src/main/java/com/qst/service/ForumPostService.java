package com.qst.service;

import com.qst.mapper.CollectionMapper;
import com.qst.mapper.ForumPostMapper;
import com.qst.pojo.ECharts;
import com.qst.pojo.ForumPost;
import com.qst.pojo.Result;
import com.qst.query.MyForumPostQuery;
import com.qst.vo.UserForumPostVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * @ClassName:ForumPostService
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/9 17:02
 **/
@Service
public class ForumPostService {

    @Autowired
    private ForumPostMapper forumPostMapper;

    @Autowired
    private CollectionMapper collectionMapper;

    public Result addForumPost(ForumPost forumPost) {

        //非空校验
        if(StringUtils.isEmpty(forumPost.getPostName())){

            return new Result(100,"帖子名称不能为空");

        }
        if(StringUtils.isEmpty(forumPost.getThemeId())){

            return new Result(100,"帖子分类不能为空");

        }
        if(StringUtils.isEmpty(forumPost.getPublisher())){

            return new Result(100,"发布人不能为空");

        }

        int row = forumPostMapper.addForumPost(forumPost);

        if(row!=1){

            return new Result(100,"发布失败");

        }

        return new Result(200,"发布成功");


    }

    public List<UserForumPostVo> getMyForumPostList(MyForumPostQuery myForumPostQuery) {

        return forumPostMapper.getMyForumPostList(myForumPostQuery);

    }

    public int getCount(MyForumPostQuery myForumPostQuery) {

        List<ForumPost> forumPostList = forumPostMapper.getCount(myForumPostQuery);

        return forumPostList.size();

    }

    public UserForumPostVo getUserForumPostVoId(Integer id) {

        return forumPostMapper.getUserForumPostVoId(id);

    }

    public Result deleteOneForumPost(Integer id) {

        Date now = new Date();
        String currentTime = String.format("%tF %<tT", now);

        int row = forumPostMapper.deleteOneForumPost(id,currentTime);

        if(row == 1){

            return new Result(200,"删除成功");

        }else {

            return new Result(100,"删除出现异常");

        }

    }

    public Result deleteSelectedForumPosts(Integer[] ids) {

        Date now = new Date();
        String currentTime = String.format("%tF %<tT", now);

        int row = forumPostMapper.deleteSelectedForumPosts(ids,currentTime);

        if(row == ids.length){

            return new Result(200,"删除成功");

        }else {

            return new Result(100,"删除出现异常");

        }

    }

    public UserForumPostVo getForumPostById(Integer id) {

        return forumPostMapper.getForumPostById(id);

    }

    public Result editForumPost(ForumPost forumPost) {

        int row = forumPostMapper.editForumPost(forumPost);

        if(row == 1){

            return new Result(200,"修改成功");

        }else {

            return new Result(100,"修改失败");

        }

    }

    public int getPostPublisherById(Integer forumId) {

        return forumPostMapper.getPostPublisherById(forumId);

    }

    public void addPostViews(Integer forumId) {

        forumPostMapper.addPostViews(forumId);

    }

    public List<UserForumPostVo> getAllForumPostList(MyForumPostQuery myForumPostQuery) {

        return forumPostMapper.getAllForumPostList(myForumPostQuery);

    }

    public int getAllCount(MyForumPostQuery myForumPostQuery) {

        List<ForumPost> forumPostList = forumPostMapper.getAllCount(myForumPostQuery);

        return forumPostList.size();

    }

    public List<UserForumPostVo> getMyCollection(MyForumPostQuery myForumPostQuery) {

        return forumPostMapper.getMyCollections(myForumPostQuery);

    }

    public List<ECharts> getEChartsData() {

        return forumPostMapper.getEChartsData();

    }
}
