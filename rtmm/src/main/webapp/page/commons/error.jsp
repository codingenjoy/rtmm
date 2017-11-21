<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${defaultTitle }</title>
<meta name="keywords" content="${defaultKeyWords }" />
<meta name="description" content="${defaultDescription }" />
<meta name="author" content="${defaultKeyWords }" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"/> 
<link href="${ctx}/resources/css/global.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<div class="top"></div>
	<div class="main">
		<!-- con_l start -->
		<%@ include file="/page/commons/menu.jsp"%>
		<!-- con_l end -->
		<!-- con_r start -->
		<div class="con_r">
			<div class="error_div">
				<div class="error_logo"></div>
				<div class="error_info"><i class="warn_icon f_l"></i><span class="mg_l_10 f_l">对不起,出错了</span></div>
				<div>
					<span class="choose_text">请尝试以下操作</span>
					<span class="choose_text">1.<a onclick="javascript:history.go(-1);"> 返回 </a></span>
					<span class="choose_text">2.联系管理员</span>
				</div>
			</div>	
		</div>
		<!-- con_r end -->
	</div>
	
</body>
</html>