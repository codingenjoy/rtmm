<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});
	});
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 100px;"><!-- 采购厂编 --><auchan:i18n id="102006003"/></div></td>
				<td><div class="t_cols" style="width: 100px;"><!-- 公司编号 --><auchan:i18n id="102006049"/></div></td>
				<td><div class="t_cols" style="width: 250px;"><!-- 公司名称 --><auchan:i18n id="102006050"/></div></td>
				<td><div class="t_cols" style="width: 150px;"><!-- 厂商种类 --><auchan:i18n id="102006007"/></div></td>
				<td><div class="t_cols" style="width: 80px;"><!-- 供货方式 --><auchan:i18n id="102006008"/></div></td>
				<td><div class="t_cols" style="width: 80px;"><!-- 采购方式 --><auchan:i18n id="102006009"/></div></td>
				<td><div class="t_cols" style="width: 80px;"><!-- 合同标准 --><auchan:i18n id="102006011"/></div></td>
				<td><div class="t_cols" style="width: 80px;"><!-- 状态 --><auchan:i18n id="102006004"/></div></td>
				<td><div class="t_cols" style="width: 80px;"><!-- 有效期 --><auchan:i18n id="102006004"/></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item" varStatus="count">
				<tr ondblclick="onDblClickRow('${item.supNo}','${item.comNo}','${count.count}');" onclick="onClickRow('${item.supNo}')">
					<td style="width: 101px;" class="align_right">
						<span style="margin-right: 5px;">${item.supNo}</span>
					</td>
					<td style="width: 101px;">
						${item.comNo}
					</td>
					<td style="width: 251px;" title="<c:out value="${item.comName}"/>">
						${item.comName}
					</td>
					<td style="width: 151px;">
						<auchan:getDictValue code="${item.supType}" mdgroup="SUPPLIER_SUP_TYPE"></auchan:getDictValue>
					</td>
					<td style="width: 81px;">
						<auchan:getDictValue code="${item.dlvryMethd}" mdgroup="SUPPLIER_DLVRY_METHD"></auchan:getDictValue>
					</td>
					<td style="width: 81px;">
						<auchan:getDictValue code="${item.buyMethd}" mdgroup="SUPPLIER_BUY_METHD"></auchan:getDictValue>
					</td>
					<td style="width: 81px;">
						<auchan:getDictValue code="${item.cntrtType}" mdgroup="SUPPLIER_CONTRT_TYPE"></auchan:getDictValue>
					</td>
					<td style="width: 81px;">
						<auchan:getDictValue code="${item.status}" mdgroup="SUPPLIER_STATUS"></auchan:getDictValue>
					</td>
					<td style="width: 81px;">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${item.validEndDate}"/>
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


