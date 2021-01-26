<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/1/22
  Time: 15:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" rel="stylesheet" href="/layui/css/layui.css"/>
    <script type="text/javascript" src="/layui/layui.js"></script>
    <script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
        layui.use('element',function () {
              var element=layui.element;

            //1.响应menu的click事件
            $(".menu").click(function () {
                  var title=$(this).text();
                  var id=$(this).attr("id");
                  var url=$(this).attr("url");
                if($("li[lay-id="+id+"]").length==0) {//这个选没有增加过，就先增加
                    element.tabAdd('tab1', {
                        title: title
                        , content: '<iframe width="100%" height="100%" frameborder="0" scrolling="no" src='+url+'></iframe>'
                        , id: id//生成tab时，这个id就是lay-id的值
                    });
                }
                element.tabChange('tab1', id);//根据id来切换tab
            });
        })
    </script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">后台管理</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">商品管理</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    贤心
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                    <dd><a href="">关于系统</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退出</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">

                <li class="layui-nav-item">
                    <a href="javascript:;">后台管理</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="menu" id="101" url="showClothes.jsp">服装管理</a></dd>
                        <dd><a href="javascript:;" class="menu" id="102" url="tree.jsp">部门管理</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a href="javascript:;">云市场</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;"  class="menu">阿里云</a></dd>
                        <dd><a href="javascript:;"  class="menu">华为云</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="">发布商品</a></li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <div class="layui-tab layui-tab-card" lay-filter="tab1" lay-allowClose="true">
            <ul class="layui-tab-title">
                <li class="layui-this">项目后台</li>

            </ul>
            <div class="layui-tab-content" style="height: 100%;">
                <div class="layui-tab-item layui-show">欢迎使用</div>

            </div>
        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © kgc.com - 底部固定区域
    </div>
</div>

</body>
</html>
