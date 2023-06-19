package com.qst.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qst.pojo.Notice;
import com.qst.pojo.Result;
import com.qst.pojo.User;
import com.qst.query.NoticeQuery;
import com.qst.service.NoticeService;
import com.qst.vo.UserNoticeVo;
import org.aspectj.weaver.ast.Not;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @ClassName:NoticeController
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/11 17:38
 **/
@Controller
@RequestMapping("notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    @RequestMapping("toAddNotice")
    public String toAddNotice(){

        return "addNotice";

    }

    @PostMapping("addNotice")
    @ResponseBody
    public Result addNotice(Notice notice){

        return noticeService.addNotice(notice);

    }

    @RequestMapping("toNoticeList")
    public String toNoticeList(){

        return "noticeList";

    }

    @RequestMapping("getNoticeList")
    @ResponseBody
    public Result getNoticeList(NoticeQuery noticeQuery){

        //开启分页
        PageHelper.startPage(noticeQuery.getPage(),noticeQuery.getLimit());

        List<UserNoticeVo> userNoticeVoList = noticeService.getNoticeList(noticeQuery);

        //当前页，下一页，上一页，首页，尾页。。。。需要一个类进行封装，
        PageInfo<UserNoticeVo> noticePageInfo = new PageInfo<>(userNoticeVoList);

        List<UserNoticeVo> data = noticePageInfo.getList();

        int count = noticeService.getCount();

        return new Result(0,"",data,count);

    }

    @RequestMapping("toEditNotice")
    public String toEditNotice(Integer id, Model model){

        Notice notice = noticeService.getNoticeById(id);

        model.addAttribute("notice",notice);

        return "editNotice";

    }

    @PostMapping("editNotice")
    @ResponseBody
    public Result editNotice(Notice notice){

        return noticeService.editNotice(notice);

    }

    @RequestMapping("toNoticeInfo")
    public String toNoticeInfo(Integer id,Model model){

        UserNoticeVo userNoticeVo = noticeService.getOneNoticeById(id);

        model.addAttribute("userNoticeVo",userNoticeVo);

        return "noticeInfo";

    }

    @RequestMapping("deleteOneNotice")
    @ResponseBody
    public Result deleteOneNotice(Integer id){

        return noticeService.deleteOneNotice(id);

    }

    @RequestMapping("deleteSelectedNotice")
    @ResponseBody
    public Result deleteSelectedNotice(@RequestParam(name="ids[]")Integer[] ids){

        return noticeService.deleteSelectedNotice(ids);

    }

    @RequestMapping("toShowAllNotice")
    public String toShowAllNotice(){

        return "showAllNotice";

    }
}
