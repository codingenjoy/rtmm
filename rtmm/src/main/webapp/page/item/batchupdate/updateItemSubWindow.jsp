<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel1 {
	height: 170px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">
	$(function(){
		showCreateDivision();
	});
</script>
<div class="Panel_top">
	<span>选择大中小分类</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<form id="cr_groupFrom" action="">
	<div class="Table_Panel1">
		<table class="CM_table" style="width: 90%; margin-left: 55px;">
			<tr>
				<td class="w30"><span>*&nbsp;处别</span></td>
				<td><select id="divisionCodeCreate" name="divisionId"
					title="请选择处别" onchange="cr_divisionSelect(this)"
					onmousedown="$('#divisionCodeCreate').removeClass('errorInput')"
					class="w35">
				</select></td>
			</tr>
			<tr>
				<td><span>*&nbsp;课别</span></td>
				<td><select id="sectionCodeCreate" name="sectionId" class="w35"
					title="请选择课别" onchange="cr_sectionSelect(this)"
					onmousedown="$('#sectionCodeCreate').removeClass('errorInput')">
				</select></td>
			</tr>
			<tr>
				<td><span>*&nbsp;大分类</span></td>
				<td><select id="groupCodeCreate" name="groupId" class="w35"
					title="请选择大分类" onchange="cr_groupSelect(this)"
					onmousedown="$('#groupCodeCreate').removeClass('errorInput')">
				</select></td>
			</tr>
			<tr>
				<td><span>*&nbsp;中分类</span></td>
				<td><select id="midsizeCodeCreate" name="midsizeId" class="w35"
					title="请选择中分类" onchange="cr_subGroupSelect(this)"
					onmousedown="$('#midsizeCodeCreate').removeClass('errorInput')">
				</select></td>
			</tr>
			<tr>
				<td><span>*&nbsp;小分类</span></td>
				<td><select id="subCodeCreate" name="subId" class="w35"
					title="请选择小分类"
					onmousedown="$('#subCodeCreate').removeClass('errorInput')">
				</select></td>
			</tr>
		</table>
	</div>
</form>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="saveSelectSub('${catlgNo}')">保存</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>