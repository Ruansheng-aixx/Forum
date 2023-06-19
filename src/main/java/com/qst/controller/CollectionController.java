package com.qst.controller;

import com.qst.pojo.Result;
import com.qst.service.CollectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @ClassName:CollectionController
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/12 12:46
 **/
@Controller
@RequestMapping("collection")
public class CollectionController {

    @Autowired
    private CollectionService collectionService;

    @RequestMapping("addCollection")
    @ResponseBody
    public Result addCollection(Integer userId,Integer postId){

        return collectionService.addCollection(userId,postId);

    }

    @RequestMapping("toMyCollection")
    public String toMyCollection(){

        return "myCollection";

    }

    @RequestMapping("deleteCollection")
    @ResponseBody
    public Result deleteCollection(Integer userId,Integer postId){

        return collectionService.deleteCollection(userId,postId);

    }
}
