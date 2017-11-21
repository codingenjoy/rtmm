<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>系统登录</title>
<meta name="keywords" content="${defaultKeyWords }" />
<meta name="description" content="${defaultDescription }" />
<meta name="author" content="${defaultKeyWords }" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/common/css/login.css"/>
</head>
<body>
	<div class="bg">
		<div class="login">
			<div class="lf lg_div"></div>
			<div class="rt lg_div">
				<form id="login_from" action="${ctx}/changeJobFun" method="post" onsubmit="return false;">
					<div class="p">
					</div>
					<div id="msg" class="msg"></div>
					<div class="name in_div">
						<input id="code" type="text" placeholder="E-员工号" />
					</div>
					<div class="pw in_div">
	                    <input id="password" type="password" placeholder="密码"/>
	                </div>
					<div class="in_div2">
						<input type="button" id="loginBtn2" value="登录 / LOGIN" class="btn"  onclick="javascript:login();return false;"/>
					</div>
				</form>
			</div>
			
		</div>
	</div>
	<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
	<script src="${ctx}/shared/js/jquery/jquery.md5.js" type="text/javascript"></script>
	<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
	<%@ include file="/page/commons/loadding.jsp"%>
	<script type="text/javascript">
		function login(/*offset, optional*/deltaOnClick,/*do forcelogin flag, optional*/forceLogin) {
			var clickLeft = deltaOnClick || $("#loginBtn2").offset().left;
			var code = $("#code").val();
			var password = $("#password").val();
			if (code == "" && password == "") {
				$('#msg').html("请输入员工号、密码");
				$("#code").focus();
				$("#password").focus();
				return;
			}
			if (code == "") {
				$("#msg").html("请输入员工号");
				$("#code").focus();
				return;
			}
			if (password == "") {
				$('#msg').html("请输入密码");
				$("#password").focus();
				return;
			} 
			$('#msg').html("");
			$.ajax({
				type : "post",
				url : ctx + "/loginCheck",
				dataType : "json",
				beforeSend:function(){
					grid_layer_open_login(clickLeft);
				},
				data :  {
					code : code,
					password : $.md5(password),
					forceLogin : forceLogin
				},
				complete:function(xhr,textStatus){
					if(xhr.status==302 || xhr.status==404 || xhr.status==503){
						window.location.href="${ctx}/login";
					}
				},
				success : function(data) {
					if (data.status=='success') {
						window.location.href="${ctx}/changeJobFun";
						return true;
					}else {
						grid_layer_close();
						if(data.error){
							var errText = data.message+","+data.message_en;
							if (data.error.code =="004")
								errText +=  " " + data.error.errorIp; 
							$('#msg').html(errText);
							if (data.error.code =="004")
								$("#forceloginWindow").css("display","block");
						}else{
							$('#msg').html(data.message+","+data.message_en);	
						}
						return false;
					} 
				},
				error : function(xhr,textStatus) {
					grid_layer_close();
					return false;
				}
			});
		}
		
		//支持回车事件
		$(function() {			
			/* 屏蔽backspace、F5,F4为刷新 */
			document.onkeydown = function(e) {
				/* var ev = document.all ? window.event : e;
				ev.cancelBubble = true; */
				var event = e || window.event;
				var e = event || arguments.callee.caller.arguments[0];
				var d = e.srcElement || e.target;
				if (e.keyCode == 13) {
					e.keyCode=-1;
					return false;
				}
				if (e.keyCode && e.keyCode == 115) {
					e.keyCode=0;
					e.returnValue=false;
					$('#forwardForm').submit();
					return false;
				}
				if (e.keyCode && e.keyCode == 116) {
					e.keyCode=0;
					return false;
				}
				if (e && e.keyCode == 8) {
					if(d.tagName.toUpperCase() == 'INPUT' && d.readOnly == true){
						return false;
					}else if(d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA'){
						return true;	
					}else{
						return false;
					}
				}
			};

			$('#code,#password').each(function(){
				$(this).unbind('keydown').bind('keydown',function(e){
					var event = e || window.event;
					var e = event || arguments.callee.caller.arguments[0];
					//ev.cancelBubble = true;
					if (e.keyCode == 13) {
						login($('#loginBtn2').offset().left);
						return true;
					}
				});
			});
			setWindowPosition();
		});
		/*set the relative position of panel.*/
		function setWindowPosition() {
            var w = 380;/*弹出框宽度*/
            var h = 120;/*弹出框高度*/
            var pagex = $(".bg").offset().left;/*网页有效区位置*/
            var pageW = 1240;
            var pageH = 700;
            $("#forceloginWindow").css({ "left": pagex + 'px' });/*遮罩的位置设定*/
            $("#forceloginWindow").children().first().css({"left":pageW/2-w/2+"px","top":pageH/2-h/2+"px"});
        }
		function doForceLogin(){			
			$("#forceloginWindow").css("display","none");
			login(null, true);
		}
		function cancelForceLogin(){
			$("#forceloginWindow").css("display","none");	
		}
	</script>
 <div class="login_bg" id="forceloginWindow" style="display : none">
	<div class="Panel">
		<div class="alert_top">
			<span class="alert_title">提示</span>
			<div class="PanelClose"></div>
		</div>
		<div class="Table_Panel">
			<div class="alert_body">
				<div class="alert_b1 warn "></div>
				<div class="alert_text" >该账户已在其它电脑登录，是否需要强制下线?</div>
			</div>
		</div>
		<div class="Panel_footer">
			<div class="PanelBtn">
				<div class="PanelBtn1" onclick="doForceLogin()">确定</div>
				<div class="cancel" onclick="cancelForceLogin()">取消</div>
			</div>
		</div>
	</div>
</div> 
</body>
</html>