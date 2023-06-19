package com.qst.pojo;

/**
 * @ClassName:ECharts
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/12 17:30
 **/
public class ECharts {
    private Integer value;
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "ECharts{" +
                "value=" + value +
                ", name='" + name + '\'' +
                '}';
    }
}
