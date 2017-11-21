<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/supplier/comGrp.js" charset="gbk" type="text/javascript"></script>
<style type="text/css">
.Table_Panel1 {
	height: 70px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">
var viewModel = new ViewModel();
ko.applyBindings(viewModel);

</script>
<div class="Panel_top">
	<span>修改集团</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel1">
	<form id="com_group_form_modify" action="">
	<table class="CM_table">
		<tr>
			<td class="w20">
				<span>*集团名称</span>
			</td>
			<td>
				<input data-bind="value: viewModel.comgrpNo" type="hidden" />
				<input data-bind="value: viewModel.comGrpName" type="text" class="inputText w80" onfocus="codeOnblur()" /> <font id="codeFont" color="red">&nbsp;</font>
			</td>
		</tr>
		<tr>
			<td>
				<span>集团英文名称 </span>
			</td>
			<td>
				<input data-bind="value: viewModel.comGrpEnName"  type="text" class="inputText w80" onfocus="nameOnblur()" /> <font id="nameFont" color="red">&nbsp;</font>
			</td>
		</tr>
	</table>
	</form>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="updateComGrp();">确认</div>
		<div class="PanelBtn2" onclick="closePopupWin();">取消</div>
	</div>
</div>