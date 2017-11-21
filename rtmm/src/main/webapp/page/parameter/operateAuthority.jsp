<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style>
.btable_div {
height:498px;
overflow-x: hidden;
overflow-y: auto;
}
</style>
<link href="${ctx}/shared/themes/${theme}/css/page/role_Param11_2.css" rel="stylesheet"
	type="text/css" />
<div id="paraOperAuthTable">
	<div class="htable_div">
		<table>
			<thead>
				<tr>
					<td><div class="t_cols" style="width: 30px;">
							<input type="checkbox" class="isCheckAll">
						</div></td>
					<td><div class="t_cols" style="width: 100px;">权限ID</div></td>
					<td><div class="t_cols" style="width: 480px;">操作权限</div></td>
				</tr>
			</thead>
		</table>
	</div>
	<div class="btable_div">
		<table class="single_tb w100">
			<c:if test="${not empty result }">
				<c:forEach items="${result}" var="item">
					<tr>
						<td class="t_cols" style="width: 30px; border-right: 0px !important; text-align: center;">
							<input type="checkbox" class="isCheck" id="${item.privId}">
						</td>
						<td style="width: 101px; text-align:right;">${item.operId}&nbsp;&nbsp;</td>
						<td style="width: 480px;">${item.textLocal}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>
</div>