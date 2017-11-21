<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ include file="/page/commons/taglibs.jsp"%>
 <script type="text/javascript">
 $(function(){
	 $("#Tools22").removeClass("Icon-size1 Tools22");
	 $("#Tools22").addClass("Icon-size1 Tools22_disable");
	 $("#Tools21").attr('class', "Icon-size1 Tools21_on");
	 $($("#Tools21").parent()).addClass("ToolsBg");
	 $(".single_tb .ptr:even").addClass("default_bg");
	 
	 $(".pricPromTr_click:even").addClass("default_bg");
	 
	 $(".showUnitName").bind("click",function(){
		 var isClose = $(this).hasClass("tr_close");
		 var unitNo = $("#unitNo").val();
		 if(isClose){
			$("td[name="+indexnum+"]").html("");
			var promNo = $(this).parents("tr").attr("promNo");
			var indexnum = $(this).parents("tr").attr("name");
			$.ajax({
				url: ctx + '/prom/nondm/art/searchUnitByPromNo?promNo='+promNo+'&unitNo='+unitNo,
		        type: "post",
		        dataType:"html",
		        success: function(data) {
		        	$("td[name="+indexnum+"]").html(data);
		        }
			});
		 }
	});
	 
 })
 
 
 $(".btable_div").scroll(function () {
	    var left = $(this).scrollLeft();
	    $(".htable_div").scrollLeft(left);
	});
   $(".pricPromTr_click").live("dblclick",function(){
	   var spromNo = $(this).attr("promno");
	   var index = $(this).attr("name");
	   var paramArray=new Array();
		var promNo = $("#promNo").val();
		var subjName = encodeURI($("#subjName").val());
		var CatlgId = $("#CatlgId").val();
		var unitType = $("#unitType").val();
		var unitNo=$("#unitNo").val();
		var promType  = $("#pricePromType").val();
		var buyBeginDateStart = $("#buyBeginDateStart").val();
		var buyBeginDateEnd = $("#buyBeginDateEnd").val();
		var buyEndDateStart = $("#buyEndDateStart").val();
		var buyEndDateEnd = $("#buyEndDateEnd").val();
		var promBeginDateStart = $("#promBeginDateStart").val();
		var promBeginDateEnd = $("#promBeginDateEnd").val();
		var promEndDateStart = $("#promEndDateStart").val();
		var promEndDateEnd = $("#promEndDateEnd").val();
		var pageNo = $("#pageNo").val();
		var pageSize = $("#pageSize").val();
		paramArray[0] =$.trim(promNo);
		paramArray[1] =encodeURI($.trim(subjName));
		paramArray[2] =$.trim(CatlgId);
		paramArray[3] =$.trim(unitType);
		paramArray[4] =$.trim(unitNo);
		paramArray[5] =$.trim(promType);
		paramArray[6] =buyBeginDateStart;
		paramArray[7] =buyBeginDateEnd;
		paramArray[8] =buyEndDateStart;
		paramArray[9] =buyEndDateEnd;
		paramArray[10] =promBeginDateStart;
		paramArray[11] =promBeginDateEnd;
		paramArray[12] =promEndDateStart;
		paramArray[13] =promEndDateEnd;
		paramArray[14] =index;
		top.grid_layer_open();

		//alet("3");
		//$.post(ctx + '/prom/nondm/art/detailARTPromo?paramArray='+paramArray,{/* paramArray:paramArray, */pageNo:pageNo,pageSize:pageSize,promNo:spromNo},function(data){
			//$('#content').html(data);
		//},'html');
		window.location.href=ctx + '/prom/nondm/art/detailARTPromo?paramArray='+paramArray+'&pageNo='+pageNo+'&pageSize='+pageSize+'&promNo='+spromNo;
   });
   $(".pricPromTr_click").live("click",function(){
	   	var promEnd = $(this).attr("promEnd");
	   	var promStart = $(this).attr("promStart");
		$("#Tools22").attr('class', "Icon-size1 Tools22");
		if(promEnd == '0'){
			$("#Tools12").removeClass("Tools12_disable");
			$("#Tools12").addClass("Icon-size1 Tools12");
		}else{
			$("#Tools12").removeClass("Icon-size1 Tools12");
			$("#Tools12").addClass("Tools12_disable ");
		}
		
		if(promStart=='0'){
			$("#Tools10").removeClass("Tools10_disable");
			$("#Tools10").addClass("Icon-size1 Tools10");
			
		}else{
			$("#Tools10").removeClass("Icon-size1 Tools10");
			$("#Tools10").addClass("Tools10_disable");
		}
		var index = $(this).attr("name");
		var spromNo = $(this).attr("promno");
	 	//跳转到详情页面
		$("#Tools22").live('click',function(){
			if($(this).hasClass("Tools22_disable")){return;};
			var paramArray=new Array();
			var promNo = $("#promNo").val();
			var subjName = encodeURI($("#subjName").val());
			var CatlgId = $("#CatlgId").val();
			var unitType = $("#unitType").val();
			var unitNo=$("#unitNo").val();
			var promType  = $("#pricePromType").val();
			var buyBeginDateStart = $("#buyBeginDateStart").val();
			var buyBeginDateEnd = $("#buyBeginDateEnd").val();
			var buyEndDateStart = $("#buyEndDateStart").val();
			var buyEndDateEnd = $("#buyEndDateEnd").val();
			var promBeginDateStart = $("#promBeginDateStart").val();
			var promBeginDateEnd = $("#promBeginDateEnd").val();
			var promEndDateStart = $("#promEndDateStart").val();
			var promEndDateEnd = $("#promEndDateEnd").val();
			var pageNo = $("#pageNo").val();
			var pageSize = $("#pageSize").val();
			paramArray[0] =$.trim(promNo);
			paramArray[1] =encodeURI($.trim(subjName));
			paramArray[2] =$.trim(CatlgId);
			paramArray[3] =$.trim(unitType);
			paramArray[4] =$.trim(unitNo);
			paramArray[5] =$.trim(promType);
			paramArray[6] =buyBeginDateStart;
			paramArray[7] =buyBeginDateEnd;
			paramArray[8] =buyEndDateStart;
			paramArray[9] =buyEndDateEnd;
			paramArray[10] =promBeginDateStart;
			paramArray[11] =promBeginDateEnd;
			paramArray[12] =promEndDateStart;
			paramArray[13] =promEndDateEnd;
			paramArray[14] =index;
			top.grid_layer_open();
			window.location.href=ctx + '/prom/nondm/art/detailARTPromo?paramArray='+paramArray+'&pageNo='+pageNo+'&pageSize='+pageSize+'&promNo='+spromNo;
			
		});
	 	
	 	
		$("#Tools12").die('click').live('click',function(){
			var promNo ="";
			var pass = true;
			$(".pricPromTr_click").each(function(){
				if($(this).hasClass("btable_checked")){
					promNo = $(this).attr("promNo");
				}
			});
			if(promNo == null && promNo == ""){
				top.jWarningAlert( '请选择一行数据！');
				pass = false;
				return;
			}
			
			if($(this).hasClass("Tools12_disable") ){
				pass = false;
				return;
			}
			if(pass){
				var artEditParamArray=new Array();
				var subjName = encodeURI($("#subjName").val());
				var paramPromNo = $("#promNo").val();
				var CatlgId = $("#CatlgId").val();
				var unitType = $("#unitType").val();
				var unitNo=$("#unitNo").val();
				var promType  = $("#pricePromType").val();
				var buyBeginDateStart = $("#buyBeginDateStart").val();
				var buyBeginDateEnd = $("#buyBeginDateEnd").val();
				var buyEndDateStart = $("#buyEndDateStart").val();
				var buyEndDateEnd = $("#buyEndDateEnd").val();
				var promBeginDateStart = $("#promBeginDateStart").val();
				var promBeginDateEnd = $("#promBeginDateEnd").val();
				var promEndDateStart = $("#promEndDateStart").val();
				var promEndDateEnd = $("#promEndDateEnd").val();
				artEditParamArray[0] =$.trim(paramPromNo);
				artEditParamArray[1] =encodeURI($.trim(subjName));
				artEditParamArray[2] =$.trim(CatlgId);
				artEditParamArray[3] =$.trim(unitType);
				artEditParamArray[4] =$.trim(unitNo);
				artEditParamArray[5] =$.trim(promType);
				artEditParamArray[6] =buyBeginDateStart;
				artEditParamArray[7] =buyBeginDateEnd;
				artEditParamArray[8] =buyEndDateStart;
				artEditParamArray[9] =buyEndDateEnd;
				artEditParamArray[10] =promBeginDateStart;
				artEditParamArray[11] =promBeginDateEnd;
				artEditParamArray[12] =promEndDateStart;
				artEditParamArray[13] =promEndDateEnd;
				artEditParamArray[14] =index;
				var artEditParamJson={};
				artEditParamJson.artEditParamArray = artEditParamArray;
				top.grid_layer_open();
				window.location.href=ctx + '/prom/nondm/art/editARTPromo?promNo='+promNo+'&paramArrayJson='+JSON.stringify(artEditParamJson);
			}
			
		});
		
		$("#Tools10").die('click').live('click',function(){
			var promNo ="";
			var pass = true;
			$(".pricPromTr_click").each(function(){
				if($(this).hasClass("btable_checked")){
					promNo = $(this).attr("promNo");
				}
			});
			if(promNo == null && promNo == ""){
				top.jWarningAlert('请选择一行数据！');
				pass = false;
				return;
			}
			
			if($(this).hasClass("Tools10_disable") ){
				pass = false;
				return;
			}
			
			if(pass){
				top.jConfirm("您确定要删除该条数据吗？", '提示消息',function(ret){
					if(ret){
						//删除数据的方法
						$.ajax({
							async : false,
							type : 'post',
							url : ctx + '/prom/nondm/art/deleteARTProm',
							data : {dmPromNo:promNo},
							success : function(data){
								top.jAlert(data.status, data.message, '消息提示');
								if (data.status == 'success') {
									$("#Tools12").removeClass("Icon-size1 Tools12").addClass("Tools12_disable");
									pageQuery(0);
								}
								
							}
						});
					}
				});
			}
		});
		
	 	
  });
   
   
  
</script>
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
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<%-- <input type="hidden" name="pageSize" id="pageSize" value="${page.pageSize }" /> --%>
 <div class="htable_div">
     <table>
         <thead>
         <tr>
             <td><div class="t_cols align_center" style="width:30px;">&nbsp;</div></td>
             <td><div class="t_cols align_center" style="width:72px;">促销期数</div></td>
             <td><div class="t_cols align_center" style="width:250px;">主题</div></td>
             <td><div class="t_cols align_center" style="width:120px;">课别</div></td>
             <td><div class="t_cols align_center" style="width:113px;">采购起始日期</div></td>
             <td><div class="t_cols align_center" style="width:113px;">采购结束日期</div></td>
             <td><div class="t_cols align_center" style="width:113px;">促销起始日期</div></td>
             <td><div class="t_cols align_center" style="width:113px;">促销结束日期</div></td>
              <td><div class="t_cols align_center" style="width:70px;">促销天数</div></td>
             <td><div style="width:19px;">&nbsp;</div></td>
         </tr>
     </thead>
  </table>
 </div>
 
 

 <div class="btable_div" style="height:509px;">
  <c:if test="${ not empty page.result}">
     <table  class="single_tb w100" id="listTable"><!--multi_tb为多选 width:1001px;-->
     	<c:forEach items="${page.result}" var="item" varStatus="num">
	         <tr class="pricPromTr_click" name="${num.index+1}" promNo="${item.promNo}" promEnd ="${item.promEnd }" promStart="${item.promStart}">
	             <td class="align_center tr_close showUnitName" style="width:30px;"></td>
	             <td style="width:73px;">${item.promNo }</td>
	             <td style="width:251px;">&nbsp;${item.subjName }</td>
	             <td style="width:121px;">${item.catlgId}-${item.catlgName}</td>
	             <td style="width:115px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.buyBeginDate }" /></td>
	             <td style="width:115px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.buyEndDate }" /></td>
	             <td style="width:115px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.promBeginDate }" /></td>
	             <td style="width:115px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${item.promEndDate }" /></td>
	             <td style="width:60px;" align="right">${item.promDays}</td>
	             <td style="width:auto">&nbsp;</td>
	         </tr>
	         <tr class="trSpecial Bar_off" style="height:auto;">
                 <td class="align_center" style="width:30px;"></td>
                 <td colspan="9" class="Black" style="white-space:normal;" name="${num.index+1}">
                     
                 </td>
                 <td class="temp">&nbsp;</td>
             </tr>
         </c:forEach>
     </table>    
     </c:if>
      <c:if test="${empty page.result}">
      	<table  class="single_tb w100"><!--multi_tb为多选 width:1001px;-->
	         <tr >
	         	<td colspan="11" class="align_center">糟糕，还没有数据,快去创建吧！</td>
	         </tr>
	    </table>
      </c:if>
 </div>
 <jsp:include page="/page/commons/pageSet2.jsp"></jsp:include>