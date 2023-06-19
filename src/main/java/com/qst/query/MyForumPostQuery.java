package com.qst.query;

/**
 * @ClassName:MyForumPostQuery
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/10 11:54
 **/
public class MyForumPostQuery extends BaseQuery {

    private Integer id;
    private String keyWord;
    private String sortField;
    private String sortOrder;

    private Integer userId;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getKeyWord() {
        return keyWord;
    }

    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }

    public String getSortField() {
        return sortField;
    }

    public void setSortField(String sortField) {
        this.sortField = sortField;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }
}
