package com.qst.mapper;

import com.qst.pojo.ForumTheme;

import java.util.List;

/**
 * @ClassName:ForumTheme
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/9 0:31
 **/
public interface ForumThemeMapper {
    List<ForumTheme> getForumThemeList();

    int addForumTheme(String forumTheme);

    ForumTheme getForumThemeById(Integer id);

    int editForumTheme(ForumTheme forumTheme);

    int deleteOneThemeById(Integer id);

    int deleteSelectedTheme(Integer[] ids);
}
