package com.qst.vo;

/**
 * @ClassName:UserNoticeVo
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/11 18:39
 **/
public class UserNoticeVo {
    private Integer id;
    private String noticeName;
    private String noticeContext;
    private String releaseTime;
    private String publisher;
    private Integer target;
    private String deleteTime;
    private String userName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNoticeName() {
        return noticeName;
    }

    public void setNoticeName(String noticeName) {
        this.noticeName = noticeName;
    }

    public String getNoticeContext() {
        return noticeContext;
    }

    public void setNoticeContext(String noticeContext) {
        this.noticeContext = noticeContext;
    }

    public String getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(String releaseTime) {
        this.releaseTime = releaseTime;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public Integer getTarget() {
        return target;
    }

    public void setTarget(Integer target) {
        this.target = target;
    }

    public String getDeleteTime() {
        return deleteTime;
    }

    public void setDeleteTime(String deleteTime) {
        this.deleteTime = deleteTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "UserNoticeVo{" +
                "id=" + id +
                ", noticeName='" + noticeName + '\'' +
                ", noticeContext='" + noticeContext + '\'' +
                ", releaseTime='" + releaseTime + '\'' +
                ", publisher='" + publisher + '\'' +
                ", target=" + target +
                ", deleteTime='" + deleteTime + '\'' +
                ", userName='" + userName + '\'' +
                '}';
    }
}
