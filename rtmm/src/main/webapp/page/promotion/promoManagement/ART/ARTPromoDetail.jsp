<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<%-- <link rel="stylesheet" type="text/css" href="${ctx}/shared/js/loading/loading.css" /> --%>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<link href="${ctx}/shared/js/freezenColums/f.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/shared/js/freezenColums/f.js" type="text/javascript"></script>
<%-- <script type="text/javascript" src="${ctx}/shared/js/loading/loading.js" charset="utf-8"></script> --%>
<script type="text/javascript" src="${ctx}/shared/js/common.js" charset="utf-8"></script>	
<script type="text/javascript">

/* 屏蔽backspace、F5,F4为刷新 */
document.onkeydown = function(e) {
	/* var ev = document.all ? window.event : e;
	ev.cancelBubble = true; */
	var e = e || window.event || arguments.callee.caller.arguments[0];
	var d = e.srcElement || e.target;
	if (e.keyCode && e.keyCode == 115) {
		e.keyCode=0;
		e.returnValue=false;
		$('#forwardForm').submit();
		return false;
	}
	if (e.keyCode && e.keyCode == 116) {
		e.keyCode=0;
		return false;
	}
	if (e && e.keyCode == 8) {
		if(d.tagName.toUpperCase() == 'INPUT' && d.readOnly == true){
			return false;
		}else if(d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA'){
			return true;	
		}else{
			return false;
		}
	}
};
	Array.prototype.unique = function () {
	    var temp = new Array();
	      this.sort();
	      for(i = 0; i < this.length; i++) {
	          if( this[i] == this[i+1]) {
	            continue;
	        }
	          temp[temp.length]=this[i];
	      }
	      return temp;
	  
	}
	var unitTypeList =new Array();
	var unitNoList = new Array();
	var itemsArrays = new Array();
	$(function() {
		/* for (var layer = 0; layer < 10; layer++) {
			top.grid_layer_close();
		} */
		
		var promEnd = $("#promEnd").val();
	   	var promStart = $("#promStart").val();
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
		
		$("#Tools11").removeClass("sh_newMac Tools11_disable");
		$("#Tools11").addClass("Icon-size1 Tools11");
		$("#Tools21").attr('class', "Icon-size1 Tools21");
		$("#Tools22").attr('class', "Icon-size1 Tools22");
		$($("#Tools22").parent()).addClass("ToolsBg");
		$("input").each(function (){
			$(this).attr("readonly","readonly");
		});
		$("#Tools11").live("click",function(){
			window.location.href=ctx + '/prom/nondm/art/createARTPromo';
		});
		/* $("#Tools12").live("click",function(){
			window.location.href=ctx + '/prom/nondm/art/editARTPromo';
		}); */
		$("#Tools21").live("click",function(){
			var pageSizeList =$("#pageSizeList").val();
			var pageNoList = $("#pageNoList").val();
			var obj = "${paramArray}";
			var array = obj.split(",");
			var subjName = encodeURI(array[1]);
			array[1] = encodeURI(subjName);
			window.location.href=ctx + '/prom/nondm/art/ARTPromo?paramArray='+array+'&pageNoList='+pageNoList+'&pageSizeList='+pageSizeList;
		});
		 $(".pro_store_tb").scroll(function () {
             var left = $(this).scrollLeft();
             $(".zt_tit").scrollLeft(left);
         });
		
		 ItemsStoreArray = ${initJsonArray};
		 showItemStore(ItemsStoreArray);
		 showUnitTypSelect(ItemsStoreArray);
		 top.grid_layer_forceClose();
	});
	
	$("#unitType").live("change",function(){
		top.grid_layer_open();
		$("#storeHead").html("");
		$("#storebody").html("");
		$(".pro_store_items").html("");
		/* $("#memo").val("");
		$("#promActvy").val("");
		$("#pmGiftHint").val(""); */
		var unitType = $(this).val();
		var num = 0;
		var ifirstItemNo="";
		var selectUnitNo = "<option value=''>全部</option>"; 
		for (var w = 0; w < unitNoList.length; w++) {
			var unitNoStr = unitNoList[w];
			var unitNoStrArray = unitNoStr.split("@");
			if(unitType !=null && unitType !=""){
				if(unitNoStrArray[2] ==unitType ){
					selectUnitNo+="<option value="+unitNoStrArray[0]+" type="+unitNoStrArray[2]+">"+unitNoStrArray[0]+"-"+unitNoStrArray[1]+"</option>";
				}
			}else{
				selectUnitNo+="<option value="+unitNoStrArray[0]+" type="+unitNoStrArray[2]+">"+unitNoStrArray[0]+"-"+unitNoStrArray[1]+"</option>";
			}
			
		}
		$("#unitNo").html(selectUnitNo);
		
		//显示商品
		for (var i = 0; i < itemsArrays.length; i++) {
			var item_on ="";
			var itemsStrArray = itemsArrays[i].split("@");
			var ijsonItemNo = itemsStrArray[0];
			var	ijsonUnitNo = itemsStrArray[1];
			var	ijsonCatlgId = itemsStrArray[2];
			var	ijsonUnitType =itemsStrArray[3];
			var	ijsonItemName =itemsStrArray[4];
			
			if(unitType !=null && unitType !=""){
				if(ijsonUnitType == unitType){
					if(num==0){
						item_on ="item_on";
						ifirstItemNo = ijsonItemNo;
						num++;
					}
					$(".pro_store_items").append("<div class='item addItems "+item_on+"' itemNoValue='"+ijsonItemNo+"' unitNoValue='"+ijsonUnitNo+"' catlgIdValue='"+ijsonCatlgId+"' unitType='"+ijsonUnitType+"'><span class='pstb_1'>"+ijsonItemNo+"-"+ijsonItemName+"</span></div>");
				}
			}else{
				if(num==0){
					item_on ="item_on";
					ifirstItemNo = ijsonItemNo;
					num++;
				}
				$(".pro_store_items").append("<div class='item addItems "+item_on+"' itemNoValue='"+ijsonItemNo+"' unitNoValue='"+ijsonUnitNo+"' catlgIdValue='"+ijsonCatlgId+"' unitType='"+ijsonUnitType+"'><span class='pstb_1'>"+ijsonItemNo+"-"+ijsonItemName+"</span></div>");
			}
			
		}
		
		for (var y = 0; y < ItemsStoreArray.length; y++) {
		 	var itemsStoreJson = ItemsStoreArray[y];
		 	var sjsonUnitNo = itemsStoreJson.unitNo;
		 	var sjsonUnitType = itemsStoreJson.unitType;
		 	var sjsonCatlgId = itemsStoreJson.catlgId;
	 		var storeArray = itemsStoreJson.storeArray;
	 		for (var j = 0; j < storeArray.length; j++) {
	 			var store = storeArray[j];
	 			var sjsonItemNo = store.itemNo;
	 			if(ifirstItemNo == sjsonItemNo){
       		    	var num1 = parseInt(Math.random()*100000);
       		    	appendShopBodyTable(store,num1,sjsonUnitType,sjsonUnitNo,sjsonCatlgId);
    				appendShopHeadTable(store,num1,sjsonUnitType,sjsonUnitNo,sjsonCatlgId);
					
	 			}
	 		}
		}
		
		
		var sotreHeadEndStr ="";
		sotreHeadEndStr+=" <tr><td style='width: 30px;'><div style='width: 30px;'>&nbsp;</div></td>";
		sotreHeadEndStr+=" <td><div style='width: 80px;'>&nbsp;</div></td><td><div style='width: 110px;'>&nbsp;</div></td></tr>";
		$("#storeHead").append(sotreHeadEndStr);
		scrollUnit();
		top.grid_layer_close();
		
	})
	
	$("#unitNo").live("change",function(){
		top.grid_layer_open();
		$("#storeHead").html("");
		$("#storebody").html("");
		$(".pro_store_items").html("");
		/* $("#memo").val("");
		$("#promActvy").val("");
		$("#pmGiftHint").val(""); */
		var unitNo = $(this).val();
		var num = 0;
		var ifirstItemNo="";
		var unitType = $("#unitType").val();
		/* for (var w = 0; w < unitNoList.length; w++) {
			var unitNoStr = unitNoList[w];
			var unitNoStrArray = unitNoStr.split("@");
			if(unitNoStrArray[0] ==unitNo ){
				$("#memo").val(unitNoStrArray[5]);
				$("#promActvy").val(unitNoStrArray[3]);
				$("#pmGiftHint").val(unitNoStrArray[4]);
			}
		} */
		
		//判断
		//显示商品
		for (var i = 0; i < itemsArrays.length; i++) {
			var item_on ="";
			var itemsStrArray = itemsArrays[i].split("@");
			var ijsonItemNo = itemsStrArray[0];
			var	ijsonUnitNo = itemsStrArray[1];
			var	ijsonCatlgId = itemsStrArray[2];
			var	ijsonUnitType =itemsStrArray[3];
			var	ijsonItemName =itemsStrArray[4];
			
			if(unitType !="" && unitNo !=""){
				if(ijsonUnitType == unitType && ijsonUnitNo == unitNo){
					if(num==0){
						item_on ="item_on";
						ifirstItemNo = ijsonItemNo;
						num++;
					}
					$(".pro_store_items").append("<div class='item addItems "+item_on+"' itemNoValue='"+ijsonItemNo+"' unitNoValue='"+ijsonUnitNo+"' catlgIdValue='"+ijsonCatlgId+"' unitType='"+ijsonUnitType+"'><span class='pstb_1'>"+ijsonItemNo+"-"+ijsonItemName+"</span></div>");
				}
				
			}
			
			if(unitType !="" && unitNo ==""){
				if(ijsonUnitType == unitType){
					if(num==0){
						item_on ="item_on";
						ifirstItemNo = ijsonItemNo;
						num++;
					}
					$(".pro_store_items").append("<div class='item addItems "+item_on+"' itemNoValue='"+ijsonItemNo+"' unitNoValue='"+ijsonUnitNo+"' catlgIdValue='"+ijsonCatlgId+"' unitType='"+ijsonUnitType+"'><span class='pstb_1'>"+ijsonItemNo+"-"+ijsonItemName+"</span></div>");
				}
				
			}
			
			if(unitType =="" && unitNo !=""){
				if(ijsonUnitNo == unitNo){
					if(num==0){
						item_on ="item_on";
						ifirstItemNo = ijsonItemNo;
						num++;
					}
					$(".pro_store_items").append("<div class='item addItems "+item_on+"' itemNoValue='"+ijsonItemNo+"' unitNoValue='"+ijsonUnitNo+"' catlgIdValue='"+ijsonCatlgId+"' unitType='"+ijsonUnitType+"'><span class='pstb_1'>"+ijsonItemNo+"-"+ijsonItemName+"</span></div>");
				}
			}
			
			if(unitType =="" && unitNo ==""){
				if(num==0){
					item_on ="item_on";
					ifirstItemNo = ijsonItemNo;
					num++;
				}
				$(".pro_store_items").append("<div class='item addItems "+item_on+"' itemNoValue='"+ijsonItemNo+"' unitNoValue='"+ijsonUnitNo+"' catlgIdValue='"+ijsonCatlgId+"' unitType='"+ijsonUnitType+"'><span class='pstb_1'>"+ijsonItemNo+"-"+ijsonItemName+"</span></div>");
			}
			
			
		}
		
		for (var y = 0; y < ItemsStoreArray.length; y++) {
		 	var itemsStoreJson = ItemsStoreArray[y];
		 	var sjsonUnitNo = itemsStoreJson.unitNo;
		 	var sjsonUnitType = itemsStoreJson.unitType;
		 	var sjsonCatlgId = itemsStoreJson.catlgId;
	 		var storeArray = itemsStoreJson.storeArray;
	 		for (var j = 0; j < storeArray.length; j++) {
	 			var store = storeArray[j];
	 			var sjsonItemNo = store.itemNo;
	 			var sjsonItemName = store.itemName;
	 			if(ifirstItemNo == sjsonItemNo){
       		    	var num1 = parseInt(Math.random()*100000);
       		    	appendShopBodyTable(store,num1,sjsonUnitType,sjsonUnitNo,sjsonCatlgId);
    				appendShopHeadTable(store,num1,sjsonUnitType,sjsonUnitNo,sjsonCatlgId);
					
	 			}
	 		}
		}
		
		
		var sotreHeadEndStr ="";
		sotreHeadEndStr+=" <tr><td style='width: 30px;'><div style='width: 30px;'>&nbsp;</div></td>";
		sotreHeadEndStr+=" <td><div style='width: 80px;'>&nbsp;</div></td><td><div style='width: 110px;'>&nbsp;</div></td></tr>";
		$("#storeHead").append(sotreHeadEndStr);
		scrollUnit();
		top.grid_layer_close();
	});
	
	$(".addItems").live("click",function(){
		var isOff = $(this).hasClass("item_on");
		if(!isOff){
			top.grid_layer_open();
			$("#storeHead").html("");
			$("#storebody").html("");
			$(".pro_store_items").find(".item_on").removeClass("item_on");
			$(this).removeClass("item_on").addClass("item_on");
			var unitype = $(this).attr("unittype");
			var catlgId =$(this).attr("catlgidvalue");
			var unitNo=$(this).attr("unitnovalue");
			var itemNo =$(this).attr("itemnovalue");
			for (var y = 0; y < ItemsStoreArray.length; y++) {
			 	var itemsStoreJson = ItemsStoreArray[y];
			 	var sjsonUnitNo = itemsStoreJson.unitNo;
			 	var sjsonUnitType = itemsStoreJson.unitType;
			 	var sjsonCatlgId = itemsStoreJson.catlgId;
		 		var storeArray = itemsStoreJson.storeArray;
		 		for (var j = 0; j < storeArray.length; j++) {
		 			var store = storeArray[j];
		 			var sjsonItemNo = store.itemNo;
		 			var sjsonItemName = store.itemName;
		 			if(itemNo == sjsonItemNo && sjsonUnitNo == unitNo && sjsonCatlgId==catlgId && catlgId ==sjsonCatlgId){
		 				var shopHeadTable ="";
	       		    	var shopBodyTable="";
	       		    	var num1 = parseInt(Math.random()*100000);
	       		    	appendShopBodyTable(store,num1,sjsonUnitType,sjsonUnitNo,sjsonCatlgId);
	    				appendShopHeadTable(store,num1,sjsonUnitType,sjsonUnitNo,sjsonCatlgId);

		 			}
		 		}
			}
			
			var sotreHeadEndStr ="";
			sotreHeadEndStr+=" <tr><td style='width: 30px;'><div style='width: 30px;'>&nbsp;</div></td>";
			sotreHeadEndStr+=" <td><div style='width: 80px;'>&nbsp;</div></td><td><div style='width: 110px;'>&nbsp;</div></td></tr>";
			$("#storeHead").append(sotreHeadEndStr);
			scrollUnit();
			top.grid_layer_close();
		}
		
	});
	function showUnitTypSelect(ItemsStoreArray){
		var unitTypeArray = new Array();
		var unitNoArray = new Array();
		for (var i = 0; i < ItemsStoreArray.length; i++) {
			unitTypeArray[unitTypeArray.length] = ItemsStoreArray[i].unitType+"@"+ItemsStoreArray[i].unitTypeName;
			unitNoArray[unitNoArray.length] = ItemsStoreArray[i].unitNo+"@"+ItemsStoreArray[i].unitNoName+"@"+ItemsStoreArray[i].unitType+"@"+ItemsStoreArray[i].promActvy+"@"+ItemsStoreArray[i].pmGiftHint+"@"+ItemsStoreArray[i].memo;
		}
		unitTypeList = unitTypeArray.unique();
		unitNoList = unitNoArray.unique();
		var selectUnitType = "<option value=''>全部</option>";
		var selectUnitNo = "<option value=''>全部</option>";
		for (var j = 0; j < unitTypeList.length; j++) {
			var unitTypeStr = unitTypeList[j];
			var unittypeStrArray = unitTypeStr.split("@");
			selectUnitType+="<option value="+unittypeStrArray[0]+">"+unittypeStrArray[0]+"-"+unittypeStrArray[1]+"</option>";
		}
		for (var w = 0; w < unitNoList.length; w++) {
			var unitNoStr = unitNoList[w];
			var unitNoStrArray = unitNoStr.split("@");
			selectUnitNo+="<option value="+unitNoStrArray[0]+" type="+unitNoStrArray[2]+">"+unitNoStrArray[0]+"-"+unitNoStrArray[1]+"</option>";
		}
		
		$("#unitType").html(selectUnitType);
		$("#unitNo").html(selectUnitNo);
		
	}
	
	function showItemList(itemsArray,itemNo){
		itemsArrays = itemsArray.unique();
		showitems(itemsArrays,itemNo);
	}
	
	function showitems(itemsArrays,itemNo){
		var itemFirstHtml="";
		for (var i = 0; i < itemsArrays.length; i++) {
			var itemsStrArray = itemsArrays[i].split("@");
			var jsonItemNo = itemsStrArray[0];
			var	jsonUnitNo = itemsStrArray[1];
			var	jsonCatlgId = itemsStrArray[2];
			var	jsonUnitType =itemsStrArray[3];
			var	jsonItemName =itemsStrArray[4];
			if(itemNo == jsonItemNo){
				itemFirstHtml +="<div class='item addItems item_on' itemNoValue='"+jsonItemNo+"' unitNoValue='"+jsonUnitNo+"' catlgIdValue='"+jsonCatlgId+"' unitType='"+jsonUnitType+"'><span class='pstb_1'>"+jsonItemNo+"-"+jsonItemName+"</span></div>";
				
			}else{
				$(".pro_store_items").append("<div class='item addItems' itemNoValue='"+jsonItemNo+"' unitNoValue='"+jsonUnitNo+"' catlgIdValue='"+jsonCatlgId+"' unitType='"+jsonUnitType+"'><span class='pstb_1'>"+jsonItemNo+"-"+jsonItemName+"</span></div>");
			}
			
		}
		$(".pro_store_items").prepend(itemFirstHtml);
		//$(".pro_store_items").find("div.item_on");
		
	}
	
	function showItemStore(ItemsStoreArray){
		var num =0;
		var firstItemNo="";
		var itemsArray = new Array();
	     for (var i = 0; i < ItemsStoreArray.length; i++) {
		 	var itemsStoreJson = ItemsStoreArray[i];
		 	var jsonUnitNo = itemsStoreJson.unitNo;
		 	var jsonUnitType = itemsStoreJson.unitType;
		 	var jsonCatlgId = itemsStoreJson.catlgId;
	 		var storeArray = itemsStoreJson.storeArray;
	 		for (var j = 0; j < storeArray.length; j++) {
	 			var store = storeArray[j];
	 			var jsonItemNo = store.itemNo;
	 			var jsonItemName = store.itemName;
	 			itemsArray[itemsArray.length] = jsonItemNo+"@"+jsonUnitNo+"@"+jsonCatlgId+"@"+jsonUnitType+"@"+jsonItemName;
	 			if(num < 1){ 
	 				firstItemNo=jsonItemNo;
	 				num=num+1;
	 			}
	 			
	 			if(firstItemNo == jsonItemNo){
       		    	var num1 = parseInt(Math.random()*100000);
       		    	appendShopBodyTable(store,num1,jsonUnitType,jsonUnitNo,jsonCatlgId);
    				appendShopHeadTable(store,num1,jsonUnitType,jsonUnitNo,jsonCatlgId);
					
	 			}
	 		}
		}
		 
	    var sotreHeadEndStr ="";
		sotreHeadEndStr+=" <tr><td style='width: 30px;'><div style='width: 30px;'>&nbsp;</div></td>";
		sotreHeadEndStr+=" <td><div style='width: 80px;'>&nbsp;</div></td><td><div style='width: 110px;'>&nbsp;</div></td></tr>";
		$("#storeHead").append(sotreHeadEndStr);
		showItemList(itemsArray,firstItemNo);
		scrollUnit();
	}
	function scrollUnit(){
		$("#m_cols_body").scrollLeft(0);
		$("#m_cols_body").scrollTop(0);
	}
	
	$(".tags_close").die("click").live("click",function (){
		$("#Tools21").click();
	});
	
	
	function appendShopBodyTable(storeJson,num,unitType,unitNo,catlgId,flag){
		var shopBodyTable = $("#oneShopBodyTableDetail");
		var promBuyPrice = "";
		var promSellPrice = "";
		var priceCut="";
		var netMaori="";
  		var status;
  		var promSupNo;
  		if(storeJson.statusName !=undefined){
  			status = storeJson.statusName;
  			promBuyPrice = storeJson.promBuyPrice;
  			promSellPrice =  storeJson.promSellPrice;
  			promSupNo = storeJson.promSupNo;
  			priceCut=storeJson.priceCut;
  			netMaori=storeJson.netMaori;
  		}else{
  			status = storeJson.itemStatusName;
  			promSupNo = storeJson.stMainSupNo;
  		}
  		
  		shopBodyTable.find("input[id='status']").attr("value",storeJson.status+"-"+status);
  		shopBodyTable.find("input[id='promSupNo']").attr("value",promSupNo);
  		shopBodyTable.find("input[id='promSellPriceBody']").attr("value",promSellPrice);
  		shopBodyTable.find("input[id='promBuyPriceBody']").attr("value",promBuyPrice);
  		shopBodyTable.find("tr").attr("id",num);
  		shopBodyTable.find("input[id='status']").addClass("status").attr("name",storeJson.basicStatus);
  		shopBodyTable.find("input[id='normBuyPrice']").attr("value",storeJson.normBuyPrice);
  		shopBodyTable.find("input[id='promBuyPriceBody']").addClass("promBuyPriceBody").attr("buyPriceLimit",storeJson.buyPriceLimit).attr("buyWhen",storeJson.buyWhen);
  		shopBodyTable.find("input[id='normSellPrice']").addClass("normSellPrice").attr("value",storeJson.normSellPrice);
  		shopBodyTable.find("input[id='promSellPriceBody']").addClass("promSellPriceBody");
  		shopBodyTable.find("input[id='priceCut']").addClass("priceCut").attr("value",priceCut);
  		shopBodyTable.find("input[id='netMaori']").addClass("netMaori").attr("value",netMaori);
  		shopBodyTable.find("input[id='netCost']").attr("value",storeJson.netCost);
  		shopBodyTable.find("input[id='vat']").attr("value",storeJson.sellVat);
  		shopBodyTable.find("input[id='mainComName']").attr("value",storeJson.mainComName);
		$("#storebody").append(shopBodyTable.html());
		 clearShopBodyTalbe();
		
	}
  	function appendShopHeadTable(storeJson,num,unitType,unitNo,catlgId){
  		var shopHeadTable = $("#oneShopHeadTableDetail");
  		shopHeadTable.find("input[id='checkbox']").attr("deleteId",num).attr("name",storeJson.storeNo).attr("unitTypeVal",unitType).attr("unitNoVal",unitNo).attr("itemNoVal",storeJson.itemNo).attr("colagNoVal",catlgId);
  		shopHeadTable.find("input[id='storeInfo']").attr("value",storeJson.storeNo+"-"+storeJson.storeName).attr("title",storeJson.storeNo+"-"+storeJson.storeName);
  		$("#storeHead").append(shopHeadTable.html());
  		clearShopHeadTable();
  	}

    function clearShopBodyTalbe(){
    	var shopBodyTable = $("#oneShopBodyTableDetail");
    	shopBodyTable.find("tr").attr("id","");
  		shopBodyTable.find("input[id='status']").removeClass("status").attr("name","").attr("value","");
  		shopBodyTable.find("input[id='normBuyPrice']").attr("value","");
  		shopBodyTable.find("input[id='promBuyPriceBody']").removeClass("promBuyPriceBody").attr("buyPriceLimit","").attr("buyWhen","").attr("value","");
  		shopBodyTable.find("input[id='normSellPrice']").removeClass("normSellPrice").attr("value","");
  		shopBodyTable.find("input[id='promSellPriceBody']").removeClass("promSellPriceBody").attr("value","");
  		shopBodyTable.find("input[id='priceCut']").removeClass("priceCut").attr("value","");
  		shopBodyTable.find("input[id='netMaori']").removeClass("netMaori").attr("value","");
  		shopBodyTable.find("input[id='netCost']").attr("value","");
  		shopBodyTable.find("input[id='vat']").attr("value","");
  		shopBodyTable.find("input[id='promSupNo']").attr("value","");
  		shopBodyTable.find("input[id='mainComName']").attr("value","");
    }
    
    function clearShopHeadTable(){
    	var shopHeadTable = $("#oneShopHeadTableDetail");
  		shopHeadTable.find("input[id='checkbox']").attr("deleteId","").attr("name","").attr("unitTypeVal","").attr("unitNoVal","").attr("itemNoVal","").attr("colagNoVal","");
  		shopHeadTable.find("input[id='storeInfo']").attr("value","").attr("title","");
    }
    
    
    $("#Tools10").die('click').live('click',function(){
		if($(this).hasClass("Tools10_disable") ){
			return;
		}
		var promNo = $("#promNo").val();
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
							$(top.document).find("#contentIframe").attr("src",ctx + '/prom/nondm/art/ARTPromo');
						}
						
					}
				});
			}
		});
	});
    
    $("#Tools12").die('click').live('click',function(){
		var promNo = $("#promNo").val();
		if($(this).hasClass("Tools12_disable") ){
			return;
		}
		top.grid_layer_open();
		var obj = "${paramArray}";
		var array = obj.split(",");
		var subjName = encodeURI(array[1]);
		array[1] = encodeURI(subjName);
		var artEditParamJson={};
		artEditParamJson.artEditParamArray =  array;
		window.location.href=ctx + '/prom/nondm/art/editARTPromo?promNo='+promNo+'&paramArrayJson='+JSON.stringify(artEditParamJson);;
	});
</script>
 <style type="text/css">
       /*overwrite*/
       .w50{
       	width:50%;
       
       }
        .item {
            height:25px;padding-top:3px;
        }
      
        .lineToolbar {
            margin-top:3px;
        }
        /*frozen table*/
        .frozen_div {
            height: 320px;
            overflow: hidden;
            border-bottom: 1px solid #ccc;
        }
        #frozen_cols {
            height:100%;
            width:130px;
        }
        #move_cols {
            height:100%;/* equals #frozen_cols.height */
            width:560px;
        }
        #f_cols_head, #m_cols_head {
            height: 30px;
            border-bottom: 1px solid #ccc;
        }
        #f_cols_head td div, #m_cols_head td div{
        text-align: center;
        }
        #f_cols_body,#m_cols_body {
            height:290px;/* equals #frozen_cols.height - #f_cols_head.height(default value is 40px) */
        }
 </style>

<%@ include file="/page/commons/toolbar.jsp"%>
  <div class="CTitle">
     <!--第一个-->
     <div class="tags1_left"></div>
	<!--最后一个-->
	<div class="tagsM">ART促销</div>
     <div class="tags1_left tags1_left_on"></div>
     <div class="tagsM tagsM_on">ART促销详情</div>
     <div class="tags3_close_on">
         <div class="tags_close"></div>
     </div>
     <!-- <div class="tags tags3_r_on">
     	<div class="tags_close"></div> -->
     	<input type="hidden" id="promEnd" value="${promMgVO.promEnd }"/>
     	<input type ="hidden" id ="promStart" value="${promMgVO.promStart}" />
     	<input type="hidden" id ="pageSizeList" value="${pageSizeList}"/>
      	<input type="hidden" id ="pageNoList" value="${pageNoList}"/>
     <!-- </div> -->
</div>
<div class="Container-1">
    <div class="Content">
        <div class="CInfo">
        	<c:if test="${ not empty promMgVO.chngBy}">
        		<span>${promMgVO.chngBy}</span>
            	<span>修改人</span>
        	</c:if>
        	 <c:if test="${ not empty promMgVO.chngDate}">
        		<span><fmt:formatDate pattern='yyyy-MM-dd' value='${promMgVO.chngDate }' /></span>
                <span>修改日期</span>
        	</c:if>
            <span>${promMgVO.chngBy}</span>
            <span>建档人</span>
            <span><fmt:formatDate pattern='yyyy-MM-dd' value='${promMgVO.creatDate }' /></span>
            <span>创建日期</span> 
        </div>
        <div class="CM" style="height:190px;">
             <div class="inner_half">
                    <div class="CM-bar"><div>促销期数基本信息</div></div>
                    <div class="CM-div">
                        <div class="ig_top20">
                            <div class="icol_text w14"><span>促销期数</span></div>
                            <input type="hidden" id="subjNo" value="${promSubjNo}"/>
                            <input type="text" class="inputText w20" id = "promNo" value="${promMgVO.promNo }"/>
                        </div>
                        <div class="ig">
                            <div class="icol_text w14"><span>主题</span></div>
                            <input type="text" class="inputText w50" value="${ promMgVO.subjName}"/>
                        </div>
                        <div class="ig">
                            <div class="icol_text w14"><span>采购期间</span></div>
                            <input  value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promMgVO.buyBeginDate }"/>" type="text" class="inputText w20" />
                            &nbsp;-&nbsp;
                            <input  value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promMgVO.buyEndDate }"/>" type="text" class="inputText w20" />
                        </div>
                        <div class="ig">
                            <div class="icol_text w14"><span>促销期间</span></div>
                             <input  value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promMgVO.promBeginDate }"/>" type="text" class="inputText w20" />
                             &nbsp;-&nbsp;
                             <input  value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promMgVO.promEndDate }"/>" type="text" class="inputText w20" />
                        </div>
                         
                    </div>
                </div>
             <div class="inner_half">
                 <div class="CM-bar"><div>促销商品基本信息</div></div>
                  <div class="CM-div">
                       
                      <div class="ig_top20">
                          <div class="icol_text w14"><span>代号类别</span></div>
                           <select class="w25" id="unitType"></select>
                      </div>
                      <div class="ig">
                            <div class="icol_text w14"><span>代号</span></div>
                             <select class="w60" id="unitNo"></select>
                      </div>
                      <div class="ig">
                           <div class="icol_text w14"><span>课别</span></div>
                           <input type="text" class="inputText w15" value="${ promMgVO.catlgId}"/>&nbsp;<input type="text" class="inputText w25" value="${promMgVO.catlgName }"/>
                       </div>
                       <div class="ig">
                          <div class="icol_text w14"><span>促销类型</span></div>
                          <input type="text" class="inputText w25 fl_left" value="${promMgVO.pricePromType }-${promMgVO.pricePromName }"/>
                         <!--  <div class="msg_txt">组合促销</div>
                            <div class="lineToolbar"></div>
                            <div class="listIcon top3"></div> -->
                      </div>
                     <!-- <div class="ig">
                      	<div class="icol_text w14"><span>促销提示</span></div>
                           <input type="text" class="inputText w50" id="promActvy" />&nbsp;<input type="text" class="inputText w25" id="pmGiftHint" />
                      </div>
                       <div class="ig">
                      	<div class="icol_text w14"><span>备注</span></div>
                           <input type="text" class="inputText" style="width:65%"  id="memo"/>
                      </div> -->
                    </div>
             </div>      
        </div>

       
		<div class="CM" style="height:380px;margin-top:2px;">
                        <div class="CM-bar"><div>促销商品门店信息</div></div>
                        <div class="CM-div">
                            <div class="pro_store_item">
                                <div class="pro_store_item1">
                                    <div class="top15">所选商品</div>
                                    <div style="height: 78%;" class="pro_store_items">
                                    </div>

                                </div>
                                <div class="pro_store_item2">
                                     <div class="frozen_div">
                                    <!--left frozen parts of a table-->
                                    <div id="frozen_cols">
                                        <!--frozen top head parts-->
                                        <div id="f_cols_head">
                                            <div class="f_head_1">
                                                <table cellSpacing="0" cellPadding="0">
                                                    <tbody><tr>
                                                        <td><div style="width: 30px;">&nbsp;</div></td>
                                                        <td><div style="width: 100px;">门店</div></td>
                                                    </tr>
                                                </tbody></table>
                                            </div>
                                        </div>
                                        <!--frozen body parts-->
                                        <div id="f_cols_body">
                                            <table cellSpacing="0" cellPadding="0">
	                                             <tbody  id="storeHead">
	                                           </tbody>
                                           </table>
                                            <table>
								            	<tr>
								              		 <td>&nbsp;</td><td>&nbsp;</td>
								            	</tr>
								           </table>
                                        </div>
                                    </div>
                                    <!--right parts that can scroll-->
                                    <div id="move_cols">
                                        <!--frozen top head parts when drag the y-scroll -->
                                        <div id="m_cols_head">
                                             <table cellSpacing="0" cellPadding="0">
                                                  <tbody><tr>
                                                      
                                                      <td><div style="width: 110px;">商品状态</div></td>
                                                      <td><div style="width: 110px;">正常进价(元)</div></td>
                                                      <td><div style="width: 100px;">促销进价(元)</div></td>
                                                      <td><div style="width: 100px;">正常售价(元)</div></td>
                                                      <td><div style="width: 100px;">促销售价(元)</div></td>
                                                      <td><div style="width: 100px;">降价幅度(%)</div></td>
                                                      <td><div style="width: 100px;">净毛利(%)</div></td>
                                                      <td><div style="width: 50px;">厂商</div></td>
                                                      <td><div style="width: 180px;">&nbsp;</div></td>
                                                      <td><div style="width: 90px;">&nbsp;</div></td><!--占位-->
                                                  </tr>
                                              </tbody></table>
                                        </div>
                                        <!--this parts can be scrolled all the time-->
                                        <div id="m_cols_body">
                                            <table cellSpacing="0" cellPadding="0">
                                                <tbody id="storebody"></tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>
         </div>           
    </div>
</div>
<%@ include file="/page/promotion/promoManagement/ART/template/ShopHeadRowTemplate.jsp"%>
<%@ include file="/page/promotion/promoManagement/ART/template/ShopBodyRowTemplate.jsp"%>