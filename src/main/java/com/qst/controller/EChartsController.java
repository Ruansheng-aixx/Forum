package com.qst.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @ClassName:EChartsController
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/12 17:15
 **/
@Controller
@RequestMapping("eCharts")
public class EChartsController {

    @RequestMapping("toECharts")
    public String toECharts(){

        return "eCharts";

    }

}
