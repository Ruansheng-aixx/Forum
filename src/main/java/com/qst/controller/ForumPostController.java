package com.qst.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qst.pojo.ECharts;
import com.qst.pojo.ForumPost;
import com.qst.pojo.Result;
import com.qst.pojo.User;
import com.qst.query.MyForumPostQuery;
import com.qst.service.CollectionService;
import com.qst.service.ForumPostService;
import com.qst.util.OssUtil;
import com.qst.vo.UserForumPostVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * @ClassName:ForumPostController
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/9 0:08
 **/
@Controller
@RequestMapping("forumPost")
public class ForumPostController {

    @Autowired
    private ForumPostService forumPostService;

    @Autowired
    private CollectionService collectionService;

    @RequestMapping("toPublishForumPost")
    public String toPublishForumPost(){

        return "publishForumPost";

    }

    @RequestMapping("uploadPostPicture")
    @ResponseBody
    public Result uploadPostPicture(@RequestParam("file") MultipartFile upload) throws IOException {

        //获取上传的文件名
        String fileName = upload.getOriginalFilename();

        //产生新的文件名，时间戳+原先文件名后缀
        String newFileName = System.currentTimeMillis()+fileName.substring(fileName.lastIndexOf("."));

        String path = "postPicture/";

        String postPicture = OssUtil.upload(newFileName, upload.getInputStream(),path);

        return new Result(200,postPicture);

    }

    @PostMapping("addForumPost")
    @ResponseBody
    public Result addForumPost(ForumPost forumPost){

        return forumPostService.addForumPost(forumPost);

    }

    @RequestMapping("toMyForumPost")
    public String toMyForumPost(){

        return "myForumPost";

    }

    @RequestMapping("getMyForumPostList")
    @ResponseBody
    public Result getMyForumPostList(MyForumPostQuery myForumPostQuery){

        //开启分页
        PageHelper.startPage(myForumPostQuery.getPage(),myForumPostQuery.getLimit());

        List<UserForumPostVo> userForumPostVoList = forumPostService.getMyForumPostList(myForumPostQuery);

        //当前页，下一页，上一页，首页，尾页。。。。需要一个类进行封装，
        PageInfo<UserForumPostVo> userForumPostVoPageInfo = new PageInfo<>(userForumPostVoList);

        List<UserForumPostVo> data = userForumPostVoPageInfo.getList();

        int count = forumPostService.getCount(myForumPostQuery);

        return new Result(0,"",data,count);

    }

    @RequestMapping("toForumPostInfo")
    public String toForumPostInfo(Integer forumId, Model model, HttpSession session){

        UserForumPostVo userForumPostVo = forumPostService.getUserForumPostVoId(forumId);

        model.addAttribute("userForumPostVo",userForumPostVo);

        int userId = forumPostService.getPostPublisherById(forumId);

        User user = (User) session.getAttribute("userInfo");


        if(userId != user.getId()){

            forumPostService.addPostViews(forumId);

        }

        return "forumPostInfo";

    }

    @RequestMapping("deleteOneForumPost")
    @ResponseBody
    public Result deleteOneForumPost(Integer id){

        return forumPostService.deleteOneForumPost(id);

    }

    @PostMapping("deleteSelectedForumPosts")
    @ResponseBody
    public Result deleteSelectedForumPosts(@RequestParam(name="ids[]")Integer[] ids){

        return forumPostService.deleteSelectedForumPosts(ids);

    }

    @RequestMapping("toEditForumPost")
    public String toEditForumPost(Integer forumId,Model model){

        UserForumPostVo userForumPostVo = forumPostService.getForumPostById(forumId);

        model.addAttribute("userForumPostVo",userForumPostVo);

        return "editForumPost";

    }

    @RequestMapping("editForumPost")
    @ResponseBody
    public Result editForumPost(ForumPost forumPost){

        return forumPostService.editForumPost(forumPost);

    }

    @RequestMapping("toAllForumPost")
    public String toAllForumPost(){

        return "allForumPost";

    }

    @RequestMapping("getAllForumPostList")
    @ResponseBody
    public Result getAllForumPostList(MyForumPostQuery myForumPostQuery){

        //开启分页
        PageHelper.startPage(myForumPostQuery.getPage(),myForumPostQuery.getLimit());

        List<UserForumPostVo> userForumPostVoList = forumPostService.getAllForumPostList(myForumPostQuery);

        //当前页，下一页，上一页，首页，尾页。。。。需要一个类进行封装，
        PageInfo<UserForumPostVo> userForumPostVoPageInfo = new PageInfo<>(userForumPostVoList);

        List<UserForumPostVo> data = userForumPostVoPageInfo.getList();

        int count = forumPostService.getAllCount(myForumPostQuery);

        return new Result(0,"",data,count);

    }

    @RequestMapping("toShowAllPost")
    public String toShowAll(){

        return "showAllPost";

    }

    @RequestMapping("getMyCollection")
    @ResponseBody
    public Result getMyCollection(MyForumPostQuery myForumPostQuery){

        Integer[] ids = collectionService.getPostIdsByUserId(myForumPostQuery.getUserId());

        //开启分页
        PageHelper.startPage(myForumPostQuery.getPage(),myForumPostQuery.getLimit());

        List<UserForumPostVo> userForumPostVoList = forumPostService.getMyCollection(myForumPostQuery);

        //当前页，下一页，上一页，首页，尾页。。。。需要一个类进行封装，
        PageInfo<UserForumPostVo> userForumPostVoPageInfo = new PageInfo<>(userForumPostVoList);

        List<UserForumPostVo> data = userForumPostVoPageInfo.getList();

        int count = ids.length;

        return new Result(0,"",data,count);

    }

    @RequestMapping("getEChartsData")
    @ResponseBody
    public List<ECharts> getEChartsData(){

        return forumPostService.getEChartsData();

    }

}
