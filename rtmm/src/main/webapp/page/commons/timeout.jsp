<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js"></script>
<c:set var="theme" value="theme1"></c:set>
<%@ include file="/page/commons/easyui.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/loading/loading.css"/>
</head>
<body>
</body>
<script type="text/javascript">
$("body").append('<div id="grid_layer"><div id="g_loading"></div></div>');
var width = top.$(document).width();
var height = top.$(document).height();
var _top = $(window).scrollTop() + ($(window).height() - 200) / 2;
$("#grid_layer").css({ "width": width, "height": height, "display": "block" });
$("#g_loading").css({ "margin-left": (width - 200) / 2, "margin-top": _top });
top.location.href = '${ctx}/toLogin?msg=timeOut';
</script>
</html>