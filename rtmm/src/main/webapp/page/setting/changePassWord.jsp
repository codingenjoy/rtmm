<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ctx}/shared/js/jquery/jquery.md5.js" type="text/javascript"></script>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/main/changePassWord.js" charset="gbk" type="text/javascript"></script>
<script type="text/javascript">
	var viewModel = new ViewModel('${flag}');
	ko.applyBindings(viewModel,document.getElementById("changePassword"));
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
	<span><!-- 密码设置 --><auchan:i18n id="100001002"/></span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div style="display: block; text-align: center; color: red">
	<c:if test="${flag == 'isFirstLogin'}">
		<!-- 您的密码不安全,请尽快设置新密码! -->
		<auchan:i18n id="100001020"/>
	</c:if>
</div>
<div class="msgDiv" style="display: none; text-align: center; color: red">
</div>
<div id="changePassword">
<div class="Table_Panel">
	<table class="CM_table">
		<tr>
			<td class="w35">
				<span>*<!-- 原密码 --><auchan:i18n id="100001014"/></span>
			</td>
			<td>
				<input type="password" class="inputText w55" data-bind="{value:viewModel.oldPwd}" /> <font color="red"
					data-bind="validationMessage:viewModel.oldPwd">&nbsp;</font>
			</td>
		</tr>
		<tr>
			<td>
				<span>*<!-- 新密码 --><auchan:i18n id="100001015"/></span>
			</td>
			<td>
				<input type="password" class="inputText w55" data-bind="{value:viewModel.newPwd}"  /> <font color="red"
					data-bind="validationMessage:viewModel.newPwd"></font>
			</td>
		</tr>
		<tr>
			<td>
				<span>*<!-- 再次输入新密码 --><auchan:i18n id="100001016"/></span>
			</td>
			<td>

				<input type="password" class="inputText w55" data-bind="{value:viewModel.newPwdAgain}" /><font color="red"
					data-bind="validationMessage:viewModel.newPwdAgain"></font>
			</td>
		</tr>
	</table>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" data-bind="click:$root.save"><!-- 确认 --><auchan:i18n id="100000002"/></div>
		<div class="PanelBtn2" onclick="closePopupWin()"><!-- 取消 --><auchan:i18n id="100000003"/></div>
	</div>
</div>
</div>


