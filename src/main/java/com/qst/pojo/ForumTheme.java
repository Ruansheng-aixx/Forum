package com.qst.pojo;

/**
 * @ClassName:ForumTheme
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/9 0:01
 **/
public class ForumTheme {
    private Integer id;
    private String themeName;

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

    @Override
    public String toString() {
        return "ForumTheme{" +
                "id=" + id +
                ", themeName='" + themeName + '\'' +
                '}';
    }
}
