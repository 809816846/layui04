<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/1/22
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>文件上传</title>
    <link type="text/css" rel="stylesheet" href="/layui/css/layui.css" />
    <script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/layui/layui.js"></script>
    <script type="text/javascript">
        layui.use("upload",function () {
            var upload = layui.upload;
            upload.render({
                elem:"#upload1",
                url:"/upload",
                done:function (resp) {
                    var img1=$("<img/>").prop("src","upload/"+resp.path)
                    $("#div1").append(img1);
                },
                error:function () {
                    
                }
            });
        });
    </script>
</head>
<body>
<button type="button" class="layui-btn" id="upload1">
    <i class="layui-icon">&#xe67c;</i>上传图片
</button>
<div id="div1"></div>
</body>
</html>
