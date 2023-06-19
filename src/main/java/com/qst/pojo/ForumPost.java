package com.qst.pojo;

/**
 * @ClassName:ForumPost
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/9 0:02
 **/
public class ForumPost {
    private Integer id;
    private Integer themeId;
    private String postName;
    private String postPicture;
    private String postContext;
    private String releaseTime;
    private Integer postViews;
    private Integer publisher;
    private String deleteTime;
    private Integer target;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getThemeId() {
        return themeId;
    }

    public void setThemeId(Integer themeId) {
        this.themeId = themeId;
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

    public Integer getPublisher() {
        return publisher;
    }

    public void setPublisher(Integer publisher) {
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

    @Override
    public String toString() {
        return "ForumPost{" +
                "id=" + id +
                ", themeId=" + themeId +
                ", postName='" + postName + '\'' +
                ", postPicture='" + postPicture + '\'' +
                ", postContext='" + postContext + '\'' +
                ", releaseTime='" + releaseTime + '\'' +
                ", postViews=" + postViews +
                ", publisher=" + publisher +
                ", deleteTime='" + deleteTime + '\'' +
                ", target=" + target +
                '}';
    }
}
