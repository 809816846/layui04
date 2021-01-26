<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/1/20
  Time: 8:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>服装显示</title>
    <meta http-equiv="Content-Type" content="text/jsp; charset=utf-8" />
    <link type="text/css" rel="stylesheet" href="/layui/css/layui.css" />
    <script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/layui/layui.js"></script>
    <script type="application/javascript">
        layui.use(['layer','table','util','form'],function () {
            var layer = layui.layer;
            var table = layui.table;
            var util = layui.util;
            var form=layui.form;
            //显示表格数据
           var tabins = table.render({
                elem:"#showClothes",
               /* height:300,*/
                url:"/clothes",
                page:true,
                limit:3,
                limits:[3,6,9,12],
                cols:[[
                    {checkbox: true},
                    {field:"id",title:"商品编号"},
                    {field:"typename",title:"商品名称"},
                    {field:"discription",title:"商品描述"},
                    {field:"ontime",title:"上架时间",templet: function(d) {return util.toDateString(d.ontime);},edit: true
                    },
                    {field:"price",title:"商品价格"},
                    {field:"操作",toolbar:"#toolbar1"}
                ]]
            });

            //增加服装点击事件
            $("#saveClothesBtn").click(function () {
                layer.open({
                    type:1,
                    title:"增加服饰",
                    area:["500px","400px"],
                    content:$("#saveClothesDiv")
                });
            });

            //完成表单的提交
            form.on("submit(addClothesFilter)",function (data) {
                $.ajax({
                    type:"post",
                    url:"/clothes/save",
                    data:$("#addClothesForm").serialize(),
                    success:function (resp) {
                        $("#addClothesForm")[0].reset();
                        layer.closeAll();
                        tabins.reload();
                        layer.msg(resp);
                    },
                    error:function () {
                        console.log("错误")
                    }
                });
                return false;
            });

            //表格工具栏事件
            table.on("tool(showClothesFilter)",function (data) {
                if(data.event=="del"){
                    //删除
                    var clothesId = data.data.id;
                    $.get("/clothes/del/"+clothesId,{},function (resp) {
                        tabins.reload();
                        layer.msg(resp.msg);
                    })
                }else{
                    //修改
                    var clothesId = data.data.id;
                    $.get("/clothes/find/"+clothesId,{},function (resp) {
                        form.val("updClothesFromFilter",{
                            "id":resp.msg.id,
                            "typename":resp.msg.typename,
                            "discription":resp.msg.discription,
                            "price":resp.msg.price,
                            "ontime":layui.util.toDateString(resp.msg.ontime, 'yyyy-MM-dd HH:mm:ss')

                        })
                    })

                    layer.open({
                        type:1,
                        title:"修改服饰",
                        area:["500px","400px"],
                        content:$("#updClothesDiv")
                    });
                }
            });

            //删除多行
            $("#delClothesBtn").click(function () {
                var ids =[];
                var checkStatus = table.checkStatus('showClothes');
                $.each(checkStatus.data,function (index,item) {
                    ids.push(item.id);
                });
                if(ids.length>0){
                    $.get("/clothes/dels?ids="+ids,{},function (resp) {
                        //2.将多个用户编号使用ajax发后台，后台来删除
                        tabins.reload();
                        layer.msg(resp.msg);
                        //3.将这个表格reload()
                    });
                }else{
                    layer.msg("请先选择要删除的行!")
                }
            });

            //监听修改的提交按钮
            form.on("submit(updClothesFilter)",function (data) {
                //提交数据
                $.ajax({
                    type:"post",
                    url:"/clothes/upd",
                    data:$("#updClothesForm").serialize(),
                    success:function (resp) {
                        tabins.reload();
                        layer.closeAll();
                        $("#updClothesForm")[0].reset();
                        layer.msg(resp.msg);
                    }
                })
            })

            //条件查询
            form.on("submit(queryClothesFilter)",function (data) {
                console.log(data.field.typename+data.field.price);
                tabins.reload({
                    where:{
                        typename:data.field.typename,
                        price:data.field.price
                    },
                    method:"post",
                    page:{
                        curr:1
                    }
                });
                return false;
            });
        })
    </script>

    <!-- table中的工具条  修改与删除  begin-->
    <script type="text/html" id="toolbar1">
        <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <!-- table中的工具条  修改与删除  end-->
</head>
<body>
<div style="text-align: center;">
    <h1>淘宝服装展示</h1>
    <div class="layui-inline">
        <!--查询条件表单begin -->
        <form class="layui-form" id="queryClothesForm">
            <div class="layui-form-item">
                <label class="layui-form-label">服装名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="typename" placeholder="请输入服装名称" autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label">价格</label>
                <div class="layui-input-inline">
                    <input type="text" name="price" placeholder="请输入价格" autocomplete="off" class="layui-input">
                </div>

                <div class="layui-input-inline">
                    <button class="layui-btn" lay-submit lay-filter="queryClothesFilter">立即查询</button>

                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>

        <button class="layui-btn layui-btn-radius layui-btn-warm" id="saveClothesBtn">增加服装</button>
        <button class="layui-btn layui-btn-radius  layui-btn-danger" id="delClothesBtn">删除服装</button>
        <table id="showClothes"  lay-filter="showClothesFilter" width="800px"></table>

    </div>


    <!--增加服装表单  开始 -->
    <div class="layui-container" style="display: none;width: 500px" id="saveClothesDiv">
        <h2>淘宝服装上架</h2>
        <form class="layui-form" id="addClothesForm"> <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
            <div class="layui-form-item">
                <label class="layui-form-label">品牌名称</label>
                <div class="layui-input-block">
                    <input type="text" name="typename" placeholder="请输入品牌名称" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">服装描述</label>
                <div class="layui-input-block">
                    <input type="text" name="discription" placeholder="请输入服装描述" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">价格</label>
                <div class="layui-input-block">
                    <input type="text" name="price" placeholder="请输入价格" autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">上架时间</label>
                <div class="layui-input-block">
                    <input type="date" name="ontime" placeholder="请输入上架时间" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="addClothesFilter">立即提交</button>

                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <!--增加用户表单 结束 -->


    <!--修改服装表单  开始 -->
    <div class="layui-container" style="display: none;width: 500px" id="updClothesDiv">
        <h2>淘宝服装修改</h2>
        <form class="layui-form" id="updClothesForm" lay-filter="updClothesFromFilter"> <!-- 提示：如果你不想用form，你可以换成div等任何一个普通元素 -->
            <input type="hidden" name="id">
            <div class="layui-form-item">
                <label class="layui-form-label">品牌名称</label>
                <div class="layui-input-block">
                    <input type="text" name="typename"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">服装描述</label>
                <div class="layui-input-block">
                    <input type="text" name="discription"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">价格</label>
                <div class="layui-input-block">
                    <input type="text" name="price"  autocomplete="off" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">上架时间</label>
                <div class="layui-input-block">
                    <input type="text" name="ontime"  autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="updClothesFilter">立即提交</button>

                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
    <!--修改用户表单 结束 -->
</div>


</body>
</html>
