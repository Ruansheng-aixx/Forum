package com.qst.pojo;

/**
 * @ClassName:Collection
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/12 12:44
 **/
public class Collections {
    private Integer id;
    private Integer userId;
    private Integer postId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    @Override
    public String toString() {
        return "Collection{" +
                "id=" + id +
                ", userId=" + userId +
                ", postId=" + postId +
                '}';
    }
}
