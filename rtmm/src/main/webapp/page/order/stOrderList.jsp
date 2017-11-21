<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
function stOrderDetail(obj){
	var param = {
			'ordNo':$(obj).find("#ordNo").val(),
			'storeNo':$(obj).find("#storeNo").val()
	};
	$.post("${ctx}/order/stOrderDetail", param, function(data){
		// 隱藏 list view 的 tag 和頁面
		$("#stOrderListTag").hide();
		$("#stOrderListView").hide();
		// 顯示 detail view 的 tag 和頁面
		$("#stOrderDetailView").html(data);
		$("#stOrderDetailView").show();
		$("#stOrderDetailTag").show();
		$('#Tools1').removeClass("Tools1").addClass("Tools1_disable").off();
	});
}

//滚动条事件
$(document).ready(function () {
    $(".btable_div").scroll(function () {
        var left = $(this).scrollLeft();
        $(".htable_div").scrollLeft(left);
    });
});

</script>


<!-- 分页属性 -->
 <input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
 <div class="htable_div">
			<table>
				<thead>
					<tr>
						<td><div class="t_cols align_center" style="width: 5px;">
								<!--<input 

type="checkbox" />-->
								&nbsp;
							</div></td>
						<td><div class="t_cols" style="width: 110px;"><auchan:i18n id="104003002"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 85px;"><auchan:i18n id="104003003"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 220px;"><auchan:i18n id="104003004"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="104003005"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="104003006"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="104003007"></auchan:i18n></div></td>

						<td><div class="t_cols" style="width: 70px;"><auchan:i18n id="104003008"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="104003009"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="104003010"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="104003011"></auchan:i18n></div></td>
						<td><div style="width: 16px;">&nbsp;</div></td>
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="btable_div" style="height: 509px;">
			<table class="single_tb w100" id='stOrder_tab_List'>
			  <c:forEach   items="${page.result}" var="orderStInfoVO">
				<!--multi_tb为多选 width:1001px;-->
				<tr ondblclick="stOrderDetail(this)">
					<td class="align_center" style="width: 5px;">
					<input id="storeNo" type="hidden" value="${orderStInfoVO.storeNo }">
					<input id="ordNo" type="hidden" value="${orderStInfoVO.ordNo }">
						</td>
					<td style="width: 111px;" align="left" title="${orderStInfoVO.storeNo }-${orderStInfoVO.storeName }">${orderStInfoVO.storeNo }-${orderStInfoVO.storeName }&nbsp;</td>
					<td style="width: 86px;"  align="right">${orderStInfoVO.ordNo }&nbsp;</td>
					<td style="width: 221px;"title="${orderStInfoVO.supNo }-${orderStInfoVO.comName }">${orderStInfoVO.supNo }-${orderStInfoVO.comName }</td>
					<td style="width: 81px;" title="${orderStInfoVO.sectionNo}-${orderStInfoVO.catlgName }">${orderStInfoVO.sectionNo}-${orderStInfoVO.catlgName }</td>
					<td style="width: 81px;"><c:if test="${orderStInfoVO.ordDate ne null}"><fmt:formatDate value="${orderStInfoVO.ordDate }" pattern="yyyy-MM-dd"/></c:if></td>
					<td style="width: 81px;"><c:if test="${orderStInfoVO.planRecptDate ne null}"><fmt:formatDate value="${orderStInfoVO.planRecptDate }" pattern="yyyy-MM-dd"/></c:if></td>
					<td style="width: 71px;"><auchan:getDictValue code='${orderStInfoVO.ordSttus}' mdgroup='ORDERS_ORD_STTUS' /></td>
					<td style="width: 81px;">${orderStInfoVO.recptNo}</td>
					<td style="width: 81px;"><c:if test="${orderStInfoVO.realRecptDate ne null}"><fmt:formatDate value="${orderStInfoVO.realRecptDate }" pattern="yyyy-MM-dd"/></c:if></td>
					<td style="width: 101px;" align="right">${orderStInfoVO.totOrdAmnt}&nbsp;</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
				</c:forEach>
				
			</table>
		</div>
               
          <jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
               