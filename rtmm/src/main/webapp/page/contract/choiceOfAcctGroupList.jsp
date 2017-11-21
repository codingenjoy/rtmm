<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<input id="acctTotalCount" type="hidden" value="${page.totalCount }" />
<div class="btable_div" style="height: 340px;">
	<table class="single_tb w100">
		<c:forEach items="${page.result }" var="grpAcctVO" varStatus="num">
			<tr>
				<td class="align_center" style="width: 30px;">
					<input type="checkbox" onclick="onclickCheckBox(this);"/>
				</td>
				<td class="align_right" style="width: 71px;">${grpAcctVO.grpAcctSeqNo }</td>
				<td class="align_right" style="width: 111px; padding-right:10px;">${grpAcctVO.grpAcctId }</td>
				<td style="width: 201px;">${grpAcctVO.grpAcctName }</td>
				<td style="width: 201px;">${grpAcctVO.grpAcctEnName }</td>
				<td style="width: 101px;">${grpAcctVO.grpGrpAbbr }</td>
				<td style="width: auto">&nbsp;</td>
			</tr>
		</c:forEach>
	</table>
</div>
<div class="paging" id="accGroupPage"></div>
<script type="text/javascript">
	var historyContract = new Paginator({
		totalItems:'${page.totalCount}',
		itemsPerPage:'${page.pageSize}',
		page:'${page.pageNo}',
		paginatorElem:'accGroupPage',
		callback:function(pageNo,pageSize){
			templContractPageQuery(pageNo,pageSize);
		}
	});
	$(window).unload(function() {
		//0.清理资源;
		historyContract.destroy();
	});
	$(function(){
		if (acctsArray.length > 0) {
			for(var i = 0; i < acctsArray.length; i++){
				var acctMap = acctsArray[i];
				var trArray = $("#grpAcctsDiv table tr");
				for(var j = 0; j < trArray.length; j++){
					var trStr = trArray[j];
					var trAcctNo = trStr.cells[2].innerHTML;
					if (acctMap.grpAcctNo == trAcctNo) {
						trStr.cells[0].children[0].checked = true;
						break;
					}
				}
			}
			checkWhetherCheckedAll();
		}
	});
</script>
