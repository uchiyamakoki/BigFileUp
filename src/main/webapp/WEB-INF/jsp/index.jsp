<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <link href="https://cdn.staticfile.org/webuploader/0.1.5/webuploader.css"
          rel="stylesheet" type="text/css" />
    <script type="text/javascript"
            src="http://cdn.staticfile.org/jquery/1.10.2/jquery.js"></script>
    <script type="text/javascript"
            src="http://cdn.staticfile.org/webuploader/0.1.5/webuploader.min.js"></script>
    <link href="${pageContext.request.contextPath}/css/javaex/pc/css/icomoon.css" rel="stylesheet" />
    <!--动画样式-->
    <link href="${pageContext.request.contextPath}/css/javaex/pc/css/animate.css" rel="stylesheet" />
    <!--核心样式-->
    <link href="${pageContext.request.contextPath}/css/javaex/pc/css/style.css" rel="stylesheet" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<div id="header">
    <div>
        <a href="#"> <img class="logo-img"
                          src="${pageContext.request.contextPath}/css/javaex/pc/images/logo.png">
        </a>
    </div>
    <!--右侧功能-->
    <ul class="pull-right header-right">
        <li>
            <a class="pull-left user-photo" href="#"><img src="${pageContext.request.contextPath}/css/javaex/pc/images/user.jpg" alt=""></a>
            <p class="pull-left margin-left-10">
                欢迎您，<span>${user.username }</span>
            </p> <label class="margin-left-10 margin-right-10">|</label> <a
                href="/user/logout.do">退出</a></li>
        <li>
        </li>
        <li><a href="${pageContext.request.contextPath}/">首页</a></li>
    </ul>
</div>

<div id="uploader" class="wu-example" >
    <!--用来存放文件信息-->
    <div id="thelist" class="uploader-list"></div>
    <div class="btns" style="text-align:center">
        <div id="picker" style="margin-left: 325px">选择文件</div>
        <button id="ctlBtn" class="button wathet" style="margin-top: 5px">开始上传</button>
    </div>
</div>
<div class="progress" style="margin-top: 5px">
    <div class="progress-bar progress-bar-warning progress-bar-striped" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 0%" id="percentage_a">
        <span id="percentage">0%</span>
    </div>
</div>
</body>
<script type="text/javascript">
    var GUID = WebUploader.Base.guid();//一个GUID
    var uploader = WebUploader.create({
        // swf文件路径
        swf: 'http://cdn.staticfile.org/webuploader/0.1.5/Uploader.swf',
        // 文件接收服务端。
        server: '/uploadFile/bigFile.do',
        formData:{
            guid : GUID
        },
        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#picker',
        chunked : true, // 分片处理
        chunkSize : 35 * 1024 * 1024, // 每片5M,
        chunkRetry : false,// 如果失败，则不重试
        threads : 1,// 上传并发数。允许同时最大上传进程数。
        // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
        resize: false
    });
    $("#ctlBtn").click(function () {
        $.ajax({
            url:'/user/check.do',
            type:"GET",
            dataType:"json",
            success:function (data) {
                //alert(data);
                if(data.code == "200"){
                    alert('开始上传!');
                    uploader.upload();
                }else if (data.code == "400"){
                    alert('没有权限!');
                }else if (data.code=="600"){
                   // alert("没有权限!");
                }
            }
        });

    });
    //当文件上传成功时触发。
    uploader.on( "uploadSuccess", function( file ) {
        $.post('/uploadFile/mergeFile.do', { guid: GUID, fileName: file.name }, function (data) {
            var result = data.results;
            //alert("11111111111111");
            //alert(data);
            //alert(data.code);
            //alert(data.code);
            if(data.code == "200"){
                alert('上传成功!');
            }else if (data.code == "400"){
                alert('上传失败!');
            }else if (data.code=="600"){
                alert("没有权限!");
            }
        },'json');
    });
    uploader.on('uploadError', function (file) {
       alert("没有权限");
    });
    uploader.on('uploadProgress', function (file, percentage) {
        $("#percentage_a").css("width",parseInt(percentage * 100)+"%");
        $("#percentage").html(parseInt(percentage * 100) +"%");

    });


</script>
</html>
