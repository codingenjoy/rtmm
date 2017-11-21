<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />

<script type="text/javascript">

$(function(){
	//全选checkbox
	$(".checkAllItems").die("click").live("click",function(){
	    if(this.checked){
	        $(".checkItem").attr("checked",true);    
	    }else{
	        $(".checkItem").attr("checked",false);    
	    }
	});
	
	$('.checkItem').die("click").live("click",function(){
  	  var flag=true;
  	  $.each($('.checkItem'),function(i,val){
			if($(val).attr('checked')==undefined){	
			flag=false;
			}
		});
  	  if(flag){
  		  $('.checkAllItems').attr('checked','checked');
  	  }
  	  else{
  		  $('.checkAllItems').removeAttr('checked');
  	  }
    });
});


function addItemStoreSupplier(){
	var itemArr=[];
	var itemStorArr=[];
	$(".checkItem:checked").each(function(i){
		var itemNo = $(this).parent().parent().find("input[name='itemNo']").val();
		var itemName = $(this).parent().parent().find("input[name='itemName']").val();
		var mainComName = $(this).parent().parent().find("input[name='mainComName']").val();
		var normBuyPrice = $(this).parent().parent().find("input[name='normBuyPrice']").val();
		var normSellPrice = $(this).parent().parent().find("input[name='normSellPrice']").val();
		var netCost=$(this).parent().parent().find("input[name='netCost']").val();
	    var vatVal=$(this).parent().parent().find("input[name='vatVal']").val();
	    var buyWhen=$(this).parent().parent().find("input[name='buyWhen']").val();
	    var buyPriceLimit=$(this).parent().parent().find("input[name='buyPriceLimit']").val();
	    var promBuyPrice='';
		var promSellPrice='';
		var stMainSupNo=$(this).parent().parent().find("input[name='stMainSupNo']").val();
		var status=$(this).parent().parent().find("input[name='status']").val();
		var buyMethd=$(this).parent().parent().find("input[name='buyMethd']").val();
		var prcssType=$(this).parent().parent().find("input[name='prcssType']").val();
		var itemJson={'itemNo':itemNo,'netCost':netCost,'vatVal':vatVal,'itemName':itemName,'mainComName':mainComName,'promSupNo':stMainSupNo,'normalBuyPrice':normBuyPrice,'promBuyPrice':promBuyPrice,'normalSalePrice':normSellPrice,'promSellPrice':promSellPrice,'buyWhen':buyWhen,'buyPriceLimit':buyPriceLimit,'status':status,'buyMethd':buyMethd,'prcssType':prcssType,'priceRange':"",'netProfit':""};
		itemArr.push(itemJson);
		if(buyPriceLimit==""){
			buyPriceLimit=null;
		}
		var itemStoreJson={'itemNo':itemNo,'netCost':netCost,'vatVal':vatVal,'itemName':itemName,'mainComName':mainComName,'stMainSupNo':stMainSupNo,'normBuyPrice':normBuyPrice,'promBuyPrice':null,'normSellPrice':normSellPrice,'promSellPrice':null,'buyWhen':buyWhen,'buyPriceLimit':buyPriceLimit,'status':status,'buyMethd':buyMethd,'prcssType':prcssType};
		itemStorArr.push(itemStoreJson);
	});
	if(itemArr.length>0){
	    //top.window.$.zWindow.close({"close":2,"itemArr":itemArr});
		document.getElementById('contentIframe').contentWindow.addDelItemReturn(itemArr,itemStorArr);

	}else{
		top.jWarningAlert('请选择要添加的商品!');
	}
}
function cancel(n){
	top.window.$.zWindow.close({"close":n});
}
</script>
<div class="Panel_top">
	<span>添加商品</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
<div class="htable_div">
     <table>
         <thead>
         <tr>
         
             <td><div class="t_cols align_center" style="width:30px;"><input class="checkAllItems" type="checkbox" ></div></td>
             <td><div class="t_cols align_center" style="width:70px;">货号</div></td>
             <td><div class="t_cols align_center" style="width:180px;">商品名称</div></td>
             <td><div class="t_cols align_center" style="width:120px;">公司名称</div></td>
             <td><div class="t_cols align_center" style="width:80px;">正常进价</div></td>
             <td><div class="t_cols align_center" style="width:100px;">正常售价</div></td>
         </tr>
     </thead>
  </table>
 </div>
  <div class="btable_div" style="height: 350px;">
     <table  class="single_tb w600">
          <c:forEach items="${itemList}" var="item">
         <tr class="pricPromTr_click">
             <td class="align_center" style="width:30px;"><input class="checkItem" type="checkbox" value="${item.itemNo }"> </td>
             <td><div class="align_center" style="width:70px;">${item.itemNo }</div></td>
             <td><div class="align_center" style="width:180px;" title="${item.itemName }">${item.itemName }</div></td>
             <td><div class="align_center" style="width:120px;" title="${item.mainComName }">${item.mainComName }</div></td>
             <td><div class="align_center" style="width:80px;">${item.normBuyPrice }</div></td>
             <td><div class="align_center" style="width:100px;">${item.normSellPrice }</div></td>
             <input type="hidden" name="itemNo" value="${item.itemNo }" />
             <input type="hidden" name="itemName" value="${item.itemName }"/>
             <input type="hidden"  name="mainComName" value="${item.mainComName }"/>
             <input type="hidden" name="normBuyPrice" value="${item.normBuyPrice }" />
             <input type="hidden" name="normSellPrice" value="${item.normSellPrice }"/>
             <input name="stMainSupNo" type="hidden" value="${item.stMainSupNo }" />
             <input name="netCost" type="hidden" value="${item.netCost }" />
             <input name="vatVal" type="hidden" value="${item.vatVal }" />
             <input name="buyPriceLimit" type="hidden" value="${item.buyPriceLimit }" />
             <input name="buyWhen" type="hidden" value="${item.buyWhen }" />
             <input name="status" type="hidden" value="${item.status }" />
             <input name="buyMethd" type="hidden" value="${item.buyMethd }" />
             <input name="prcssType" type="hidden" value="${item.prcssType }" />
         </tr>
         </c:forEach>
        
     </table>    
 </div>
 </div>
 
<div class="Panel_footer">
    <div class="PanelBtn">
        <span class="PanelBtn1" onclick="addItemStoreSupplier()">确定</span>
        <span class="PanelBtn2" onclick="closePopupWin()">取消</span>
    </div>
</div>
<div style="clear:both;"></div>
