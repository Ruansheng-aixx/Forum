package com.qst.mapper;

import com.qst.pojo.ECharts;
import com.qst.pojo.ForumPost;
import com.qst.query.MyForumPostQuery;
import com.qst.vo.UserForumPostVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName:ForumPostMapper
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/9 17:03
 **/
public interface ForumPostMapper {
    int addForumPost(ForumPost forumPost);

    List<UserForumPostVo> getMyForumPostList(MyForumPostQuery myForumPostQuery);

    List<ForumPost> getCount(MyForumPostQuery myForumPostQuery);

    UserForumPostVo getUserForumPostVoId(Integer id);

    int deleteOneForumPost(@Param("id") Integer id,@Param("currentTime") String currentTime);

    int deleteSelectedForumPosts(@Param("ids")Integer[] ids,@Param("currentTime") String currentTime);

    UserForumPostVo getForumPostById(Integer id);

    int editForumPost(ForumPost forumPost);

    int getPostPublisherById(Integer forumId);

    void addPostViews(Integer forumId);

    int deleteForumPostByPublisher(@Param("id")Integer id, @Param("currentTime")String currentTime);

    List<ForumPost> getForumPostByPublisher(Integer id);

    int deleteForumPostByPublisherList(@Param("ids")Integer[] ids,@Param("currentTime") String currentTime);

    int deleteForumPostByThemeList(@Param("ids")Integer[] ids,@Param("currentTime") String currentTime);

    List<UserForumPostVo> getAllForumPostList(MyForumPostQuery myForumPostQuery);

    List<ForumPost> getAllCount(MyForumPostQuery myForumPostQuery);

    List<UserForumPostVo> getMyCollections(MyForumPostQuery myForumPostQuery);

    List<ECharts> getEChartsData();

    int deleteForumPostByThemeId(@Param("id") Integer id, @Param("currentTime") String currentTime);
}
