package com.qst.mapper;

import org.apache.ibatis.annotations.Param;

/**
 * @ClassName:CollectionMapper
 * @Author:阮昇
 * @Description:
 * @Datetime: 2023/6/12 12:48
 **/
public interface CollectionMapper {
    int addCollection(@Param("userId") Integer userId, @Param("postId") Integer postId);

    Integer[] getCollectionByUserId(Integer userId);

    int deleteCollection(@Param("userId") Integer userId, @Param("postId") Integer postId);
}
