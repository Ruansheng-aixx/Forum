package com.qst.query;

/**
 * @ClassName:BaseQuery
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/10 11:53
 **/
public class BaseQuery {
    //当前页
    private Integer page=1;
    //每页显示的记录数
    private Integer limit=5;

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }
}
