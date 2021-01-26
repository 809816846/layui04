package com.kgc.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

/**
 * 上传控制器
 */
@Controller
public class UpLoadController {
    //自动注入上下文对象
    @Autowired
    private ServletContext servletContext;

    @RequestMapping("upload")
    @ResponseBody
    public Map uploadFile(MultipartFile file) throws IOException {
        String path = servletContext.getRealPath("upload");
        File dir = new File(path);
        if(!dir.exists())dir.mkdir();
        String fileName=getFileName(file.getOriginalFilename());
        String str=path+"/"+fileName;//上传文件的原始名称
        file.transferTo(new File(str));
        System.out.println(str);


        Map map=new HashMap();
        map.put("msg","文件上传成功!");
        map.put("path",file.getOriginalFilename());
        return map;
    }


    //随机生一个新的文件名+老的文件名的缀
    private String getFileName(String fileName){
        String extName=fileName.substring(fileName.lastIndexOf("."));
        return UUID.randomUUID()+""+new Random().nextInt(1000)+extName;
    }
}
