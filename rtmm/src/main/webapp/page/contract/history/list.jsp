<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	//滚动条事件
	$(document).ready(function () {
	    $(".btable_div").scroll(function () {
	        var left = $(this).scrollLeft();
	        $(".htable_div").scrollLeft(left);
	    });
	});
</script>
<input type="hidden" id="totalCount" value="${page.totalCount}">
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td>
					<div class="t_cols align_center" style="width: 30px;">&nbsp;</div>
				</td>
				<td>
					<div class="t_cols" style="width: 110px;">合同编号</div>
				</td>
				<td>
					<div class="t_cols" style="width: 60px;">年份</div>
				</td>
				<td>
					<div class="t_cols" style="width: 70px;">合同状态</div>
				</td>
				<td>
					<div class="t_cols" style="width: 300px;">厂编</div>
				</td>
				<td>
					<div class="t_cols" style="width: 70px;">税率</div>
				</td>
				<td>
					<div class="t_cols" style="width: 130px;">课别</div>
				</td>
				<td>
					<div class="t_cols" style="width: 70px;">采购</div>
				</td>

				<td>
					<div class="t_cols" style="width: 100px;">预估营业额</div>
				</td>
				<td>
					<div style="width: 16px;">&nbsp;</div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 509px;">
	<table class="single_tb w100" id="historicalContract">
		<c:forEach items="${page.result}" var="contract" varStatus="seq">
			<!--multi_tb为多选 width:1001px;-->
			<tr id="cntrt-${contract.cntrtId}" ondblclick="switchToDetailView(${seq.index })">
				<td class="align_center" style="width: 30px;"></td>
				<td class="align_right" style="width: 111px;" title="">${contract.cntrtId}&nbsp;</td>
				<td class="align_right" style="width: 61px;">${contract.year}&nbsp;</td>
				<td style="width: 71px;">
					<auchan:getDictValue code='${contract.status}' mdgroup='CONTRIBUTION_GRP_ACCOUNT_STATUS' />
				</td>
				<td style="width: 301px;" title="${contract.supNo}-${contract.supName}">${contract.supNo}-${contract.supName}&nbsp;</td>
				<td style="width: 71px;">${contract.supVatNo}-${contract.supVatVaule}%&nbsp;</td>
				<td style="width: 131px;">${contract.catlgId}-${contract.catlgName}&nbsp;</td>
				<td style="width: 71px;"><auchan:getStuffName value="${contract.buyer}"/>&nbsp;</td>
				<td style="width: 101px;" class="align_right"><fmt:formatNumber value='${contract.estmtPurchAmnt}' type='number' pattern='##########'/>&nbsp;</td>
				<td style="width: auto">&nbsp;</td>
			</tr>
		</c:forEach>

	</table>
</div>
<%-- <jsp:include page="/page/commons/pageSet.jsp" flush="true">     
     <jsp:param name="fpCallBack" value="historyContractPageQuery"/> 
</jsp:include> --%> 
<div class="paging" id="historyContractPage"></div>
<script type="text/javascript">
	var historyContract = new Paginator({
		totalItems:'${page.totalCount}',
		itemsPerPage:'${page.pageSize}',
		page:'${page.pageNo}',
		paginatorElem:'historyContractPage',
		callback:function(pageNo,pageSize){
			historyContractPageQuery(pageNo,pageSize);
		}
	});
	$(window).unload(function() {
		//0.清理资源;
		historyContract.destroy();
	});
</script>


