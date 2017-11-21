<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${defaultTitle }</title>
<meta name="keywords" content="${defaultKeyWords }" />
<meta name="description" content="${defaultDescription }" /> 
<meta name="author" content="${defaultAuthor }" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"/>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/Global.css"> 
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
</head>
<body>
<auchan:menu isselected="2"></auchan:menu>
-------------------------------------------------------------------------------------
<auchan:menu pid="1"></auchan:menu>
</body>
</html>