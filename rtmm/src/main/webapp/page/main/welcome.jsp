<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.auchan.rtmm.common.session.SessionHelper" language="java"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${defaultTitle }</title>
<meta name="keywords" content="${defaultKeyWords }" />
<meta name="description" content="${defaultDescription }" />
<meta name="author" content="${defaultKeyWords }" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/Highcharts-4.0.3/js/highcharts.js"></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/common/css/help.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/rtmm.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/common.js?t=1" type="text/javascript"></script>
<%@ include file="/page/commons/easyui.jsp"%>
<%@ include file="/page/commons/datepick.jsp"%>
<%@ include file="/page/commons/loadding.jsp"%>
<%@ include file="/page/commons/jquery-alerts.jsp"%>
<%@ include file="/page/commons/paginator.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/welcome.css" rel="Stylesheet" />
<%@ include file="/page/commons/zWindow.jsp"%>
<script type="text/javascript">
/* 	 function stopError() {
		return true;
	}
	window.onerror = stopError; */
	$('input[type=text]').live("keypress", function(event) {
		if (event.keyCode == 13) {
			$(this).blur();
			return false;
		}
	});
	var showConsole = false;
	/* 屏蔽backspace、F5,F4为刷新 */
	document.onkeydown = function(e) {
		/* var ev = document.all ? window.event : e;
		ev.cancelBubble = true; */
		var e = e || window.event || arguments.callee.caller.arguments[0];
		var d = e.srcElement || e.target;
		if (e.keyCode && e.keyCode == 115) {
			e.keyCode=0;
			e.returnValue=false;
			$('#forwardForm').submit();
			return false;
		}
		if (e.keyCode && e.keyCode == 123) {
			if(!showConsole){
				showConsole = true;
				$('#consoleDiv').show();
			}else{
				showConsole = false;
				$('#consoleDiv').hide();
			}
			return true;
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
		if (e && e.keyCode == 112) {
			var storeNo = <%=SessionHelper.getCurrentStoreNo()%>;
			if(storeNo==0){
				window.open('/help/RTHO Manual.pdf');
			}else{
				window.open('/help/RTStore Manual.pdf');
			}
			return false;
		}
	};

	/*屏蔽页面选中复制*/
	document.onselectstart = function(e) {
		var e = e || window.event || arguments.callee.caller.arguments[0];
		var d = e.srcElement || e.target;
		if (!((d.tagName == "INPUT" && d.type.toLowerCase() == "text") || d.tagName == "TEXTAREA")) {
			return false;
		}
		return true;
	};
	
	$(function() {
		$.ajax({
			url : ctx+'/workspace/getNotice4Row',
			type : 'POST',
			success : function(data) {
				$('#newsPanel').empty();
				$.each(data,function(index,obj){
					var value = obj.title;
					if (index > 4) {
						return;
					} else if (index == 4) {
						value = '查看更多>>';
						date = '' ;
					} else {
						date = new Date(obj.createDate).format('yyyy-MM-dd');
					}
					var news = '<div class="news"><input type="hidden" value="'+obj.id+'"><div class="n1" ><div class="n11 n11_1"></div><div class="n12">'
							+ value
							+ '</div></div><span>'
							+ date + '</span></div>';
					$('#newsPanel').append(news);
				});
				$('#newsPanel').find('.news:first').css('margin-top','15px');
				$('#newsPanel').find('.news:lt(4)').bind("click",function(){
					var noticeId = $(this).find('input').val();
					var form = $('#forwardForm');
					$(form).attr('action',ctx +'/fav/37');
					$(form).append('<input type="hidden" name="noticeId" value="'+noticeId+'">');
					$(form).submit();
					
				});
				$('#newsPanel').find('.news:gt(3)').bind("click",function(){
					getNoticeByPage();
				});
			}
		});

		//菜单多了切换屏
		var mu = new mainMenu();
		$(".menuBtn2").click(function () {
		    mu.move("right");
		});
		$(".menuBtn1").click(function () {
		    mu.move("left");
		});
	});
	
	function getNoticeByPage(){
		var form = $('#forwardForm');
		$(form).attr('action',ctx+'/fav/37');
		$(form).submit();
	}


	//用户关闭浏览器，注销用户会话
	window.onunload = onunload_handler;
	function onunload_handler() {
		$.post(ctx + '/logout', function(data) {
		});
	}
</script>
</head>
<body>
	<form id="forwardForm" method="post"></form>
	<div class="TopMenu" id="top_menu">
		<jsp:include page="/page/commons/menu.jsp"></jsp:include>
	</div>
	<div id="content_body" class="Center">
		<div class="wlc1">
			<div class="ch1"></div>
			<div class="ch2">
				<div class="ch21">
					<img src="../rtmm/shared/themes/theme1/images/ch_2.jpg" width="100%" height="100%" border="0" />
				</div>
				<div class="ch22">门店数量</div>
			</div>
		</div>
		<div class="wlc2">
			<div class="wlc21 wlc2x">
				<div class="n x"></div>
				<div id="newsPanel"></div>
			</div>
			<div class="wlc22 wlc2x">
				<div class="m x"></div>
				<div class="news" style="margin-top: 15px;">
					<div class="n1">
						<div class="n11 n11_2"></div>
						<div class="n12">Auchan RTMM V2 管理系统上线</div>
					</div>
					<span>2014-09-13</span>
				</div>
				<div class="news">
					<div class="n1">
						<div class="n11 n11_2"></div>
						<div class="n12">Auchan RTMM V2 管理系统上线</div>
					</div>
					<span>2014-09-13</span>
				</div>
				<div class="news">
					<div class="n1">
						<div class="n11 n11_2"></div>
						<div class="n12">Auchan RTMM V2 管理系统上线</div>
					</div>
					<span>2014-09-13</span>
				</div>
				<div class="news">
					<div class="n1">
						<div class="n11 n11_2"></div>
						<div class="n12">Auchan RTMM V2 管理系统上线</div>
					</div>
					<span>2014-09-13</span>
				</div>
				<div class="news">
					<div class="n1">
						<div class="n11  n11_2"></div>
						<div class="n12">查看更多>></div>
					</div>
				</div>
			</div>
		</div>
		<div class="foot">
			<span>欧尚（中国）投资有限公司</span>
			<div class="rts"></div>
		</div>
	</div>

	<div class="wpop" id="consoleDiv" style="display: none;">
		<div class="wclose">
			操作日志
			<div class="close" onclick="closeLogConsole()"></div>
		</div>
		<div class="wcontent" id="console"></div>
	</div>
</body>
</html>
