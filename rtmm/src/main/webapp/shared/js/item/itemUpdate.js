//添加组商品
function itemComposed_addGroupItem(obj){
	var str = "<div class='ig' style='margin-left:10px;'><input class='isCheck' type='checkbox' /><div class='iconPut fl_left w10'><input class='w75' type='text' /> <div class='ListWin'></div></div><input type='text' class='w12_5 inputText Black' /><input type='text' class='w5 inputText' /><input type='text' class='w5 inputText' /><input type='text' class='w5 inputText' /><span>=</span><input type='text' class='w5 inputText' /><input type='text' class='w5 inputText' /><span>x</span><input type='text' class='w5 inputText' /><input type='text' class='w5 inputText' /><input type='text' class='w10 inputText' /><input type='text' class='w10 inputText' /><input type='text' class='w5 inputText' /></div>";
	$(obj).parent().prev().append($("#itemBarDiv").html());
}

function str_ItemCorrelationNo() {
	var itemNoList = ",";
	var select = $($("#correlationdiv").find("div")).find("input[name='itemNo']");
	if (select.length != 0){
		for (var i = 0; i <select.length; i++ ){
			itemNoList = itemNoList + select[i].value + ",";
		}
	}
	$("#itemNoStr").val(itemNoList);
	return itemNoList;
}

//母货类型选择事件
$("#itemType").die();
$("#itemType").live("change",function(){
	itemArticleNoSelect();
});
function itemArticleNoSelect(){
	var itemArticleNo = $.trim($("#sel_itemArticleNo").val());
	if (itemArticleNo != "") {
		$.ajax( {
			type : 'post',
			url : ctx + '/item/basicInformation/itemNoTypeSelectAction',
			async : false,
			data :{
				itemNoType : $("#itemType").val()
				/*itemNo : $("#sel_itemArticleNo").va()*/
			},
			success : function(data) {
				var itemNo = $("#itemType").val();
				if (itemNo == "5") {
		         	$("#startDate").val('');
		        	$("#endDate").val('');
					$("#effectiveDateDiv").css("display","block");
				} else {
					$("#effectiveDateDiv").css("display","none");
				}
				$("#sonItemNoDiv").children().remove();
				$("#sonItemNoDiv").html(data);
			}
		});
	} else {
		$("#sel_itemArticleNo").addClass("errorInput");
	}
}

//根据itemNo查询
function correlation_SearchItem(){
	   var itemNo =  $("#sel_itemArticleNo").val();
	   	$.ajax( {
	   		type : 'post',
	   		url : ctx + '/item/query/itemBaseInfo',
	   		data :{
	   			itemNo:itemNo
	   		},
	   		success : function(data) {
	   			$("#content").children().remove();
	 			$("#content").html(data);
	 			//设置storeName
	 			setItremName();
	 			//设置订货方式
	 			setItemStoreInfoOrdCreatMethd();
				//屏蔽查询
				$('#Tools6').removeClass('Tools6').addClass('Tools6_disable').unbind("click");
				//重置按钮
				$('#Tools20').removeClass('Tools20_disable').addClass('Tools20').bind('click', function() {
					$(':input').val(null);
					$("#storeNo").empty();
					$("#storeNo").html("");
					$(':input:checkbox').attr('checked',false);
					//点亮查询
					$('#Tools6').removeClass('Tools6_disable').addClass('Tools6').bind('click', function() {
						search();
					});
					$('#Tools20').removeClass('Tools20').addClass('Tools20_disable').unbind("click");
				});
				//图标点亮
				$("#Tools22").attr('class', "Icon-size1 Tools22_on");
				$("#Tools21").attr('class', "Icon-size1 Tools21");
				$($("#Tools22").parent()).addClass("ToolsBg");
				$($("#Tools21").parent()).removeClass("ToolsBg");
	   		}
	   	}); 
	   }

//选择某条数据是否为全选
$(".isChecks").live("click",function(){
       var checkAll=true;
       var itemCheckBoxList=$(".zz_2").find("input.isChecks");
    $.each(itemCheckBoxList,function(index,item){
        if(this.checked==false){
            checkAll=false;
            return false;
        };
    });
    if(!checkAll){
        $(".isCheckAlls").attr("checked",false);
    }
    else{
        $(".isCheckAlls").attr("checked",true);
        $($($("#itemBarDiv").find("div")[0]).find('input')[0]).attr("checked",false);
    }
        
});
//全选事件
$(".isCheckAlls").live("click",function(){
    if(this.checked){
        $(".isChecks").attr("checked",true);    
        $($($("#itemBarDiv").find("div")[0]).find('input')[0]).attr("checked",false);
    }
    else{
        $(".isChecks").attr("checked",false);    
    }
    
});

//删除事件
$(".deleteCheckeds").live("click",function(){
    $("input.isChecks:checked").parent().remove();
    $(".isCheckAlls").attr("checked",false);
});
 
//选择指定的货号
 function saveCorrelationArticleNo(){
	item_itemCorrelation($("#update_items").datagrid("getSelected").itemNo);
 	closePopupWin();
 }
 
//选择指定的子货号
function saveSonCorrelationArticleNo(){
	var itemArticle = $("#itemNoStr").val().substring(1,$("#itemNoStr").val().length);
	var itemType = $("#itemType").val();
	if (itemType == "3" || itemType == "4") {
		$("#correlationdiv").html("");
        	$.ajax({
        		type : 'post',
        		url : ctx + '/item/basicInformation/showAlterSonItemMessAction',
        		data : {
        			itemNos : itemArticle,
                },
        		success : function(data){
        			if (data.result != null) {
        				$.each(data.result,function(i,val){
        				var  str = "<div class='ig' style='margin-left: 10px;'>";
        				str = str + "<input class='isChecks' type='checkbox' />&nbsp;";
        				str = str + "<div class='iconPut fl_left w12_5'>";
        				str = str + "<input id='itemNo' name='itemNo' class='w75' type='text' value="+val.itemNo+" readonly='readonly' />";
        				str = str + "</div>";
        				str = str + "<input name='itemName' type='text' value=\""+val.itemName+"\" class='w25 inputText Black' readonly='readonly'/>&nbsp;";
        				str = str + "<input name='status' type='text' value=\""+getDictValue('ITEM_BASIC_STATUS',val.status)+"\" class='w12_5 inputText Black' readonly='readonly' />&nbsp;";
        				str = str + "<input name='sonSellUnit' type='text' value=\""+getDictValue('UNIT',val.sellUnit,2)+"\" class='w12_5 inputText Black' readonly='readonly' />&nbsp;";
        				str = str + "<input name='stdSellPrice' type='text' value=\""+val.stdSellPrice+"\" class='w12_5 inputText Black' readonly='readonly' />&nbsp;";
        				str = str + "<input name='stdBuyPrice' type='text' value=\""+val.stdBuyPrice+"\" class='w12_5 inputText Black' readonly='readonly' />";
        				str = str + "</div>";
        				$("#correlationdiv").append(str);
        				});
        			}
        		}
        	});
	} else {
		$("#correlationdiv").html("");
        	$.ajax({
        		type : 'post',
        		url : ctx + '/item/basicInformation/showAlterSonItemMessAction',
        		data : {
        			itemNos : itemArticle,
                },
        		success : function(data){
        			if (data.result != null) {
        				$.each(data.result,function(i,val){
        				var cntdQty = $.trim(val.cntdQty);
        				if (cntdQty == "") {
        					cntdQty = "0";
        				}
        				var valPct = $.trim(val.valPct);
        				if (valPct == "" || valPct == "0") {
        					valPct = "0.00";
        				}
        				var  str = '<div class="ig" style="margin-left: 10px;">';
        				str = str + '<input class="isChecks" type="checkbox" />';
        				str = str + '<div class="iconPut fl_left w10">';
        				str = str + '<input id="itemNo" name="itemNo" class="w75" type="text" value='+$.trim(val.itemNo)+' readonly="readonly"/>';
        				str = str + '</div>&nbsp;';
        				str = str + '<input name="itemName" type="text" class="w12_5 inputText Black" readonly="readonly" value="'+val.itemName+'" />&nbsp;';
        				str = str + '<input name="status" type="text" class="w5 inputText Black" readonly="readonly" value='+getDictValue('ITEM_BASIC_STATUS',val.status)+' />&nbsp;';
        				str = str + '<input id="cntdQty" name="cntdQty" onblur="writeCntdQtyDecimals(this)" maxlength="3" onkeyup="numberVerify(this)" type="text" class="w5 inputText" value='+cntdQty+' ></input>&nbsp;';
        				str = str + '<input name="sellUnit" type="text" class="w5 inputText Black" readonly="readonly" value='+getDictValue('UNIT',val.sellUnit,2)+' />&nbsp;';
        				str = str + '<span>=</span>&nbsp;';
        				str = str + '<input name="numOfPackUnit" type="text" class="w5 inputText Black" readonly="readonly" value='+$.trim(val.numOfPackUnit)+' ></input>&nbsp;';
        				str = str + '<input name="packUnit" type="text" class="w5 inputText Black" readonly="readonly" value='+$.trim(val.packUnit)+' ></input>&nbsp;';
        				str = str + '<span>x</span>&nbsp;';
        				str = str + '<input name="baseVol" type="text" class="w5 inputText Black" readonly="readonly" value='+$.trim(val.baseVol)+' ></input>&nbsp;';
        				str = str + '<input name="baseVolUnit" type="text" class="w5 inputText  Black" readonly="readonly" value='+$.trim(val.baseVolUnit)+' ></input>&nbsp;';
        				str = str + '<input name="stdBuyPrice" type="text" class="w10 inputText Black" readonly="readonly" value='+$.trim(val.stdBuyPrice)+' ></input>&nbsp;';
        				str = str + '<input name="stdSellPrice" type="text" class="w10 inputText Black" readonly="readonly" value='+val.stdSellPrice+' />&nbsp;';
        				str = str + '<input id="valPct" name="valPct" onblur="writeValPctDecimals(this)" maxlength="7" onkeyup="decimalsVerify(this)" type="text" class="w5 inputText" value='+valPct+' ></input>';
        				str = str + '</div>';
        				$("#correlationdiv").append(str);
        			});
        			}
        		}
        	});
	}
	
	closePopupWin();
}
//选择指定的子货号整箱
function saveSonCorrelationFullArticleNo(){

	if($("#update_items").css("display")!="none"||$("#update_items").datagrid("getSelected")==null){
     	$("#sonItemNo").val("");
    	$("#sonItemName").val("");
    	$("#sonItemEnName").val("");
    	$("#sonSellUnit").val("");
    	$("#sonNumOfPackUnit").val("");
    	$("#sonPackUnit").val("");
    	$("#sonBaseVol").val("");
    	$("#sonBaseVolUnit").val("");
    	$("#sonCntdQty").val("");
    	$("#sonStatus").val("");
    	$("#sonMajorSupNo").val("");
    	$("#sonMajorSupName").val("");
    	$("#sonStdBuyPrice").val("");
    	$("#sonBuyVatNo").val("");
    	$("#sonBuyVatVal").val("");
    	$("#sonStdSellPrice").val("");
    	$("#sonSellVatNo").val("");
    	$("#sonSellVatVal").val("");
    	closePopupWin();
	}
	else{
	var rowData = $("#update_items").datagrid("getSelected");
	$.ajax({
		type : 'post',
		url : ctx + '/item/basicInformation/showAlterSonItemMessAction',
		data : {
			itemNos : rowData.itemNo,
        },
		success : function(data){
			
			if(data.result!=null){
			var rowData = data.result[0];
			$("#sonItemNo").val(rowData.itemNo);
			$("#sonItemName").val(rowData.itemName);
			$("#sonItemEnName").val(rowData.itemEnName);
            if(rowData.sellUnit==undefined){
            	$("#sonSellUnit").val("");
            }else{
            	$("#sonSellUnit").val(getDictValue('UNIT',rowData.sellUnit,2));
            }
			$("#sonNumOfPackUnit").val(rowData.numOfPackUnit);
            if(rowData.packUnit==undefined){
            	$("#sonPackUnit").val("");
            }else{
            	$("#sonPackUnit").val(getDictValue('UNIT',rowData.packUnit,2));
            }
            
			$("#sonBaseVol").val(rowData.baseVol);
            if(rowData.baseVolUnit==undefined){
            	$("#sonBaseVolUnit").val("");
            }else{
            	$("#sonBaseVolUnit").val(getDictValue('UNIT',rowData.baseVolUnit,2));
            }
            
			$("#sonCntdQty").val(rowData.cntdQty);
			
            if(rowData.status==undefined){
            	$("#sonStatus").val("");
            }else{
            	$("#sonStatus").val(getDictValue('ITEM_BASIC_STATUS',rowData.status,1));
            }
			$("#sonMajorSupNo").val(rowData.comNo);
			$("#sonMajorSupName").val(rowData.comName);
			$("#sonStdBuyPrice").val(rowData.stdBuyPrice);
			$("#sonBuyVatNo").val(rowData.buyVatNo);
			$("#sonBuyVatVal").val(rowData.buyVatVal);
			$("#sonStdSellPrice").val(rowData.stdSellPrice);
			$("#sonSellVatNo").val(rowData.sellVatNo);
			$("#sonSellVatVal").val(rowData.sellVatVal);
			}
        	closePopupWin();
		}
	});
	}
}
//商品关联
function item_itemCorrelation(obj){
	$.ajax( {
		type : 'post',
		url : ctx + '/item/basicInformation/composedEditAction',
		data :{
			itemNo:obj
		},
		success : function(data) {
			$("#content").children().remove();
			$("#content").html(data);
		},
		error : function(data) {
			$("#content").html("<font>系统建设中，敬请期待。</font>");
		}
	});
}

//母货号弹出框
function itemCorrelationArticleSelect(){
	openPopupWin(630,548,"/item/basicInformation/itemCorrelationArticleSelectWindowAction");
	$("#sel_itemArticleNo").removeClass("errorInput");
}

//子货号弹出框
function sonItemCorrelationArticleSelect(){
	openPopupWin(660,548,"/item/basicInformation/sonItemCorrelationArticleSelectWindowAction?itemIndex="+str_ItemCorrelationNo());
}

//子货号正想弹出框
function sonItemCorrelationFullArticleSelect(){
	openPopupWin(630,548,"/item/basicInformation/sonItemCorrelationFullArticleSelectWindowAction");
}
//子货号信息
function sonItemBasicinfo(obj,index){
	$.ajax({
		type : 'post',
		url : ctx + '/item/basicInformation/sonItemBasicinfoAction',
		data :{
			soonItemNo : $.trim(obj),
			itemIndex : index
		},
		success : function(data) {
			var igdiv = $("#correlationdiv").find(".ig")[data.index];
			$(igdiv).find("input[name='itemNo']").attr("value",data.itemBasicVO.itemNo);
			$(igdiv).find("input[name='itemName']").attr("value",data.itemBasicVO.itemName);
			$(igdiv).find("input[name='status']").attr("value",getDictValue('ITEM_BASIC_STATUS',data.itemBasicVO.status));
			$(igdiv).find("input[name='cntdQty']").attr("value",getDictValue('UNIT',data.itemBasicVO.cntdQty));
			$(igdiv).find("input[name='sellUnit']").attr("value",data.itemBasicVO.SellUnit);
			$(igdiv).find("input[name='numOfPackUnit']").attr("value",data.itemBasicVO.numOfPackUnit);
			$(igdiv).find("input[name='packUnit']").attr("value",data.itemBasicVO.packUnit);
			$(igdiv).find("input[name='baseVol']").attr("value",data.itemBasicVO.baseVol);
			$(igdiv).find("input[name='baseVolUnit']").attr("value",data.itemBasicVO.baseVolUnit);
			$(igdiv).find("input[name='stdSellPrice']").attr("value",data.itemBasicVO.stdSellPrice);
			$(igdiv).find("input[name='stdBuyPrice']").attr("value",data.itemBasicVO.stdBuyPrice);
			$(igdiv).find("input[name='valPct']").attr("value",data.itemBasicVO.valPct);
		}
	});
}

//子货号母货类型3、4信息
function sonItemTypeinfo(){
	$.ajax({
		type : 'post',
		url : ctx + '/item/basicInformation/itemCorrelationFullArticleSelectAction',
		data :{
        	itemNo : $.trim($("#sel_itemArticleNo").val()),
        	rltnType : $.trim($("#itemType").val()),
        	page : "1",
        	rows : "9999"
		},
		success : function(data) {
			$.each(data.rows,function(i,val){
				var  str = "<div class='ig' style='margin-left: 10px;'>";
				str = str + "<input class='isChecks' type='checkbox' />&nbsp;";
				str = str + "<div class='iconPut fl_left w12_5'>";
				str = str + "<input id='itemNo' name='itemNo' class='w75' type='text' value="+val.itemNo+" readonly='readonly' />&nbsp;";
				str = str + "<div class='ListWin' ></div>";
				str = str + "</div>";
				str = str + "<input name='itemName' type='text' value="+val.itemName+" class='w25 inputText Black' readonly='readonly'/>&nbsp;";
				str = str + "<input name='status' type='text' value="+getDictValue('ITEM_BASIC_STATUS',val.status)+" class='w12_5 inputText Black' readonly='readonly' />&nbsp;";
				str = str + "<input name='sonSellUnit' type='text' value="+getDictValue('UNIT',val.sellUnit,2)+" class='w12_5 inputText Black' readonly='readonly' />&nbsp;";
				str = str + "<input name='stdSellPrice' type='text' value="+val.stdSellPrice+" class='w12_5 inputText Black' readonly='readonly' />&nbsp;";
				str = str + "<input name='stdBuyPrice' type='text' value="+val.stdBuyPrice+" class='w12_5 inputText Black' readonly='readonly' />";
				str = str + "</div>";
				$("#correlationdiv").append(str);
			});

		}
	});
}

//子货号母货类型2信息
function sonItemTypeinfo_2(){
	$.ajax({
		type : 'post',
		url : ctx + '/item/basicInformation/itemCorrelationFullArticleSelectAction',
		data :{
        	itemNo : $.trim($("#sel_itemArticleNo").val()),
        	rltnType : $.trim($("#itemType").val()),
        	page : "1",
        	rows : "9999"
		},
		success : function(data) {
			$.each(data.rows,function(i,val){
				var cntdQty = $.trim(val.cntdQty);
				if (cntdQty == "") {
					cntdQty = "0";
				}
				var valPct = $.trim(val.valPct);
				if (valPct == "" || valPct == "0") {
					valPct = "0.00";
				}
				var  str = '<div class="ig" style="margin-left: 10px;">';
				str = str + '<input class="isChecks" type="checkbox" />';
				str = str + '<div class="iconPut fl_left w10">';
				str = str + '<input id="itemNo" name="itemNo" class="w75" type="text" value='+$.trim(val.itemNo)+' />';
				str = str + '<div class="ListWin" ></div>';
				str = str + '</div>&nbsp;';
				str = str + '<input name="itemName" type="text" class="w12_5 inputText Black" readonly="readonly" value='+val.itemName+' />&nbsp;';
				str = str + '<input name="status" type="text" class="w5 inputText Black" readonly="readonly" value='+getDictValue('ITEM_BASIC_STATUS',val.status)+' />&nbsp;';
				str = str + '<input id="cntdQty" name="cntdQty" onblur="writeCntdQtyDecimals(this)" maxlength="3" onkeyup="numberVerify(this)" type="text" class="w5 inputText" value='+cntdQty+' ></input>&nbsp;';
				str = str + '<input name="sellUnit" type="text" class="w5 inputText Black" readonly="readonly" value='+getDictValue('UNIT',val.sellUnit)+' />&nbsp;';
				str = str + '<span>=</span>&nbsp;';
				str = str + '<input name="numOfPackUnit" type="text" class="w5 inputText Black" readonly="readonly" value='+$.trim(val.numOfPackUnit)+' ></input>&nbsp;';
				str = str + '<input name="packUnit" type="text" class="w5 inputText Black" readonly="readonly" value='+$.trim(val.packUnit)+' ></input>&nbsp;';
				str = str + '<span>x</span>&nbsp;';
				str = str + '<input name="baseVol" type="text" class="w5 inputText Black" readonly="readonly" value='+$.trim(val.baseVol)+' ></input>&nbsp;';
				str = str + '<input name="baseVolUnit" type="text" class="w5 inputText  Black" readonly="readonly" value='+$.trim(val.baseVolUnit)+' ></input>&nbsp;';
				str = str + '<input name="stdBuyPrice" type="text" class="w10 inputText Black" readonly="readonly" value='+$.trim(val.stdBuyPrice)+' ></input>&nbsp;';
				str = str + '<input name="stdSellPrice" type="text" class="w10 inputText Black" readonly="readonly" value='+val.stdSellPrice+' />&nbsp;';
				str = str + '<input id="valPct" onblur="writeValPctDecimals(this)" name="valPct" maxlength="7" onkeyup="decimalsVerify(this)" type="text" class="w5 inputText" value='+valPct+' ></input>';
				str = str + '</div>';
				$("#correlationdiv").append(str);
			});

		}
	});
}
//子货号母货类型1、5信息
function sonFullItemBasicinfo(){
	$.ajax({
		type : 'post',
		url : ctx + '/item/basicInformation/itemCorrelationFullArticleSelectAction',
		data :{
        	itemNo : $.trim($("#sel_itemArticleNo").val()),
        	rltnType : $.trim($("#itemType").val()),
        	page : "1",
        	rows : "9999"
		},
		success : function(data) {
			if (data.rows.length > 0) {
				var rowData = data.rows[0];
				$("#startDate").val(new Date(rowData.reltvStartDate).format('yyyy-MM-dd'));
				$("#endDate").val(new Date(rowData.reltvEndDate).format('yyyy-MM-dd'));
				$("#sonItemNo").val(rowData.itemNo);
				$("#sonItemName").val(rowData.itemName);
				$("#sonItemEnName").val(rowData.itemEnName);
                if(rowData.sellUnit==undefined){
                	$("#sonSellUnit").val("");
                }else{
                	$("#sonSellUnit").val(getDictValue('UNIT',rowData.sellUnit,2));
                }
				$("#sonNumOfPackUnit").val(rowData.numOfPackUnit);
                if(rowData.packUnit==undefined){
                	$("#sonPackUnit").val("");
                }else{
                	$("#sonPackUnit").val(getDictValue('UNIT',rowData.packUnit,2));
                }
				$("#sonBaseVol").val(rowData.baseVol);
                if(rowData.baseVolUnit==undefined){
                	$("#sonBaseVolUnit").val("");
                }else{
                	$("#sonBaseVolUnit").val(getDictValue('UNIT',rowData.baseVolUnit,2));
                }
				$("#sonCntdQty").val(rowData.cntdQty);
                if(rowData.status==undefined){
                	$("#sonStatus").val("");
                }else{
                	$("#sonStatus").val(getDictValue('ITEM_BASIC_STATUS',rowData.status,1));
                }
				$("#sonMajorSupNo").val(rowData.majorSupNo);
				$("#sonMajorSupName").val(rowData.majorSupName);
				$("#sonStdBuyPrice").val(rowData.stdBuyPrice);
				$("#sonBuyVatNo").val(rowData.buyVatNo);
				$("#sonBuyVatVal").val(rowData.buyVatVal);
				$("#sonStdSellPrice").val(rowData.stdSellPrice);
				$("#sonSellVatNo").val(rowData.sellVatNo);
				$("#sonSellVatVal").val(rowData.sellVatVal);
			}
		}
	});
}

function removeElements(obj){
	$(obj).removeClass('errorInput');
	$(obj).removeAttr('title');
}

// 修改商品條碼訊息: 新增一筆條碼
function newBarcode(){
	last = $('#barcodeList .ig[id!=template] #barcode:last');
	if ($(last).val() == "" || $(last).hasClass("errorInput") ){
		$(last).attr("class", "w110 inputText errorInput");
		return;
	}
	if ($('#barcodeList .ig:visible').length <= 15){
		var content = $('#template').clone();
		content.removeAttr('id');
		content.find(':checkbox').attr('class', 'isCheck');
		content.show();
		$('#barcodeList').append(content);
	}
	else{
		top.jAlert('warning','一个商品只能有15个条码', '消息提示');
	}
}

//修改商品條碼訊息: 刪除條碼
function deleteBarcode(delBarcodeList){
	$(".ig #isCheck:checked ~ #barcode").parent().remove();
	$(".isCheckAll").attr("checked",false);
	return delBarcodeList;
}

//修改商品條碼訊息: 驗證新條碼
function checkValidBarcode(object){
	
	var value = $.trim(object.value); 
	if (value != ''){ 
		var pattern = (/^([0-9]{13})+$/) ;
		if(value.substr(0,1) == 2 || value.length != 13 || !pattern.test(value)){
			object.setAttribute("class", "w120 inputText errorInput");
			object.setAttribute("title", "请输入符合规范的国际条码");
		} else{
			$.ajax({
				type : 'POST',
				url : ctx + "/item/update/checkBarcode",
				async : false,
				dataType : 'json',
				data : {
					newBarcode : value
				},
				success : function(data) {
					if (!data.status){
						object.setAttribute("class", "w110 inputText errorInput");
						object.setAttribute("title", data.msg);	
					}
				},
				error : function(data) {
					top.jAlert('error', '条码检查失败', '消息提示');
				}
				
			});
			
		}
	}
}

//修改商品條碼訊息: 儲存barcode修改
function saveBarcodeUpdate(delBarcodeList) {

	if ($('#barcodeList .ig[id!=template]').length == 0 || $('#barcodeList .ig[id!=template] #barcode:first').val() ==''){
		top.jAlert("warning","条码不可为空","消息提示");
		return;
	}
	if ($('.errorInput').length == 0) {
		var list = $('#barcodeList >.ig> #barcode');
		var barcodes = [];
		var itemNo = $('#itemNo').val();
		var itemName = $('#itemName').val();
		$.each(list, function(index, item) {
			var value = $.trim(list[index].value);
			if (value != '') {
				barcodes.push(list[index].value) ;
			}
		});
		
		$.ajax({
			type : 'POST',
			url : ctx + '/item/update/saveBarcodeUpdate',
			async : false,
			dataType : 'json',
			data : {
				itemNo : itemNo,
				itemName : itemName,
				barcodes : barcodes.toString()
			},
			success : function(data) {
				if (data.status == 'SUCCESS'){
					top.jAlert('success', data.msg,'提示消息',function(){	
						$('#ovreviewContent').load(ctx + '/item/query/itemBarcodeInfo', getParam());
					});
				}else{
					top.jAlert('error', data.msg, '提示消息');
				}
			},
			error : function(data) {
				top.jAlert('error', '操作失败', '提示消息');
			}
		});

	}

}

//保存商品关联修改、新增，类型1、5。
function saveItemCorrelation_1_5(){
		$.ajax( {
			type : 'post',
			url : ctx + '/item/basicInformation/saveItemCorrelationAction',
			data :{
				itemNo : $("#sel_itemArticleNo").val(),
				rltnType : $("#itemType").val(),
				sonItemNo : $("#sonItemNo").val(),
				sonCntdQty : $("#sonCntdQty").val(),
				sonItemEnName : $.trim($("#sonItemEnName").val()),
				startDate : $.trim($("#startDate").val()),
				endDate : $.trim($("#endDate").val())
			},
			success : function(data) {	
				if (data.status == "success") {
					top.jAlert('success', data.message,'提示消息');
				} else {
					top.jAlert('error', data.message ,'提示消息');
				}
			}
		});
}

//保存商品关联修改、新增，类型2。
function saveItemCorrelation_2(){
	$.ajax( {
		type : 'post',
		url : ctx + '/item/basicInformation/saveItemCorrelationTwoAction',
		data :{
			itemNo : $("#sel_itemArticleNo").val(),
			rltnType : $("#itemType").val(),
			sonItemStr : convertJsonStr("correlationdiv")
		},
		success : function(data) {
			if (data.status == "success") {
				top.jAlert('success', data.message,'提示消息');
			} else {
				top.jAlert('error', data.message ,'提示消息');
			}
		}
	});
}
// 修改商品DC訊息: 檢查輸入
function inputCheck(){
	// 必填欄位
	$('.required').blur(function(){
		if($.trim($(this).val())=='' && !($(this).hasClass())){
			$(this).addClass('errorInput');
		}
	});
	$('.required').focus(function(){
		$(this).removeClass('errorInput');
	});
	
	// 數字格式
	$('.number').blur(function(){
		var pattern = new RegExp(/^\d*$/);
		if ($.trim($(this).val()!= '')){
			var result = pattern.test($(this).val());
			if (!result){
				$(this).addClass("errorInput");
				$(this).attr("title", "數字格式");
			}
		}
	});
	$('.number').focus(function(){
		$(this).removeClass('errorInput');
	});
	
	// 六位數字包含小數點兩位
	$('.scale62').blur(function(){
		var pattern = new RegExp(/^\d{0,4}[.]{0,1}\d{0,2}$/);
		if ($.trim($(this).val()!= '')){
			var result = pattern.test($(this).val());
			if (!result){
				$(this).addClass("errorInput");
				$(this).attr("title", "格式需为4位整数与小数点至多2位");
			}
		}
	});
	$('.scale62').focus(function(){
		$(this).removeClass('errorInput');
	});
	
	// 十位數字包含小數點三位
	$('.scale103').blur(function(){
		var pattern = new RegExp(/^\d{0,10}[.]{0,1}\d{0,3}$/);
		if ($.trim($(this).val()!= '')){
			var result = pattern.test($(this).val());
			if (!result){
				$(this).addClass("errorInput");
				$(this).attr("title", "格式需为10位整数与小数点至多3位");
			}
		}
	});
	$('.scale103').focus(function(){
		$(this).removeClass('errorInput');
	});
	
}

// 商品修改DC訊息: 儲存變更
function saveDCupdate(){
	
	if ($('.errorInput').length != 0){
		return
	}
	else{
		var itemDCinfo = JSON.stringify($('#dcInfo').serializeObject());
		$.ajax({
			type : 'POST',
			url : ctx + '/item/update/saveDCupdate',
			data :{
				itemNo : $('#itemNo').val(),
				itemDCinfo : itemDCinfo
			},
			dataType : 'json',
			success : function(data){
				if (data.status == 'SUCCESS') {
					top.jAlert('success', data.msg, '提示消息');
				}
				else{
					top.jAlert('error', data.msg, '提示消息');
				}
			},
			error : function(data){
				top.jAlert('error', data.msg, '提示消息');
			}
		});
	}
}

// copied from item_create.js
$.fn.serializeObject = function() 
{ 
   var o = {}; 
   var a = this.serializeArray(); 
   $.each(a, function() { 
       if (o[this.name]) { 
           if (!o[this.name].push) { 
               o[this.name] = [o[this.name]]; 
           } 
           o[this.name].push(this.value || null); 
       } else { 
           o[this.name] = this.value || null; 
       } 
   }); 
   return o; 
};

//数组转换Json
function convertJsonStr(obj){
	var div_name = $("#"+obj).find(".ig");
    var comma = "--";
    var bracket_left = "{";
    var bracket_right = "}";
    var div_str = "";
    $.each(div_name, function(i,val){
        var str = "";
        var div_name_ig = $(div_name[i]).find("input");
        $.each(div_name_ig,function(j, val){
            if (val.id != "") {
                str = str + '"' + val.id + '":"' + val.value + '",';
            }
        });
        str = str.substring(0,str.length-1);
        div_str = div_str + bracket_left + str + bracket_right + comma;
    });
    div_str = div_str.substring(0, div_str.length-2);
    return div_str;
}
//正数字验证
function numberVerify(obj){
	$(obj).keyup(function(){  //keyup事件处理 
		$(obj).val($(obj).val().replace(/\D|^0/g,''));  
	}).bind("paste",function(){  //CTR+V事件处理 
		$(obj).val($(obj).val().replace(/\D|^0/g,''));  
	}).css("ime-mode", "disabled");  //CSS设置输入法不可用
}
//小数字验证
function decimalsVerify(obj){
	$(obj).keyup(function(){
        $(obj).val($(obj).val().replace(/[^0-9.]/g,''));  
    }).bind("paste",function(){  //CTR+V事件处理  
        $(obj).val($(obj).val().replace(/[^0-9.]/g,''));   
    }).css("ime-mode", "disabled"); //CSS设置输入法不可用  
}
//价格比率为空的时候自动填充0.00
function writeValPctDecimals(obj){
	if ($.trim($(obj).val()) == "") {
		$(obj).val('0.00');
	}
}
//包含数量为空的时候自动填充0
function writeCntdQtyDecimals(obj){
	if ($.trim($(obj).val()) == "") {
		$(obj).val('0');
	}
}

/* Rachel問 東東: 這段是要刪掉嗎?
Item Edit - UpdateItemStock : search item stock msg by itemNo、itemName、storeNo、storeName
function searchItemStockMsg(storeNo){
	
    var itemNo = $('#itemNo').val()=='输入货号查询'?null : $('#itemNo').val();
    if(itemNo != null && itemNo != ""){
       	$.ajax( {
      		type : 'post',
      		url : ctx + '/item/update/searchItemStockMsg',
      		data : {
      			storeNo : storeNo,
      			itemNo : itemNo
   		},
  		success : function(data) {

  		}
      	}); 
    }
}
*/

/*Item Edit - UpdateItemStock : search item stock msg by itemNo、itemName、storeNo、storeName*/
function changeItemStockByStoreNo(storeNo){
    var itemNo = $('#itemNo').val();
    if(itemNo != undefined && itemNo != ""){
    	$('.Container').load(ctx + "/item/update/updateItemStock",getParam()); 
    }
}

//修改广告语弹出框
function openAdvWindowAlter(windowWidth, windowHeight){
	openPopupWin(630,450,"/item/basicInformation/openAdvWindowAlterAction");
}

function closeAdvWindowAlter(){
	$('#openDiv').window("close");
	$("#grid_layer").hide();
}

/*validate the decimal's length*/
function valFloatNumOnBlur(obj,Integer,decimal){
	if(obj.value==""||obj.value==undefined){
		return false;
	}
	if(/^[-]{0,1}[1-9]{0,}[.]{0,1}[0-9]{0,}$/.test(obj.value)){
		$(obj).removeClass('errorInput');
		$(obj).removeAttr('title');
		if(obj.value>=0){
			$(obj).removeClass('errorInput');
			$(obj).removeAttr('title');
		if(obj.value.indexOf('.')==-1){
			if(obj.value.length>Integer){
				$(obj).addClass('errorInput');
				$(obj).attr("title","请输入小于或等于"+Integer+"位的数字");	
			}
			else{
				$(obj).removeClass('errorInput');
				$(obj).removeAttr('title');
			}
		}
		else{
		   var index=obj.value.indexOf('.');
		   var integerVal=obj.value.substring(0,index);
		   var decimalVal=obj.value.substring(index+1,obj.value.length);
			if(integerVal.length>Integer){
				$(obj).addClass('errorInput');
				$(obj).attr("title","整数位数需小于或等于"+Integer+"位");
           	}
			else{
				$(obj).removeClass('errorInput');
				$(obj).removeAttr('title');
				if(decimalVal.length>decimal){
					$(obj).addClass('errorInput');
					$(obj).attr("title","小数位数需小于或等于"+decimal+"位");
				}
				else{
					$(obj).removeClass('errorInput');
					$(obj).removeAttr('title');
				}
			}
		}
		}
		else{
			$(obj).addClass('errorInput');
			$(obj).attr("title","请输入大于0的数字");	
		}
	}
	else{
		$(obj).addClass('errorInput');
		$(obj).attr("title","请输入浮点数！");
	}
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

function valItemStockMsg(){
    if($("#storeNo").val()==""||$("#storeNo").val()==undefined){
    	$("#storeNo").attr("title","货号不能为空");
    	$("#storeNo").addClass("errorInput");
    }
    else{
    	$("#storeNo").removeAttr("title");
    	$("#storeNo").removeClass("errorInput");
    }
    if($("#itemNo").val()==""||$("#itemNo").val()==undefined){
    	$("#itemNo").attr("title","货号不能为空");
    	$("#itemNo").addClass("errorInput");
    }
    else{
    	$("#itemNo").removeAttr("title");
    	$("#itemNo").removeClass("errorInput");
    } 
}
//修改广告语的增加和删除
//选择某条数据是否为全选
$(".isChecksItem").live("click",function(){
    var checkAll=true;
    var itemCheckBoxList=$(".create3_zz_2").find("input.isChecksItem");
    $.each(itemCheckBoxList,function(index,item){
        if(this.checked==false){
            checkAll=false;
            return false;
        };
    });
    if(!checkAll){
        $(".isCheckAllsItem").attr("checked",false);
    }
    else{
        $(".isCheckAllsItem").attr("checked",true);
    }

});
//全选事件
$(".isCheckAllsItem").live("click",function(){
    if(this.checked){
        $(".isChecksItem").attr("checked",true);    
    }
    else{
        $(".isChecksItem").attr("checked",false);    
    }
    
});

//删除事件
$(".deleteCheckedsItem").live("click",function(){
    $("input.isChecksItem:checked").parent().remove();
    $(".isCheckAllsItem").attr("checked",false);
});

//广告语初始化信息
function searchItemSlogan(){
	var itemNo = $.trim($("#itemNo").val());
	if (itemNo != "") {
		$.ajax( {
			type : 'post',
			url : ctx + '/item/basicInformation/getAlterItemAdDescByItemNoAction',
			data :{
				itemNo : itemNo,
				page : "1",
				rows : "9999"
			},
			success : function(data) {
				$.each(data.rows,function(index, val){
					var str = '<div class="ig zz_2_1">';
					str = str + '<input type="checkbox" class="fl_left isChecksItem" />';
					str = str + '<input name="seqNo" class="w10 align_right" value='+val.seqNo+' readonly="readonly" ></input>&nbsp;&nbsp;';
					str = str + '<input id="adCnDesc" name="adCnDesc" type="text" class="w35 inputText" value='+$.trim(val.adCnDesc)+' ></input>&nbsp;&nbsp;';
					str = str + '<input id="adEnDesc" name="adEnDesc" type="text" class="w44 inputText" value='+$.trim(val.adEnDesc)+' ></input>&nbsp;&nbsp;';
					str = str + '</div>';
					$("#itemBarDiv").append(str);
				});
			}
		});
	}
}
//添加广告语
function addItemSlogan(){
	var itemBarDiv = $("#itemBarDiv").find("div");
	var slogan = itemBarDiv.size();
	var itemNo = "";
	if (slogan > 0) {
		itemNo = itemBarDiv.find("input[name='seqNo']")[slogan-1].value;
		itemNo++;
	} else {
		itemNo = 1;
	}
	var str = '<div class="ig zz_2_1">';
	str = str + '<input type="checkbox" class="fl_left isChecksItem" />';
	str = str + '<input name="seqNo" class="w10 align_right" readonly="readonly" value='+itemNo+' ></input>&nbsp;&nbsp;';
	str = str + '<input id="adCnDesc" name="adCnDesc" type="text" class="w35 inputText" value="" ></input>&nbsp;&nbsp;';
	str = str + '<input id="adEnDesc" name="adEnDesc" type="text" class="w44 inputText" value="" ></input>&nbsp;&nbsp;';
	str = str + '</div>';
	$("#itemBarDiv").append(str);
}
//把已添加到广告语在页面上显示
function saveSelectSlogan(){
	var itemBarDiv = $("#itemBarDiv").find("div");
    var div_str = "";
    if (itemBarDiv.size() > 0) {
    	$.each(itemBarDiv, function(i,val){
    		var seqNo = $(itemBarDiv[i]).find("input[name='seqNo']").val();
    		var adCnDesc = $.trim($(itemBarDiv[i]).find("input[name='adCnDesc']").val());
    		var adEnDesc = $.trim($(itemBarDiv[i]).find("input[name='adEnDesc']").val());
    		
    		div_str = div_str + seqNo + "." + adCnDesc + "," + adEnDesc + ";";
    	});
    	div_str = div_str.substring(0, div_str.length-1);
    	if(div_str!=''){
    		$("#advShowList").attr("value",div_str);
    		var itemAdDescSet = convertJsonStr("itemBarDiv");
    		$("#itemAdDescSet").val(itemAdDescSet);
    	}
    	else{
    		commonAlert("请输入广告语!",300,50,'新增商品');
    		return false;
    	}
    	closePopupWin();
    }
    
}
//保存修改商品规格的信息
function saveItemSpecMess(param){
	$.ajax( {
		type : 'post',
		url : ctx + '/item/basicInformation/judgeItemNoWhetherAlterAction',
		data :{itemNo : $("#itemNo").val()},
		success : function(data) {
			if (data.status == "success") {
				var alterItemSpec_from = $("#alterItemSpec_from").serialize();
				$.ajax( {
					type : 'post',
					url : ctx + '/item/basicInformation/saveItemSpecMessAction',
					data :alterItemSpec_from,
					success : function(data) {
						if (data.status == "success") {
							top.jAlert('success', '操作成功','提示消息',function(){
								$('#ovreviewContent').load(ctx + '/item/query/itemSpecInfo', param); 
							});
						} else {
							top.jAlert('error', '操作失败','提示消息');
						}
					}
				});
			} else {
				top.jAlert('warning', data.message,'提示消息');
			}
		}
	});
}


//课别属性选择框
function loadKebieAttrInputSelectAlter(obj,dataList,divWidth){
	$(obj).autocomplete(dataList, {
	    minChars: 0,
	    width:$.trim(divWidth)==''?$(this).attr('width'):divWidth,
		max:	3000,
	    matchContains: true,
	    matchCase:false,//不区分大小写
	    autoFill: false,
	    dataType: 'json',
	    formatItem: function(row, i, max) {
	    	return row.secAttrValNo+"-"+row.secAttrValName;
	    },
	    formatMatch: function(row, i, max) {
	        return row.secAttrValNo;

	    },
	    formatResult: function(row) {
	        return row.secAttrValNo;
	    }
	    
	}).result(function(event, data, formatted) { //回调
		$(this).parent().parent().find('.attrVal').val(data.secAttrValName);
		$(this).parent().find('.attrId').val(data.secAttrId);
	    });
}

//保质期日期计算
function getStdShelfLifeDaysAlter(){
	var stdShelfLifePerd =$.trim($('#stdShelfLifePerd').val());
	var perdUnitName = $.trim($('#perdUnitName').val());
	if(stdShelfLifePerd=='' || perdUnitName==''){
		$('#stdShelfLifeDays').val('');
		return false;
	}
	switch(perdUnitName){
		case '3':
			$('#stdShelfLifeDays').val(365*eval(stdShelfLifePerd));
			break;
		case '2':
			$('#stdShelfLifeDays').val(30*eval(stdShelfLifePerd));
			break;
		case '1':
			$('#stdShelfLifeDays').val(stdShelfLifePerd);
			break;	 
	}
}


/*****************************/
/*NEW SUPPLY AREA 新增下傳區域區塊*/
/****************************/

/**
 * New Supply Area : 選取訂貨方式
 */
function changeOrdCreatMethd(obj){
	var value = $(obj).val();
	var total = $(obj).siblings('.ordCreatMethd').val();
	var methods = [];
	if (total != '' && total != undefined ){
		methods = total.split(',');
		if ($.inArray(value.toString(),methods) != -1 ){
			methods.splice($.inArray(value.toString(), methods),1);
		}
		else{
			methods.push(value);
		}
	}
	else{
		methods.push(value);
	}
	$(obj).siblings('.ordCreatMethd').val(methods.toString());
}

/**
 * New Supply Area: 新品試銷單選框
 * @param obj
 */
function selectTrialSale(obj){
	if ($("input[class=newSell]:checked:visible").length != 0){
		$(obj).val('1');
	}
	else{
		$(obj).val('0');
	}
}

/**
 * New Supply Area : 按新增下傳區域的弹出框
 * @param windowWidth 彈出窗寬度
 * @param windowHeight 彈出框高度
 */
function openNewPopupSupAreaWin(windowWidth, windowHeight) {
	var flag = true;
	if ($('.list_ex0').length != 0 ){
		flag = chkItemInfo();
	}	
	if (flag){
		var itemNo = $('#itemNo').val();
		var selector = $('* #popupItemWin:last');
		var left = (screen.width/2) - (windowWidth/2);
		var top = (690/2) - (windowHeight/2);
		$(selector).window({
			width : windowWidth,
			height : windowHeight,
			draggable : true,
			resizable : false,
			modal : true,
			shadow : false,
			border : false,
			noheader : true,
			top : top,
			left : left
		});
		$.ajaxSetup({async : false});
		$(selector).load(ctx+'/item/update/newSupAreaSelect?itemNo='+ itemNo);
		$.ajaxSetup({async : true});
		$(selector).css("display", "block");
		$(selector).window("open");
		grid_layer_close();
		window.windowSelector = selector;
	}
}

/**
 * New Supply Area : 顯示所選商品的廠商列表彈出框
 */
function supplierPopup(){
	openPopupWin(630,548,"/item/update/supplierWindow");
	querySupplier();
}

/**
 * New Supplier Area: 檢查是不是數字
 * @param input
 * @returns {Boolean}
 */
function IsNumeric(input)
{
    return (input - 0) == input && (''+input).replace(/^\s+|\s+$/g, "").length > 0;
}

/**
 * New Supply Area: 查詢可選的Supplier 列表
 */
function querySupplier(){
	var pageNo = $('#pageNo').val();
	var pageSize = $('#pageSize').val();
	var itemNo = $('#itemNo').val();
	var supNo = $('#searchSup').val();
	var supNoOrName;
	var supName;
	
	if ( $.trim($("#searchSup").attr("value")) != ""){
		var input = $("#searchSup").attr("value");
		if (IsNumeric(input)){
			supNoOrName = input;
		}
		else{
			supName = input;
		}	}
	$.ajax({
		type : "post",
		data : {
			'itemNo' : itemNo,
			'supNo' : supNo,
			'pageNo': pageNo,
			'pageSize' : pageSize,
			'supNoOrName' : supNoOrName,
			'supName' : supName
		},
		dataType : "html",
		url : ctx + '/item/update/getSupByItemNo',
		success : function(data) {
			$('#supplierList').html(data);
		}
	});
}

/**
 * New Supply Area : 選擇廠商後關閉彈出框
 */
function chooseSup(){
	
	if ($('#supplierList').find('.btable_checked').length != 1){
		top.jAlert('warning', '请选择厂商', '消息提示');
	}
	else{
		var supNo = $('#supplierList').find('.btable_checked').find('#supNo').text();
		var supName = $('#supplierList').find('.btable_checked').find('#comName').text();
		closePopupWin();
		$("#supNo").val(supNo);
		$("#supName").val(supName);
		getSupAreaBySupplier(supNo);
	}
}

/**
 * New Supply Area : 關閉彈出框
 */
function closePanel(){
	$('* #popupItemWin:last').html('');
	$('* #popupItemWin:last').window("close");
}

/**
 * New Supply Area: 選擇廠商後產生下傳區域樹
 * @param supNo
 */
function getSupAreaBySupplier(supNo){
	var itemNo = $('#itemNo').val();
	var dlvryMethd = 0;
	
	$.post(ctx + "/item/create/getSupRegion?supNo="+supNo,function(data){
		if(data.status=='success'){
			var internalInd = data.supplier.internalInd;
			var setStores = [];
			dlvryMethd = data.supplier.dlvryMethd;
			var checkedStores = ($('#checkedStores').val()).split(',');
			
			$.ajaxSetup({async : false});		
			$('#tt').tree({
				checkbox : true,
				data : data.tree,
				onClick : function(node) {

				},
				onLoadSuccess : function (node, data){
					// 取得已經下傳過的分店
					$.post(ctx + "/item/update/getMainSupSetStoreList?itemNo="+itemNo, function(result){
						if (result){
							$.each(result, function (index,value){
								setStores.push(value.storeNo);
							});
						}
					});
					
					// 取得廠商加工中心和物流中心的下傳清單
					$.post(ctx + "/item/update/getNationalCenterList?supNo=" + supNo + "&internalInd=" + internalInd, function(result){
						if (result){
							var dcCenterDivStr = '';
							var machinDivStr = '';
							$.each(result, function(index, value){

								// 送貨方式不是直配, 或是內部廠商 才能下傳到物流中心
								if (value.bizType == 7 && (dlvryMethd != 1 || internalInd == 1)){
									dcCenterDivStr+='<div class="item2 '+value.assrtId+'"><label>';
									dcCenterDivStr+='<input type="checkbox" class="selectedInput" name="d" tagNameTitle="'+value.storeName+'" value="'+value.storeNo+'">';
									dcCenterDivStr+='</label><span id="' + value.storeNo +'">'+value.storeNo+'-'+value.storeName+'</span></div>';
								}
								if (value.bizType == 8){
									machinDivStr+='<div class="item2 '+value.assrtId+'"><label>';
									machinDivStr+='<input type="checkbox" class="selectedInput" name="a" tagNameTitle="'+value.storeName+'" value="'+value.storeNo+'">';
									machinDivStr+='</label><span id="' + value.storeNo + '">'+value.storeNo+'-'+value.storeName+'</span></div>';
								}
								
							});	

							$('#dcCenterDiv').html(dcCenterDivStr);
							$('#machinDiv').html(machinDivStr);
							
							// 不可以勾選已經下傳的分店
							if (setStores != null){
								$.each(setStores, function(index, value){
									$('#newSupAreaForm input[value='+value+']').attr('disabled','disabled');
								});
							}

							// 不可以勾選之前已經選過了的分店
							if (checkedStores != ""){
								$.each(checkedStores, function(index,value){
									$('#newSupAreaForm input[value='+value+']').attr('disabled','disabled');
								});
							}

							// 如果不能選擇加工中心 或是 加工中心裡沒有店, 則disable 全選框
							if ( (dlvryMethd == 1 && internalInd == 0) || $('#dcCenterDiv input:enabled').length == 0){
								$('#dcCenterDiv').find('input').attr('disabled', 'disabled');
								$('.dcSupAttr').attr('disabled', 'disabled');
							}
							
							if ($('#machinDiv input:enabled').length == 0){
								$('#machinDiv').find('input').attr('disabled','disabled');
								$('.jgCsAttr').attr("disabled","disabled");
							}
	
						}
					});
				},
				onCheck : function(node,checked) {
					var nodes = $('#tt').tree('getChildren', node.target);
					if(checked){
						var disabledNodes = $('tree-node[disable="disabled"]'); // 加了這行
						var _str = '';
						if(nodes.length>0){
							for(var i=0;i<nodes.length;i++){
								var breakFlag = false;
								for (var j=0; j<disabledNodes.size(); j++){
									var nodeId = $(disabledNodes[j]).attr('node-id');
									if (nodeId == nodes[i].id){
										breakFlag = true;
										break;
									}
								}
								if (breakFlag){
									continue;
								}
								
								_str = _str +","+ nodes[i].id;
							}
						}
						else{
							_str = _str +","+ node.id;
						}
						_str = _str.substr(1);
						$.post(ctx + "/item/create/getStoreList?supNo="+supNo+"&regnNoList="+_str+"&internalInd="+internalInd,function(data){
							if(data){
								var storeDivStr = '';
								$.each(data, function(index, value) {						
									if(value.bizType==1 && ($('#storeDiv [value=' + value.storeNo + ']').length) == 0 ){
										storeDivStr+='<div class="item2 '+value.assrtId+'"><label>';
										storeDivStr+='<input type="checkbox" class="selectedInput" name="n" tagNameTitle="'+value.storeName+'" value="'+value.storeNo+'">';
										storeDivStr+='</label><span>'+value.storeNo+'-'+value.storeName+'</span></div>';
									}
								});
								
								$('#storeDiv').append(storeDivStr);

								if ($('#storeDiv input:enabled').length == 0){
									$('#storeDiv').find('input').attr('disabled', 'disabled');
									$('#storeCheckAll').attr('disabled', 'disabled');
								}
								
								// 不可以勾選已經下傳的分店
								if (setStores != null){
									$.each(setStores, function(index, value){
										$('#newSupAreaForm input[value='+value+']').attr('disabled','disabled');
									});
								}
								
								// 不可以勾選之前已經選過了的分店
								if (checkedStores != ""){
									$.each(checkedStores, function(index,value){
										$('#newSupAreaForm input[value='+value+']').attr('disabled','disabled');
									});
								}
							}
							// 檢查全選框要不要勾選
							checkStoreCheckAll();
						});
											
					}
					else{
						if(nodes.length>0){
							for(var i=0;i<nodes.length;i++){
								$('#storeDiv .'+nodes[i].id).remove();
							}
						}
						else{
							$('#storeDiv #'+node.id).remove();
						}
						// 檢查全選框要不要勾選
						checkStoreCheckAll();
					}
					
				}
			});
			if(bnoResult!=null){ 
				changeNodeBNOResult();
			}
			$.ajaxSetup({async : true});
		}
		else{
			top.jAlert('error', data.message, '消息提示');
		}
	});
	
}

/**
 * BNO 檢查
 */
function changeNodeBNOResult(){
	
	 var bnoName = $('#popupItemWin .bnoName').val();
	 $('.disChk').remove();
	 $('#tt').find('.tree-checkbox-d').addClass('tree-checkbox').removeClass('tree-checkbox-d');
	 $('#tt li').removeAttr('title');
	 $('#tt .red_bno_node').removeClass('red_bno_node');
	 $('#tt .tree-node').removeAttr('disable');
	 if(bnoName==''){
	  return false;
	 }
	 if($('#clstrType').val()=='1'){
	  return false;
	 }
	 $.each(bnoResult,function(i){
	  var disChk = '<input type="checkbox" style="margin-top:8px;" class="tree-checkbox1 disChk" disabled="disabled">';
	  if(this[""+bnoName]!=''){
	   $('#tt .tree-node[node-id="'+i+'"]').parent().attr('title',"本区域以下门店"+bnoName+"属性超出:"+this[""+bnoName]);
	   $('#tt .tree-node[node-id="'+i+'"]').parent().addClass('red_bno_node');
	   $('#tt .tree-node[node-id="'+i+'"]').parent().find('.tree-checkbox').addClass('tree-checkbox-d').after(disChk).removeClass('tree-checkbox');
	   $('#tt .tree-node[node-id="'+i+'"]').parent().find('.tree-node').each(function(){
	    $(this).attr('disable','disabled');
	   });
	  }
	  else{
	   $(this).removeAttr('disable');
	  }
	 });
	  
	 $('#storeDiv .item2').show();
	 var disabledNodes = $('.tree-node[disable="disabled"]');
	 for(var j=0;j<disabledNodes.size();j++){
	  var nodeId = $(disabledNodes[j]).attr('node-id');
	  $('#storeDiv .'+nodeId).hide();
	 }
}

/**
 * 當點選區域的時候, 分店列表變動, 檢查全選框要不要勾選
 */
function checkStoreCheckAll(){
	if ($('#storeDiv .item2 :enabled:checked').length != 0 && ($('#storeDiv .item2 :enabled').length == $('#storeDiv .item2 :enabled:checked').length)){
		$('#storeCheckAll').attr("checked", "checked");
	}
	else{
		$('#storeCheckAll').removeAttr("checked");
	}
}

/**
 * 新增下傳區域, 選擇下傳區域彈出框: 點選店時檢查全選框
 */
$('.item2').live('click', function(){
	var tmp = $(this).find("input");
	var name = $(tmp).attr("name");
	if ($(this).find('input:enabled').length == 1) {
		if ($(".selectedInput[name="+ name + "]:enabled:checked").length == $(".selectedInput[name="+ name + "]:enabled").length){
			$(".checkAll[name="+ name + "]").attr("checked","checked");
		}
		else{
			$(".checkAll[name="+ name + "]").removeAttr("checked");
		}
	}
});

/**
 * New Supply Area: 確定選擇的下傳區域
 */
function addOneSupArea(){
	// 讓頁面的左邊和右邊區塊隱藏
	$('#storeListDiv').children().removeClass('list_ex0_on');
	$('#storeInfoList').children().hide();
	
	var currentObject =  $('.list_ex0').length;
	var stores = $(".selectedInput:input:checked");
	if ($('#supNo').val() == ''){
		top.jAlert('warning', '请选择厂商', '消息提示');
	}
	else if (stores.length < 1){
		top.jAlert('warning', '请选择下传门店', '消息提示');
	}
	else{
		var storeNames = $(".selectedInput:input:checked").parent().parent().find('span');
		var thisGroupStores = [];
		var checkedStores = [];
		if ($('#checkedStores').val() != ''){
			checkedStores = ($.trim($('#checkedStores').val())).split(',');
		}
		
		// 處理左邊的下傳區域
		var output = "<div class=\"list_ex0 list_ex0_on\" id=\"group"+ currentObject +"\">";
		output = output + "<div class=\"list_ex1\">";
		output = output + "<div class=\"ssuo list_ex11 Icon-size1\"></div>";
		output = output + "<div class=\"longText list_ex12\" title=\"" + $('#supNo').val() + "-" + $('#supName').val() + "\">" + $('#supNo').val() + "-" + $('#supName').val() + "</div>";
		output = output + "<div class=\"list_ex14 Icon-size2 Tools10\"></div>";
		output = output + "</div>";
		output = output + "<div class=\"list_ex2\">";
		output = output + "<div class=\"list_ex21\" >";
		$.each(storeNames, function(index, value){
			output = output + "<div id=\"oneStore\">" + value.innerText + "</div>";
		});	
		output = output + "</div>";
		
		// 把所選分店加入總清單
		$.each(stores, function(index, value){
			checkedStores.push(value.value);
			thisGroupStores.push(value.value);
		});
		output = output + "<input type=\"hidden\" value=\"" +thisGroupStores.toString() +"\"> ";
		output = output + "</div>";
		output = output + "</div>";
		
		// 處理右邊的屬性
		// 新增第一筆的時候, copy #template 的內容. 以後都只複製group0 的內容
		if ($('#storeInfoList').find('#group0').length == 0){
			newStoreAttr = $('#template').clone();
		}
		else{
			newStoreAttr = $('#storeInfoList > #group0').clone();
		}
		newStoreAttr.show();
		newStoreAttr.attr('id', 'group' + currentObject );
		newStoreAttr.find('.supStoreNoList').val(thisGroupStores.toString());
		newStoreAttr.find('.stMainSupNo').val($('#supNo').val());
		newStoreAttr.find('.grpId').val(new Date().format('yyyyMMddhhmmssSSS'));
		
		// 把之前填的訊息直接帶到新的 storeInfoList
		var bno = $('#newSupAreaForm :selected').text();
		$("#bnoValue").val(bno);
		newStoreAttr.find('.bnoName').val(bno);
		newStoreAttr.find('.storeUpdtSpInd').val($('#storeInfoList > #group0').find('.storeUpdtSpInd').val());
		newStoreAttr.find('.speclBuyVatNo').val($('#storeInfoList > #group0').find('.speclBuyVatNo').val());
		newStoreAttr.find('.dcAttr').val($('#storeInfoList > #group0').find('.dcAttr').val());
		newStoreAttr.find('.rtnAllow').val($('#storeInfoList > #group0').find('.rtnAllow').val());
		
		$('#storeInfoList').append(newStoreAttr);
		$('#checkedStores').val(checkedStores.toString());
		$('#storeListDiv').append(output);
		nullInputCheck();
		closePanel();
	}
}

/**
 * New Supply Area: input check
 */
function nullInputCheck(){

	$('.mustInput').live("blur", function(){
		if($.trim($(this).val())=='' && !($(this).hasClass())){
			$(this).addClass('errorInput');
		}
	});
	
	$('.mustInput,.inputText').live("focus", function(){
		$(this).removeClass('errorInput');
	});
	
	$('.ordCreatMethds').live("focus", function(){
		$('.dhxx_info_1').removeClass('errorInput');
	});
	
}

/**
 * New Supply Area: 檢查訂貨方式
 * @returns {Boolean}
 */
function checkOrderMethod(){
	var value = $('.dhxx_info:visible ').find('.ordCreatMethd').val();
	if ( value == ''){
		$('.dhxx_info_1').addClass('errorInput');
		return false;
	}
	return true;
}

/**
 * New Supply Area: form 校验 
 * @returns {Boolean}
 */
function chkItemInfo(){
	var inputOk = true;
	
	inputOk = checkOrderMethod();
	
	$('.mustInput:visible').each(function(){
		if($.trim($(this).val())==''){
			if(!($(this).hasClass('errorInput'))){
				$(this).addClass('errorInput');
			}
			inputOk=false;
		}
	});
	
	return inputOk;
}

/**
 * New Supply Area: 儲存新增下傳區域
 */
function saveNewSupArea(){
	
	// 先刪掉樣版
	$('#storeInfoList #template').remove();
	
	var itemStoreInfoAuditVOJson = $('#storeInfoList').find('.itemStoreInfo').map(function(){
		return JSON.stringify($(this).serializeObject());
	}).get().join("+");
	
	$.ajax({
		type : 'POST',
		async : 'false',
		datatype: 'json',
		url : ctx + '/item/update/saveNewSupArea',
		data :{
			itemNo : $('#itemNo').val(),
			itemStoreInfoAuditVOJson : itemStoreInfoAuditVOJson
		},
		success : function(data){
			if (data.status == 'SUCCESS'){
				top.jAlert('success', data.msg, '消息提示');
				$('#ovreviewContent').load(ctx + '/item/query/itemBaseInfo', getParam());
				openCleanBtn('/item/query/itemBarcodeInfo',false);
			}
			else{
				top.jAlert('error', data.msg, '消息提示');
			}
		},
		error : function(data){
			top.jAlert('error', '操作失败', '消息提示');
		}
	});
}

/* 新增商品下傳區域結束 */

/*$("#width").die().live('blur',function(){
	getSumCapacity();
});
$("#layer").die().live('blur',function(){
	getSumCapacity();
});
$("#depth").die().live('blur',function(){
	getSumCapacity();
});*/

function valMinWidth(obj){
  valNumOnBlur(obj,2);
  if($("#minWidth").val()>$("#width").val()){     
	  $("#width").val($("#minWidth").val());
  }
  getSumCapacity();
}
function valMinLayer(obj){
	valNumOnBlur(obj,2);
	  if($("#minLayer").val()>$("#layer").val()){
		  $("#layer").val($("#minLayer").val());
	  }
  getSumCapacity();
}
function valMinDepth(obj){
	valNumOnBlur(obj,2);
	  if($("#minDepth").val()>$("#depth").val()){
		  $("#depth").val($("#minDepth").val());
	  }
  getSumCapacity();
}

function valWidth(obj){
	  valNumOnBlur(obj,2);
	  if($("#minWidth").val()>$("#width").val()){     
		  $("#minWidth").val($("#width").val());
	  }
	  getSumCapacity();
	}
	function valLayer(obj){
		valNumOnBlur(obj,2);
		  if($("#minLayer").val()>$("#layer").val()){
			  $("#minLayer").val($("#layer").val());
		  }
		  getSumCapacity();
	}
	function valDepth(obj){
		valNumOnBlur(obj,2);
		  if($("#minDepth").val()>$("#depth").val()){
			  $("#minDepth").val($("#depth").val());
		  }
		  getSumCapacity();
	}

function getSumCapacity(){
   var sumCapacity=$("#width").val()*$("#layer").val()*$("#depth").val();
   if(!/\d/.test(sumCapacity)){
	   $("#sumCapacity").val("");
   }
   else{
   $("#sumCapacity").val(sumCapacity);
   }
}
function closeUptItemInfo(module,param){
	if(module==""||module==undefined){
		return false;
	}
	else if(module=='itemSpec'){
		$('#ovreviewContent').load(ctx + '/item/query/itemSpecInfo', param);
	}
	else if(module=='itemBarcode'){
		$('#ovreviewContent').load(ctx + '/item/query/itemBarcodeInfo', param);
	}
	else if(module=='itemRealInfoClose'){
		$('#ovreviewContent').load(ctx + '/item/query/itemRealativeInfo', param);
	}
	else if(module=='itemStockClose'){
		$('#ovreviewContent').load(ctx + '/item/query/itemRealStoreSaleCtrlInfo', param);
	}
	else if(module=='itemOriginClose'){
		$('#ovreviewContent').load(ctx + '/item/query/itemOriginInfo', param);
	}
}
/*
 * query the item corrrelation repacking and promotion 
 * message according by the input box.
 * */
function itemCorrePacAndPromoQuery(){
	var itemNo;
	var queryKey = $.trim($("#sonItemNo").val()) == "请输入商品货号或名称查询" ? "" : $
			.trim($("#sonItemNo").val());
	if(queryKey==""||queryKey==undefined){	
		return false;
	}
	if(/\d/.test(queryKey)){
		if(/^[0-9]{1,8}$/.test(queryKey)){
			itemNo=queryKey;
		}
	}
	var pageNo = $('#pageNo').val() || '1';
	var pageSize = $('#pageSize').val() || '10';
	$.ajax({
		type : "post",
		dataType : "html",
		data : {
			page : pageNo,
			rows : pageSize,
			itemNo : itemNo,
        	parentItemNo : $("#sel_itemArticleNo").val(),
        	itemType : $("#itemType").val()
		},
		url : ctx + '/item/basicInformation/sonItemNoListAction',
		success : function(data) {
			var data=JSON.parse(data);
			if(data.rows!=""){
			var itemNo=data.rows[0].itemNo;
			$.ajax({
				type : 'post',
				url : ctx + '/item/basicInformation/showAlterSonItemMessAction',
				data : {
					itemNos : itemNo,
		        },
				success : function(data){
					
					if(data.result!=null){
					var rowData = data.result[0];
					$("#sonItemNo").val(rowData.itemNo);
					$("#sonItemName").val(rowData.itemName);
					$("#sonItemEnName").val(rowData.itemEnName);
		            if(rowData.sellUnit==undefined){
		            	$("#sonSellUnit").val("");
		            }else{
		            	$("#sonSellUnit").val(getDictValue('UNIT',rowData.sellUnit,2));
		            }
					$("#sonNumOfPackUnit").val(rowData.numOfPackUnit);
		            if(rowData.packUnit==undefined){
		            	$("#sonPackUnit").val("");
		            }else{
		            	$("#sonPackUnit").val(getDictValue('UNIT',rowData.packUnit,2));
		            }
		            
					$("#sonBaseVol").val(rowData.baseVol);
		            if(rowData.baseVolUnit==undefined){
		            	$("#sonBaseVolUnit").val("");
		            }else{
		            	$("#sonBaseVolUnit").val(getDictValue('UNIT',rowData.baseVolUnit,2));
		            }
		            
					$("#sonCntdQty").val(rowData.cntdQty);
					
		            if(rowData.status==undefined){
		            	$("#sonStatus").val("");
		            }else{
		            	$("#sonStatus").val(getDictValue('ITEM_BASIC_STATUS',rowData.status,1));
		            }
					$("#sonMajorSupNo").val(rowData.comNo);
					$("#sonMajorSupName").val(rowData.comName);
					$("#sonStdBuyPrice").val(rowData.stdBuyPrice);
					$("#sonBuyVatNo").val(rowData.buyVatNo);
					$("#sonBuyVatVal").val(rowData.buyVatVal);
					$("#sonStdSellPrice").val(rowData.stdSellPrice);
					$("#sonSellVatNo").val(rowData.sellVatNo);
					$("#sonSellVatVal").val(rowData.sellVatVal);
					}
				}
			});
			}
			else{
		    	$("#sonItemName").val("");
		    	$("#sonItemEnName").val("");
		    	$("#sonSellUnit").val("");
		    	$("#sonNumOfPackUnit").val("");
		    	$("#sonPackUnit").val("");
		    	$("#sonBaseVol").val("");
		    	$("#sonBaseVolUnit").val("");
		    	$("#sonCntdQty").val("");
		    	$("#sonStatus").val("");
		    	$("#sonMajorSupNo").val("");
		    	$("#sonMajorSupName").val("");
		    	$("#sonStdBuyPrice").val("");
		    	$("#sonBuyVatNo").val("");
		    	$("#sonBuyVatVal").val("");
		    	$("#sonStdSellPrice").val("");
		    	$("#sonSellVatNo").val("");
		    	$("#sonSellVatVal").val("");
			}

		}
	});
} 

/*save the item origin message.*/
function saveUpdateItemOrigin(){

	var itemNo=$("#itemNo").val();
	var majorOriginAddr = JSON.stringify($('#majorRegn').serializeObject());
	var otherOriginList = $('#otherRegList').find('.otherRegn').map(
			function() {
				return JSON.stringify($(this).serializeObject());
			}).get().join(", ");
	$.ajax({
		type : 'post',
		url : ctx + '/item/update/saveItemOrigin',
		data :{
			majorOriginAddr : majorOriginAddr,
			otherOriginList : otherOriginList,
			itemNo : itemNo
		},
		success : function(data){
			if (data.status == 'success'){
				top.jAlert('success', data.message, '消息提示',function(){
					$('#ovreviewContent').load(ctx + '/item/query/itemOriginInfo', getParam());
				});			
			}
			else if(data.status == 'error'){
				top.jAlert('error', data.message, '消息提示');
			}
			
		}
	});
	
	
}
