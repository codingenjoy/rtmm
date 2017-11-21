<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>index</title>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>

<style type="text/css">
body,input{
	font-family:'Microsoft YaHei';
    font-size:12px;
    color:#333;
}
.msg{color:red;margin-top:10px;}
</style>

</head>
<body>

 <div class="fileInput left">
	<form method="post" action="/auchan-upload/upload/upload" enctype="multipart/form-data">
	<input type="file" id="houseMaps" name="houseMaps"/><br/>
	<div type="text" class="msg">(请选择小于5M的图片)</div>
	<!--	<input type="file" id="houseMaps" name="houseMaps" class="upfile" onchange="document.getElementById('upfileResult').innerHTML=this.value" />  -->
	<!-- 	 <input class="upFileBtn" type="button" value="上传图片" onclick="document.getElementById('houseMaps').click()" /> -->
		<!--1.item;2.supplier --> 
			<input type="hidden" name="category" id="category"/>
			<input type="hidden" name="subjectNo" id="subjectNo"/>
		<br/>
	<!-- 	<input type="submit" value="提交"/> -->
	</form> 
	<br />	
</div>
<br />
  <!--   <span  id="upfileResult" style="font-size: 12px;font-family: 'Microsoft YaHei';color: #333">请选择要上传的图片</span>-->

		
</body>
</html>

