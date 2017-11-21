<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.tbx {
	height: 443px;
}

.tbx td {
	height: 30px;
}

.tbx tr {
	border-bottom: 1px solid white;
	cursor: pointer;
}

.tbx tr:hover {
	background: #99cc66;
}

.item_on2 {
	background: #3F9673 !important;
	color: #fff;
}

.Con_tb {
	width: 35%;
	margin-top: 0px;
	height: 580px;
	float: left;
}

.Con_R {
	width: 65%;
	float: right;
	height: 580px;
}

.con_title {
	height: 30px;
	background: #EEEEEE;
	overflow: hidden;
}

.con_title table {
	margin-top: 5px;
}

.con_title td {
	height: 20px;
}
.scroll_bar {
	overflow-x: auto;
}
</style>

<!-- Bar_on-->
<div class="SearchTopx">
	<span><auchan:i18n id="101004002"></auchan:i18n></span>
</div>
<div class="con_title">
	<table class="w100">
		<tr>
			<td class="w10 align_center" style="border-right: 1px solid #cccccc;"></td>
			<td class="w10 align_center" style="border-right: 1px solid #cccccc;"><auchan:i18n id="101004003"></auchan:i18n></td>
			<td class="w35 align_center" style="border-right: 1px solid #cccccc;"><auchan:i18n id="101004004"></auchan:i18n></td>
			<td class="w45 align_center"><auchan:i18n id="101004005"></auchan:i18n></td>
		</tr>
	</table>
</div>
<div class="tbx">
	<table class="w100">
		<c:forEach items="${divisionList}" var="division">
			<tr id="sectionTr${division.id }" onclick="pageQuery('${division.id}')" class="tbr">
				<td class="w10 align_center"><input type="hidden" name="divisionId" value="${division.id}"></td>
				<td class="w10 align_center" style="text-align: right;">${division.code }&nbsp;&nbsp;&nbsp;</td>
				<td class="w35">${division.name }</td>
				<td class="w45">${division.enName }</td>
			</tr>
		</c:forEach>
	</table>
</div>
<div class="line"></div>
<script type="text/javascript">
	$(function() {
		$('.tbx').find('tr:eq(0)').trigger('click');
	});
</script>

