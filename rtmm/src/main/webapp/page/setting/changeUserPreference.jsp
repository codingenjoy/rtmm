<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/main/changeUserPreference.js" charset="gbk" type="text/javascript"></script>
<script type="text/javascript">
	var viewModel = new ViewModel('${userPreferenceVO.lang}', '${userPreferenceVO.theme}');
	ko.applyBindings(viewModel,document.getElementById("userPreference"));
</script>

<style type="text/css">
.Table_Panel {
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<div class="Panel_top">
	<span>
		<!-- 用户偏好 -->
		<auchan:i18n id="100001009"/>
	</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div id="userPreference">
<div class="msgDiv" style="display: none; text-align: center; color: red"></div>
<div class="Table_Panel">
	<table class="CM_table">
		<tr>
			<td class="w35">
				<span>*
					<!-- 选择语言 -->
					<auchan:i18n id="100001011"/>
				</span>
			</td>
			<td>&nbsp;
				<select name="lang" data-bind="value:viewModel.lang" class="w55">
					<option value="local">-<!-- 中文 --><auchan:i18n id="100001012"/>-</option>
					<option value="en">-English-</option>
					<option value="fr">-français-</option>
				</select> <font color="red" data-bind="validationMessage:viewModel.lang"></font>
			</td>
		</tr>
		<tr>
			<td>
				<span>*<!-- 选择主题 --><auchan:i18n id="100001010"/></span>
			</td>
			<td>&nbsp;
				<select name="theme" data-bind="value:viewModel.theme" class="w55">
					<option value="theme1">-<!-- 主题1 --><auchan:i18n id="100001013"/>-</option>
					<!-- <option value="theme2">-主题2-</option>
					<option value="theme3">-主题3-</option> -->
				</select> <font color="red" data-bind="validationMessage:viewModel.theme"></font>
			</td>
		</tr>
	</table>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" data-bind="click:$root.save"><!-- 保存 --><auchan:i18n id="100000004"/></div>
		<div class="PanelBtn2" onclick="closePopupWin()"><!-- 取消 --><auchan:i18n id="100000003"/></div>
	</div>
</div>
</div>

