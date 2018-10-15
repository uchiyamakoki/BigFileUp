<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>无标题文档</title>
<!--字体图标样式 绝对地址WEB-INF为根目录目测-->
<link href="${pageContext.request.contextPath}/css/javaex/pc/css/icomoon.css" rel="stylesheet" />
<!--动画样式-->
<link href="${pageContext.request.contextPath}/css/javaex/pc/css/animate.css" rel="stylesheet" />
<!--核心样式-->
<link href="${pageContext.request.contextPath}/css/javaex/pc/css/style.css" rel="stylesheet" />
<!--jquery，当前版本不可更改jquery版本-->
<script src="${pageContext.request.contextPath}/css/javaex/pc/lib/jquery-1.7.2.min.js"></script>
<!--全局动态修改-->
<script src="${pageContext.request.contextPath}/css/javaex/pc/js/common.js"></script>
<!--核心组件-->
<script src="${pageContext.request.contextPath}/css/javaex/pc/js/javaex.min.js"></script>
<!--表单验证-->
<script src="${pageContext.request.contextPath}/css/javaex/pc/js/javaex-formVerify.js"></script>
<style>
	.login-bg{width: 100%;min-height: 600px;height: calc(100vh - 100px - 100px);background-image: url("http://upload.javaex.cn/login-bg.jpg");background-size: auto 100%;background-position: 45% center;background-repeat: no-repeat;position: relative;}
	.login-form{position: absolute;width: 288px;right:260px;background: #fff;padding: 20px 38px 0;top:25%;}
	.login-title{font-size: 20px;text-align: center;margin-bottom: 25px;}
	.login-item{display: flex;margin-bottom: 14px;}
	.login-link{margin-bottom: 14px;}
	.login-link label, .login-link a{color: #9B9B9C;}
	.login-link a{font-size: 14px;}
	.login-text{min-height: 40px;width: 100%;color: #B3B3B3;font-size: 14px;border: 1px solid #EEEFF0;border-radius: 3px;font-family: Helvetica, "microsoft yahei", sans-serif;padding-left: 16px;outline: none;}
	.button.login{background-color: #2D9C8B;color: white;width: 100%;border-radius: 3px;font-size: 14px;height: 40px;line-height: 40px;}
	.login-link .line{display: inline-block;width: 1px;height: 12px;background-color: #EEEEEE;margin: 0 6px;}
</style>
</head>

<body>
	<!--顶部logo-->
	<div style="width: 100%; height: 100px; display: flex;">
		<div style="width: 1200px; margin: 20px auto;">
			<a href="#"> <img src="${pageContext.request.contextPath}/css/javaex/pc/images/logo.png" />
			</a>
		</div>
	</div>
	<!--中间主体信息-->
	<div class="login-bg">
		<!--表单-->
		<form id="login">
			<div class="login-form">
				<!--标题-->
				<div class="login-title">登录后台</div>
				<!--用户名-->
				<div class="login-item">
					<input type="text" class="login-text" id="login_name"
						name="username" data-type="必填" placeholder="用户名" />
				</div>
				<!--密码-->
				<div class="login-item">
					<input type="password" class="login-text" name="password"
						data-type="必填" placeholder="请输入密码" />
				</div>
				<!--登录按钮-->
				<div class="login-item">
					<input type="button" id="submit" class="button login" value="登录" />
				</div>
			</div>
		</form>
	</div>
</body>
<script>
	$("#submit").click(function(){
		//表单验证函数
		if(javaexVerify()){
			$.ajax({
				url : "/user/login.json",
				type : "POST",
				dataType : "json",
				data : $("#login").serialize(),
				success : function(rtn) {
				    //alert(rtn.status);
					//console.log(rtn.data.key);
					if(rtn.status=="0"){//=和==注意一下
						//跳转到首页
						window.location.href = "/uploadFile/index.do";
						//alert(2222)
					}else{
                        window.location.href = "/user/index.do";
						//alert(1111);
					}
				}
			});
		}
	});

</script>
</html>