package com.kgc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kgc.dao.ClothesMapper;
import com.kgc.entity.Clothes;
import com.kgc.entity.ClothesExample;
import com.kgc.service.ClothesService;
import com.kgc.utils.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 服装业务层实现类
 */
@Service
public class ClothesServiceImpl implements ClothesService {
    //注入dao层实例对象
    @Autowired
    private ClothesMapper clothesMapper;
    //分页查询所有服装
    public PageBean<Clothes> findAllClothes(Integer page, Integer pageSize, Clothes clothes) {
        PageHelper.startPage(page,pageSize);
        List<Clothes> clothes1;
        ClothesExample clothesExample = new ClothesExample();
        ClothesExample.Criteria criteria = clothesExample.createCriteria();
        if(clothes.getTypename()!=null&& clothes.getTypename().length()>0){
            criteria.andTypenameLike("%"+clothes.getTypename()+"%");
        }

        if(clothes.getPrice()!=null && clothes.getPrice()!=0){
            criteria.andPriceEqualTo(clothes.getPrice());
        }
        clothes1= clothesMapper.selectByExample(clothesExample);
        PageInfo<Clothes> pageInfo = new PageInfo<Clothes>(clothes1);
        //填充自定义工具类
        PageBean pageBean = new PageBean();
        pageBean.setList(pageInfo.getList());
        pageBean.setPageNum(pageInfo.getPageNum());
        pageBean.setPrePage(pageInfo.getPrePage());
        pageBean.setNexPage(pageInfo.getNextPage());
        pageBean.setPages(pageInfo.getPages());
        pageBean.setTotal(pageInfo.getTotal());
        return pageBean;
    }
    //查询单件服装根据id
    public Clothes findClothesById(Integer id) {
        return clothesMapper.selectByPrimaryKey(id);
    }
    //根据服装名字查询
    public Clothes findClothesByName(String name) {
        ClothesExample clothesExample = new ClothesExample();
        ClothesExample.Criteria criteria = clothesExample.createCriteria();
        criteria.andTypenameEqualTo(name);
        List<Clothes> clothes = clothesMapper.selectByExample(clothesExample);
        return clothes.get(0);
    }

    //增加单件服装
    public void saveClothes(Clothes clothes) {
        clothesMapper.insertSelective(clothes);
    }
    //修改服装
    public void updClothes(Clothes clothes) {
        clothesMapper.updateByPrimaryKeySelective(clothes);
    }
    //根据id删除单件服装
    public void delClothes(Integer id) {
        clothesMapper.deleteByPrimaryKey(id);
    }
    //批量删除服装
    public void delClothesByIds(Integer[] ids) {
        if(ids.length>0){
            for(Integer i:ids){
                clothesMapper.deleteByPrimaryKey(i);
            }
        }
    }
}
