<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
$(function(){
	// 让bar中的某个菜单不可用（修改）并且移除单击事件
		$('#Tools12').removeClass('Tools12').addClass(
		'Tools12_disable').unbind("click");
	$('#Tools22').removeClass('Tools22').addClass(
			'Tools22_disable').unbind("click");	
});

function itemSeriesDetail(obj){
	 var param = {
			'clstrId':$(obj).find("#clstrId").text()
	};
	showContent('/series/toReadSeriesByClstrId',param);
}

//滚动条事件
$(document).ready(function () {
    $(".btable_div").scroll(function () {
        var left = $(this).scrollLeft();
        $(".htable_div").scrollLeft(left);
    });
});


//单击事件
function checkedClstrInfo(obj){
var	clstrId= $(obj).find("#clstrId").text();
$("#clstrIdInfo").val(clstrId);	

//让bar中的某个菜单可用（查看）
$('#Tools22').removeClass('Tools22_disable').addClass('Tools22').unbind("click").bind(
		'click',
		function() {
			//alert('d');	
			showContent('/series/toReadSeriesByClstrId?clstrId='
					+ clstrId);
		});
 
// 让bar中的某个菜单可用（修改）
<auchan:operauth ifAnyGrantedCode="112211996" >
$('#Tools12')
		.removeClass('Tools12_disable')
		.addClass('Tools12')
		.unbind("click")
		.bind(
				'click',
				function() {
					//alert('d');	
					showContent('/series/toUpdateSeries?clstrId='
							+clstrId);
				});
</auchan:operauth>
}



</script>


<!-- 分页属性 -->
 <input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
 <input type="hidden" id="clstrIdInfo">
 <div>
 <div class="htable_div">
			<table>
				<thead>
					<tr>
						<td><div class="t_cols align_center" style="width: 30px;">
							</div></td>
						<td><div class="t_cols" style="width: 70px;" ><auchan:i18n id="103002002"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 270px;"><auchan:i18n id="103002003"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 180px;"><auchan:i18n id="103002004"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="103002005"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 160px;"><auchan:i18n id="103002006"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="103002007"></auchan:i18n></div></td>
						<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="103002008"></auchan:i18n></div></td>						
						<td><div style="width: 16px;">&nbsp;</div></td>
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="btable_div" style="height: 509px;">
		
		
			<table class="single_tb w100" id='itemOrigin_tab_List'>
				<!--multi_tb为多选 width:1001px;-->
				 <c:forEach   items="${page.result}" var="itemClusterVO">
				<tr ondblclick="itemSeriesDetail(this)" onclick="checkedClstrInfo(this)">
					<td class="align_center" style="width: 30px;">
						</td>
					<td style="width: 71px;" id="clstrId" align="right">${itemClusterVO.clstrId }</td>
					<td style="width: 271px;"  title="<c:out value='${itemClusterVO.clstrName }' />">&nbsp;<c:out value="${itemClusterVO.clstrName }" /></td>
					<td style="width: 181px;">${itemClusterVO.catlgId }-${itemClusterVO.catlgName }</td>
					<td style="width: 81px;" align="right">${itemClusterVO.refItemNo } &nbsp;</td>
					<td style="width: 161px;" title="<c:out value='${itemClusterVO.refItemName }'/>"><c:out value="${itemClusterVO.refItemName }"/></td>
					<td style="width: 101px;"><auchan:getDictValue code='${itemClusterVO.clstrType }' mdgroup='ITEM_CLUSTER_CLSTR_TYPE' /></td>
					<td style="width: 101px;"><auchan:getDictValue code='${itemClusterVO.batchPriceChngInd }' mdgroup='ITEM_CLUSTER_BATCH_PRICE_CHNG_IND' /></td>					
					<td style="width: auto">&nbsp;</td>
				</tr>
				</c:forEach>
			</table>
		</div>
     </div>          
          <jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
               