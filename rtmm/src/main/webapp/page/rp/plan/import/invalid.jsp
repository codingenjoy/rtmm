<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<div class="ig_top10 invalidSummary">
	<div class="icol_text">错误条目数&nbsp;</div>
	<input id="failCount" type="text" class="inputText w5 fl_left align_right" readonly="readonly" value="${page.totalCount }" />
	<div class="icol_text">&nbsp;&nbsp;错误原因&nbsp;</div>
	<select id="errorCode" class="w30 fl_left" onchange="invalidRpQuery()" value="${errorCode}">
			<option value="">请选择</option>
			<c:if test="${not empty errorList }" >
				<c:forEach items="${errorList }" var="code">
					<option value="${code}" 
					<c:if test="${code == errorCode }">
						selected="selected" 
					</c:if>  
					><auchan:getDictValue code="${code }" showType="3" mdgroup="RP_IMPORT_ERROR_INFO"></auchan:getDictValue></option>
				</c:forEach>
			</c:if>
	</select>
	<span class="choosed"></span>
	<!-- <div class="icol_text">&nbsp;验证全部</div> -->
</div>
<form id="invalidForm">
	<div style="height: 450px; padding-top: 8px;">
		<div class="htable_div">
			<table>
				<thead>
					<tr>
						<td>
							<div class="t_cols align_center" style="width: 30px;">&nbsp;</div>
						</td>
						<td>
							<div class="t_cols" style="width: 70px;">货号</div>
						</td>
						<td>
							<div class="t_cols" style="width: 165px;">品名</div>
						</td>
<!-- 						<td>
							<div class="t_cols" style="width: 70px;">*买价(元)</div>
						</td> -->
						<td>
							<div class="t_cols" style="width: 70px;">厂编</div>
						</td>
						<td>
							<div class="t_cols" style="width: 160px;">公司名称</div>
						</td>
						<td>
							<div class="t_cols" style="width: 60px;">买价(元)</div>
						</td>
						<td>
							<div class="t_cols" style="width: 75px;">正常买价(元)</div>
						</td>
						<td>
							<div class="t_cols" style="width: 205px;">错误原因</div>
						</td>
						<td>
							<div class="t_cols" style="width: 70px;">分店详情</div>
						</td>
						<td>
							<div style="width: 16px;">&nbsp;</div>
						</td>
					</tr>
				</thead>
			</table>
		</div>
		<div class="btable_div" style="height: 420px;">
			<table class="single_tb w100">
				<!--multi_tb为多选 width:1001px;-->
				<tbody>
					<c:if test="${not empty page.result}">
						<c:forEach items="${page.result}" var="rp" varStatus="rpindex">
							<tr ondblclick="showStoreError('${processId}','${rp.itemNo }')">
								<td class="align_center" style="width: 30px;">&nbsp;</td>
								<td class="align_right" style="width: 66px; padding-right:5px;">${rp.itemNo}</td>
								<td style="width: 166px;" title="${rp.itemName}">${rp.itemName}</td> 
								<%-- 
								<td class="align_right" style="width: 71px;"><fmt:formatNumber value="${rp.buyPrice}" pattern="#.##" minFractionDigits="2" /></td>
								 --%>
								<td class="align_right" style="width: 66px; padding-right:5px;">${rp.dcSupNo}</td>
								<td style="width: 161px;" title="${rp.dcSupName}">${rp.dcSupName}</td> 
								<td class="align_right" style="width: 61px;"><fmt:formatNumber value="${rp.buyPrice }" pattern="#.####" minFractionDigits="4" /></td>
								<td class="align_right" style="width: 71px; padding-right:5px;"><fmt:formatNumber value="${rp.normBuyPrice }" pattern="#.####" minFractionDigits="4" /></td>
								<td style="width: 206px;">
									<c:choose>
										<c:when test="${rp.errorInfo  == 6 || rp.errorInfo  == 7}" >
											<span class="longText" title="99-分店详情错误">99-分店详情错误</span>
										</c:when>
										<c:otherwise>
											<span class="longText"
												title="<auchan:getDictValue code="${rp.errorInfo }" showType="3" mdgroup="RP_IMPORT_ERROR_INFO"></auchan:getDictValue>"> <auchan:getDictValue
													code="${rp.errorInfo }" showType="3" mdgroup="RP_IMPORT_ERROR_INFO"></auchan:getDictValue>
											</span>
										</c:otherwise>	
									</c:choose>
								</td>
								<td class="align_center" style="width: 71px;"><div class="ListWin" style="width: 25px; margin-top: 6px; margin-left:25px;"
										onclick="showStoreError('${processId}','${rp.itemNo }')"></div></td>
								<td style="width: auto">&nbsp;</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="paging" id="invalidRpList"></div>
		<input type="hidden" name="pageSize" value="${page.pageSize}" />
		<input type="hidden" name="pageNo" value="${page.pageNo}" />
		<input type="hidden" name="errorCode" />
		<input type="hidden" name="processId" id="processId" value="${processId }" />
		<%@ include file="/page/commons/paginator.jsp"%>
	</div>
</form>
<script type="text/javascript">
	var p = new Paginator({
		totalItems : '${page.totalCount}',
		itemsPerPage : '${page.pageSize}',
		page : '${page.pageNo}',
		paginatorElem : 'invalidRpList',
		psConfigurable : [ 100, 200, 300 ],
		callback : function(pageNo, pageSize) {
			$("#invalidForm input[name=pageSize]").val(pageSize);
			$("#invalidForm input[name=pageNo]").val(pageNo);
			invalidRpQuery();
		}
	});
	$(window).unload(function() {
		//0.清理资源;
		p.destroy();
	});

	$(function() {
		document.onkeydown = function(e) {
			enterShow(e);
		};

	});
</script>