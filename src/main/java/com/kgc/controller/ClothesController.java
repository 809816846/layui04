package com.kgc.controller;

import com.kgc.entity.Clothes;
import com.kgc.service.ClothesService;
import com.kgc.utils.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 服装类控制器
 */
@Controller
public class ClothesController {
    //注入dao层业务层实现类
    @Autowired
    private ClothesService clothesService;

    //分页显示所有服装
    @RequestMapping(value = "clothes")
    @ResponseBody
    public Map showClothes(
                           Clothes clothes,
                           @RequestParam(value = "page") Integer page,
                           @RequestParam(value = "limit") Integer limit
                              ){

        Map map = new HashMap();
        PageBean<Clothes> pageBean = clothesService.findAllClothes(page, limit, clothes);
        map.put("code",0);
        map.put("msg","查询成功");
        map.put("count",pageBean.getTotal());
        map.put("data",pageBean.getList());
        return map;
    }
   /* //跳转界面
    @RequestMapping("{page}")
    public String toShow(@PathVariable("page") String  page){
        return page;
    }*/


    /*//去到添加页面
    @RequestMapping("toSaveClothes")
    public String toSaveClothes(){
        return "saveClothes";
    }*/

    //商品增加
    @RequestMapping(value = "clothes/save",method = RequestMethod.POST,produces ={"text/html;charset=UTF-8;","application/json;"})
    @ResponseBody
    public String  saveClothes(Clothes clothes){
        clothesService.saveClothes(clothes);
        return "add clothes ok";
    }

   /* //去到修改页面
    @RequestMapping("toUpdClothes")
    public String toUpdClothes(Integer id,Model model){
        Clothes clothes = clothesService.findClothesById(id);
        model.addAttribute("clothes",clothes);
        return "updClothes";
    }

    //修改页面
    @RequestMapping(value = "clothes",method = RequestMethod.PUT)
    public String updClothes(Clothes clothes){
        clothesService.updClothes(clothes);
        return "redirect:/clothes";
    }*/

    //删除商品
    @RequestMapping("clothes/del/{id}")
    @ResponseBody
    public Map delClothes(@PathVariable("id")Integer id){
        Map map = new HashMap();
        clothesService.delClothes(id);
        map.put("msg","删除成功!");
        return map;
    }

    //批量删除商品
    @RequestMapping("clothes/dels")
    @ResponseBody
    public Map delClothesByIds(Integer[] ids){
        Map map = new HashMap();
        clothesService.delClothesByIds(ids);
        map.put("msg","删除成功!");
        return map;
    }

    //根据id查询商品
    @RequestMapping("clothes/find/{id}")
    @ResponseBody
    public Map findOneClothes(@PathVariable("id") Integer id){
        Map map = new HashMap();
        Clothes clothes = clothesService.findClothesById(id);
        map.put("msg",clothes);
        return map;
    }

    //修改页面
    @RequestMapping(value = "clothes/upd")
    @ResponseBody
    public Map updClothes(Clothes clothes){
        Map map = new HashMap();
        clothesService.updClothes(clothes);
        map.put("msg","修改成功！！");
        return map;
    }


}
