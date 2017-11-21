<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="${ctx}/shared/js/workspace/report.js"></script>
<script type="text/javascript">

//滚动条事件
$(document).ready(function () {
    $(".btable_div").scroll(function () {
        var left = $(this).scrollLeft();
        $(".htable_div").scrollLeft(left);
    });
});

//参数设定
var queryStore={ 
		"itemNo":itemNo,
		"itemName":itemName,
		"supNo":supNo,
		"storeNo":storeNo
		}; 
var setQuerySotre = function(){ 
var str = ""; 
for(var o in queryStore){ 
	if(queryStore[o] != -1){ 
		str += o + "=" + queryStore[o] + "&"; 
		} 
		} 
		var str = str.substring(0, str.length-1); 
		return str; 
	}; 
	
<c:if test="${page ne null and page.totalCount gt 0}" var="supItemStoreResult">
   //导出信息
	$('#Tools23').removeClass('Tools23_disable').addClass('Tools23').unbind().bind('click',function() {
	if('${page.totalCount}'>5000){
		 top.jAlert('warning', '请缩小查询范围到5000项以下！', '提示消息');
		 return false;
	}
	top.jAlert('success', '数据正在导出，请稍候...', '提示消息');
	exportReport('sync','112312005',queryStore);	
});
</c:if>
</script>


<!-- 分页属性 -->
 <input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
 <div>
 <div class="htable_div">
			<table>
				<thead>
					<tr>
						<td><div class="t_cols align_center" style="width: 5px;">
							</div></td>
						<td><div class="t_cols" style="width: 70px;">店号</div></td>
						<td><div class="t_cols" style="width: 100px;">店名</div></td>
						<td><div class="t_cols" style="width: 70px;">货号</div></td>
						<td><div class="t_cols" style="width: 200px;">品名</div></td>
						<td><div class="t_cols" style="width: 100px;">商品状态</div></td>
						<td><div class="t_cols" style="width: 100px;">厂编</div></td>
						<td><div class="t_cols" style="width: 280px;">厂商名称</div></td>
						<td><div class="t_cols" style="width: 100px;">厂商状态</div></td>						
						<td><div class="t_cols" style="width: 160px;">是否主厂商</div></td>											
						<td><div style="width: 16px;">&nbsp;</div></td>
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="btable_div" style="height: 509px;">
				
			<table class="single_tb w100" >
				<!--multi_tb为多选 width:1001px;-->
				 <c:forEach   items="${page.result}" var="itemSupVO">
				<tr>
					<td class="align_center" style="width: 6px;">
						</td>
					<td style="width: 71px;" align="right">${itemSupVO.storeNo } &nbsp; </td>
					<td  style="width: 101px;">${itemSupVO.storeName }</td>
					<td style="width: 71px;" align="right">${itemSupVO.itemNo } &nbsp;</td>
					<td style="width: 201px;">${itemSupVO.itemName }</td>
					<td style="width: 101px;"><c:if test="${itemSupVO.itemStatus ne null }">&nbsp;<auchan:getDictValue code="${itemSupVO.itemStatus }" mdgroup="ITEM_BASIC_STATUS"/></c:if></td>
					<td style="width: 101px;" align="right">${itemSupVO.supNo } &nbsp;</td>
					<td style="width: 281px;" >${itemSupVO.comName }</td>
					<td style="width: 101px;"><c:if test="${itemSupVO.supStatus ne null }">&nbsp;<auchan:getDictValue code="${itemSupVO.supStatus }" mdgroup="SUPPLIER_STATUS"/></c:if></td>
					<td style="width: 161px;"><c:if test="${itemSupVO.majorSupInd ne null }"><auchan:getDictValue code='${itemSupVO.majorSupInd }' mdgroup='SUP_PAYMENT_ELEC_INV_IND' /></c:if></td>				
					<td style="width: auto">&nbsp;</td>
				</tr>
				</c:forEach>
			</table>
		</div>
     </div>          
          <jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
               