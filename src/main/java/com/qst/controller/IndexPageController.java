package com.qst.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @ClassName:IndexPageController
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/12 0:24
 **/
@Controller
@RequestMapping("indexPage")
public class IndexPageController {

    @RequestMapping("toIndexMain")
    public String toIndexMain(){

        return "indexMain";

    }

}
