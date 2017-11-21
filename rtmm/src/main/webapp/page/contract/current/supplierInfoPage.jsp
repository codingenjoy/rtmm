<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<script type="text/javascript">
</script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols align_center" style="width: 60px;">厂商NO</div></td>
				<td><div class="t_cols" style="width: 290px;">厂商名称</div></td>
				<td><div class="t_cols" style="width: 290px;">厂商英文名称</div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 340px;">
	<table class="single_tb w100">
		<!--multi_tb为多选 width:1001px;-->
		<c:forEach items="${supList}" var="supplier">
			<tr class='sup_tr' supNo="${supplier.supNo}"
				comName="${supplier.supName}"
				onclick="ClickSelectSupplier('${supplier.supNo}','${supplier.supName}')"
				ondblclick="selectCurrentSupplier('${supplier.supNo}','${supplier.supName}')">
				<td class="align_center" style="width: 60px; text-align: right;">${supplier.supNo}&nbsp;&nbsp;</td>
				<td align="left" style="width: 290px;">${supplier.supName}</td>
				<td align="left" style="width: 290px;">${supplier.supEnName}</td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</c:forEach>
	</table>
</div>
<jsp:include page="/page/commons/page2.jsp"></jsp:include>

