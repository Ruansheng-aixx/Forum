package com.qst.query;

/**
 * @ClassName:UserQuery
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/11 11:43
 **/
public class UserQuery extends BaseQuery{
    private String keyWord;
    private String sortField;
    private String sortOrder;

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
