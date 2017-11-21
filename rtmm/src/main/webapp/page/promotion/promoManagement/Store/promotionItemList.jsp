<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
 /* .btable_div {
     overflow-x:hidden;
 } */
 .trSpecial table tr {
     border-bottom:0;
 }
 .temp {
    width:150px;
}

.btable_div .innerTb {
    width: 99%;
}
</style>
<script type="text/javascript"> 

$(function(){
	$(".single_tb .ptr:even").addClass("default_bg");
	$("#Tools22").removeClass("Icon-size1 Tools22");
	$("#Tools22").addClass("Icon-size1 Tools22_disable");
	$("#Tools12").removeClass("Icon-size1 Tools12");
	$("#Tools12").addClass("Tools12_disable");
	$(".btable_div").scroll(function () {
	    var left = $(this).scrollLeft();
	    $(".htable_div").scrollLeft(left);
	});


$(".pricPromTr_click").unbind("dblclick").bind("dblclick",function(){
	top.grid_layer_open();
  	var promNoSel=$(this).find("input[name='promNo']").val();
	var storeNoSel=$(this).find("input[name='storeNo']").val();
   
		var index = $(this).attr("name").split("-");
		
	 	//跳转到详情页面
			var paramArray=new Array();
			var promNo = $("#promNo").val();
			var subjName = encodeURI($("#subjName").val());
			var catlgId = $("#catlgId").val();
			var promPartyParam = $("#promParty").val();
			var storeNo=$("#storeNo").val();
			var unitType = $("#unitType").val();
			var unitNo=$("#promUnitNo").val();
			var buyBeginDateStart = $("#beginDate1").val();
			var buyBeginDateEnd = $("#beginDate2").val();
			var buyEndDateStart = $("#endDate1").val();
			var buyEndDateEnd = $("#endDate2").val();
			var promBeginDateStart = $("#promBeginDate1").val();
			var promBeginDateEnd = $("#promBeginDate2").val();
			var promEndDateStart = $("#promEndDate1").val();
			var promEndDateEnd = $("#promEndDate2").val();
			var pageNo = $("#pageNo").val();
			var pageSize = $("#pageSize").val();
			
			paramArray[0] =promNo;
			paramArray[1] =encodeURI(subjName);
			paramArray[2] =catlgId;
			paramArray[3] =unitType;
			paramArray[4] =unitNo;
			paramArray[5] ='promType';
			paramArray[6] =buyBeginDateStart;
			paramArray[7] =buyBeginDateEnd;
			paramArray[8] =buyEndDateStart;
			paramArray[9] =buyEndDateEnd;
			paramArray[10] =promBeginDateStart;
			paramArray[11] =promBeginDateEnd;
			paramArray[12] =promEndDateStart;
			paramArray[13] =promEndDateEnd;
			paramArray[14] =index[0];
			paramArray[15] =storeNo;
			paramArray[16] =promPartyParam;
			window.location.href=ctx + '/prom/nondm/store/detail?paramArray='+paramArray+'&pageNo='+pageNo+'&pageSize='+pageSize+'&promNo='+promNoSel+'&storeNo='+storeNoSel;
		
});
$(".pricPromTr_click").unbind("click").bind("click",function(){
   	var promNoSel=$(this).find("input[name='promNo']").val();
	var storeNoSel=$(this).find("input[name='storeNo']").val();
   	var promParty=$(this).find("input[name='promPartyInput']").val();
   	var promEnd=$(this).find("input[name='promEnd']").val();
	var promBegin=$(this).find("input[name='promBegin']").val();
   	
   	
	if(promParty=='L'&&promEnd==0)
		{
			$("#Tools22").attr('class', "Icon-size1 Tools22");
			$("#Tools12").removeClass("Tools12_disable");
			$("#Tools12").addClass("Icon-size1 Tools12");
		}
	else
		{
			$("#Tools22").attr('class', "Icon-size1 Tools22");
			$("#Tools12").removeClass("Icon-size1 Tools12");
			$("#Tools12").addClass("Tools12_disable");
		}
	if(promParty=='L'&&promBegin==0)
	{
		$("#Tools10").removeClass("Tools10_disable");
		$("#Tools10").addClass("Icon-size1 Tools10");
	}
    else
	{
		$("#Tools10").removeClass("Icon-size1 Tools10");
		$("#Tools10").addClass("Tools10_disable");
		$("#Tools10").unbind("click");
	}
$("#Tools10:not('.Tools10_disable')").unbind("click").bind('click',function(){
	    top.jConfirm('你确定需要删除该条促销信息吗','提示消息',function(ret){
		if(ret){
		 $.ajax({
 		        //async:false,
		    	url: ctx + '/prom/nondm/store/delPromotionItem?ti='+(new Date()).getTime(),
				type: "post",
				dataType:"json",
				data : {'promNo':promNoSel},
				success: function(result) {
	   	    			top.jAlert('warning', result.message, '提示消息',function(){
	   	    				pageQuery();
	   	    			});
	   	    			
				}
		    });
		}
	    });
	});
	var index = $(this).attr("name").split("-");
		
//跳转到详情页面
$("#Tools22:not('.Tools22_disable')").unbind("click").bind('click',function(){
		top.grid_layer_open();
		var paramArray=new Array();
		var promNo = $("#promNo").val();
		var promPartyParam = $("#promParty").val();
		var subjName = encodeURI($("#subjName").val());
		var catlgId = $("#catlgId").val();
		var storeNo=$("#storeNo").val();
		var unitType = $("#unitType").val();
		var unitNo=$("#promUnitNo").val();
		var buyBeginDateStart = $("#beginDate1").val();
		var buyBeginDateEnd = $("#beginDate2").val();
		var buyEndDateStart = $("#endDate1").val();
		var buyEndDateEnd = $("#endDate2").val();
		var promBeginDateStart = $("#promBeginDate1").val();
		var promBeginDateEnd = $("#promBeginDate2").val();
		var promEndDateStart = $("#promEndDate1").val();
		var promEndDateEnd = $("#promEndDate2").val();
		var pageNo = $("#pageNo").val();
		var pageSize = $("#pageSize").val();
		
		paramArray[0] =promNo;
		paramArray[1] =encodeURI(subjName);
		paramArray[2] =catlgId;
		paramArray[3] =unitType;
		paramArray[4] =unitNo;
		paramArray[5] ='promType';
		paramArray[6] =buyBeginDateStart;
		paramArray[7] =buyBeginDateEnd;
		paramArray[8] =buyEndDateStart;
		paramArray[9] =buyEndDateEnd;
		paramArray[10] =promBeginDateStart;
		paramArray[11] =promBeginDateEnd;
		paramArray[12] =promEndDateStart;
		paramArray[13] =promEndDateEnd;
		paramArray[14] =index[0];
		paramArray[15] =storeNo;
		paramArray[16] =promPartyParam;
		
		window.location.href=ctx + '/prom/nondm/store/detail?paramArray='+paramArray+'&pageNo='+pageNo+'&pageSize='+pageSize+'&promNo='+promNoSel+'&storeNo='+storeNoSel;
	});
   $("#Tools12:not('.Tools12_disable')").unbind("click").bind("click",function(){
	    var promNo=$(".btable_checked").find("input[name='promNo']").val();
		var paramArray=new Array();
		var promNoSel = $("#promNo").val();
		var subjName = encodeURI($("#subjName").val());
		var catlgId = $("#catlgId").val();
		var promPartyParam = $("#promParty").val();
		var storeNo=$("#storeNo").val();
		var unitType = $("#unitType").val();
		var unitNo=$("#promUnitNo").val();
		var buyBeginDateStart = $("#beginDate1").val();
		var buyBeginDateEnd = $("#beginDate2").val();
		var buyEndDateStart = $("#endDate1").val();
		var buyEndDateEnd = $("#endDate2").val();
		var promBeginDateStart = $("#promBeginDate1").val();
		var promBeginDateEnd = $("#promBeginDate2").val();
		var promEndDateStart = $("#promEndDate1").val();
		var promEndDateEnd = $("#promEndDate2").val();
		var pageNo = $("#pageNo").val();
		var pageSize = $("#pageSize").val();
		
		paramArray[0] =promNoSel;
		paramArray[1] =encodeURI(subjName);
		paramArray[2] =catlgId;
		paramArray[3] =unitType;
		paramArray[4] =unitNo;
		paramArray[5] ='promType';
		paramArray[6] =buyBeginDateStart;
		paramArray[7] =buyBeginDateEnd;
		paramArray[8] =buyEndDateStart;
		paramArray[9] =buyEndDateEnd;
		paramArray[10] =promBeginDateStart;
		paramArray[11] =promBeginDateEnd;
		paramArray[12] =promEndDateStart;
		paramArray[13] =promEndDateEnd;
		paramArray[14] ='';
		paramArray[15] =storeNo;
		paramArray[16] =promPartyParam;
	if(promNo&&promNo!=""){
	   top.grid_layer_open();
	   $(top.document).find("#contentIframe").attr("src",ctx + '/prom/nondm/store/edit?promNo='+promNo+'&paramArray='+paramArray+'&pageNo='+pageNo+'&pageSize='+pageSize);
	}
   });
});


$(".showUnitName").unbind("click").bind("click",function(){
	 
	 var isClose = $(this).hasClass("tr_close");
	 if(isClose){
		$("td[name="+indexnum+"]").html("");
		var promNo = $(this).parents("tr").find("input[name='promNo']").val();
		var storeNo = $(this).parents("tr").find("input[name='storeNo']").val();
		var indexnum = $(this).parents("tr").attr("name").split("-")[0];
		var unitNo=$("#promUnitNo").val();
		$.ajax({
			url: ctx + '/prom/nondm/store/searchUnitByPromNo?promNo='+promNo+'&storeNo='+storeNo+'&unitNo='+unitNo,
	        type: "post",
	        dataType:"html",
	        success: function(data) {
	        	$("td[name="+indexnum+"]").html(data);
	        }
		});
	 }
});
});
function checkAll(chk)
{
	$('input[name="promNoAndstoreNo"]').each(function() {
		if(chk.checked)
			{
    	      $(this).attr("checked",true);
			}
		else
			{
			 $(this).attr("checked",false);
			}
 });
}
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />

<div class="btable_div" style="height:490px;">
    <table  class="single_tb w100"><!--multi_tb为多选 width:1001px;-->
        <c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item" varStatus="num">
        <tr class="pricPromTr_click ptr" name="${num.index+1}-${item.promUnitNo }-${item.unitType}">
            <input name="promEnd"  value="${item.promEnd }" type="hidden" />
            <input name="promBegin"  value="${item.promBegin }" type="hidden" />
            <input name="storeNo"  value="${item.storeNo}" type="hidden" />
            <td class="align_center tr_close showUnitName" style="width:30px;"></td>
            <td align="left" style="width:76px;">&nbsp;${item.promNo}<input name="promNo"  value="${item.promNo}" type="hidden" /></td>
            <td align="left" style="width:136px;" title="${item.subjName}">&nbsp;${item.subjName}</td>
            <td align="left"  style="width:81px;" title="${item.catlgId}-${item.catlgName}">&nbsp;${item.catlgId}-${item.catlgName}</td>
            <td align="left" style="width:101px;">&nbsp;<c:if test="${item.promParty=='L'}">L-门店</c:if><c:if test="${item.promParty=='S'}">S-采购</c:if> <input name="promPartyInput"  value="${item.promParty}" type="hidden" /></td>
            <td align="left" style="width:101px;" title="${item.storeNo}-${item.storeName}">&nbsp;${item.storeNo}-${item.storeName}</td>
            <td align="left" style="width:101px;">&nbsp;<c:if test="${item.beginDate!=''}"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.beginDate }" /></c:if> </td>
            <td align="left" style="width:101px;">&nbsp;<c:if test="${item.endDate!=''}"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.endDate }" /></c:if> </td>
            <td align="left" style="width:101px;">&nbsp;<c:if test="${item.promBeginDate !=''}"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.promBeginDate }" /></c:if></td>
            <td align="left" style="width:101px;">&nbsp;<c:if test="${item.promEndDate!=''}"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.promEndDate }" /></c:if></td>
            <td align="right" style="width:75px;">&nbsp;${item.promDays}</td>
            <td align="left" style="width:auto">&nbsp;</td>
        </tr>
         <tr class="trSpecial Bar_off" style="height:auto;">
                 <td class="align_center" style="width:30px;"></td>
                 <td colspan="11" class="Black" style="white-space:normal;" name="${num.index+1}">
                 </td>
                 <td style="width:500px;">&nbsp;</td>
             </tr>
       </c:forEach>
       </c:if>
    </table>    
</div>
<jsp:include page="/page/commons/pageSet2.jsp"></jsp:include>


