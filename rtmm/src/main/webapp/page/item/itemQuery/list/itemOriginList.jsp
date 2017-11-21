<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
/* $("#stOrder_tab_List tr").unbind("dblclick").bind("dblclick",function(){	
showContent("${ctx}/order/stOrderDetail");
});  */

function itemOriginDetail(obj){
	 var param = {
			'itemNo':$(obj).find("#itemNo").text()
	};
	showContent("<c:url value='/itemQueryManagement/toItemOriginDetail'/>", param);	 
}

//滚动条事件
$(document).ready(function () {
    $(".btable_div").scroll(function () {
        var left = $(this).scrollLeft();
        $(".htable_div").scrollLeft(left);
    });
});

function bindItemOriginDetail(obj){
	$("#Tools22").removeClass('Tools22_disable').addClass('Tools22').unbind('click').bind('click',function(){
		$("#Tools21").removeClass('Tools21').addClass('Tools21_disable').unbind('click');
		 var param = {
					'itemNo':$(obj).find("#itemNo").text()
			};
			showContent("<c:url value='/itemQueryManagement/toItemOriginDetail'/>", param);	
	});	
}

</script>


<!-- 分页属性 -->
 <input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
 <div>
 <div class="htable_div">
			<table>
				<thead>
					<tr>
						<td><div class="t_cols align_center" style="width: 30px;">
							</div></td>
						<td><div class="t_cols" style="width: 70px;">货号</div></td>
						<td><div class="t_cols" style="width: 270px;">品名</div></td>
						<td><div class="t_cols" style="width: 180px;">产地</div></td>
						<td><div class="t_cols" style="width: 80px;">是否主产地</div></td>
						<td><div class="t_cols" style="width: 160px;">生产单位</div></td>
						<td><div class="t_cols" style="width: 100px;">城市</div></td>
						<td><div class="t_cols" style="width: 100px;">单位地址</div></td>						
						<td><div style="width: 16px;">&nbsp;</div></td>
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="btable_div" style="height: 509px;">
		
		
			<table class="single_tb w100" id='itemOrigin_tab_List'>
				<!--multi_tb为多选 width:1001px;-->
				 <c:forEach   items="${page.result}" var="itemOthOrignVO">
				<tr ondblclick="itemOriginDetail(this)" onclick="bindItemOriginDetail(this)">
					<td class="align_center" style="width: 30px;">
						</td>
					<td style="width: 71px;" id="itemNo" align="right" >${itemOthOrignVO.itemNo }</td>
					<td style="width: 271px;" >&nbsp;${itemOthOrignVO.itemName }</td>
					<td style="width: 181px;"><auchan:getDictValue code='${itemOthOrignVO.orignCode }' mdgroup='origin' /></td>
					<td style="width: 81px;" ><auchan:getDictValue code='${itemOthOrignVO.majorOrigInd }' mdgroup='ITEM_STORE_INFO_TRIAL_SALE_IND' /></td>
					<td style="width: 161px;">
					${itemOthOrignVO.prdcrComNo }<c:if test="${itemOthOrignVO.prdcrComNo ne null} ">-</c:if>${itemOthOrignVO.prdcrName }</td>
					<td style="width: 101px;">${itemOthOrignVO.cityName }</td>
					<td style="width: 101px;">${itemOthOrignVO.detllAddr }</td>					
					<td style="width: auto">&nbsp;</td>
				</tr>
				</c:forEach>
			</table>
		</div>
     </div>          
     <jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
               