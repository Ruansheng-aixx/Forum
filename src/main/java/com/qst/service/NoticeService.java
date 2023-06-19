package com.qst.service;

import com.qst.mapper.NoticeMapper;
import com.qst.pojo.Notice;
import com.qst.pojo.Result;
import com.qst.query.NoticeQuery;
import com.qst.vo.UserNoticeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @ClassName:NoticeService
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/11 17:38
 **/
@Service
public class NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;
    public Result addNotice(Notice notice) {

        int row = noticeMapper.addNotice(notice);

        if(row == 1){

            return new Result(200,"发布成功");

        }else {

            return new Result(100,"发布失败");

        }

    }

    public List<UserNoticeVo> getNoticeList(NoticeQuery noticeQuery) {

        return noticeMapper.getNoticeList(noticeQuery);

    }

    public int getCount() {

        List<UserNoticeVo> userNoticeVoList = noticeMapper.getAll();

        return userNoticeVoList.size();

    }

    public Notice getNoticeById(Integer id) {

        return noticeMapper.getNoticeById(id);

    }

    public Result editNotice(Notice notice) {

        int row = noticeMapper.editNotice(notice);

        if(row == 1){

            return new Result(200,"修改成功");

        }else {

            return new Result(100,"修改失败");

        }

    }

    public UserNoticeVo getOneNoticeById(Integer id) {

        return noticeMapper.getOneNoticeById(id);

    }

    public Result deleteOneNotice(Integer id) {

        Date now = new Date();
        String currentTime = String.format("%tF %<tT", now);

        int row = noticeMapper.deleteOneNotice(id,currentTime);

        if(row == 1){

            return new Result(200,"删除成功");

        }else {

            return new Result(100,"删除失败");

        }

    }

    public Result deleteSelectedNotice(Integer[] ids) {

        Date now = new Date();
        String currentTime = String.format("%tF %<tT", now);

        int row = noticeMapper.deleteSelectedNotice(ids,currentTime);

        if(row == ids.length){

            return new Result(200,"删除成功");

        }else {

            return new Result(100,"删除出现异常");

        }

    }
}
