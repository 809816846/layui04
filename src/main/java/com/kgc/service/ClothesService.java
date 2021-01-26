package com.kgc.service;

import com.kgc.entity.Clothes;
import com.kgc.utils.PageBean;


/**
 * 服装业务层接口
 */
public interface ClothesService {
    //分页查询所有服装
    PageBean<Clothes> findAllClothes(Integer page, Integer pageSize, Clothes clothes);

    //查询单件服装根据id
    Clothes findClothesById(Integer id);

    //根据服装名字查询
    Clothes findClothesByName(String name);

    //增加单件服装
    void saveClothes(Clothes clothes);

    //修改服装
    void updClothes(Clothes clothes);

    //根据id删除单件服装
    void delClothes(Integer id);

    //批量删除服装
    void delClothesByIds(Integer ids[]);

}
