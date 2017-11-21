<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />

<script type="text/javascript">
$(function(){
	//全选checkbox
	$(".checkAllStores").live("click",function(){
	    if(this.checked){
	        $(".checkstores:not(:disabled)").attr("checked",true);    
	    }else{
	        $(".checkstores:not(:disabled)").attr("checked",false);    
	    }
	});
	
	$(".checkstores:not(:disabled)").live("click",function(){
		var falg = true;
		$(".checkstores:not(:disabled)").each(function(){
			if(!this.checked){
				falg = false;
			}
		});
		if(falg){
			$(".checkAllStores").attr("checked",true);    
		}else{
			$(".checkAllStores").attr("checked",false);  
		}
		
	});
});

function addStoreGrpType(){
	var storeIdArray = new Array();
	$(".checkstores:checked").each(function(i){
		var storeId = $(this).attr("storeId");
		storeIdArray[i] = storeId;
	});

	if(storeIdArray.length==0){
		top.jWarningAlert('请选择要添加的门店');
	}else{
		//top.window.$.zWindow.close({"storeIdArray":storeIdArray});
		document.getElementById('contentIframe').contentWindow.addStoreSupMessReturn(storeIdArray);
	}
}

function cancel(n){
	//top.window.$.zWindow.close({"close":n});
	//top.closePopupWin();
}
</script>
<style type="text/css">
	input[type="checkbox"] {
		vertical-align: middle;
		margin-top: 5px;
	}
</style>
<div class="Panel_top">
	<span>选择门店</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="htable_div">
  <table>
         <thead>
         <tr>
         
             <td width="50px"><div class="t_cols align_center" style="width:50px;"><input type="checkbox" class="checkAllStores"></div></td>
             <td width="110px"><div class="t_cols align_center" style="width:110px;">门店名称<!--<div style="display:inline-block;width:10px;height:20px;"></div>--></div></td>
             <td width="130px"><div class="t_cols align_center" style="width:130px;">商品状态</div></td>
             <td width="270px"><div class="t_cols align_center" style="width:270px;">厂商</div></td>
             <td width="90px"><div class="t_cols align_center" style="width:90px;">正常售价</div></td>
             <td width="110px"><div class="t_cols align_center" style="width:110px;">正常进价</div></td>
             <td width="20px"></td>
         </tr>
     </thead>
  </table>
 </div>
  <div class="btable_div" style="height: 350px;">
     <table  class="single_tb" width="100%">
     		<c:if test="${ not empty storelist}">
				<c:forEach items="${storelist}" var="store" varStatus="sorenum">
			         <tr class="pricPromTr_click">
			             <td class="align_center" style="width:50px;"><div  style="width:51px;">
			            <%--  <c:choose>
							<c:when test="${ flag=='promART'}">
								<c:if test="${not empty store.promNo}">
									<input type="checkbox" class="checkstores" storeId='${store.storeNo}' disabled="disabled"/>
								</c:if>
								<c:if test="${empty store.promNo}">
									<input type="checkbox" class="checkstores" storeId='${store.storeNo}' />
								</c:if>
							</c:when>
							<c:otherwise> --%>
								<input type="checkbox" class="checkstores" storeId='${store.storeNo}' />
							<%-- </c:otherwise>
						</c:choose> --%>
			             </div></td>
			             <td width="110px"><div  style="width:110px;">${store.storeNo}-${store.storeName}<!--<div style="display:inline-block;width:10px;height:20px;"></div>--></div></td>
			             <td width="131px"><div  style="width:131px;">${store.status}-${store.itemStatusName }</div></td>
			             <td width="271px"><div  style="width:271px;">${store.mainComName}</div></td>
			             <td width="90px"><div  style="width:90px;">${store.normSellPrice}</div></td>
			             <td width="113px"><div  style="width:113px;">${store.normBuyPrice}</div></td>
			         </tr>
         		</c:forEach>
         </c:if>
     </table>    
 </div>
 
 
<div class="Panel_footer">
    <div class="PanelBtn">
        <span class="PanelBtn1" onclick="addStoreGrpType()">确定</span>
        <span class="PanelBtn2" onclick="closePopupWin()">取消</span>
    </div>
</div>
<div style="clear:both;"></div>
