package com.qst.controller;

import com.qst.pojo.ForumTheme;
import com.qst.pojo.Result;
import com.qst.service.ForumThemeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @ClassName:ForumTheme
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/9 0:28
 **/
@Controller
@RequestMapping("forumTheme")
public class ForumThemeController {

    @Autowired
    private ForumThemeService forumThemeService;

    @RequestMapping("getForumThemeList")
    @ResponseBody
    public List<ForumTheme> getForumThemeList(){

        return forumThemeService.getForumThemeList();

    }

    @RequestMapping("getForumThemeListData")
    @ResponseBody
    public Result getForumThemeListData(){

        List<ForumTheme> data = forumThemeService.getForumThemeList();

        return new Result(0,data);

    }

    @RequestMapping("toAddForumTheme")
    public String toAddForumTheme(){

        return "addForumTheme";

    }

    @RequestMapping("addForumTheme")
    @ResponseBody
    public Result addForumTheme(String themeName){

        return forumThemeService.addForumTheme(themeName);

    }

    @RequestMapping("toThemeList")
    public String themeList(){

        return "themeList";

    }

    @RequestMapping("toEditTheme")
    public String toEditTheme(Integer id, Model model){

        ForumTheme forumTheme = forumThemeService.getForumThemeById(id);

        model.addAttribute("forumTheme",forumTheme);

        return "editTheme";

    }

    @RequestMapping("editForumTheme")
    @ResponseBody
    public Result editForumTheme(ForumTheme forumTheme){

        return forumThemeService.editForumTheme(forumTheme);

    }

    @RequestMapping("deleteOneTheme")
    @ResponseBody
    public Result deleteOneTheme(Integer id){

        return forumThemeService.deleteOneThemeById(id);

    }

    @RequestMapping("deleteSelectedTheme")
    @ResponseBody
    public Result deleteSelectedTheme(@RequestParam(name="ids[]")Integer[] ids){

        return forumThemeService.deleteSelectedTheme(ids);

    }

}
