<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
/* $("#stOrder_tab_List tr").unbind("dblclick").bind("dblclick",function(){	
showContent("${ctx}/order/stOrderDetail");
});  */

function itemCorrelationDetail(obj){
	 var param = {
			'itemNo':$(obj).find("#itemNo").text()
	};
	showContent("<c:url value='/itemQueryManagement/toItemCorrelationDetail'/>",param);			 
}

function bindItemCorrelationDetail(obj){
	$("#Tools22").removeClass('Tools22_disable').addClass('Tools22').unbind('click').bind('click',function(){
		$("#Tools21").removeClass('Tools21').addClass('Tools21_disable').unbind('click');
		 var param = {
					'itemNo':$(obj).find("#itemNo").text()
			};
		  showContent("<c:url value='/itemQueryManagement/toItemCorrelationDetail'/>",param);		
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
 <div>
 <div class="htable_div">
			<table>
				<thead>
					<tr>
						<td><div class="t_cols align_center" style="width: 30px;">
							</div></td>
						<td><div class="t_cols" style="width: 70px;">母货号</div></td>
						<td><div class="t_cols" style="width: 270px;">母货品名</div></td>
						<td><div class="t_cols" style="width: 100px;">母货类型</div></td>
						<td><div class="t_cols" style="width: 80px;">售价</div></td>
						<td><div class="t_cols" style="width: 160px;">子货号</div></td>
						<td><div class="t_cols" style="width: 180px;">子货品名</div></td>
						<td><div class="t_cols" style="width: 100px;">售价</div></td>						
						<td><div style="width: 16px;">&nbsp;</div></td>
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="btable_div" style="height: 509px;">
		
		
			<table class="single_tb w100" id='itemCorrelation_tab_List'>
				<!--multi_tb为多选 width:1001px;-->
				 <c:forEach   items="${page.result}" var="itemRelativeVO">
				<tr ondblclick="itemCorrelationDetail(this)" onclick="bindItemCorrelationDetail(this)" >
					<td class="align_center" style="width: 30px;">
						</td>
					<td style="width: 71px;"id="itemNo" align="right">${itemRelativeVO.itemNo}</td>
					<td style="width: 271px;"> &nbsp;${itemRelativeVO.itemName}</td>
					<td style="width: 101px;"><auchan:getDictValue code='${itemRelativeVO.rltnType}' mdgroup='ITEM_RELATIVE_RLTN_TYPE' /></td>
					<td style="width: 81px;" align="right">${itemRelativeVO.stdSellPrice}&nbsp;</td>
					<td style="width: 161px;"align="right">${itemRelativeVO.childItemNo}&nbsp;</td>
					<td style="width: 181px;">${itemRelativeVO.childItemName}</td>
					<td style="width: 101px;"align="right">${itemRelativeVO.childStdSellPrice}&nbsp;</td>					
					<td style="width: auto">&nbsp;</td>
				</tr>
				</c:forEach>
			</table>
		</div>
     </div>          
          <jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
               