<!-- DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />

<script type="text/javascript">

$(function(){
	//全选checkbox
	$(".checkAllItems").live("click",function(){
	    if(this.checked){
	        $(".checkItem:not(:disabled)").attr("checked",true);    
	    }else{
	        $(".checkItem:not(:disabled)").attr("checked",false);    
	    }
	});
	
	$(".checkItem:not(:disabled)").live("click",function(){
		var falg = true;
		$(".checkItem:not(:disabled)").each(function(){
			if(!this.checked){
				falg = false;
			}
		});
		if(falg){
			$(".checkAllItems").attr("checked",true);    
		}else{
			$(".checkAllItems").attr("checked",false);  
		}
		
	});
	
	
	
});

function addStoreGrpType(){
	var itemNoArray = new Array();
	var itemNameArray = new Array();
	$(".checkItem:checked").each(function(i){
		var itemNo = $(this).attr("itemNoVal");
		var itemName = $(this).attr("itemNameVal");
		itemNoArray[i] = itemNo;
		itemNameArray[i] = itemName;
	});
	
	var basicInfo = $("#basicInfo").val();
	if(itemNoArray.length==0){
		top.jWarningAlert('请选择要添加的商品');
	}else{
		//top.window.$.zWindow.close({"close":"confirm","itemNoArray":itemNoArray,"itemNameArray":itemNameArray});
		document.getElementById('contentIframe').contentWindow.addSelectedItemReturn(itemNoArray,itemNameArray,basicInfo);
	}
}

function cancel(n){
	//top.window.$.zWindow.close({"close":"close"});
	top.closePopupWin();
}
</script>
<input type ="hidden" id="basicInfo" value="${basiecInfo }"/>
<div class="Panel_top">
	<span>选择商品</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="htable_div">
     <table>
         <thead>
	         <tr>
	             <td><div class="t_cols align_center" style="width:50px;"><input type="checkBox" class="checkAllItems" ></div></td>
	             <td><div class="t_cols align_center" style="width:100px;">编号<!--<div style="display:inline-block;width:10px;height:20px;"></div>--></div></td>
	             <td><div class="t_cols align_center" style="width:240px;">商品名称</div></td>
	             <td><div style="width:50px;">&nbsp;</div></td>
	         </tr>
        </thead>
  </table>
 </div>
 <div class="btable_div" style="height: 350px;overflow-x:hidden;">
     <table  class="single_tb w400">
     	<c:forEach items="${itemList }" var="promItemVO">
			<tr class="pricPromTr_click">
			    <td class="align_center" style="width:50px;">
			    <div class="align_center" style="width:50px;">
			  <%-- 
		    		<c:if test=" ${flag=='promART'}"> --%>
				    	<%-- <c:choose>
							<c:when test="${ flag=='promART'}">
								<c:if test="${not empty promItemVO.promNo}">
									<input type="checkbox" class="checkItem" itemNoVal="${promItemVO.itemNo }" itemNameVal="${promItemVO.itemName }" disabled="disabled">
								</c:if>
								<c:if test="${empty promItemVO.promNo}">
									<input type="checkbox" class="checkItem" itemNoVal="${promItemVO.itemNo }" itemNameVal="${promItemVO.itemName }">
								</c:if>
							</c:when>
							<c:otherwise> --%>
								<input type="checkbox" style="margin-top:5px;" class="checkItem " itemNoVal="${promItemVO.itemNo }" itemNameVal="${promItemVO.itemName }">
							<%-- </c:otherwise>
						</c:choose> --%>
					<%-- </c:if>
					<c:if test="${empty flag}">
					 	<input type="checkbox" class="checkItem" itemNoVal="${promItemVO.itemNo }" itemNameVal="${promItemVO.itemName }">${flag }
					</c:if> --%>
			    	
			    </div>
			    </td>
			    <td style="width:102px;"><div  style="width:102px;">${promItemVO.itemNo }</div></td>
			    <td style="width:243px;">${promItemVO.itemName }</td>
			</tr>
     	</c:forEach>
     </table>    
 </div>
<div class="Panel_footer">
        <span class="PanelBtn1" onclick="addStoreGrpType()">确定</span>
        <span class="PanelBtn2" onclick="closePopupWin()">取消</span>
</div>
<!-- <div style="clear:both;"></div> -->
