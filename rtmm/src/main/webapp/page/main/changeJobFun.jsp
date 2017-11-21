<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css"
	rel="Stylesheet" />
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/page/chooseRole.css"
	rel="stylesheet" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js"
	type="text/javascript"></script>
<script src="${ctx}/shared/js/rtmm.js" charset="gbk"
	type="text/javascript"></script>
<%@ include file="/page/commons/jquery-alerts.jsp"%>
<script type="text/javascript">

		$(function(){  
			$(".job").click(function(){
				$(".tr_on").attr('class','job');
				$(this).find('div').remove();
			    $(this).attr('class','tr_on');
			    $(this).find('td:last').append('<div></div>');
			  });
			});
				
		function changeJobFun2() {
			var jobFunctionId =$("tr[class='tr_on']").find('input').attr('value');
			if (undefined == jobFunctionId || "" == jobFunctionId){
				top.jAlert('warning','请选择职位','提示消息');
				return false;	
			}			
			$('input[name=jobFunctionId]').attr('value',jobFunctionId);
			$('#changeJobFunForm').attr('action', ctx + '/changeJobFun');
			$('#changeJobFunForm').submit();
			
		}
	</script>
</head>
<body>
	<style type="text/css">
/*	
.Table_Panel {
	height: 400px;
	overflow: hidden;
}

.List {
	margin: 0 auto;
	width: 97%;
	height: 400px;
	overflow: auto;
}

.item {
	height: 30px;
	line-height: 28px;
}

item div {
	float: right;
	margin-right: 10px;
}

.item span {
	float: left;
	margin-left: 10px;
}

.item:hover,.item_on {
	//background: url('../images/icon0401.png') no-repeat  -11px -476px;
	background: #3F9673;
}
*/
.auto-style1 {
	height: 30px;
}
</style>
<!--  
	<form id="changeJobFunForm" method="post">
		<input type="hidden" name="jobFunctionId" />
	</form>
	<div class="Panel" style="margin-left: 30%; margin-top: 10%;">
		<div class="Panel_top">
			<span>请选择登入岗位</span>
		</div>
		<div class="Table_Panel">
			<div style="height: 10px;"></div>
			<div class="item">
				<span style="width: 100px"><b>店号</b></span> <span
					style="width: 100px"><b>部门</b></span> <span style="width: 100px"><b>职位</b></span>
				<div class="ListIcon"></div>
			</div>
			<c:forEach items="${jfList}" var="vo">
				<div id="${vo.id}" class="item" onclick="changeJobFun(${vo.id})">
					<span style="width: 100px">${vo.storeName }</span> <span
						style="width: 100px">${vo.deptName }</span> <span
						style="width: 100px">${vo.jobFunctionName }</span>
					<div class="ListIcon"></div>
				</div>
			</c:forEach>
		</div>
	</div>
-->

	<div class="bg">
		<form id="changeJobFunForm" method="post">
		<input type="hidden" name="jobFunctionId" />
		</form>
		<div style="height: 190px;"></div>
		<div class="m">
			<table class="tb1">
				<tr>
					<td class="crole1"><span>你可以选择如下职位登陆:</span></td>
				</tr>
				<tr>
					<td style="background: #fff;">
						<div class="div1">
							<div class="div11">门店</div>
							<div class="div12">部门</div>
							<div class="div13">职位</div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tbody">
						<div class="tbody_div">
							<table class="tb2">
								<c:forEach items="${jfList}" var="vo">
									<tr class="job" ondblclick="changeJobFun2()" >
										<td style="width: 31%;">
										<input type="hidden" value="${vo.id} "></input>
										${vo.storeName }</td>
										<td style="width: 40%;">${vo.deptName }</td>
										<td style="width: 29%;">${vo.jobFunctionName }</td>
										
									</tr>
								</c:forEach>
							</table>
						</div>
					</td>
				</tr>
				<!-- <tr>
					<td><label> <input type="checkbox" />
					</label> <span>将选择的身份设置为默认身份</span></td>
				</tr> -->
				<tr>
					<td class="Panel_footer">
						<div class="PanelBtn1" onclick="changeJobFun2()">确定</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

</body>
</html>
