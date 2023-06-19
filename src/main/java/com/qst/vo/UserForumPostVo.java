package com.qst.vo;

/**
 * @ClassName:UserForumPostVo
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/10 0:46
 **/
public class UserForumPostVo {
    private Integer id;
    private Integer themeId;
    private String themeName;
    private String postName;
    private String postPicture;
    private String postContext;
    private String releaseTime;
    private Integer postViews;
    private Integer publisher;
    private String userName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getThemeName() {
        return themeName;
    }

    public void setThemeName(String themeName) {
        this.themeName = themeName;
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getPostPicture() {
        return postPicture;
    }

    public void setPostPicture(String postPicture) {
        this.postPicture = postPicture;
    }

    public String getPostContext() {
        return postContext;
    }

    public void setPostContext(String postContext) {
        this.postContext = postContext;
    }

    public String getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(String releaseTime) {
        this.releaseTime = releaseTime;
    }

    public Integer getPostViews() {
        return postViews;
    }

    public void setPostViews(Integer postViews) {
        this.postViews = postViews;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getThemeId() {
        return themeId;
    }

    public void setThemeId(Integer themeId) {
        this.themeId = themeId;
    }

    public Integer getPublisher() {
        return publisher;
    }

    public void setPublisher(Integer publisher) {
        this.publisher = publisher;
    }

    @Override
    public String toString() {
        return "UserForumPostVo{" +
                "id=" + id +
                ", themeId=" + themeId +
                ", themeName='" + themeName + '\'' +
                ", postName='" + postName + '\'' +
                ", postPicture='" + postPicture + '\'' +
                ", postContext='" + postContext + '\'' +
                ", releaseTime='" + releaseTime + '\'' +
                ", postViews=" + postViews +
                ", publisher=" + publisher +
                ", userName='" + userName + '\'' +
                '}';
    }
}
