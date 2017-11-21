/* open popupWin with the multiple modification of the item by copy item number*/
function itemBulkEditMultiMod() {
	openPopupWinTwo(652, 497, "/item/batchupdate/itemMulModMethod");
}
/*open the pupupWin Paste the itemNo in the Bulk edit.*/
function bulkEditPastePopup(itemBasicNos){
	openPopupWin(640,500,"/item/batchupdate/itemBulkEditPaste?itemBasicNos="+itemBasicNos);	
}
/*open the pupupWin Paste the itemNo in the Bulk edit.*/
function bulkEditSelPopup(itemBasicNos){
	openPopupWin(740,548,"/item/batchupdate/itemBulkEditSelect?itemBasicNos="+itemBasicNos);
}
/*validate the item No and get the item detail message.*/
function validateItemNo(obj){
	var itemNumValStr = "";
	var flag = false;
	itemNumValStr = $("#txtAreaItemNum").val().replace(/[\n]/ig,';').replace(/;+/g, ';').replace(/\s+/g,"");
	if(itemNumValStr.indexOf(';', 0)==0){
		itemNumValStr=itemNumValStr.substring(1, itemNumValStr.length);
	}
      if ($("#txtAreaItemNum").hasClass("errorInput")) {
		flag = false;
	} else if (itemNumValStr == "" || itemNumValStr == undefined) {
		$("#txtAreaItemNum").addClass("errorInput");
		$("#txtAreaItemNum").attr("title", "请输入需要修改的货号");
		flag = false;
	} else if (itemNumValStr.split(';').length-1>50){
			$("#txtAreaItemNum").addClass("errorInput");
			$("#txtAreaItemNum").attr("title", "货号不能超过50个");	
	} else {
		$("#txtAreaItemNum").removeClass("errorInput");
		$("#txtAreaItemNum").attr("title", "");
		flag = true;
	}
  	if(flag){
		$.ajax({		
			type : "post",
			url : ctx+"/item/batchupdate/validateItemNo",
			data : {
				itemNumValStr:itemNumValStr
			},
			success : function(data){
				    var errorMsg="";
				    var itemNumModStr="";
				    $.each(data,function(key,value) {           
				    	if(value=='false'){
				    		errorMsg=errorMsg+key+';';
				    	}
				    	else{
				    		itemNumModStr=itemNumModStr+key+",";
				    	}
			        });
				    //新增商品中手动增添商品
				    if (obj == "manufacturer") {
				    	if (itemNumModStr.substring(itemNumModStr.length-1, itemNumModStr.length) == ",") {
				    		itemNumModStr = itemNumModStr.substring(0, itemNumModStr.length-1);
				    	}
				    	
				    	if(errorMsg==""){
				    		$.ajax({
				    			type : "post",
				    			url : ctx+"/item/batchupdate/itemManualAddArticleSelectAction",
				    			data : {
				    				itemNumModStr : itemNumModStr,
				    				itemManufacturerNo : $("#sel_itemManufacturerNo").val(),
				    				cancelHidden : $("#cancelHidden").val()
				    			},
				    			success : function(data){
				    				
				    				if(data.status=='success'){
				    				$("#bulkEditPasteError").html("");
				    				if(data.itemNoStr!=""){
				    					if(data.addOrcancel=="newAdd"){
				    						$("#bulkEditPasteError").html("商品号("+data.itemNoStr+")不存在或已关联该厂商!");
				    						return false;
				    						}
				    						else if(data.addOrcancel=="cancel"){
				    						$("#bulkEditPasteError").html("商品号("+data.itemNoStr+")不存在或未关联该厂商!");
				    						return false;
				         					}		
				    				}
				    				else{
				    					$("#div_itemManufacturer").children().remove();
				    					closePopupWin();
				    					$.each(data.rows,function(i,val){
				    						val.itemNo=val.itemNo==null?"":val.itemNo;
				    						val.itemName=val.itemName==null?"":val.itemName;
				    						val.status=val.status==null?"":val.status;
				    						var  str = "<div class='ig'>";
				    						str = str + "<input class='isChecks' type='checkbox' />&nbsp;";
				    						str = str + "<input name='itemNo' type='text' class='w20 inputText Black' value=\""+val.itemNo+"\" readonly=\"readonly\"/>&nbsp;";
				    						str = str + "<input type='text' class='w45 inputText Black' value=\""+val.itemName+"\" readonly=\"readonly\"/>&nbsp;";
				    						str = str + "<input type='text' class='w20 inputText Black' value=\""+getDictValue('ITEM_BASIC_STATUS',val.status)+"\" readonly=\"readonly\"/>&nbsp;";
				    						str = str + "</div>";
				    						$("#div_itemManufacturer").append(str);
				    					});
				    				}
				    				}
				    				else if(data.status=='warn'){
				    					top.jAlert('warning', data.message,'提示消息');
				    				}
				    			}
				    		});
				    		$(".isCheckAllss").attr('checked',false);
				    	}
				    	else{
				    		errorMsg=errorMsg.substring(0,errorMsg.lastIndexOf(';'));
				    		$("#bulkEditPasteError").html("以下货号不存在或已编辑!("+errorMsg+")");
				    	}
				    } else {
				    	if(errorMsg==""){
				    		$("#itemBulkEditNo").val(itemNumModStr);
				    		if(itemNumModStr.indexOf(',', 0)==0){
				    			itemNumModStr=itemNumModStr.substring(0, 1);
				    		}
				    		$.ajax({
				    			type : "post",
				    			url : ctx+"/item/batchupdate/itemDetailMsgByItemNo",
				    			data : {
				    				itemNumModStr : itemNumModStr
				    			},
				    			success : function(data){
				    				
				    				if(data.status=='success'){	
				    				$("#itemBulkEditNoMsg").html('');
				    				closePopupWin();
				    				$.each(data.rows,function(i,val){	
			    						val.itemNo=val.itemNo==null?"":val.itemNo;
			    						val.itemName=val.itemName==null?"":val.itemName;
			    						val.status=val.status==null?"":val.status;
				    					var  str = "<div class='ig'>";
				    					str = str + "<input class='isChecks' type='checkbox' />&nbsp;";
				    					str = str + "<input name='itemNo' type='text' class='w20 inputText Black itemNoList' value=\""+val.itemNo+"\" readonly=\"readonly\"/>&nbsp;";
				    					str = str + "<input type='text' class='w45 inputText Black' value=\""+val.itemName+"\" readonly=\"readonly\"/>&nbsp;";
				    					str = str + "<input type='text' class='w20 inputText Black' value=\""+getDictValue('ITEM_BASIC_STATUS',val.status)+"\" readonly=\"readonly\"/>&nbsp;";
				    					str = str + "</div>";
				    					$("#itemBulkEditNoMsg").append(str);
				    				});
				    				$("#itemBulkEditCheckAll").attr('checked',false);
				    				}
				    				else{
				    					top.jAlert('warning',data.message,'提示消息');
				    				}
				    			}
				    		});
				    	}
				    	else{
				    		errorMsg=errorMsg.substring(0,errorMsg.lastIndexOf(';'));
				    		$("#bulkEditPasteError").html("以下货号不存在或已编辑!("+errorMsg+")");
				    	}
				    }
			}
		});
	} 	
}

/*validate the supNo and get the supplier detail message.*/
function validateSupNo(){
	var supNoValStr = "";
	var flag = false;
	supNoValStr = $.trim($("#txtAreaSupNum").val().replace(/[\n]/ig,';').replace(/;+/g, ';').replace(/\s+/g,""));
	if(supNoValStr.indexOf(';', 0)==0){
		supNoValStr=supNoValStr.substring(1, supNoValStr.length);
	}
    var supNoValStrs = supNoValStr.split(';');
    var supStr = "";
    $.each(supNoValStrs, function(index, val){
    	if (val.length > 8) {
    		supStr = supStr + val + ",";
    	}
    });
    if ($.trim(supStr) != "") {
    	supStr = supStr.substring(0, supStr.length-1);
    }
    if ($("#txtAreaSupNum").hasClass("errorInput")) {
		flag = false;
	} else if (supNoValStr == "" || supNoValStr == undefined) {
		$("#txtAreaSupNum").addClass("errorInput");
		$("#txtAreaSupNum").attr("title", "请输入需要修改的厂编");
		flag = false;
	} else if (supNoValStr.split(';').length-1>50){
		$("#txtAreaSupNum").addClass("errorInput");
		$("#txtAreaSupNum").attr("title", "厂编不能超过50个");	
		flag = false;
	} else if ($.trim(supStr) != ""){
		$("#bulkEditPasteError").html("厂商格式有误。厂商编号为("+supStr+")需小于8位数字");
		flag = false;
	} else {
		$("#txtAreaSupNum").removeClass("errorInput");
		$("#txtAreaSupNum").attr("title", "");
		flag = true;
	}

    if(flag){
    	if (supNoValStr.substr(supNoValStr.length-1) == ";") {
    		supNoValStr = supNoValStr.substring(0, supNoValStr.length-1);
    	}
		$.ajax({
			type : "post",
			url : ctx+"/item/batchupdate/itemArticleAddManufacturerSelectAction",
			data : {
				itemNo : $.trim($("#sel_itemArticleNo").val()),
				supNoValStr : supNoValStr.replace(/;/g, ","),
				hidden : $("#cancelHidden").val()
			},
			success : function(data){
				if(data.status=='success'){
				$("#bulkEditPasteError").html("");
				if(data.supStr!=""){
				if(data.hiddenStr=="newAdd"){
				$("#bulkEditPasteError").html("厂编号("+data.supStr+")不存在或已关联该商品!");
				return false;
				}
				else if(data.hiddenStr=="cancel"){
				$("#bulkEditPasteError").html("厂编号("+data.supStr+")不存在或未关联该商品!");
				return false;
				}
				}
				else{
					closePopupWin();
					$("#div_itemArticle").children().remove();
					$.each(data.esVoList,function(i,val){
						val.supNo=val.supNo==null?"":val.supNo;
						val.comName=val.comName==null?"":val.comName;
						val.status=val.status==null?"":val.status;
						var  str = "<div class='ig'>";
						str = str + "<input class='isChecks' type='checkbox' />&nbsp;";
						str = str + "<input name='comNo' type='text' class='w20 inputText Black' value=\""+val.supNo+"\" readonly=\"readonly\"/>&nbsp;";
						str = str + "<input type='text' class='w45 inputText Black' value=\""+val.comName+"\" readonly=\"readonly\"/>&nbsp;";
						str = str + "<input type='text' class='w20 inputText Black' value=\""+getDictValue('SUPPLIER_STATUS',val.status)+"\" readonly=\"readonly\"/>&nbsp;";
						str = str + "</div>";
						$("#div_itemArticle").append(str);
					});
					$(".isCheckAll").attr('checked',false);
					$(".isCheckAllss").attr('checked',false);
				}
				} 			
				else if(data.status=='warn'){
					top.jAlert('warning', data.message,'提示消息');
				}
			}
		});
    } 
}

/*confirm the selected item No when in the bulk edit.*/
function itemBulkEditSelect(){
	var pageNo = $('#pageNo').val()||'1';
	var pageSize = $('#pageSize').val();
	$("#itemBulkEditNoMsg").html('');
	var itemBulkEditNoStr=$("#itemBulkEditNo").val().replace(/\s+/g,"");
	if(itemBulkEditNoStr.indexOf(',', 0)==0){
		itemBulkEditNoStr=itemBulkEditNoStr.substring(1,itemBulkEditNoStr.length);
	}
	if(itemBulkEditNoStr==""||itemBulkEditNoStr==undefined){
		top.jAlert('warning', "请选择需要修改的商品",'提示消息');
		return false;
	}
	$.ajax({
		type : "post",
		url : ctx+"/item/batchupdate/itemDetailMsgByItemNo",
		data : {
			pageNo:pageNo,
			pageSize:pageSize,
			itemNumModStr : itemBulkEditNoStr
		},
		success : function(data){
			if(data.status=='success'){
			closePopupWin();
			$("#itemBulkEditNoMsg").html('');
			$.each(data.rows,function(i,val){
				val.itemNo=val.itemNo==null?"":val.itemNo;
				val.itemName=val.itemName==null?"":val.itemName;
				val.status=val.status==null?"":val.status;
				var  str = "<div class='ig'>";
				str = str + "<input class='isChecks' type='checkbox' />&nbsp;";
				str = str + "<input name='itemNo' type='text' class='w20 inputText Black itemNoList' value=\""+val.itemNo+"\" readonly=\"readonly\"/>&nbsp;";
				str = str + "<input type='text' class='w45 inputText Black' value=\""+val.itemName+"\" readonly=\"readonly\"/>&nbsp;";
				str = str + "<input type='text' class='w20 inputText Black' value=\""+getDictValue('ITEM_BASIC_STATUS',val.status)+"\" readonly=\"readonly\"/>&nbsp;";
				str = str + "</div>";
				$("#itemBulkEditNoMsg").append(str);
			});
			$("#itemBulkEditCheckAll").attr('checked',false);
			}
			else{
				top.jAlert('warning',data.message,'提示消息');
			}
		}
	});
	$("#itemBulkEditCheckAll").attr('checked',false);
	}

/* choose modify option with item multiple modification */
function itemChooseMulModOption() {
	/* get the changed item NO and the needed modified forum */
	var chgForumId = $('input[name="itemChgForum"]:checked').attr('id');
	var flag = true;
	var itemNumModStr="";
	    $(".itemNoList").each(function() {
	    	itemNumModStr = itemNumModStr+$(this).val()+",";
	   });
    if($('input[name="itemChgForum"]:checked').hasClass('itemEditOtherForum')){
    	itemNumModStr="";	
    }
	if (flag) {
		$.ajax({
			type : 'post',
			url : ctx + '/item/batchupdate/itemMulModMethodChoose',
			data : {
				itemNumModStr : itemNumModStr,
				chgForumId : chgForumId
			},
			success : function(data) {
				if (data.status == 'success') {
//					$("#itemBulkEditNoMsg").find('div').remove();
					if (data.stepPage == 'itemStoreInfo') {
						openPopupWinTwo(953, 646, "/item/batchupdate/"
								+ data.stepPage + "?itemNumModStr="
								+ itemNumModStr,200);
					}else if(data.stepPage == 'itemChgPrice'){
						
						openPopupWinTwo(950, 646, "/item/batchupdate/"
								+ data.stepPage + "?itemNumModStr="
								+ itemNumModStr);
					}				
					else if(data.stepPage=='itemBaseInfo') {
						openPopupWinTwo(330, 650, "/item/batchupdate/"
								+ data.stepPage + "?itemNumModStr="
								+ itemNumModStr);
					}
					else if(data.stepPage=='disAssoItemSup') {
						$.ajax({
							type : 'post',
							url : ctx + '/item/batchupdate/disAssoItemSup',
							success : function(data){
								$('#content').html();
								$('#content').html(data);
							}
						});
					}
					else if(data.stepPage=='addAssoItemSup') {
						$.ajax({
							type : 'post',
							url : ctx + '/item/batchupdate/addAssoItemSup',
							success : function(data){
								$('#content').html();
								$('#content').html(data);
							}
						});
					}
					else if(data.stepPage=='itemBulkEditBidRate') {
						$.ajax({
							type : 'post',
							url : ctx + '/item/batchupdate/itemBulkEditBidRate',
							success : function(data){
								$('#content').html();
								$('#content').html(data);
							}
						});
					}
					
				} else {
					top.jAlert('warning', data.message,'提示消息');
				}
			}
		});
	}
}

/*show multiple modify item store page by ajax request*/
function itemMulModEditor(itemNumModStr){
	var storeMultiModStr = "";
	var storeInfoOptStr = "";
	var list=[];
	
	var paginStyleId=$('input[name="paginationStyle"]:checked').attr("id");
	
	$.each($('input[name="lmtMdfOpts"]:checked'), function(index, item) {
		storeInfoOptStr = storeInfoOptStr + $(this).val() + ",";
	});
	$.each($('.check[type=checkbox]:checked'), function(index,item) {
		list.push({
			'storeNo' : $(this).val(),
			'storeName' : $(this).parent().next().text()
		});
		storeMultiModStr = storeMultiModStr + $(this).val() + ",";
	});
	if (list.length == 0) {
		top.jAlert('warning', '请选择门店','提示消息');
		return false;
	}
	if(storeInfoOptStr==""||storeInfoOptStr==undefined){
		top.jAlert('warning', '请选择修改项','提示消息');
		return false;
	}
	$.ajax({
		type : 'post',
		url : ctx + '/item/batchupdate/itemMulModEditor',
		data : {
			itemNumModStr : itemNumModStr,
			storeMultiModStr : storeMultiModStr,
			paginStyleId : paginStyleId,
			fields : storeInfoOptStr
		},
		success : function(data) {
			$("#Tools12").attr('class', "Tools12_disable").unbind("click");
			$("#Tools2").attr('class', "Tools2");
			closePopupWinTwo();
			$('#itemBaseInfoContainer').html();
			$('#itemBaseInfoContainer').html(data);
		}

	});

}

/*show multiply modify item base info page by ajax request*/
function itemBaseInfoEditor(itemNumModStr){
	
	var storeInfoOptStr = "";	
	$.each($('input[name="lmtMdfOpts"]:checked'),function(index,item){
		storeInfoOptStr =storeInfoOptStr+ $(this).val()+",";
	});
	if(storeInfoOptStr==""||storeInfoOptStr==undefined){
		top.jAlert('warning', '请选择修改项','提示消息');
		return false;
	}
	$.ajax({	
		type : 'post',
		url : ctx+'/item/batchupdate/itemBaseInfoEditor',
		data : {
			itemNumModStr : itemNumModStr,
			fields : storeInfoOptStr
		},
		success : function(data) {
			$("#Tools12").attr('class', "Tools12_disable").unbind("click");
			$("#Tools2").attr('class', "Tools2");
			closePopupWinTwo();
			$('#itemBaseInfoContainer').html();	
			$('#itemBaseInfoContainer').html(data);
		}
		
	});
}

/*show multiply modify item base info page by ajax request*/
function itemChgPriEditor(itemNumModStr){
	var storeMultiModStr = "";	
	var paginStyleId=$('input[name="paginationStyle"]:checked').attr("id");

	$.each($('.check[type=checkbox]:checked'), function(index,
			item) {
		storeMultiModStr = storeMultiModStr + $(this).val() + ",";
	});
	
	if(storeMultiModStr==""||storeMultiModStr==undefined){	
		top.jAlert('warning', '请选择需要修改商品的店','提示消息');
		return false;
	}
	$.ajax({	
		type : 'post',
		url : ctx+'/item/batchupdate/itemChgPriList',
		data : {
			itemNumModStr : itemNumModStr,
			paginStyleId:paginStyleId,
			storeMultiModStr : storeMultiModStr
		},
		success : function(data) {
			$("#Tools12").attr('class', "Tools12_disable").unbind("click");
			$("#Tools2").attr('class', "Tools2");
			closePopupWinTwo();
			$('#itemBaseInfoContainer').html();	
			$('#itemBaseInfoContainer').html(data);
		}
		
	});
}


/*check all the hype market when multiply modify
  the item store page.*/	
function hypeMarketCheckAll(obj) {
	if (obj.checked) {
		$('#storeDiv').find("input").not('[disabled="disabled"]').attr(
				'checked', true);
	} else {
		$('#storeDiv').find("input").not('[disabled="disabled"]').attr(
				'checked', false);
	}
}

/*check all the logistics center when multiply modify
the item store page.*/	
function dcCenterCheckAll(obj) {
	if (obj.checked) {
		$('#dcCenterDiv').find("input").not('[disabled="disabled"]').attr(
				'checked', true);
	} else {
		$('#dcCenterDiv').find("input").not('[disabled="disabled"]').attr(
				'checked', false);
	}
}


/*check all the machine center when multiply modify
the item store page.*/	
function machinCheckAll(obj) {
	if (obj.checked) {
		$('#machinDiv').find("input").not('[disabled="disabled"]').attr(
				'checked', true);
	} else {
		$('#machinDiv').find("input").not('[disabled="disabled"]').attr(
				'checked', false);
	}
}
/*display the list of modifying item base info*/
function itemBaseInfoList(fields,itemNumModStr) {
	var pageNo = $('#itemBaseInfoContainer #pageNo').val()||'1';
	$.ajax({
		type : "post",
		data : {
			pageNo : pageNo,
			fields  : fields,
			itemNumModStr : itemNumModStr
		},
		dataType : "html",
		url : ctx + "/item/batchupdate/updateItemByPage",
		success : function(data) {
			$('#page_content').html(data);
		}
	});
}
/*display the list of modifying item store info*/
function itemStoreInfoList(fields,itemNumModStr,storeMultiModStr,paginStyleId) {
	var pageNo = $('#pageNo').val()||'1';
	$.ajax({
		type : "post",
		data : {
			pageNo : pageNo,
			fields  : fields,
			itemNumModStr : itemNumModStr,
			paginStyleId : paginStyleId,
			storeMultiModStr : storeMultiModStr
		},
		dataType : "html",
		url : ctx + "/item/batchupdate/updateItemStoreByPage",
		success : function(data) {
			$('#page_content').html(data);
		}
	});
}
/*display the list of modifying item change price*/
function itemChgPriList(itemNumModStr,storeMultiModStr,paginStyleId) {
	var pageNo = $('#pageNo').val()||'1';
	$.ajax({
		type : "post",
		data : {
			pageNo : pageNo,
			itemNumModStr : itemNumModStr,
			paginStyleId : paginStyleId,
			storeMultiModStr : storeMultiModStr,
			taskId : $("#taskId").val()
		},
		dataType : "html",
		url : ctx + "/item/batchupdate/updateitemPriByPage",
		success : function(data) {
			$('#page_content').html(data);
		}
	});
}

/* Bulkupdate - BidRate:  Display the selected items in the main page */ 
function addSupItems(method,supNo) {

	var output = "";
	var rows=[];
	
	$("#supSelectedItems").html('');
	var itemBulkEditNoStr=$("#itemBulkEditNo").val().replace(/\s+/g,"");
	if(itemBulkEditNoStr.indexOf(',', 0)==0){
		itemBulkEditNoStr=itemBulkEditNoStr.substring(1,itemBulkEditNoStr.length);
	}

	if (method == "select") {
		if(itemBulkEditNoStr==""||itemBulkEditNoStr==undefined){
			top.jAlert('warning', '请选择商品','提示消息');
			return false;
		}
		$.ajax({
			type : "post",
			url : ctx + "/item/batchupdate/showSelectedItems",
			data : {
				selectedItemStr : itemBulkEditNoStr,
				supNo : supNo
			},
			success : function(data) {
				if(data.status=='success'){
				rows = data.rows;
				if (rows.length != 0) {
					for ( var i = 0; i < rows.length; i++) {
						rows[i].itemNo=rows[i].itemNo==null?"":rows[i].itemNo;
						rows[i].itemName=rows[i].itemName==null?"":rows[i].itemName;
						rows[i].itemStatus=rows[i].itemStatus==null?"":rows[i].itemStatus;
						rows[i].speclBuyVatNo=rows[i].speclBuyVatNo==null?"":rows[i].speclBuyVatNo;
						rows[i].speclBuyVatVal=rows[i].speclBuyVatVal==null?"":rows[i].speclBuyVatVal;
						output = output + '<div class="ig" style="margin-top: 5px;">';
						output = output + '<input type="checkbox" class="isChecks" name="itemBulkEditCheck"/>';
						output = output + '<input class="inputText twoinput20 w15 Black itemNoList" name="vatItemNo" type="text" value="' + rows[i].itemNo + '" readonly="readonly" />';
						output = output + '<input class="inputText twoinput20 w35 Black" type="text" value="' + rows[i].itemName + '" readonly="readonly" />';
						output = output + '<input class="inputText twoinput20 w15 Black" type="text" value="' + getDictValue('ITEM_BASIC_STATUS', rows[i].itemStatus) + '"readonly="readonly" />';
						if(rows[i].speclBuyVatNo==""||rows[i].speclBuyVatVal==""){
							output = output + '<input class="inputText twoinput20 w20 Black" type="text" readonly="readonly" />';
						}
						else{
						output = output + '<input class="inputText twoinput20 w20 Black" type="text" value="' + rows[i].speclBuyVatNo +'-&nbsp;'+ rows[i].speclBuyVatVal + '%" readonly="readonly" />';
						}
						output = output + '</div>';
					}
				}
				$("#supSelectedItems").html(output);
				closePopupWin();
				}
				else{
					top.jAlert('warning',data.message,'提示消息');
				}
			}
		});

	} else {
		$.ajax({
					type : "post",
					url : ctx + "/item/batchupdate/showSelectedItems",
					data : {
						selectedItemStr : $('#itemNoTextArea').val().replace(/[\n]/ig,';').replace(/;+/g, ';').replace(/\s+/g,"").replace(/;/g,','),
						supNo : supNo
					},
					success : function(data) {
						if(data.status=='success'){
						rows = data.rows;
						if (rows.length != 0) {
							for ( var i = 0; i < rows.length; i++) {
								rows[i].itemNo=rows[i].itemNo==null?"":rows[i].itemNo;
								rows[i].itemName=rows[i].itemName==null?"":rows[i].itemName;
								rows[i].itemStatus=rows[i].itemStatus==null?"":rows[i].itemStatus;
								rows[i].speclBuyVatNo=rows[i].speclBuyVatNo==null?"":rows[i].speclBuyVatNo;
								rows[i].speclBuyVatVal=rows[i].speclBuyVatVal==null?"":rows[i].speclBuyVatVal;
								output = output + '<div class="ig" style="margin-top: 5px;">';
								output = output + '<input type="checkbox" class="isChecks" name="itemBulkEditCheck"/>';
								output = output + '<input class="inputText twoinput20 w15 Black itemNoList" name="vatItemNo" type="text" value="' + rows[i].itemNo + '" readonly="readonly" />';
								output = output + '<input class="inputText twoinput20 w35 Black" type="text" value="' + rows[i].itemName + '" readonly="readonly" />';
								output = output + '<input class="inputText twoinput20 w15 Black" type="text" value="' + getDictValue('ITEM_BASIC_STATUS', rows[i].itemStatus) + '"readonly="readonly" />';
								if(rows[i].speclBuyVatNo==""||rows[i].speclBuyVatVal==""){
									output = output + '<input class="inputText twoinput20 w20 Black" type="text" readonly="readonly" />';
								}
								else{
								output = output + '<input class="inputText twoinput20 w20 Black" type="text" value="' + rows[i].speclBuyVatNo +'-&nbsp;'+ rows[i].speclBuyVatVal + '%" readonly="readonly" />';
								}
								output = output + '</div>';
							}
						}
						$("#supSelectedItems").html(output);
						closePopupWin();
						}
						else{
							top.jAlert('warning',data.message,'提示消息息');
						}
					}
				});
	}
	$(".isCheckAllss").attr('checked',false);
	
}

/* choice the radio associating the all item */
function assoAllItem(obj) {
	$("#div_itemManufacturer").find("div").remove();
	$("#supBulkEditSelIcon").removeClass("Tools11").addClass("Tools11_disable");
	$("#supBulkEditPasIcon").removeClass("copy").addClass("copy_off");
	$("#supCheckAllIcon").attr('disabled','disabled');
	$("#supDeleteCheckedIcon").removeClass("Tools10").addClass("Tools10_disable");
}
/* choice the radio associating the section item */
function isCheckAll() {
	$("#supBulkEditSelIcon").removeClass("Tools11_disable").addClass("Tools11");
	$("#supBulkEditPasIcon").removeClass("copy_off").addClass("copy");
	$("#supCheckAllIcon").removeAttr('disabled');
	$("#supDeleteCheckedIcon").removeClass("Tools10_disable").addClass("Tools10");
	
}
/* choice the radio associating the all supplier */
function assoAllSup(obj) {
	    $("#div_itemArticle").find("div").remove();
	    $("#itemBulkEditSelIcon").removeClass("Tools11").addClass("Tools11_disable");
		$("#itemBulkEditPasIcon").removeClass("copy").addClass("copy_off");
		$("#itemCheckAllIcon").attr('disabled','disabled');
		$("#itemDeleteCheckedIcon").removeClass("Tools10").addClass("Tools10_disable");
	
}
/* choice the radio associating the section supplier */
function assoSecSup() {
	$("#itemBulkEditSelIcon").removeClass("Tools11_disable").addClass("Tools11");
	$("#itemBulkEditPasIcon").removeClass("copy_off").addClass("copy");
	$("#supCheckAllIcon").removeAttr('disabled');
	$("#itemCheckAllIcon").removeAttr('disabled');
	$("#itemDeleteCheckedIcon").removeClass("Tools10_disable").addClass("Tools10");
}
/*open the popupWin for selecting the items isn't associated by supplier */
function supAssoItemSel(){
	openPopupWin(630,548,"/item/batchupdate/supAssoItemSel");	
}
//厂商管理选择货号弹出框
function itemArticleSelect(){
	openPopupWin(740,548,"/item/batchupdate/itemArticleSelectWindowAction");
	$("#sel_itemArticleNo").removeClass("errorInput");
}
//选择指定的货号
function saveArticleNo(){
	var update_item = $("#popupWin").find(".btable_checked");
	if (update_item.length!=0&&update_item.length!=undefined) {
		$("#div_itemArticle").children().remove();
		$("#sel_itemArticleNo").val($(update_item).find('input[name=itemNo]').val());
		$("#sel_itemArticleName").val($(update_item).find('input[name=itemName]').val());
		closePopupWin();
	} else {
		top.jAlert('warning','请选择商品','提示消息');
		return false;
	}
}
//厂商管理新增厂商弹出框
function itemSupplierAddArticleSelect() {
	var itemArticleNo = $.trim($("#sel_itemArticleNo").val());
	var addClass = $("#itemBulkEditSelIcon").attr("class");
	if (addClass.indexOf("_disable") < 0) {
		if (itemArticleNo == "") {
			$("#sel_itemArticleNo").addClass("errorInput");
			return false;
		} else {
			openPopupWin(740, 548,
					"/item/batchupdate/itemAddArticleSelectWindowAction?itemNos="
							+ str_ItemNo() + "&hidden="
							+ $.trim($("#cancelHidden").val()) + "&itemNo="
							+ $.trim($("#sel_itemArticleNo").val()));
		}
	}
}
//厂商管理选择厂商弹出框
function itemManufacturerSelect(){
	openPopupWin(740,548,"/item/batchupdate/itemManufacturerSelectWindowAction");
	$("#sel_itemManufacturerNo").removeClass("errorInput");
}
//选择指定的厂商
function saveManufacturerNo(){
	var update_items = $("#popupWin").find(".btable_checked");
	if (update_items.length!=0&&update_items!=undefined) {
		$("#div_itemManufacturer").children().remove();
		$("#sel_itemManufacturerNo").val($(update_items).find('input[name=supNo]').val());
		$("#sel_itemManufacturerName").val($(update_items).find('input[name=supName]').val());
		closePopupWin();
	} else {
		top.jAlert('warning','请选择厂商','提示消息');
		return false;
	}
	
}
//厂商管理新增商品弹出框
function itemAddManufacturerWindowSelect() {
	var addClass = $("#supBulkEditSelIcon").attr("class");
	var itemSupplierNo = $.trim($("#sel_itemManufacturerNo").val());
	if (addClass.indexOf("_disable") < 0) {
		if (itemSupplierNo == "") {
			$("#sel_itemManufacturerNo").addClass("errorInput");
			return false;
		} else {
			var supplierNo = $.trim($("#sel_itemManufacturerNo").val());
			openPopupWin(740, 548,
					"/item/batchupdate/itemAddManufacturerWindowSelectAction?hidden="
							+ $.trim($("#cancelHidden").val()) + "&itemNo="
							+ str_supplierNo() + "&supplierNo=" + supplierNo);
		}
	}
}
/*open the popupWin for pasting the items isn't associated by supplier */
function supAssoItemPas(){	
	openPopupWin(640,500,"/item/batchupdate/supAssoItemPas");	
}
/*open the popupWin for selecingt the supplier isn't associated by items */
function itemAssoSupSel(){
	openPopupWin(630,548,"/item/batchupdate/itemAssoSupSel");
}
/*open the popupWin for pasting the supplier isn't associated by items */
function itemAssoSupPas(){
	openPopupWin(640,500,"/item/batchupdate/itemAssoSupPas");
}
//手动添加厂商弹出框
function itemManualAddArticleSelect(){	
	var  itemArticleNo = $.trim($("#sel_itemArticleNo").val());
	var addClass = $("#itemBulkEditPasIcon").attr("class");
	if (addClass.indexOf("_off") < 0) {
		if (itemArticleNo == "") {
			$("#sel_itemArticleNo").addClass("errorInput");
			return false;
		} else {
			var supBasicNos=str_ItemNo().replace(/,/g,';');
    		if(supBasicNos.indexOf(';', 0)==0){
    			supBasicNos=supBasicNos.substring(1, supBasicNos.length);
    			}
			openPopupWin(640,500,"/item/batchupdate/itemManualAddArticleWindowSelectAction?itemNo="+supBasicNos);
		}
	}
}
//手动添加商品弹出框
function itemArticleAddManufacturerWindowSelect(){
	var itemSupplierNo = $.trim($("#sel_itemManufacturerNo").val());
	var addClass = $("#supBulkEditPasIcon").attr("class");
	if (addClass.indexOf("_off") < 0) {
		if (itemSupplierNo == "") {
			$("#sel_itemManufacturerNo").addClass("errorInput");
			return false;
		} else {
			var itemBasicNos=str_supplierNo().replace(/,/g,';');
    		if(itemBasicNos.indexOf(';', 0)==0){
    			itemBasicNos=itemBasicNos.substring(1, itemBasicNos.length);
    			}
			openPopupWin(640,500,"/item/batchupdate/itemArticleAddManufacturerWindowSelectAction?itemNo="+itemBasicNos);
		}
	}
	
}
/*open the popupWin for selecting the all suppliers*/
function itemEditBidRateSel(supNo,itemNos){	
	if (supNo == "" || supNo == undefined){
		$("#sel_supNo").addClass("errorInput");
		$("#sel_supNo").attr("title", "请选择需要修改的厂商");
	}else{
	  
		openPopupWin(740,548,"/item/batchupdate/itemEditBidRateSel?supNo=" + supNo + "&itemNos=" + itemNos);
	}
}
/*open the popupWin for pasting the all suppliers*/
function itemEditBidRatePas(supNo,itemNos){	
	if (supNo == "" || supNo == undefined){
		$("#sel_supNo").addClass("errorInput");
		$("#sel_supNo").attr("title", "请选择需要修改的厂商");
	}else{
		if(itemNos.indexOf(',', 0)==0){
			itemNos=itemNos.substring(1, itemNos.length);
			}
		openPopupWin(640,500,"/item/batchupdate/itemEditBidRatePas?supNo=" + supNo + "&itemNos=" + itemNos);
	}
}
$(function() {

	/*validate the valid of the textarea input*/
	$("#txtAreaItemNum").live('blur', function() {
		var itemNumVal = $("#txtAreaItemNum").val();
		/*	    var pattren = new RegExp(/^([[1-9]{1,10}[;]){0,}$/);*/
		if(itemNumVal==""){
			$("#txtAreaItemNum").addClass("errorInput");
			$("#txtAreaItemNum").attr("title", "请输入需要修改的货号");
			return false;
			
		}
		else{
			$("#txtAreaItemNum").removeClass("errorInput");
			$("#txtAreaItemNum").attr("title", "");
		}
		var pattren = new RegExp(/^([0-9][;]{0,1}[\n\s]{0,})+$/);
		var itemNumStyle = pattren.test(itemNumVal);
		if (itemNumStyle) {
			var itemNumValArray=itemNumVal.split(';');
			var itemNumValLen=itemNumValArray.length;
			if(itemNumValLen>50){
				$("#txtAreaItemNum").addClass("errorInput");
				$("#txtAreaItemNum").attr("title", "货号格式不正确");
			}
			else{
			$("#txtAreaItemNum").removeClass("errorInput");
			$("#txtAreaItemNum").attr("title", "");
			}
		} else {
			$("#txtAreaItemNum").addClass("errorInput");
			$("#txtAreaItemNum").attr("title", "货号格式不正确");
		}
	});
	
	/*validate the valid of the textarea input*/
	$("#txtAreaSupNum").live('blur', function() {
		var itemNumVal = $("#txtAreaSupNum").val();
		if(itemNumVal==""){
			$("#txtAreaSupNum").addClass("errorInput");
			$("#txtAreaSupNum").attr("title", "请输入需要修改的厂编");
			return false;
		}
		else{
			$("#txtAreaSupNum").removeClass("errorInput");
			$("#txtAreaSupNum").attr("title", "");
		}
		var pattren = new RegExp(/^([0-9][;]{0,1}[\n\s]{0,})+$/);
		var itemNumStyle = pattren.test(itemNumVal);
		if (itemNumStyle) {
			var itemNumValArray=itemNumVal.split(';');
			var itemNumValLen=itemNumValArray.length;
			if(itemNumValLen>50){
				$("#txtAreaSupNum").addClass("errorInput");
				$("#txtAreaSupNum").attr("title", "厂编格式不正确");
			}
			else{
			$("#txtAreaSupNum").removeClass("errorInput");
			$("#txtAreaSupNum").attr("title", "");
			}
		} else {
			$("#txtAreaSupNum").addClass("errorInput");
			$("#txtAreaSupNum").attr("title", "厂编格式不正确");
		}
	});

	/*limit the modify option number is less than or equal to 5 in the store info forum*/
	$('input[name="lmtMdfOpts"]').live('click', function() {
		if ($('input[name="lmtMdfOpts"]:checked').length >= 5) {
			$('input[name="lmtMdfOpts"]').each(function() {
				if ($(this).attr('checked') == undefined) {
					$(this).attr('disabled', 'disabled');
				}
			});
		} else {
			$('input[name="lmtMdfOpts"]').removeAttr("disabled");
		}
	});
	/*enable the icons when choicing the item base edit forums.*/
	$(".itemEditBaseForum").live("click",function(){
		$("#itemBulkEditSelIcon").removeClass("Tools11_disable")
		.addClass("Tools11").die().live('click',bulkEditSelWin);
        $("#itemBulkEditPasIcon").removeClass("copy_off").addClass("copy")
        .die().live('click',bulkEditPasteWin);  
		$("#itemBulkEditDelIcon").removeClass("Tools10_disable")
		.addClass("Tools10");
		$("#itemBulkEditCheckAll").removeAttr("disabled");
	});
	/*disable the icons when choicing the  item other forums.*/
	$(".itemEditOtherForum").live("click",function(){
		$.each($("#itemBulkEditNoMsg").find('div').find('[name=itemNo]'),function(index,val){
			var itemNo= parseInt(val.value);
			$("#itemBulkEditNo").val($("#itemBulkEditNo").val().replace(itemNo+',',''));
		});
		$("#itemBulkEditNoMsg").find('div').remove();
		$("#itemBulkEditSelIcon").removeClass("Tools11")
		.addClass("Tools11_disable").die();
        $("#itemBulkEditPasIcon").removeClass("copy").addClass("copy_off")
        .die();
		$("#itemBulkEditDelIcon").removeClass("Tools10")
		.addClass("Tools10_disable");
		$("#itemBulkEditCheckAll").attr("disabled","disabled");
		
	});
	/*judge if check the checkAllBox when changing the status of the check. */
	$(".isCheck").live("click",function(){
		   var checkAll=true;
		   var itemCheckBoxList=$(".isCheck");
		$.each(itemCheckBoxList,function(index,item){
			if(this.checked==false){
				checkAll=false;
				return false;
			};
			});
		if(!checkAll){	
			$(".isCheckAll").attr("checked",false);
		}
		else{
			$(".isCheckAll").attr("checked",true);
		}
		
	});
	/*judge if check all the checkbox*/
	$(".isCheckAll").live("click",isChelkALL=function(){
		
		if(this.checked){
			$(".isCheck").attr("checked",true);	
		}
		else{
			$(".isCheck").attr("checked",false);	
		}
		
	});
	$(".deleteChecked").live("click",function(){
		$("input.isCheck:checked").parent().remove();
		$(".isCheckAll").attr("checked",false);
	});
	
	
	//另一个删除checkbox
	/*judge if check the checkAllBox when changing the status of the check. */
	$(".isChecks").live("click",function(){
		   var checkAll=true;
		   var itemCheckBoxList=$(".isChecks");
		$.each(itemCheckBoxList,function(index,item){
			if(this.checked==false){
				checkAll=false;
				return false;
			};
			});
		if(!checkAll){	
			$(".isCheckAllss").attr("checked",false);
		}
		else{
			$(".isCheckAllss").attr("checked",true);
		}
		
	});
	/*judge if check all the checkbox*/
	$(".isCheckAllss").live("click",function(){
		if(this.checked){
			$(".isChecks").attr("checked",true);	
		}
		else{
			$(".isChecks").attr("checked",false);	
		}
		
	});
	$(".deleteCheckeds").live("click",function(){
		$("input.isChecks:checked").parent().remove();
		$(".isCheckAllss").attr("checked",false);
	});
	
	$("#itemBulkEditSelIcon").die().live('click',bulkEditSelWin=function(){
		bulkEditSelPopup(itemBasicCheckedNo());
	});
	$("#itemBulkEditPasIcon").die().live('click',bulkEditPasteWin=function(){
		bulkEditPastePopup(itemBasicCheckedNo());
	});

});

//显示新增厂商的内容
function itemAddArticleSave(){
	
	var pageNo = $('#pageNo').val()||'1';
	var pageSize = $('#pageSize').val();
	var supBulkEditNoStr=$("#supBulkEditNo").val().replace(/\s+/g,"");
	if(supBulkEditNoStr.indexOf(',', 0)==0){
		supBulkEditNoStr=supBulkEditNoStr.substring(1,supBulkEditNoStr.length);
	}
	if(supBulkEditNoStr==""||supBulkEditNoStr==undefined){	
		top.jAlert('warning','请选择厂商','提示消息');
		return false;
	}
	$.ajax({
		type : "post",
		url : ctx+"/item/batchupdate/itemArticleAddManufacturerSelectAction",
		data : {
			pageNo:pageNo,
			pageSize:pageSize,
			itemNo : $.trim($("#sel_itemArticleNo").val()),
			supNoValStr : supBulkEditNoStr.replace(/;/g, ","),
			hidden : $("#cancelHidden").val()
		},
		success : function(data){
			
			if(data.status=='success'){
			$("#bulkEditPasteError").html("");
				closePopupWin();
				$("#div_itemArticle").children().remove();
				$.each(data.esVoList,function(i,val){
					
					val.supNo=val.supNo==null?"":val.supNo;
					val.comName=val.comName==null?"":val.comName;
					val.status=val.status==null?"":val.status;
					var  str = "<div class='ig'>";
					str = str + "<input class='isChecks' type='checkbox' />&nbsp;";
					str = str + "<input name='comNo' type='text' class='w20 inputText Black' value=\""+val.supNo+"\" readonly=\"readonly\"/>&nbsp;";
					str = str + "<input type='text' class='w45 inputText Black' value=\""+val.comName+"\" readonly=\"readonly\"/>&nbsp;";
					str = str + "<input type='text' class='w20 inputText Black' value=\""+getDictValue('SUPPLIER_STATUS',val.status)+"\" readonly=\"readonly\"/>&nbsp;";
					str = str + "</div>";
					$("#div_itemArticle").append(str);
				});
				$(".isCheckAll").attr('checked',false);
				$(".isCheckAllss").attr('checked',false);
			} 
			else if(data.status=='warn'){
				top.jAlert('warning', data.message,'提示消息');
			}
		}
	});
}
//显示新增商品的内容
function itemAddManufacturerSave(){
	var pageNo = $('#pageNo').val()||'1';
	var pageSize = $('#pageSize').val();
	var itemNumModStr=$("#itemBulkEditNo").val().replace(/\s+/g,"");
	if(itemNumModStr.indexOf(',', 0)==0){
		itemNumModStr=itemNumModStr.substring(1,itemNumModStr.length);
	}
	if(itemNumModStr==""||itemNumModStr==undefined){
		top.jAlert('warning','请选择商品','提示消息');
		return false;
	}
	$.ajax({
		type : "post",
		url : ctx+"/item/batchupdate/itemManualAddArticleSelectAction",
		data : {
			pageNo:pageNo,
			pageSize:pageSize,
			itemNumModStr : itemNumModStr,
			itemManufacturerNo : $("#sel_itemManufacturerNo").val(),
			cancelHidden : $("#cancelHidden").val()
		},
		success : function(data){
			if(data.status=='success'){
			$("#bulkEditPasteError").html("");
				$("#div_itemManufacturer").children().remove();
				closePopupWin();
				$.each(data.rows,function(i,val){
					val.itemNo=val.itemNo==null?"":val.itemNo;
					val.itemName=val.itemName==null?"":val.itemName;
					val.status=val.status==null?"":val.status;
					var  str = "<div class='ig'>";
					str = str + "<input class='isChecks' type='checkbox' />&nbsp;";
					str = str + "<input name='itemNo' type='text' class='w20 inputText Black' value="+val.itemNo+" readonly=\"readonly\"/>&nbsp;";
					str = str + "<input type='text' class='w45 inputText Black' value="+val.itemName+" readonly=\"readonly\"/>&nbsp;";
					str = str + "<input type='text' class='w20 inputText Black' value="+getDictValue('ITEM_BASIC_STATUS',val.status)+" readonly=\"readonly\"/>&nbsp;";
					str = str + "</div>";
					$("#div_itemManufacturer").append(str);
				});		
		    }
			else if(data.status=='warn'){
				top.jAlert('warning', data.message,'提示消息');
			}
		}
	});
	$(".isCheckAllss").attr('checked',false);

}

//保存新增厂商商品
function addSupplierManualfacturer(){
	var div_name = $($("#div_itemManufacturer").find("div")).find("input");
	var str = "";
	var itemManufacturerNo = $.trim($("#sel_itemManufacturerNo").val());
	if (itemManufacturerNo == "") {
		$("#sel_itemManufacturerNo").addClass("errorInput");
		return false;
	} else {
		$.each(div_name, function(i,val){
			if (val.name != "") {
				str = str + val.value + ",";
			}
		});
		if(str==""||str==undefined){
			top.jAlert('warning', "请选择需要修改的商品",'提示消息');
			return false;
		}
		str = str.substring(0, str.length-1);
		$.ajax({
			type : "post",
			data : {
				itemNumModStr : $("#sel_itemManufacturerNo").val(),
				manualfactureJson : str
			},
			url : ctx + "/item/batchupdate/saveManualfacturerAction",
			success : function(data) {
				if (data.status == "success") {
					top.jAlert('success', data.message,'提示消息');
					$("#sel_itemManufacturerNo").val("");
					$("#sel_itemManufacturerName").val("");
					$("#div_itemManufacturer").text("");
				} else {
					top.jAlert('warning', data.message,'提示消息');
				}
			}
		});
	}
}

//保存新增商品厂商
function addItemManualfacturer(){
	var div_name = $($("#div_itemArticle").find("div")).find("input");
	var str = "";
	var  itemArticleNo = $.trim($("#sel_itemArticleNo").val());
	if (itemArticleNo == "") {
		$("#sel_itemArticleNo").addClass("errorInput");
		return false;
	} else {
		$.each(div_name, function(i,val){
			if (val.name != "") {
				str = str + val.value + ",";
			}
		});
		if(str==""||str==undefined){
			top.jAlert('warning',"请选择需要修改的厂商",'提示消息');
			return false;
		}
		str = str.substring(0, str.length-1);
		$.ajax({
			type : "post",
			data : {
				itemArticleNo : itemArticleNo,
				itemArticleStr : str
			},
			url : ctx + "/item/batchupdate/addItemManualfacturerAction",
			success : function(data) {
				if (data.status == "success") {
					top.jAlert('success', data.message,'提示消息');
					$("#sel_itemArticleNo").val("");
					$("#sel_itemArticleName").val("");
					$("#div_itemArticle").text("");
				} else {
					top.jAlert('warning',data.message,'提示消息');
				}
			}
		});
	}
}

//保存取消商品厂商
function cancelItemManualfacturer(){
	var div_name = $($("#div_itemArticle").find("div")).find("input");
	var str = "";
	var  itemArticleNo = $.trim($("#sel_itemArticleNo").val());
	if (itemArticleNo == "") {
		$("#sel_itemArticleNo").addClass("errorInput");
		return false;
	} else {
		$.each(div_name, function(i,val){
			if (val.name != "") {
				str = str + val.value + ",";
			}
		});
		if($("input[name='assoSup']:checked").val()=='0'){
			if(str==""||str==undefined){
			top.jAlert('warning',"请选择需要修改的厂商",'提示消息');
			return false;
			}
		}
		str = str.substring(0, str.length-1);
		$.ajax({
			type : "post",
			data : {
				itemArticleNo : itemArticleNo,
				itemArticleStr : str,
				assoSup : $("input[name='assoSup']:checked").val()
			},
			url : ctx + "/item/batchupdate/cancelItemManualfacturerAction",
			success : function(data) {
				if (data.status == "success") {
					$("#sel_itemArticleNo").val("");
					$("#sel_itemArticleName").val("");
					$("#div_itemArticle").text("");
					top.jAlert('success',data.message,'提示消息');
				} else if(data.status=="error"){
					top.jAlert('error',data.message,'提示消息');
				}else{
					top.jAlert('warning',data.message,'提示消息');
				}
			}
		});
	}
}

//保存取消厂商商品
function cancelSupplierManualfacturer(){
	var div_name = $($("#div_itemManufacturer").find("div")).find("input");
	var str = "";
	var itemManufacturerNo = $.trim($("#sel_itemManufacturerNo").val());
	if (itemManufacturerNo == "") {
		$("#sel_itemManufacturerNo").addClass("errorInput");
		return false;
	} else {
		$.each(div_name, function(i,val){
			if (val.name != "") {
				str = str + val.value + ",";
			}
		});
		if($("input[name='assoItem']:checked").val()=='0'){
		if(str==""||str==undefined){
			top.jAlert('warning',"请选择需要修改的商品",'提示消息');
			return false;
		}
		}
		str = str.substring(0, str.length-1);
		$.ajax({
			type : "post",
			data : {
				itemNumModStr : $("#sel_itemManufacturerNo").val(),
				manualfacture : str,
				assoItem : $("input[name='assoItem']:checked").val()
			},
			url : ctx + "/item/batchupdate/cancelSupplierManualfacturerAction",
			success : function(data) {
				if (data.status == "success") {
					$("#sel_itemManufacturerNo").val("");
					$("#sel_itemManufacturerName").val("");
					$("#div_itemManufacturer").text("");
					top.jAlert('success',data.message,'提示消息');
				}else if(data.status=="error"){
					top.jAlert('error',data.message,'提示消息');
				} else {
					top.jAlert('warning',data.message,'提示消息');
				}
			}
		});
	}
}

// Bulk update - BidRate: string selected itemNo
function stringItemNo() {
	var itemNoList = ",";
	var select = $('#supSelectedItems > div > [name=vatItemNo]');
	if (select.length != 0){
		for (var i = 0; i <select.length -1; i++ ){
			itemNoList = itemNoList + select[i].value + ",";
		}
		itemNoList = itemNoList + select[select.length-1].value+',';
	}
	$("#itemBulkEditNo").val(itemNoList);
	return itemNoList;
}

//Bulk update - BidRate: 
function itemBulkEditRateDel(){
	
	$.each($("#supSelectedItems").find('div').find('[name=vatItemNo]'),function(index,val){
		var itemNo= parseInt(val.value);
		itemBulkEditRateMap.remove(itemNo);
	});
}

// Bulk update - BidRate: show supplier popup window
function supplierList(){
	$("#sel_supNo").removeClass('errorInput');
	openPopupWin(660,548,"/item/batchupdate/supplierWindow");	
}

//Bulk update - BidRate: show selected supplier on the main page
function confirmSelSup(){
	var update_sup = $("#popupWin").find(".btable_checked");
	if (update_sup.length!=0&&update_sup!=undefined) {
		$("#sel_supNo").val($(update_sup).find('input[name=supNo]').val());
		$("#sel_supName").val($(update_sup).find('input[name=supName]').val());
		closePopupWin();
	} else {
		top.jAlert('warning',"请选择厂商",'提示消息');
		return false;
	}
}

//Bulk update -BidRate: save the Bid rate change
function saveSupItemVatChange(){
	var supNo = $('#sel_supNo').val();
	var all = true;
	var itemNos = stringItemNo();
	var vat = $('#vatCode').val();
	var flag = true;
	
	if (supNo == "" || supNo == undefined){
		$("#sel_supNo").addClass("errorInput");
		$("#sel_supNo").attr("title", "请选择需要修改的厂商");
		flag = false;
	}
	if ( $("#part_select").attr("checked") == "checked"){
		if (itemNos == "," ){
			flag = false;
			top.jAlert('warning',"请选择待修改的商品",'提示消息');
		}
		else{
			all = false;
		}
	}
	else{
		itemNos = "";
	}
	
	if (vat == ""||vat==undefined){
		$("#vatCode").addClass("errorInput");
		$("#vatCode").attr("title", "请输入新的进价税率");
		flag = false;
	}
	if (flag == true){
		$.ajax({
			type : "post",
			data : {
				supNo : supNo,
				itemNos : itemNos,
				all : all,
				vat : vat
			},
			url : ctx + "/item/batchupdate/saveSupItemVat",
			success : function(data) {
				top.jAlert('success',"批量修改特殊进价税率成功",'提示消息');
				$("#sel_supNo").val("");
				$("#sel_supName").val("");
				$("#supSelectedItems").text("");
				$("#vatCode").get(0).selectedIndex=0;
				itemBulkEditRateMap=new Map();
			},
			error: function (data){
				top.jAlert('error',"修改失败",'提示消息');
			}
		});
	}
}

/*Bulk update - Item basic: get the checked itemNos in the item basic module */
function itemBasicCheckedNo(){
	var itemBasicNos=",";
	$.each($("input[name='itemNo']"),function(i,val){
		itemBasicNos=itemBasicNos+$(this).val()+',';
	});
	$("#itemBulkEditNo").val(itemBasicNos);
	return itemBasicNos;
}


function str_ItemNo() {
	var itemNoList = ",";
	var select = $("#div_itemArticle > div > input[name='comNo']");
	if (select.length != 0){
		for (var i = 0; i <select.length -1; i++ ){
			itemNoList = itemNoList + select[i].value + ",";
		}
		itemNoList = itemNoList + select[select.length-1].value+',';
	}
	$("#supBulkEditNo").val(itemNoList);
	return itemNoList;
}
function str_supplierNo() {
	var itemNoList = ",";
	var select = $("#div_itemManufacturer > div > input[name='itemNo']");
	if (select.length != 0){
		for (var i = 0; i <select.length -1; i++ ){
			itemNoList = itemNoList + select[i].value + ",";
		}
		itemNoList = itemNoList + select[select.length-1].value+',';
	}
	$("#itemBulkEditNo").val(itemNoList);
	return itemNoList;
}
function searchItemMsgbyNo(id){
	$('#'+id+'').datagrid('load', {
		itemNo : $('#itemNoInput').val()==''?'':$('#itemNoInput').val()
	});
}

function getVatList(){
	
	$.ajax({
		type: 'post',
		url : ctx + '/item/batchupdate/vatList',
		success : function (data){
			var select = $("#vatCode");
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.vatNo + ">" + "<p>" + value.vatNo
				+ "</p>" + "-&nbsp;"+ value.vatVal + "%</option>";
				select.append(option);
			});
		}
		
	});
}
/*Bulk Update - cancelAssoSupWithItem : cancel supplier association for item*/
function cancelSupForItem(){
	$("#sel_itemManufacturerName").val("");
	$("#sel_itemManufacturerNo").val("");
	$("#div_itemManufacturer").find('div').remove();
}
/*Bulk Update - cancelAssoSupWithItem : cancel item association for supplier*/
function cancelItemForSup(){
	$("#sel_itemArticleName").val("");
	$("#sel_itemArticleNo").val("");
	$("#div_itemArticle").find('div').remove();
	
}
/*triggle this event when clicking the all select radio in the bulk edit bid rate module*/
function itemEditBidRateAllSelect(){
	$('#supSelectedItems').find('div').remove();
	itemBulkEditRateMap=new Map();
}

//选择小分类弹出框
function selectSubGroupNo(catlgNo){
	$("#catlgCode_"+catlgNo).blur();
	openPopupWin(500, 265, '/item/batchupdate/selectSubGroupNoAction?catlgNo='+catlgNo);
}

//保存选择的小分类信息
function saveSelectSub(catlgNo){
	if(catlgNo=='undefined'){
	var subAllText=$("#subCodeCreate option:selected").text();
	var subAllId=$("#subCodeCreate option:selected").val();
	$('input[name=catlgCodeHeader]').val(subAllText);
	$('input[name=catlgIdHeader]').val(subAllId);
	$('input[name=catlgCodeHeader]').change();
	}
	else{
	var subText = $("#subCodeCreate option:selected").text();
	var subId= $("#subCodeCreate option:selected").val();
	$('#catlgCode_'+catlgNo).val(subText);
	$('#catlgId_'+catlgNo).val(subId);
    }
	closePopupWin();
}

//验证数字
function isNumber(obj){
	var search_str = new RegExp(/^[0-9]{1,7}$/);
	if (obj.value != "") {
		if(!search_str.test($.trim(obj.value))){
			$("#"+obj.id).addClass("errorInput");
		} else {
			$("#"+obj.id).removeClass("errorInput");
		}
	}
}


/*Bulk Edit-Validate itemChgPri and itemStoreMsg: validate the style of normBuyPrice */
function valiNormPri(obj,event){
	var isHavePoint=true;
	if(obj.value.indexOf('.')==-1){
		isHavePoint=false;
	}
	if(!isHavePoint){
		if(event.keyCode==190){	
			return true;
		}
	}
	if(event.keyCode == 8||event.keyCode == 37||event.keyCode == 39){
		return true;
	}
	else{
		var inputChar=String.fromCharCode(event.keyCode);
		if(/\d/.test(inputChar)){
				return true;
		}
		else{
			return false;
		}
	}
}

/*Bulk Edit-Validate itemChgPri and itemStoreMsg : format the normBuyPrice with the format Number(10,4)*/
function formatNorPri(obj,n){
	
	    var s=obj.value;
	    if(s==""||s==undefined){
	    	$(obj).removeAttr('title');
	    	$(obj).removeClass('errorInput');
	    	return false;
	    }
	    n = n > 0 && n <= 20 ? n : 2;
	    s=s.replace(/,/g,"");
	    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
	    if(!/^[0-9]{0,6}[\.]{0,1}[0-9]{0,4}$/.test(s)){
	    	$(obj).addClass('errorInput');
	    	$(obj).attr('title','价格整数部分不能超过6位，小数部分不能超过4位');
	    	return false;
	    }
	    else{
	    	$(obj).removeAttr('title');
	    	$(obj).removeClass('errorInput');
	    }
	    var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];  
	    t = "";  
	    for (var i = 0; i < l.length; i++) {  
	        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
	    }
       obj.value=t.split("").reverse().join("") + "." + r;

}

/*Bulk Edit-Validate Num : validate the style and the max length of the input */
function valiNumMax(obj,event,num){
	if(event.keyCode == 8||event.keyCode == 37||event.keyCode == 39){
		return true;
	}
	else{
		var inputChar=String.fromCharCode(event.keyCode);
		if(/\d/.test(inputChar)){
			if(obj.value.length>=num){	
				return false;
			}
		}
		else{
			return false;
		}
	}
}
/*Bulk Edit-Validate Character : validate the max length of the character */
function valiChar(obj,event,num){
	if(event.keyCode == 8||event.keyCode == 37||event.keyCode == 39){
		return true;
	}
	 var isValid=true;
     if(obj.value.length>=num){
    	 isValid=false;
	}
    return isValid;
}

/*Bulk Edit-Validate itemChgPri and itemStoreMsg : format the minBuyPrice with the format Number(8,2)*/
function formatMinPri(obj,n){
	    var s=obj.value;
	    if(s==""||s==undefined){
	    	$(obj).removeAttr('title');
	    	$(obj).removeClass('errorInput');
	    	return false;
	    }
	    n = n > 0 && n <= 20 ? n : 2;
	    s=s.replace(/,/g,"");
	    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
	    if(!/^[0-9]{1,6}[\.]{0,1}[0-9]{0,2}$/.test(s)){
	    	$(obj).addClass('errorInput');
	    	$(obj).attr('title','价格整数部分不能超过6位，小数部分不能超过2位');
	    	return false;
	    }
	    else{
	    	$(obj).removeAttr('title');
	    	$(obj).removeClass('errorInput');
	    }
	    var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];  
	    t = "";  
	    for (var i = 0; i < l.length; i++) {  
	        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
	    }
       obj.value=t.split("").reverse().join("") + "." + r;
}

/*Bulk-Edit : the definition of <method>Map()</method>*/
function Map() {
	 var struct = function(key, value) {
	  this.key = key;
	  this.value = value;
	 };
	 
	 var put = function(key, value){
	  for (var i = 0; i < this.arr.length; i++) {
	   if ( this.arr[i].key === key ) {
	    this.arr[i].value = value;
	    return;
	   }
	  }
	   this.arr[this.arr.length] = new struct(key, value);
	 };
	 
	 var get = function(key) {
	  for (var i = 0; i < this.arr.length; i++) {
	   if ( this.arr[i].key === key ) {
	     return this.arr[i].value;
	   }
	  }
	  return null;
	 };
	 
	 var remove = function(key) {
	  var v;
	  for (var i = 0; i < this.arr.length; i++) {
	   v = this.arr.pop();
	   if ( v.key === key ) {
	    continue;
	   }
	   this.arr.unshift(v);
	  }
	 };
	 
	 var size = function() {
	  return this.arr.length;
	 };
	 
	 var isEmpty = function() {
	  return this.arr.length <= 0;
	 };
	 this.arr = new Array();
	 this.get = get;
	 this.put = put;
	 this.remove = remove;
	 this.size = size;
	 this.isEmpty = isEmpty;
	}

function itemEditRateChageSup(){
	$('#supSelectedItems').find('div').remove();
	itemBulkEditRateMap=new Map();
}

//delete the choosed item when clicking the trash basket.
function itemBulkEditDel(){
	$.each($("input.isChecks:checked").parent().find('[name=itemNo]'),function(index,val){
		var itemNo= val.value;
		$("#itemBulkEditNo").val($("#itemBulkEditNo").val().replace(','+itemNo+',',','));

	});
}

//delete the choosed supplier when clicking the trash basket.
function supBulkEditDel(){
	$.each($("input.isChecks:checked").parent().find('[name=comNo]'),function(index,val){
		var comNo= val.value;
		$("#supBulkEditNo").val($("#supBulkEditNo").val().replace(','+comNo+',',','));

	});	
}
//BULK EDIT-Item Base Info:open the pop window of brand 
function openBrandWindow(brandNo) {
	$("#top_menu").focus();
	openPopupWin(650, 510, '/item/batchupdate/showBrandListPop?brandNo='+brandNo);
}
/*validate the integer's length*/
function valNumOnBlur(obj,maxLength,minLength){
	
	if(obj.value==""||obj.value==undefined){
		return false;
	}	
	if(maxLength==""||maxLength==undefined){
		maxLengt=0;
	}
	if(minLength==""||minLength==undefined){
		minLength=0;
	}
	if(/\d/.test(obj.value)){
		$(obj).removeClass('errorInput');
		$(obj).removeAttr('title');
		if(obj.value>=0){
		$(obj).removeClass('errorInput');
		$(obj).removeAttr('title');
		if(obj.value.length<=maxLength){
			$(obj).removeClass('errorInput');
			$(obj).removeAttr('title');
			if(obj.value.length>=minLength){
				$(obj).removeClass('errorInput');
				$(obj).removeAttr('title');
			}
			else{
				$(obj).addClass('errorInput');
				$(obj).attr("title","请输入大于或等于"+minLength+"位的数字");	
			}
		}
		else{
			$(obj).addClass('errorInput');
			$(obj).attr("title","请输入小于或等于"+maxLength+"位的数字");	
		}
		}
		else{
			$(obj).addClass('errorInput');
			$(obj).attr("title","请输入大于0的数字");	
		}
	}
	else{
		$(obj).addClass('errorInput');
		$(obj).attr("title","请输入数字");
	}
}
/*validate the string's length*/
function valStrOnBlur(obj,maxLength,minLength){
	
	if(obj.value==""||obj.value==undefined){
		return false;
	}	
	if(maxLength==""||maxLength==undefined){
		maxLengt=0;
	}
	if(minLength==""||minLength==undefined){
		minLength=0;
	}
		if(obj.value.length<=maxLength){
			$(obj).removeClass('errorInput');
			$(obj).removeAttr('title');
			if(obj.value.length>=minLength){
				$(obj).removeClass('errorInput');
				$(obj).removeAttr('title');
			}
			else{
				$(obj).addClass('errorInput');
				$(obj).attr("title","请输入大于或等于"+minLength+"位的字符串");	
			}
		}
		else{
			$(obj).addClass('errorInput');
			$(obj).attr("title","请输入小于或等于"+maxLength+"位的字符串");	
		}

}
/*validate the search input in the bulk edit module*/
function valInputInSearch(obj, maxNoLength, maxNameLength) {
	if (/\d/.test($(obj).val())) {
		$(obj).removeClass('errorInput');
		$(obj).removeAttr('title');
		if ($(obj).val().length > maxNoLength) {
			$(obj).addClass('errorInput');
			$(obj).attr("title", "请输入小于或等于" + maxNoLength + "位的数字");
			return false;
		} else {
			$(obj).removeClass('errorInput');
			$(obj).removeAttr('title');
		}
	}else{
		$(obj).addClass('errorInput');
		$(obj).attr("title", "请输入数字");
		return false;
	}
	/*else {
		if ($(obj).val().length > maxNameLength) {
			$(obj).addClass('errorInput');
			$(obj).attr("title", "请输入小于或等于" + maxNameLength + "位的字符串");
			return false;
		} else {
			$(obj).removeClass('errorInput');
			$(obj).removeAttr('title');
		}
	}*/
}

