package com.qst.mapper;

import com.qst.pojo.Notice;
import com.qst.query.NoticeQuery;
import com.qst.vo.UserNoticeVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName:NoticeMapper
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/11 17:39
 **/
public interface NoticeMapper {
    int addNotice(Notice notice);

    List<UserNoticeVo> getNoticeList(NoticeQuery noticeQuery);

    List<UserNoticeVo> getAll();

    Notice getNoticeById(Integer id);

    int editNotice(Notice notice);

    UserNoticeVo getOneNoticeById(Integer id);

    int deleteOneNotice(@Param("id")Integer id, @Param("currentTime") String currentTime);

    int deleteSelectedNotice(@Param("ids")Integer[] ids, @Param("currentTime")String currentTime);
}
