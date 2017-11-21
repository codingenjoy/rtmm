<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/catalog/catalogCommon.js" type="text/javascript"></script>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel1 {
	height: 100px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">
	function showCreateDivision() {	
		$.ajax( {
			async: false,
			type : "post",
			url : ctx + "/catalog/groupShowDivisionsAction",
			success : function(data) {
				var select = $("#divisionCodeCreate");
				select.empty();
				select.append("<option value=''>"+window.pleaseSelect+"</option>");
				$.each(data, function(index, value) {
					var option = "<option value=" + value.id + ">" + value.code
							+ "-&nbsp;" + value.name + "</option>";
					select.append(option);
				});
				// 把處下面的下拉式選單都disable
				$("#sectionCodeCreate").attr("disabled", "true");
				$("#groupCodeCreate").attr("disabled", "true");
				$("#midsizeCodeCreate").attr("disabled", "true");
				$("#subCodeCreate").attr("disabled", "true");
			}
		});
	}
	$(function(){
		showCreateDivision();
	});
</script>
<div class="Panel_top">
	<span><auchan:i18n id="101005007"></auchan:i18n></span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel1">
	<form id="cr_groupFrom" action="">
		<table class="CM_table">
			<tr>
				<td style="width: 122px">
					<span><auchan:i18n id="101005006"></auchan:i18n></span>
				</td>
				<td>
					<select id="sectionAttrDivNo" name="divNo" onchange="sectionSelect(this.value,'sectionAttrSecNo')" class="w80" style="width:135px;">
						<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
						<c:forEach items="${divisionList }" var="item">
							<option value="${item.id}">${item.id}-${item.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width: 122px">
					<span><auchan:i18n id="101005002"></auchan:i18n></span>
				</td>
				<td>
					<select  id="sectionAttrSecNo"  name="secNo" class="w80" style="width:135px;">
					</select>
				</td>
			</tr>
		</table>
	</form>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="chooseSection()"><auchan:i18n id="100000002"></auchan:i18n></div>
		<div class="PanelBtn2" onclick="closePopupWin()"><auchan:i18n id="100000003"></auchan:i18n></div>
	</div>
</div>