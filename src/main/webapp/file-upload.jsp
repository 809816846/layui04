<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/10/31
  Time: 21:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link type="text/css" rel="stylesheet" href="/layui/css/layui.css"/>
    <script type="text/javascript" src="/layui/layui.js"></script>
    <script type="text/javascript" src="/js/jquery-3.2.1.min.js"></script>
    <style type="text/css">
        .image-container{
            float: left;
        }
    </style>
</head>
<body>
<button type="button" class="layui-btn" id="drapUpload">
    <i class="layui-icon">&#xe67c;</i>上传图片
</button>

<button type="button" class="layui-btn" id="doUpload">上传</button>
<div id="div_prev">

</div>
<script type="text/javascript">
    var resultData = new Array();
    layui.use(['upload'], function () {
        var upload = layui.upload;
        var layer = layui.layer;

        var url = '/upload';
        var uploadInst = upload.render({
            elem: '#drapUpload',
            url: url,
            accept: 'file',
            size: 1000 * 1024, //限制文件大小，单位 KB
            multiple: true, //允许多文件上传
            auto: false, //选完文件后不要自动上传
            bindAction: '#doUpload', //指定一个按钮触发上传
            choose: function (obj) {
                var files = this.files = obj.pushFile();//将每次选择的文件追加到文件队列
                //图像预览，如果是多文件，会逐个添加。(不支持ie8/9)
                obj.preview(function(index, file, result){
                    if (files.size > 0 && $('#div_prev').find('img').length === 0) {
                        $('#div_prev').empty();
                    }
                    // 添加图片 ImgPreview-预览的dom元素的id
                    $('#div_prev').append('<div class="image-container"  id="container'+index+'">'
                        + '<div style="dispaly:inline-block" class="delete-css">'
                        + '<button id="upload_img_'+index+'" class="layui-btn layui-btn-danger layui-btn-xs">删除</button></div>'
                        + '<img id="showImg'+index+'" style="width: 120px;height: 68px; margin:0px;cursor:pointer;"src="' + result + '" alt="' + file.name + '"></div>');
                    //删除某图片
                    $("#upload_img_" + index).bind('click', function () {
                        delete files[index];
                        $("#container"+index).remove();
                    });

                    //某图片放大预览
                    $("#showImg"+index).bind('click',function () {
                        var width = $("#showImg"+index).width();
                        var height = $("#showImg"+index).height();
                        var scaleWH = width/height;
                        var bigH = 600;
                        var bigW = scaleWH*bigH;
                        if(bigW>900){
                            bigW = 900;
                            bigH = bigW/scaleWH;
                        }
                        // 放大预览图片
                        layer.open({
                            type: 1,
                            title: false,
                            closeBtn: 1,
                            shadeClose: true,
                            area: [600 + 'px', 300 + 'px'], //宽高
                            content: "<img width='"+bigW+"' height='"+bigH+"' src=" + result + " />"
                        });
                    });
                });

            },
            before: function (obj) { //obj参数包含的信息，跟 choose回调完全一致，可参见上文。

            },
            done: function (res, index, upload) {
                console.log(res);
                console.log(index);
                console.log(upload);
                layer.closeAll('loading');
                var data = res.data;
                if (res.code == 0) {
                    for (var i = 0; i < data.length; i++) {
                        resultData[resultData.length + i] = data[i];
                    }
                }
                /* $("#upload_img_" + index).trigger("click");
                 $("#container"+index).remove();*/
            },
            allDone: function(obj){ //当文件全部被提交后，才触发
                layer.msg('上传成功');
                console.info(resultData.join(","))
                //setAttachedTable(resultData);
               // resultData = [];//清空

                /* console.log(obj.total); //得到总文件数
                 console.log(obj.successful); //请求成功的文件数
                 console.log(obj.aborted); //请求失败的文件数*/
            }
            ,error: function () {
                layer.msg('上传失败');
                layer.closeAll('loading');
            }

        });

    });
</script>
</body>
</html>
