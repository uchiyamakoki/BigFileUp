<html>
<head>
    <link href="https://cdn.staticfile.org/webuploader/0.1.5/webuploader.css"
          rel="stylesheet" type="text/css" />
    <script type="text/javascript"
            src="http://cdn.staticfile.org/jquery/1.10.2/jquery.js"></script>
    <script type="text/javascript"
            src="http://cdn.staticfile.org/webuploader/0.1.5/webuploader.min.js"></script>
</head>
<body>
<div id="uploader" class="wu-example">
    <!--用来存放文件信息-->
    <div id="thelist" class="uploader-list"></div>
    <div class="btns">
        <div id="picker">选择文件</div>
        <button id="ctlBtn" class="btn btn-default">开始上传</button>
    </div>
</div>
</body>
<script type="text/javascript">
    var GUID = WebUploader.Base.guid();//一个GUID
    var uploader = WebUploader.create({
        // swf文件路径
        swf: 'http://cdn.staticfile.org/webuploader/0.1.5/Uploader.swf',
        // 文件接收服务端。
        server: './uploadFile/bigFile.do',
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
        uploader.upload();
    });
    //当文件上传成功时触发。
    uploader.on( "uploadSuccess", function( file ) {
        $.post('./uploadFile/mergeFile.do', { guid: GUID, fileName: file.name }, function (data) {
            var result = data.results;
            if(result.code == 200){
                alert('上传成功!');
            }
        });
    });
</script>
</html>