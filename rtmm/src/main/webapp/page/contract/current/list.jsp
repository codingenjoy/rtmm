<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td>
					<div class="t_cols align_center" style="width: 30px;">&nbsp;</div>
				</td>
				<td>
					<div class="t_cols" style="width: 100px;">合同编号</div>
				</td>
				<td>
					<div class="t_cols" style="width: 100px;">年份</div>
				</td>
				<td>
					<div class="t_cols" style="width: 100px;">合同状态</div>
				</td>
				<td>
					<div class="t_cols" style="width: 250px;">厂编</div>
				</td>
				<td>
					<div class="t_cols" style="width: 100px;">税率</div>
				</td>
				<td>
					<div class="t_cols" style="width: 100px;">课别</div>
				</td>
				<td>
					<div class="t_cols" style="width: 100px;">采购</div>
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
	<table class="single_tb w100">
		<c:forEach items="${page.result}" var="contract">
			<!--multi_tb为多选 width:1001px;-->
			<tr ondblclick="showDetailPage(${contract.cntrtId});" onclick="selectContract(${contract.cntrtId});" cntrtId="${contract.cntrtId}">
				<td class="align_center" style="width: 30px;"></td>
				<td style="width: 101px;" align="right" title="">${contract.cntrtId}&nbsp;</td>
				<td style="width: 101px;" align="right">${contract.year}&nbsp;</td>
				<td style="width: 101px;">
					<auchan:getDictValue code='${contract.status}' mdgroup='CONTRIBUTION_GRP_ACCOUNT_STATUS' />
				</td>
				<td style="width: 251px;" title="${contract.supNo}-${contract.supName}">${contract.supNo}-${contract.supName}&nbsp;</td>
				<td style="width: 101px;">${contract.supVatNo}-${contract.supVatVaule}%&nbsp;</td>
				<td style="width: 101px;">${contract.catlgId}-${contract.catlgName}&nbsp;</td>
				<td style="width: 101px;"><auchan:getStuffName value="${contract.buyer}"/>&nbsp;</td>
				<td style="width: 101px;"><fmt:formatNumber value='${contract.estmtPurchAmnt}' type='number' pattern='##########'/>&nbsp;</td>
				<td style="width: auto">&nbsp;</td>
			</tr>
		</c:forEach>
	</table>
</div>
<%-- <jsp:include page="/page/commons/pageSet.jsp" flush="true">     
     <jsp:param name="fpCallBack" value="currentContractPageQuery"/> 
</jsp:include> --%>
<div class="paging" id="currentContract"></div>
<%@ include file="/page/commons/paginator.jsp"%>
<script type="text/javascript">
	var p = new Paginator({
		totalItems:'${page.totalCount}',
		itemsPerPage:'${page.pageSize}',
		page:'${page.pageNo}',
		paginatorElem:'currentContract',
		callback:function(pageNo,pageSize){
			currentContractPageQuery(pageNo,pageSize);
		}
	});
	$(window).unload(function() {
		//0.清理资源;
		p.destroy();
	});
	
	$(function(){
		$(".btable_div").scroll(function () {
		    var left = $(this).scrollLeft();
		    //alert(left);
		    $(".htable_div").scrollLeft(left);
		});
		
	});
	
</script>

