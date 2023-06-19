package com.qst.service;

import com.qst.mapper.CollectionMapper;
import com.qst.pojo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @ClassName:collectionService
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/12 12:48
 **/
@Service
public class CollectionService {
    @Autowired
    private CollectionMapper collectionMapper;
    public Result addCollection(Integer userId, Integer postId) {

        Integer[] postIds = collectionMapper.getCollectionByUserId(userId);

        for(Integer id:postIds){

            if(postId == id){

                return new Result(100,"已收藏");

            }

        }

        int row = collectionMapper.addCollection(userId,postId);

        if(row == 1){

            return new Result(200,"收藏成功");

        }else {

            return new Result(100,"收藏失败");

        }

    }

    public Integer[] getPostIdsByUserId(Integer id) {

        return collectionMapper.getCollectionByUserId(id);

    }

    public Result deleteCollection(Integer userId, Integer postId) {

        int row = collectionMapper.deleteCollection(userId,postId);

        if(row == 1){

            return new Result(200,"取消收藏成功");

        }else {

            return new Result(200,"取消收藏失败");

        }

    }
}
