package com.qst.query;

/**
 * @ClassName:NoticeQuery
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/11 18:23
 **/
public class NoticeQuery extends BaseQuery{
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
