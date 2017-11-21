/*
 * 本文件定义了在本功能页面上所有DOM元素的事件处理函数.
 */
var pArtPromHandler = new ARTPromMgmtHandler();
$(window).unload(function() {
	//0.清理资源;
	pArtPromHandler.destroy();
});
//代号弹出框
/*
 * 代号弹出框
 * 重要备注:记录下最近一次被选中的[代号输入框]
 * 
 */
var pLastUnitNoInputElem = null;
function doChooseOnePromUnitNo(/*Node*/evtNode){
	//促销已经开始不能添加代号
	if(promIsBegin()){return;}
	var hasItemOn =$(evtNode).parent().parent().hasClass("item_on");
	if(!hasItemOn){
		return false;
	}
	if(!checkAreAllInputDateValid()){
		top.jWarningAlert('请选择时间！');
		return;
	}
	
	//该代号是否有订单使用到
	var checkPromIsInOrderFlag = true;
	//判断是否是修改页面
	if(isUpdatePage()){
		//获取页面的数据
		var dataSnapshot = pArtPromHandler.getData();	
		var units = dataSnapshot.units;
		var unitItems = dataSnapshot.unit2items;
		//获取到代号的画布
		var _unitsCanvas = pArtPromHandler.getUnitsCanvas();
		var unitRowIndex = _unitsCanvas.getRowIndex(evtNode);
		var unitRowData = units[unitRowIndex];
		var unitNo = unitRowData.unitNo;
		if(unitNo){
			var itemArray = unitItems[unitNo].data;
			var ItemNoArray = new Array();
			for (var itemArrayInde = 0; itemArrayInde < itemArray.length; itemArrayInde++) {
				ItemNoArray.push(itemArray[itemArrayInde].itemNo);
			}
			checkPromIsInOrderFlag = checkPromIsInOrder(1,0,0,ItemNoArray,0);
		}
	}
	
	if(!checkPromIsInOrderFlag){top.jWarningAlert('该代号下有商品被订单使用，不能修改！');return;}
	//0.根据传入的[代号选择窗口]触发元素，选择目标[代号输入框].
	var rowIdx = pArtPromHandler.getUnitsCanvas().getRowIndex(evtNode);
	var currUnitNoInputTxt = pArtPromHandler.getUnitsCanvas().getRowMemberNodeByIndex(rowIdx, 1, 0);
	pLastUnitNoInputElem = currUnitNoInputTxt;
	
	var buyts = $("#buyTimeStart").val();
	var buyte = $("#buyTimeEnd").val();
	var promts= $("#promTimeStart").val();
	var promte= $("#promTimeEnd").val();
    var singleUnitNo = JSON.stringify(pArtPromHandler.doGetSingleUnitNo());
	var unitType =$(evtNode).parent().parent().find("select").val();
	
	var catlgId = $("#CatlgId").val();
	var promType = $("#promType").val(); 
	if(catlgId == null || catlgId == ""){
		top.jWarningAlert('请选择课别信息！');
		return;
	}
	var promNo="";
	if(isUpdatePage()){
		promNo = $("#promNo").val(); 
	}
	top.openPopupWin(800,450, '/prom/nondm/art/showUnitWin?unitType='+unitType+'&catlgId='+catlgId+'&promType='+promType+'&buyStartDate='+buyts+'&buyEndDate='+buyte+'&promStartDate='+promts+'&promEndDate='+promte+'&promNo='+promNo+'&singleUnitNo='+singleUnitNo);
};
//当在[促销代号]输入框键入回车时,执行此方法
function enterUnitNoShow(/*Event Object*/evtObj,/*Node*/obj) {
	 var evt=evtObj?evtObj:(window.event?window.event:null);//兼容IE和FF
	 if (evt.keyCode==13){
		obj.blur();
	 }
};
/*
 * 当用户变更了[代号类型](下拉框选择)时,执行此方法.
 */
//代号类型的选择事件
function doOnUnitTypeChanged(/*Node*/unitTypeSelectElem){
	//促销已经开始不能添加代号
	if(promIsBegin()){return;}

	//该代号是否有订单使用到
	var checkPromIsInOrderFlag = true;
	//判断是否是修改页面
	if(isUpdatePage()){
		//获取页面的数据
		var dataSnapshot = pArtPromHandler.getData();	
		var units = dataSnapshot.units;
		var unitItems = dataSnapshot.unit2items;
		//获取到代号的画布
		var _unitsCanvas = pArtPromHandler.getUnitsCanvas();
		var unitRowIndex = _unitsCanvas.getRowIndex(unitTypeSelectElem);
		var unitRowData = units[unitRowIndex];
		var unitNo = unitRowData.unitNo;
		//alert(unitNo);
		if(unitNo){
			var itemArray = unitItems[unitNo].data;
			var ItemNoArray = new Array();
			for (var itemArrayInde = 0; itemArrayInde < itemArray.length; itemArrayInde++) {
				ItemNoArray.push(itemArray[itemArrayInde].itemNo);
			}
			checkPromIsInOrderFlag = checkPromIsInOrder(1,0,0,ItemNoArray,0);
		}
	}
	if(!checkPromIsInOrderFlag){
		var lastInputUnitType = pArtPromHandler.getUnitRowPropValFromNode(unitTypeSelectElem, "unitType");
		unitTypeSelectElem.value = lastInputUnitType;
		top.jWarningAlert('该代号下有商品被订单使用，不能修改！');
		return;
	}
	pArtPromHandler.resetOnePromUnitToBlank(unitTypeSelectElem);
	pArtPromHandler.getUnitsCanvas().setRowMemberFocusedByNode(unitTypeSelectElem, 1,0);
};
/*
 * 加载目标代号数据，并同步显示到界面上。
 * 重要备注：
 * <1>.在内部也建立了完整的“ 1个代号--〉1个或多个商品”的映射关系；
 * <2>.本方法不处理任何"商品-->门店"的映射关系。 
 */
function doLoadOnePromUnit(/*Node*/unitNoElem){
	//促销已经开始不能添加新的代号
	if(promIsBegin()){return;}
	//0.检查新输入的代号是否未变化；
	//从Handler中取最近一次用户输入的促销代号，并与当前用户输入的进行比较，检查是否有变化；
	var lastInputUnitNo = pArtPromHandler.getUnitRowPropValFromNode(unitNoElem, "unitNo");
	var unitNo = unitNoElem.value;
	if(!unitNo){ unitNoElem.value=lastInputUnitNo;return};
	if(!isNumber(unitNo)){
		top.jWarningAlert('请输入数字！');
		unitNoElem.value="";
		unitNoElem.focus();
		return;
	}	
	
	//2.取@代号类别
	var unitTypeVal = pArtPromHandler.getUnitsCanvas().getRowMemberNodeValue(unitNoElem, 0);
	if (lastInputUnitNo == unitNo) return;
	//1.检查新输入的代号是否已重复；
	if (pArtPromHandler.isPromUnitNoAndTypeDuplicated(unitNo,unitTypeVal)){
		top.jWarningAlert('促销代号重复！');
		unitNoElem.value="";
		return;
	} 
	
	//3.准备查询[代号]数据
	var promType = $("#promType").val(); 
	var buyts = $("#buyTimeStart").val();
	var buyte = $("#buyTimeEnd").val();
	var promts= $("#promTimeStart").val();
	var promte= $("#promTimeEnd").val();
	var catlgId = $("#CatlgId").val();
	var promNo="";
	if(isUpdatePage()){
		promNo = $("#promNo").val(); 
	}
	
	var queryCond = {};
	queryCond.unitNo = unitNo;
	queryCond.unitType = unitTypeVal;
	queryCond.catlgId = catlgId;
	queryCond.promType = promType;
	queryCond.buyStartDate = buyts;
	queryCond.buyEndDate = buyte;
	queryCond.promStartDate = promts;
	queryCond.promEndDate = promte;
	queryCond.promNo = promNo;
	queryCond.singleUnitNo  = JSON.stringify(pArtPromHandler.doGetSingleUnitNo());
	//添加新的数据
	$.ajax({
	url: ctx + '/prom/nondm/art/newGetARTJsonData',
    type: "post",
    dataType:"json",
    //data: {unitType:unitType,unitNo:unitNo,catlgId:catlgId,promType:promType,buyStartDate:buyts,buyEndDate:buyte,promStartDate:promts,promEndDate:promte},
    data: queryCond,
    success: function(result) {
    	////top.grid_layer_close();
    	if (result.hasUnitFlag==1){
    		top.jWarningAlert('该代号不存在！');
    		pArtPromHandler.resetOnePromUnitToBlank(unitNoElem);
    		pArtPromHandler.clearAllInputTextsAndButtons();
    		unitNoElem.focus();
    		return;
    	}
    	if((result.hasUnitFlag==0)&&(result.list == null || result.list.length <=0)&&unitTypeVal!=0){
    		top.jWarningAlert('该代号不存在或该代号下的商品都已添加！');
    		pArtPromHandler.resetOnePromUnitToBlank(unitNoElem);
    		pArtPromHandler.clearAllInputTextsAndButtons();
    		unitNoElem.focus();
    		return;
    	}
	    	//2.清除掉[老代号]下的所有数据
			pArtPromHandler.replaceOnePromUnitNodeWithNewVal(unitNoElem, unitNo);
	    	
	    	/*重要备注:因为从"/prom/nondm/art/newGetARTJsonData"返回来的数据结构如下:
	    	{
	    		'unitName': 代号名称,
	    		'list':[xxItemVO]//包含商品与门店列表的数据
	    	}
	    	所以，需要对“包含商品与门店列表的数据”进行拆分，从中提取出2类数据：
	    	<1>.独立的商品列表；
	    	<2>.每个商品下挂的门店列表；
	    	*/
	    	var itemsData = getTransformedItemsStoresMapping(result.list,false);
	    	var repeatItemNo = pArtPromHandler.doCheckItemNoIsOnlyOne(itemsData,unitTypeVal)
	    	if(repeatItemNo){
	    		top.jWarningAlert('商品号为'+repeatItemNo+'的商品已经添加！');
	    		pArtPromHandler.resetOnePromUnitToBlank(unitNoElem);
	    		unitNoElem.focus();
	    		return;
	    	};
	    	
	    	var unitData = {};
	    	unitData.unitName = result.unitName;
	    	unitData.unitType = unitTypeVal;
	    	pArtPromHandler.updateOnePromUnitRowContent(unitNoElem, unitData);
	    	pArtPromHandler.activatePromUnitByAnyElement(unitNoElem, true);
	    	
	    	pArtPromHandler.addNewItems2OnePromUnit(unitNo, itemsData);
	    	pArtPromHandler.resetOnePromUnitPriceToBlank(unitNoElem);
	    	setReSetItemStoreScroll();
      }
	}); 
};
//删除某个促销代号(由用户发起)
function doDeletePromUnit(/*Node*/anyPURowMemberNodeIn){
	//促销已经开始不能删除代号
	if(promIsBegin()){return;}
	//该代号是否有订单使用到
	var checkPromIsInOrderFlag = true;
	//判断是否是修改页面
	if(isUpdatePage()){
		//获取页面的数据
		var dataSnapshot = pArtPromHandler.getData();	
		var units = dataSnapshot.units;
		var unitItems = dataSnapshot.unit2items;
		//获取到代号的画布
		var _unitsCanvas = pArtPromHandler.getUnitsCanvas();
		var unitRowIndex = _unitsCanvas.getRowIndex(anyPURowMemberNodeIn);
		var unitRowData = units[unitRowIndex];
		var unitNo = unitRowData.unitNo;
		if(unitNo){
			var itemArray = unitItems[unitNo].data;
			var ItemNoArray = new Array();
			for (var itemArrayInde = 0; itemArrayInde < itemArray.length; itemArrayInde++) {
				ItemNoArray.push(itemArray[itemArrayInde].itemNo);
			}
			checkPromIsInOrderFlag = checkPromIsInOrder(1,0,0,ItemNoArray,0);
		}
	}
	if(checkPromIsInOrderFlag){
		pArtPromHandler.removeOnePromUnitByNode(anyPURowMemberNodeIn);
		setReSetItemStoreScroll();
	}else{
		top.jWarningAlert( '已经有没有作废的订单使用该促销期数!');
	}
	
};
//删除某个促销代号下的某个商品(由用户发起)
function doDeletePromUnitItem(/*Node*/anyPUIRowMemberNodeIn){
	//促销已经开始不能删除商品
	if(promIsBegin()){return;}
	if(!pArtPromHandler.checkIfAnyUnitHasAtLeastOneItem()){
		top.jWarningAlert('当前代号下至少要保留一个商品！');
		return;
	}
	//该代号是否有订单使用到
	var checkPromIsInOrderFlag = true;
	//判断是否是修改页面
	if(isUpdatePage()){
		var dataSnapshot = pArtPromHandler.getData();	
		var unitItems = dataSnapshot.unit2items;
		var _itemsCanvas = pArtPromHandler.getItemsCanvas();
		var currUnitNo = pArtPromHandler.getCurrentPromUnitNo();
		var puItemsData = unitItems[currUnitNo].data;
		var itemRowIndex = _itemsCanvas.getRowIndex(anyPUIRowMemberNodeIn);
		var itemRowData = puItemsData[itemRowIndex];
		var puItemNo = itemRowData.itemNo;
		checkPromIsInOrderFlag = checkPromIsInOrder(1,0,0,puItemNo,0);
	}
	if(checkPromIsInOrderFlag){
		pArtPromHandler.removeOnePromUnitItemByNode(anyPUIRowMemberNodeIn);
		setReSetItemStoreScroll();
	}else{
		top.jWarningAlert('已经有没有作废的订单使用该促销期数!');
	}
	
};
//删除某个促销代号/某个商品下被选中的多个门店(由用户发起)
function doDeletePromUnitItemStores(/*None*/){
	//to-do.取选中的多个门店编号
	
};
//增加一个新的[待编辑]的促销代号行
function addOneNewPromUnitUnit(){
	//促销已经开始不能添加代号
	if(promIsBegin()){return;}
	pArtPromHandler.addOneEmptyPromUnit();
	setReSetItemStoreScroll();
};
//当目标[促销代号行]被点击后,执行本操作
function doOnPromUnitSelected(/*Node*/anyRowMemberNodeIn){
	pArtPromHandler.activatePromUnitByAnyElement(anyRowMemberNodeIn, true);
	setReSetItemStoreScroll();
};
//当目标[商品行]被点击后，执行本操作
function doOnPromUnitItemSelected(/*Node*/anyRowMemberNodeIn){
	top.grid_layer_open();
	var forced = $("#promUnitItemsPanel").attr("forced");
	pArtPromHandler.activateItemByAnyElement(anyRowMemberNodeIn,forced);
	setReSetItemStoreScroll();
	top.grid_layer_close();
};
//将传入的线性结构[Multi ItemStores Entries]转化成Map结构
/*
 * 结构为：
 * [xxxitemNo]-->
 * promType 促销类型
 * flag 标示是加载原来的数据还是新添加的数据
 * 
 */
function getTransformedItemsStoresMapping(/*Array*/linearItemsStoresMappingIn,/*Boolean*/isAddDataOrLoadData){
	var promType = $("#promType").val();
	var items2stores = {};
	for (var entryIdx=0;entryIdx<linearItemsStoresMappingIn.length;entryIdx++){
		//0.从线性结构中取一笔数据（包含@storeNo, @itemNo）
		var oneItemStoreEntry = linearItemsStoresMappingIn[entryIdx];
		var newItemNo = oneItemStoreEntry.itemNo;
		var newStoreNo = oneItemStoreEntry.storeNo;
		//1.判断该笔“ItemStoreInfo”关联的[商品]是否已添加;
		var mappingData = items2stores[newItemNo]; 
		if (!mappingData){
			//初始化
			mappingData = items2stores[newItemNo] = {}; 
			mappingData.stores = [];
			
			mappingData.itemNo = newItemNo;
			mappingData.itemName = oneItemStoreEntry.itemName;
			mappingData.unitNo = oneItemStoreEntry.unitNo;
		}

		//2-2.将该笔数据中的门店信息提取出来；并追加到“已建立的商品条目列表”中.
		
		var newItemStoreInfo = {};
		//填充这笔[商品门店]的数据;
		//@门店号
		newItemStoreInfo.storeNo = newStoreNo;
		//@门店名称
		newItemStoreInfo.storeName = oneItemStoreEntry.storeName;
		//@成本时点
		newItemStoreInfo.buyWhen = oneItemStoreEntry.buyWhen;
		//@买价限制
		newItemStoreInfo.buyPriceLimit = oneItemStoreEntry.buyPriceLimit;
		newItemStoreInfo.netCost = oneItemStoreEntry.netCost;
		newItemStoreInfo.promNo = oneItemStoreEntry.promNo;
		newItemStoreInfo.buyBeginDate = oneItemStoreEntry.buyBeginDate;
		newItemStoreInfo.buyEndDate = oneItemStoreEntry.buyEndDate;
		//@促销开始日期
		newItemStoreInfo.promBeginDate = oneItemStoreEntry.promBeginDate;
		//@促销类型
		newItemStoreInfo.promType = promType;
		//@促销结束日期
		newItemStoreInfo.promEndDate = oneItemStoreEntry.promEndDate;
		//@商品在当前门店的主厂商编号
		newItemStoreInfo.stMainSupNo = oneItemStoreEntry.stMainSupNo;
		//@商品在当前门店的主厂商名称
		newItemStoreInfo.stMainSupName = oneItemStoreEntry.mainComName;
		//@商品状态
		newItemStoreInfo.itemStatus = oneItemStoreEntry.status;
		//@商品状态
		newItemStoreInfo.itemStatusName = oneItemStoreEntry.itemStatusName;
		
		//@appendbuy 可以进行进价促销，0可以通过，1代表日期重叠
		newItemStoreInfo.appendBuy = oneItemStoreEntry.appendBuy;
		
		//appendProm 可以进行售价促销，0代表通过，1代表日期重叠，2代表前七后七重叠
		newItemStoreInfo.appendProm = oneItemStoreEntry.appendProm;
		
		//promNo指的是在哪一个促销期数中已经存在oneItemStoreEntry.promUnitNo
		newItemStoreInfo.promNo = oneItemStoreEntry.promNo;
		//-----------------------------------------价格的处理Begin---------------------------------------
		//进售价促销，进价促销，页面的促销进价不为空
		
		//@正常进价
		newItemStoreInfo.normBuyPrice = oneItemStoreEntry.normBuyPrice;
		
		//@正常售价
		var normSellPriceVal = oneItemStoreEntry.normSellPrice;
		newItemStoreInfo.normSellPrice = normSellPriceVal;
		var netCostVal = oneItemStoreEntry.netCost;	
		//@销售税率
		var sellVatVal = oneItemStoreEntry.vatVal==null?oneItemStoreEntry.vat:oneItemStoreEntry.vatVal;
		newItemStoreInfo.sellVat = sellVatVal;
		if(isAddDataOrLoadData){
			var promSellPriceVal="";
			if(oneItemStoreEntry.promSellPrice && oneItemStoreEntry.promSellPrice!=0){
				promSellPriceVal =oneItemStoreEntry.promSellPrice;
			}
			//@促销进价
			var promBuyPriceVal="";
			if(oneItemStoreEntry.promBuyPrice && oneItemStoreEntry.promBuyPrice!=0){
				promBuyPriceVal =oneItemStoreEntry.promBuyPrice;
			}
			newItemStoreInfo.promBuyPrice = promBuyPriceVal;
			//@促销售价
			newItemStoreInfo.promSellPrice =promSellPriceVal;
			if (promSellPriceVal && !isNaN(promSellPriceVal)){
				//计算出“降价幅度”：为售价的降价幅度, (normSellPrice - promSellPrice) / normSellPrice * 100%
				var priceCutVal = roundFun ((normSellPriceVal-promSellPriceVal)/normSellPriceVal*100,2);
				newItemStoreInfo.priceCut = priceCutVal;
				/**
		 		*计算“净毛利”：需要首先从itemStoreInfo中取出商品的净成本netCost, 还要从ItemBasic中取出该商品的sellVat 通过关联VAT　表拿到商品的售价税率，最后通过如下计算公式计算:
			 	*( promSellPrice / ( 1 + 销售税率）　－ netCost) / (promSellPrice / ( 1 + 销售税率）) * 100%
				*/
				var netMarginVal = roundFun((((Number(promSellPriceVal)/( 1 + Number(sellVatVal/100)))-Number(netCostVal))/( Number(promSellPriceVal)/( 1 + Number(sellVatVal/100))))*100,2);
				newItemStoreInfo.netMargin = netMarginVal;
			}else{
				newItemStoreInfo.priceCut = "";
				newItemStoreInfo.netMargin = "";
			}			
			
		}else if(!isAddDataOrLoadData){
			newItemStoreInfo.promBuyPrice = "";
			newItemStoreInfo.priceCut="";
			newItemStoreInfo.netMargin = "";
			newItemStoreInfo.promSellPrice = "";
		}
		//-----------------------------------------价格的处理End---------------------------------------
		mappingData.stores.push(newItemStoreInfo);
		mappingData.loaded = true;
	}
	//将Map结构转化为Handler需要的Array类型；
	//注意：这个转化操作可能会造成[商品排列顺序]的错乱;若有排序错乱发生，则请更改上面的归并算法。
	var itemsData = [];
	for (var anyItemNo in items2stores){
		itemsData.push(items2stores[anyItemNo]);
	}
	return itemsData;
};
//促销类型的显示规则
//buyTimeStart//promTimeStart//promSellPriceBody,promBuyPriceBody
function callOnAnyDateChanged(/*None*/){
	//0.检查[促销代号列表]是否为空
	var isUnitListIsEmpty = !(pArtPromHandler.hasMoreUnits());
	var timeType = $(this).attr("ttype");
	var currId=$(this).attr("id");
	var obbd = $("#oBuyBeginDate").val();
	var obed = $("#oBuyEndDate").val();
	var osbd = $("#oSellBeginDate").val();
	var osed = $("#oSellEndDate").val();
	var buyts = $("#buyTimeStart").val();
	var buyte = $("#buyTimeEnd").val();
	var promts= $("#promTimeStart").val();
	var promte= $("#promTimeEnd").val();
	var promType = $("#promType").val();
	if(obbd =="" || isUnitListIsEmpty){
		$("#oBuyBeginDate").val(buyts);
	}
	if(obed=="" || isUnitListIsEmpty){
		$("#oBuyEndDate").val(buyte);
	}
	if(osbd=="" || isUnitListIsEmpty){
		$("#oSellBeginDate").val(promts);
	}
	if(osed=="" || isUnitListIsEmpty){
		$("#oSellEndDate").val(promte);
	}
	var obj=this;
	var checktime =true;
	if(timeType =='buy'&&(promts =="" && promte=="")){
 		$("#promTypeValue").val("2-仅进价促销");
		$("#promType").val("2");
		checktime = checkTime(true,obj)
		if(buyts != "" && buyte !="" && !checkUnitListIsEmpty() && checktime){
			top.jConfirm("所有代号要进行重新验证，可能需要等待较长时间，确定要修改时间吗？", '提示消息',function(ret){
   				if(ret){
   					refreshArray(buyts,buyte,promts,promte);
   				}else{
   					//将旧值重置
   					changeDateValue(currId);
   					checkTime(true,obj)
   				}
		   	});
		}
	}
	if((timeType =='buy' && (promts!="" || promte!="")) || (timeType =='prom' && (buyts!="" || buyte!=""))){
			if(promType !="" && promType !="1"){
				if(checkUnitListIsEmpty()&&isUnitListIsEmpty){
					 $("#promTypeValue").val("1-进-售价促销");
				     $("#promType").val("1");
				     checkTime(true,obj);
				}else{
					top.jConfirm("促销类型已改变，商品信息将被清空！","提示信息",function(ret){
					 	if(ret){
						    $("#promTypeValue").val("1-进-售价促销");
						    $("#promType").val("1");
						    $("#txtChangePromBuyPriceAtItem").val("");
							$("#txtChangePromSellPriceAtItem").val("");
							pArtPromHandler.clear();
						 	checkTime(true,obj);
					 	}else{
					 		obj.value="";
					 	}
							    	
					});
				}
		   }else{
		   		checktime = checkTime(true,obj)
		   		if(buyts!="" && buyte!="" && promte !="" && promts !="" && !checkUnitListIsEmpty() &&checktime){
		   			top.jConfirm("所有代号要进行重新验证，可能需要等待较长时间，确定要修改时间吗？", '提示消息',function(ret){
		   				if(ret){
		   					refreshArray(buyts,buyte,promts,promte);
		   				}else{
		   					changeDateValue(currId);
		   					checkTime(true,obj)
		   				}
		   			});
		   		
		   		}
		   }
	}
	if(timeType =='prom' && (buyts=="" && buyte=="")){
		$("#promTypeValue").val("3-仅售价促销");
		$("#promType").val("3");
		checktime = checkTime(true,obj)
		if(promts !="" && promte !="" && !checkUnitListIsEmpty() &&checktime){
			top.jConfirm("所有代号要进行重新验证，可能需要等待较长时间，确定要修改时间吗？", '提示消息',function(ret){
   				if(ret){
   					refreshArray(buyts,buyte,promts,promte);
   				}else{
   					changeDateValue(currId);
   					checkTime(true,obj)
   				}
		   	});
		}
	}
	var newPromType = $("#promType").val();
	pArtPromHandler.changePromType(parseInt(newPromType));
};
//添加代号信息行
function addARTPromoCode(/*None*/){
	if(promIsBegin()){return;}
	var subjName=$("#subjName").val();
    var errorInd = 0;
    if($.trim(subjName)==''){
		   $("#subjName").removeClass('errorInput').addClass(
			'errorInput');
		   $("#subjName").attr("title",'请输入主题!');
		   errorInd++;
	 }
 	if(!checkAreAllInputDateValid()){
 		errorInd++;
    }
    
    if(errorInd>=1) return;
    //调用，增加新代号；
    addOneNewPromUnitUnit();
	$(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+30);
	setReSetItemStoreScroll();
};
/*
 * 黏贴代号弹出框
 * 1.促销是否开始，如果开始，则不需要黏贴代号
 * 2.验证part1部分的信息，是否为空，是否符合要求，
 * 如果符合弹出代号框，如果不符合，则返回
 */
function showPasteWin(/*Node*/unitPasteElem){
	if(promIsBegin()){return;}
	var subjName=$("#subjName").val();
    var errorInd = 0;
    if($.trim(subjName)==''){
		   $("#subjName").removeClass('errorInput').addClass(
			'errorInput');
		   $("#subjName").attr("title",'请输入主题!');
		   errorInd++;
	 }
 	if(!checkAreAllInputDateValid()){
 		errorInd++;
    }
    
   if(errorInd>=1) return;
   top.openPopupWin(600,450,'/prom/nondm/art/pastePromUnitNo');
    
}
/*
 * 当任意代号行上的[促销进价]输入框值发生变化时，调用本函数.
 */
function doUnitLevelBuyPriceChange(/*Node*/unitBuyPriceElem){
	if($(unitBuyPriceElem).hasClass("Black")){return;}
	
	if(unitBuyPriceElem.value==''){return;}
	
	var is6dot4Style = doCheckIfInputIsValidNumeric(unitBuyPriceElem.value, 6, 4);
	if (!is6dot4Style){
		unitBuyPriceElem.value = '';
		top.jWarningAlert('促销进价必须是不能超过四位小数的数字!');
		return;
	}
	if(unitBuyPriceElem.value==0){
		unitBuyPriceElem.value = '';
		top.jWarningAlert('促销进价不能为0!');
		return;
	}
	//fixup:检查当前所在行的[促销代号]是否有效
	var currPromUnitNo = pArtPromHandler.getCurrentPromUnitNo();
	if (!currPromUnitNo) return;
	var checkPromIsInOrderFlag = true;
	if(isUpdatePage()){
		var dataSnapshot = pArtPromHandler.getData();	
		var unitItems = dataSnapshot.unit2items;
		var itemArray = unitItems[currPromUnitNo].data;
		var ItemNoArray = new Array();
		for (var itemArrayInde = 0; itemArrayInde < itemArray.length; itemArrayInde++) {
			ItemNoArray.push(itemArray[itemArrayInde].itemNo);
		}
		checkPromIsInOrderFlag = checkPromIsInOrder(1,0,0,ItemNoArray,0);
	}
	//防止0123累死的情况，现将他转换为数值，然后替换输入框中的数值
	var unitBuyPriceValue =Number(unitBuyPriceElem.value)==0?"":Number(unitBuyPriceElem.value);
	unitBuyPriceElem.value = unitBuyPriceValue;
	if(checkPromIsInOrderFlag){
		pArtPromHandler.doBatchSyncPromBuyPriceAtUnit(unitBuyPriceValue);
		$("#txtChangePromBuyPriceAtItem").val(unitBuyPriceValue);
	}else{
		top.jWarningAlert('已经有没有作废的订单使用该促销期数!');
		unitBuyPriceElem.value = '';
	}
};
/*
 * 当任意代号行上的[促销售价]输入框值发生变化时，调用本函数.
 */
function doUnitLevelSellPriceChange(/*Node*/unitSellPriceElem){
	if($(unitSellPriceElem).hasClass("Black")){return;}
	if(unitSellPriceElem.value == ''){return;}
	var is6dot2Style = doCheckIfInputIsValidNumeric(unitSellPriceElem.value, 6, 2);
	if (!is6dot2Style){
		top.jWarningAlert('促销售价必须是不能超过二位小数的数字!');
		unitSellPriceElem.value = '';
		return;
	}
	if(unitSellPriceElem.value==0){
		unitSellPriceElem.value = '';
		top.jWarningAlert( '促销售价不能为0!');
		return;
	}
	//fixup:检查当前所在行的[促销代号]是否有效
	var currPromUnitNo = pArtPromHandler.getCurrentPromUnitNo();
	if (!currPromUnitNo) return;
	var unitSellPriceValue =Number(unitSellPriceElem.value)==0?"":Number(unitSellPriceElem.value);
	unitSellPriceElem.value=unitSellPriceValue;
	pArtPromHandler.doBatchSyncPromSellPriceAtUnit(unitSellPriceElem.value);
	$("#txtChangePromSellPriceAtItem").val(unitSellPriceElem.value);
};
/*
 * 当某商品的[门店列表]上的[批量促销进价]输入框值发生变化时，调用本函数.
 */
function doItemLevelBuyPriceChange(/*Node*/itemBuyPriceElem){
	if($(itemBuyPriceElem).hasClass("Black")){return;}
	if(itemBuyPriceElem.value == ''){return;}
	var checkPromIsInOrderFlag = true;
	if(isUpdatePage()){
		var puItemNo = pArtPromHandler.getCurrentPromUnitItemNo();
		checkPromIsInOrderFlag = checkPromIsInOrder(1,0,0,puItemNo,0);
	}
	if(checkPromIsInOrderFlag){	
		var is6dot4Style = doCheckIfInputIsValidNumeric(itemBuyPriceElem.value, 6, 4);
		if (!is6dot4Style){
			itemBuyPriceElem.value = '';
			top.jWarningAlert('促销进价必须是不能超过四位小数的数字!');
			return;
		}
		if(itemBuyPriceElem.value==0){
			itemBuyPriceElem.value = '';
			top.jWarningAlert('促销进价不能为0!');
			return;
		}
		var itemBuyPriceValue =Number(itemBuyPriceElem.value)==0?"":Number(itemBuyPriceElem.value);
		itemBuyPriceElem.value = itemBuyPriceValue;
		pArtPromHandler.doBatchSyncPromBuyPriceAtItem(itemBuyPriceElem.value);
	}else{
		top.jWarningAlert('已经有没有作废的订单使用该促销期数!');
		itemBuyPriceElem.value="";
	}
};
/*
 * 当某商品的[门店列表]上的[批量促销售价]输入框值发生变化时，调用本函数.
 */
function doItemLevelSellPriceChange(/*Node*/itemSellPriceElem){
	if($(itemSellPriceElem).hasClass("Black")){return;}
	if(itemSellPriceElem.value == ''){return;}
	var is6dot2Style = doCheckIfInputIsValidNumeric(itemSellPriceElem.value, 6, 2);
	if (!is6dot2Style){
		top.jWarningAlert('促销售价必须是不能超过二位小数的数字!');
		itemSellPriceElem.value = '';
		return;
	}
	if(itemSellPriceElem.value==0){
		top.jWarningAlert('促销售价不能为0!');
		itemSellPriceElem.value = '';
		return;
	}
	var itemSellPriceValue =Number(itemSellPriceElem.value)==0?"":Number(itemSellPriceElem.value);
	itemSellPriceElem.value=itemSellPriceValue;
	pArtPromHandler.doBatchSyncPromSellPriceAtItem(itemSellPriceElem.value);
};
/*
 * 当某商品某门店上的[促销进价]输入框值发生变化时，调用本函数.
 */
function doStoreLevelBuyPriceChange(/*Node*/storeBuyPriceElem){
	if($(storeBuyPriceElem).hasClass("Black")){return;}
	if(storeBuyPriceElem.value ==''){return;}
	//恢复之前的值
	//1-1获取当前选中的itemNo
	var puItemNo = pArtPromHandler.getCurrentPromUnitItemNo();
	//1-2获取当前门店所在行
	var storeIndex = pArtPromHandler._storesRightBodyCanvas.getRowIndex(storeBuyPriceElem);
	//1-3获取 到当前门店的促销进价
	var promBuyPrice = pArtPromHandler.getItemStorePropValue(puItemNo, storeIndex, "promBuyPrice");
	
	var is6dot2Style = doCheckIfInputIsValidNumeric(storeBuyPriceElem.value, 6, 4);
	if (!is6dot2Style){
		top.jWarningAlert('促销进价必须是不能超过四位小数的数字!');
		storeBuyPriceElem.value = promBuyPrice==null?"":promBuyPrice;
		return;
	}
	
	if(storeBuyPriceElem.value==0){
		storeBuyPriceElem.value = promBuyPrice;
		top.jWarningAlert('促销进价不能为0!');
		return;
	}
	
	var checkPromIsInOrderFlag = true;
	if(isUpdatePage()){
		var storeNo = pArtPromHandler.doGetStoreNoByPromPrice(storeBuyPriceElem);	
		var puItemNo = pArtPromHandler.getCurrentPromUnitItemNo();
		checkPromIsInOrderFlag = checkPromIsInOrder(1,0,0,puItemNo,storeNo);
	}
	
	if(checkPromIsInOrderFlag){	
		var storeBuyPriceValue =Number(storeBuyPriceElem.value)==0?"":Number(storeBuyPriceElem.value);
		storeBuyPriceElem.value = storeBuyPriceValue;
		pArtPromHandler.doSyncPromBuyPriceAtStore(storeBuyPriceElem.value, storeBuyPriceElem);
	}else{
		
		storeBuyPriceElem.value = promBuyPrice==null?"":promBuyPrice;
		top.jWarningAlert( '已经有没有作废的订单使用该促销期数!');
		
	}
	
};
/*
 * 当某商品某门店上的[促销售价]输入框值发生变化时，调用本函数.
 */
function doStoreLevelSellPriceChange(/*Node*/storeSellPriceElem){
	if($(storeSellPriceElem).hasClass("Black")){return;}
	if(storeSellPriceElem.value ==''){return;}
	//恢复之前的值
	//1-1获取当前选中的itemNo
	var puItemNo = pArtPromHandler.getCurrentPromUnitItemNo();
	//1-2获取当前门店所在行
	var storeIndex = pArtPromHandler._storesRightBodyCanvas.getRowIndex(storeSellPriceElem);
	//1-3获取 到当前门店的促销进价
	var promSellPrice = pArtPromHandler.getItemStorePropValue(puItemNo, storeIndex, "promSellPrice");
	
	var is6dot2Style = doCheckIfInputIsValidNumeric(storeSellPriceElem.value, 6, 2);
	if (!is6dot2Style){
		top.jWarningAlert('促销售价必须是不能超过二位小数的数字!');
		storeSellPriceElem.value = promSellPrice==null?"":promSellPrice;
		return;
	}
	if(storeSellPriceElem.value==0){
		storeSellPriceElem.value = promSellPrice;
		top.jWarningAlert('促销售价不能为0!');
		return;
	}
	
	var storeSellPriceValue =Number(storeSellPriceElem.value)==0?"":Number(storeSellPriceElem.value);
	storeSellPriceElem.value = storeSellPriceValue;
	pArtPromHandler.doSyncPromSellPriceAtStore(storeSellPriceElem.value, storeSellPriceElem);
};

/*
 * 当某商品某门店上的[(进售价)降价幅度]输入框值发生变化时，调用本函数.
 */
function doStoreLevelBuyPriceCutRangeChange(/*Node*/storeBuyPriceCutRangeElem){
	if($(storeBuyPriceCutRangeElem).hasClass("Black")){return;}
	var buyPriceCutRange = storeBuyPriceCutRangeElem.value;
	if(buyPriceCutRange ==''){return;}
	//1-1获取当前选中的itemNo
	var currentItemNo = pArtPromHandler.getCurrentPromUnitItemNo();
	//1-2获取当前门店所在行
	
	var currentStoreIndex = pArtPromHandler._storesRightBodyCanvas.getRowIndex(storeBuyPriceCutRangeElem);
	//1-3获取 正常进售价 降价的比例 的值
	var normBuyPrice = pArtPromHandler.getItemStorePropValue(currentItemNo, currentStoreIndex, "normBuyPrice");
	//1-4计算促销进价并且存入门店数组中
	pArtPromHandler.calculatePromBuyPrice(/*int*/currentItemNo,/*int*/currentStoreIndex,/*int*/buyPriceCutRange,/*int*/normBuyPrice,/*Node*/storeBuyPriceCutRangeElem);
}

/*
 * 当某商品某门店上的[（促销进售价）降价幅度]输入框值发生变化时，调用本函数.
 */
function doStoreLevelSellPriceCutRangeChange(/*Node*/storeSellPriceCutRangeElem){
	if($(storeSellPriceCutRangeElem).hasClass("Black")){return;}
	//var sellPriceCutRange = storeSellPriceCutRangeElem.value;
	if(storeSellPriceCutRangeElem.value ==''){return;}
	//1-1获取当前选中的itemNo
	var currentItemNo = pArtPromHandler.getCurrentPromUnitItemNo();
	//1-2获取当前门店所在行
	var currentStoreIndex = pArtPromHandler._storesRightBodyCanvas.getRowIndex(storeSellPriceCutRangeElem);
	//1-3获取 促销进售价 降价的比例 的值
	var sellPriceCutRange = pArtPromHandler.getItemStorePropValue(currentItemNo, currentStoreIndex, "sellPriceCutRange");
}


/*
 * [促销进价]文本框的键入检查,一般格式为Number(10, 4)
 * 
 */
function doCheckOnPromBuyPriceKeyin(/*Event*/evtIn, /*Node*/pbpElemIn){
	doCheckIfInputInRangeAndFix(evtIn, 6, 4);
};
/*
 * [促销售价]文本框的键入检查,一般格式为Number(8, 2)
 * 
 */
function doCheckOnPromSellPriceKeyin(/*Event*/evtIn, /*Node*/pspElem){
	doCheckIfInputInRangeAndFix(evtIn, 6, 2);
};
function doCheckOnPaste(/*Node*/anyElem){
	if(isNaN(anyElem.value)) document.execCommand('undo');
};
/*
 * 通过传入的事件，对事件源（一般为DOM元素）进行检查，看“目标字符串”是否符合预期的数据格式：[majorLenIn][.][minorLenIn]
 */
function doCheckIfInputInRangeAndFix(/*Event*/evtIn, /*int*/majorLenIn, /*int*/minorLenIn){
	var evt = evtIn || window.event;
	var anyElem = evt.srcElement || evt.target;
	//0.判断当前keyin的值是否在[0~9]+ [.]之间;
	var charCode = evt.keyCode || evt.which;
	if (charCode == 13){//回车即“失去焦点”
		anyElem.blur();
		return;
	}
	var numCheckFlag = (charCode>=48 && charCode<=57) || charCode ==46;
	//todo.需要考虑整体数据的合法性：如123[xxx光标所在地被选取的内容]1.2345
	if (numCheckFlag){
		//再次检查用户是否输入了第2个点号.
		if (charCode == 46){
			var inputVal = anyElem.value;
			numCheckFlag = inputVal.indexOf(".")<=0;
		}
	}
	if (!numCheckFlag){
	    if (evt.preventDefault) {
	        evt.preventDefault();
	    } else {
	        evt.returnValue = false;
	    }	
	}	
};
/*
 * 比如，对待检查的字符串s1("1234567.89235")可以执行下面的合法性检查：
 * doCheckIfNumInputValid(s1, 6, 4)
 * 检查当前传入的字符串是否符合[majorNumLenIn].[minorNumLenIn]的数字串格式;
 */
function doCheckIfInputIsValidNumeric(/*String*/inputStrIn, /*int*/majorNumLenIn, /*int*/minorNumLenIn){
	var ruleStr = "^([0-9][\\d]{0," + (majorNumLenIn-1) + "})(\\.[\\d]{1," + minorNumLenIn + "})?$";
	var ruleObj = new RegExp(ruleStr);
	var strArr = inputStrIn.match(ruleObj);
	return strArr != null;
};

//关闭ART页面
function doCloseARTPage(/*None*/Param){
	var url = ctx + '/prom/nondm/art/ARTPromo';
	if(Param !=null && Param !=""){
		url = url+'?paramArray='+Param;
	}
	$(top.document).find("#contentIframe").attr("src",url);
}


/*
 * 进入ART修改页面初始化页面的数据
 * 1.填充页面数据
 * 1-1.填充初始化units数据【代号的数据结构体】
 * 1-2.填充初始化unit2items数据【代号与商品的映射关系结构体】
 * 1-3.填充初始化item2stores数据【商品与门店的映射关系结构体】
 * 2.填充页面显示的数据
 * 2-1.初始化basicinfo的数据【part1部分】
 * 2-2.初始化代号区域的模板动态内容【part2部分】
 * 2-3.初始化商品，门店区域的模板动态内容【part3部分】
 */
function initARTDataOnUpdate(/*Array*/unitStoreList,/*Array*/unitNoList,/*Array*/basicInfo){
	//0.初始化当前促销的基础数据
	initARTBasicInfoOnUpdate(basicInfo);
	initARTBasicInfoOnUpdateForDate(basicInfo);
	//1.将当前促销期数下的“代号列表”加入到结构中；
	pArtPromHandler.addNewPromUnits(unitNoList, true);
	//2.往各个代号下增加[商品门店]列表数据；
	for (var unitStoreIndex = 0; unitStoreIndex < unitStoreList.length; unitStoreIndex++) {
		var unitStoreMap = unitStoreList[unitStoreIndex];
		var itemsStoreList = JSON.parse(unitStoreMap.datas);
		var unitNo = unitStoreMap.unitNo;
		var itemsData = getTransformedItemsStoresMapping(itemsStoreList,true);
		//重要备注：只向[目标代号]中追加[商品门店]数据
		pArtPromHandler.addNewItems2OnePromUnit(unitNo, itemsData, true);
	}
	//3.模拟选中第1个代号；
	pArtPromHandler.getUnitsCanvas().clickRowByIndex(0);
	$("#initOver").val("0");
	
}

function initARTBasicInfoOnUpdateForDate(/*object*/basicInfo){
	var promType = basicInfo[0].promType;
	var buyBeginDate = basicInfo[0].buyBeginDate;
	var buyEndDate = basicInfo[0].buyEndDate;
	var promBeginDate = basicInfo[0].promBeginDate;
	var promEndDate = basicInfo[0].promEndDate;
	var minBuyDate = basicInfo[0].minBuyDate; 
	var minPromDate= basicInfo[0].minPromDate;
	$("#buyTimeStart").val(buyBeginDate);
	$("#buyTimeEnd").val(buyEndDate);
	$("#promTimeStart").val(promBeginDate);
	$("#promTimeEnd").val(promEndDate);
	$("#oBuyBeginDate").val(buyBeginDate);
    $("#oBuyEndDate" ).val(buyEndDate);
    $("#oSellBeginDate" ).val(promBeginDate);
    $("#oSellEndDate" ).val(promEndDate);
	var promType = $("#promType").val();
 	var buybegin = $("#buyBegin").val();
 	var sellBegin = $("#sellBegin").val();
	var buyEnd = $("#buyEnd").val();
 	var sellEnd = $("#sellEnd").val();
 	//当整个促销已经结束
	if(promIsEnd()){
		$("#buyTimeStart").removeClass("Black").addClass("Black").removeAttr("onfocus");
		$("#buyTimeEnd").removeClass("Black").addClass("Black").removeAttr("onfocus");
		$("#promTimeStart").removeClass("Black").addClass("Black").removeAttr("onfocus");
		$("#promTimeEnd").removeClass("Black").addClass("Black").removeAttr("onfocus");
	}else{
		var calendarLang = $("#calendarLang").val();
		var endDate ="WdatePicker({onpicked:callOnAnyDateChanged,isShowClear: false, readOnly: true,lang:'"+calendarLang+"',dateFormat:'yy-MM-dd',minDate:'%y-%M-\#{%d}'})";
		var buyStartDate = "WdatePicker({onpicked:callOnAnyDateChanged,isShowClear: false, readOnly: true,lang:'"+calendarLang+"',dateFormat:'yy-MM-dd',minDate:'"+minBuyDate+"'})";
		var SellStartDate = "WdatePicker({onpicked:callOnAnyDateChanged,isShowClear: false, readOnly: true,lang:'"+calendarLang+"',dateFormat:'yy-MM-dd',minDate:'"+minPromDate+"'})";
		if(promType==1){//进售价促销
			if(buybegin==1){
				$("#buyTimeStart").removeClass("Black").addClass("Black").removeAttr("onfocus");
			}else{
				$("#buyTimeStart").attr("onFocus",buyStartDate);
			}
			if(buyEnd==1){
				$("#buyTimeEnd").removeClass("Black").addClass("Black").removeAttr("onfocus");
			}else{
				$("#buyTimeEnd").attr("onFocus",endDate);
			}
			if(sellBegin==1){
				$("#promTimeStart").removeClass("Black").addClass("Black").removeAttr("onfocus");
			}else{
				$("#promTimeStart").attr("onFocus",SellStartDate)
			}
			if(promTimeEnd==1){
				$("#promTimeEnd").removeClass("Black").addClass("Black").removeAttr("onfocus");
			}else{
				$("#promTimeEnd").attr("onFocus",endDate);
			}
			
		}else if(promType==2){
			if(buybegin==1){
				$("#buyTimeStart").removeClass("Black").addClass("Black").removeAttr("onfocus");
			}else{
				$("#buyTimeStart").attr("onFocus",buyStartDate);
			}
			if(buyEnd==1){
				$("#buyTimeEnd").removeClass("Black").addClass("Black").removeAttr("onfocus");
			}else{
				$("#buyTimeEnd").attr("onFocus",endDate);
			}
			
			$("#promTimeStart").removeClass("Black").addClass("Black").removeAttr("onfocus");
			$("#promTimeEnd").removeClass("Black").addClass("Black").removeAttr("onfocus");
			
		}else if (promType==3){
			if(sellBegin==1){
				$("#promTimeStart").removeClass("Black").addClass("Black").removeAttr("onfocus");
			}else{
				$("#promTimeStart").attr("onFocus",SellStartDate)
			}
			if(promTimeEnd==1){
				$("#promTimeEnd").removeClass("Black").addClass("Black").removeAttr("onfocus");
			}else{
				$("#promTimeEnd").attr("onFocus",endDate);
			}
			
			$("#buyTimeStart").removeClass("Black").addClass("Black").removeAttr("onfocus");
			$("#buyTimeEnd").removeClass("Black").addClass("Black").removeAttr("onfocus");
		}
	}
	
	
	
}




/*
 * 修改ART促销页面初始化basicInfo的数据【part1部分】
 */
function initARTBasicInfoOnUpdate(/*Array*/basicInfoJson){
	var basicInfo= basicInfoJson[0];
	var subjNo = basicInfo.subjNo;
	var subjName = basicInfo.subjName;
	var catlgId = basicInfo.catlgId;
	var catlgName = basicInfo.catlgName;
	var promType = basicInfo.promType;
	var promTypeName = basicInfo.promTypeName;
	//0.设置促销期数
	$("#promNo").val(subjNo);
	//1.设置促销名称
	$("#subjName").val(subjName);
	//6.设置课别
	$("#CatlgId").val(catlgId);
	//7.设置课别名称
	$("#CatlgName").val(catlgName);
	//8.设置促销类型
	$("#promTypeValue").val(promType+"-"+promTypeName);
	$("#promType").val(promType);
	
	pArtPromHandler.changePromType(parseInt(promType),promIsBegin());
	if(promIsBegin()){

		$("#subjName").removeClass("Black").addClass("Black").removeAttr("onfocus").attr("readOnly","readOnly");
		$("#txtChangePromSellPriceAtItem").removeClass("Black").addClass("Black").removeAttr("onfocus");
		$("#txtChangePromBuyPriceAtItem").removeClass("Black").addClass("Black").removeAttr("onfocus");
		
	}
}

/**
 * 将已经删除的商品添加回来（在弹出框选中的商品）
 * @param {} itemNoArray 选中的商品的商品编号列表值
 * @param {} itemNameArray 选中商品的商品名称的列表值
 * @param {} basicInfo 返回基本信息，unitNo，和untType
 * 1.根据选中的商品列表查询商品-门店的列表
 * 2.将商品保存到页面想赢的item，stores列表中
 * 3.将商品显示在页面上
 */
function addSelectedItemReturn(/*Array*/itemNoArray,/*Array*/itemNameArray,/*Object*/basicInfo){

	if(itemNoArray.length==0){return;}
	//0将返回的itemNo格式化，进行是否已经添加的检测
	var doCheckItemNoIsOnlyOneArray = new Array();
	for (var itemNoArrayIndex = 0; itemNoArrayIndex < itemNoArray.length; itemNoArrayIndex++) {
		var itemNo = itemNoArray[itemNoArrayIndex];
		var oCheckItemNoIsOnlyOneJson ={};
		oCheckItemNoIsOnlyOneJson.itemNo = itemNo;
		doCheckItemNoIsOnlyOneArray.push(oCheckItemNoIsOnlyOneJson);
	}
	var basicInfoArray = basicInfo.split("-");
	var repeatItemNo  = pArtPromHandler.doCheckItemNoIsOnlyOne(doCheckItemNoIsOnlyOneArray,basicInfoArray[1]);
	if(repeatItemNo){
		top.jWarningAlert('商品号为'+repeatItemNo+'的商品已经添加！');
		return;
	}
	//1-1.获取代号
	var unitNo = basicInfoArray[0];
	//1-2.获取代号类型
	var unitType =  basicInfoArray[1];
	//1-3.获取课别的编号
	var catlgId = $("#CatlgId").val();
	//1-4.获取进价促销的开始时间
	var buyts = $("#buyTimeStart").val();
	//1-5.获取进价促销的结束时间
	var buyte = $("#buyTimeEnd").val();
	//1-6.获取售价促销的开始时间
	var promts= $("#promTimeStart").val();
	//1-7.获取售价促销的结束时间
	var promte= $("#promTimeEnd").val();
	//1-8.获取促销类型
	var promType = $("#promType").val();  
	var promNo="";
	if(isUpdatePage()){
		promNo = $("#promNo").val(); 
	}
	var addItemStoresParam = {};
	addItemStoresParam.unitType = unitType;
	addItemStoresParam.unitNo = unitNo;
	addItemStoresParam.catlgId =catlgId;
	addItemStoresParam.promType =promType;
	addItemStoresParam.buyBeginDate = buyts;
	addItemStoresParam.buyEndDate = buyte;
	addItemStoresParam.promBeginDate = promts;
	addItemStoresParam.promEndDate = promte;
	addItemStoresParam.promNo = promNo;
	$.ajax({
		async : false,
		url: ctx + '/prom/nondm/art/ItemsStoreInfoBy?itemsNoArray='+itemNoArray,
        data:addItemStoresParam,
        type: "post",
        dataType:"json",
        success: function(result) {
        	if(result.storeList.length > 0){
        		//结构为当前unitNo的itemsData
        		var itemsData = getTransformedItemsStoresMapping(JSON.parse(result.storeList),false);
				//重要备注：只向[目标代号]中追加[商品门店]数据
				pArtPromHandler.addNewItems2OnePromUnit(unitNo, itemsData, false);
				setReSetItemStoreScroll();
        	}
        }
    });
	top.closePopupWin();
}
/*
 * 将已经删除的商品添加回来
 * 
 */
function addMoreItems(/*None*/){
	if(promIsBegin()){return;}
	//1.获取查询必要的参数
	var $promUnitDivObject = $(".pro_store_tb_edit").find("div.item_on");
	//1-1.获取到当前所选的代号
	var unitNo = pArtPromHandler.getCurrentPromUnitNo();
	if(pArtPromHandler.getData().units.length==0){return;}
	//1-2.获取代号类型的值
	//var unitType =pArtPromHandler.getCurrentPromUnitType();
	var unitType = $promUnitDivObject.find("select[name='unitType']").val();
	//1-2-1 当代号类型为单品的时候，将其返回
	if(unitType==0){return;}
	
	//1-2.获取到当前页面包含的全部商品【itemNo】，弹出的商品列表要把这些商品排除
	//1-2-1. 获取unitNo-itemNo的映射关系
	 var unitItems = pArtPromHandler.getData().unit2items;
	//1-2-2. 获取当前代号下的所有的itemNo
	 var thisCheckUnitNoItemList = unitItems[unitNo].data;
	 if(thisCheckUnitNoItemList.length==0){return;}
	 var itemsNoArray= new Array();
	 for (var itemNoIndex = 0; itemNoIndex < thisCheckUnitNoItemList.length; itemNoIndex++) {
	 	itemsNoArray.push(thisCheckUnitNoItemList[itemNoIndex].itemNo);
	 }
	 var singleUnitNoJson = pArtPromHandler.doGetSingleUnitNo();
	 var singleUnitNoArray = singleUnitNoJson.singleUnitNo;
	 if(singleUnitNoArray !=null && singleUnitNoArray.length > 0){
	 	for (var singleUnitNoArrayIndex = 0; singleUnitNoArrayIndex < singleUnitNoArray.length; singleUnitNoArrayIndex++) {
	 		itemsNoArray.push(singleUnitNoArray[singleUnitNoArrayIndex]);
	 	}
	 }
	 
	//1-3.获取促销类型的值
	var promType = $("#promType").val();
	//1-4.获取进价促销的开始时间
	var buyts = $("#buyTimeStart").val();
	//1-5.获取进价促销的结束时间
	var buyte = $("#buyTimeEnd").val();
	//1-6.获取售价促销的开始时间
	var promts= $("#promTimeStart").val();
	//1-7.获取售价促销的结束时间
	var promte= $("#promTimeEnd").val();
	//1-8.获取课别的编号
	var catlgId = $("#CatlgId").val();
	var promNo="";
	if(isUpdatePage()){
		promNo = $("#promNo").val(); 
	}
	 top.openPopupWin(420,480,'/prom/nondm/art/showARTDeleteItemsList?itemsValue='+itemsNoArray+'&unitNo='+unitNo+'&catlgId='+catlgId+'&unitType='+unitType+'&flag=ART&promType='+promType+'&buyStartDate='+buyts+'&buyEndDate='+buyte+'&promStartDate='+promts+'&promEndDate='+promte+'&promNo='+promNo);
}

function addStoreSupMessReturn(/*Array*/storeIdArray){
	if(storeIdArray.length<1){return;}
	//1-1.获取促销类型的值
	var unitNo =  pArtPromHandler.getCurrentPromUnitNo();
	//1-2.获取促销类型的值
	var catlgId = $("#CatlgId").val();
	//1-3.获取促销类型的值
	var itemNo =  pArtPromHandler.getCurrentPromUnitItemNo();
	//1-4.获取促销类型的值
	var promType = $("#promType").val();
	//1-5.获取进价促销的开始时间
	var buyts = $("#buyTimeStart").val();
	//1-6.获取进价促销的结束时间
	var buyte = $("#buyTimeEnd").val();
	//1-7.获取售价促销的开始时间
	var promts= $("#promTimeStart").val();
	//1-8.获取售价促销的结束时间
	var promte= $("#promTimeEnd").val();
	var promNo="";
	if(isUpdatePage()){
		promNo = $("#promNo").val(); 
	}
	var addStoresParam ={};
	addStoresParam.unitNo = unitNo;
	addStoresParam.catlgId = catlgId;
	addStoresParam.itemNo = itemNo;
	addStoresParam.promType = promType;
	addStoresParam.buyBeginDate = buyts;
	addStoresParam.buyEndDate = buyte;
	addStoresParam.promBeginDate = promts;
	addStoresParam.promEndDate = promte;
	addStoresParam.promNo = promNo;
	$.ajax({
		async : false,
		url: ctx + '/prom/nondm/art/showSupplerList?storeNos='+storeIdArray,
		data:addStoresParam,
        type: "post",
        dataType:"json",
        success: function(result) {
        	if(result.storelist.length > 0){
        		//为当前选中的商品itemNO增加更多的门店
        		pArtPromHandler.addNewStores(result.storelist);
        		setReSetItemStoreScroll();
        	}
        }
	 });
	top.closePopupWin();
}
function addMoreStores(/*None*/){
	if(promIsBegin()){return;}
	//1-2.获取当前选中的代号unitNo
	var unitNo = pArtPromHandler.getCurrentPromUnitNo();
	//1-1.获取选中的itemNo
	var itemNo = pArtPromHandler.getCurrentPromUnitItemNo();
	if(!itemNo){return;}
	//1-3.获取当前商品下显示的storeNO
	var itemStores = pArtPromHandler.getData().item2stores;	
	var thisCheckItemStoresList = itemStores[itemNo].data;
	if(thisCheckItemStoresList.length==0){return;}
	var storesNoArray= new Array();
	for (var itemStoresIndex = 0; itemStoresIndex < thisCheckItemStoresList.length; itemStoresIndex++) {
		storesNoArray.push(thisCheckItemStoresList[itemStoresIndex].storeNo);
	}
	//1-4.获取促销类型的值
	var promType = $("#promType").val();
	//1-5.获取进价促销的开始时间
	var buyts = $("#buyTimeStart").val();
	//1-6.获取进价促销的结束时间
	var buyte = $("#buyTimeEnd").val();
	//1-7.获取售价促销的开始时间
	var promts= $("#promTimeStart").val();
	//1-8.获取售价促销的结束时间
	var promte= $("#promTimeEnd").val();
	//1-9.获取课别的编号
	var catlgId = $("#CatlgId").val();
	
	var promNo="";
	if(isUpdatePage()){
		promNo = $("#promNo").val(); 
	}
	top.openPopupWin(800,480, '/prom/nondm/art/showARTDeleteSupplerList?storeNos='+storesNoArray+'&unitNo='+unitNo+'&catlgId='+catlgId+'&itemNo='+itemNo+'&promType='+promType+'&buyStartDate='+buyts+'&buyEndDate='+buyte+'&promStartDate='+promts+'&promEndDate='+promte+'&promNo='+promNo);
	
}
/*整理ART数据并将其保存*/
function savePromARTData(/*None*/){
	var toDoFlag = "create";
	var subjName=$("#subjName").val();
	var promBeginDate=$("#promTimeStart").val();
	var promEndDate=$("#promTimeEnd").val();
	var buyBeginDate=$("#buyTimeStart").val();
    var buyEndDate=$("#buyTimeEnd").val();
    var catlgId=$("#CatlgId").val();
    var pricePromType=$("#promType").val();
    
    //0.验证主题名称是否为空
    if(!checkSubjNameBoolean()){
    	return;
    }
	 //1.检查时间是否正确
 	if(!checkTime(true)){
		return;
    }
    //接收数据
	var dataSnapshot = pArtPromHandler.getData();	
	var units = dataSnapshot.units;
	var unitItems = dataSnapshot.unit2items;
	var itemStores = dataSnapshot.item2stores;
 	
    //检查是否存在空白的[促销代号];
    if(pArtPromHandler.hasEmptyUnitExist()){
    	top.jWarningAlert('请填写代号信息！');
 		return;
 	}
 	//循环页面保存的所有数据，判断促销进价，促销售价是否填写
 	if(!checkItemStoresValid(itemStores,unitItems,units)){
 		return;
     }
     
	var artData2CreateOrUpdateJson ={};//待提交的完整结构体
	var artSaveOrUpdateParam={};
	var artBasicInfo = {};
 	artBasicInfo.promBeginDate = promBeginDate;
 	artBasicInfo.promEndDate = promEndDate;
 	artBasicInfo.buyBeginDate = buyBeginDate;
 	artBasicInfo.buyEndDate = buyEndDate;
 	artBasicInfo.catlgId = catlgId;
 	artBasicInfo.pricePromType = pricePromType;
 	artBasicInfo.subjName =subjName;
 	if(isUpdatePage()){
		var promNo = $("#promNo").val();
		artBasicInfo.promNo =promNo;
		toDoFlag = "modify";
	}
 	//0.设置促销的主档信息
	artData2CreateOrUpdateJson.basicInfo = artBasicInfo;
	/**
	 * 1.进入重要的执行步骤：设置[代号--〉商品--〉门店]的数据结构体。
	 * 此处取简化后的[数据]版本，以实现在一个AJAX请求中完成数十笔大批量代号的保存。
	 * 为了配合WEB Server侧的Action实现，简化版返回来的数据结构类似于getData()返回的完整版本。
	 * 注意：若在一个促销中维护了数十笔（比如30笔）以上的代号（大部分是系列商品），则客户端还需要考虑使用“分组批次传送”的功能。
	 */
	var reducedData4Save = pArtPromHandler.getData4SaveOnly();	
 	//1-1.代号列表数据
	artData2CreateOrUpdateJson.units = reducedData4Save.units;
	//1-2.所有代号下的商品列表数据
	artData2CreateOrUpdateJson.unitItems = reducedData4Save.unit2items;
	//1-3.所有代号/所有商品下的门店列表数据
	artData2CreateOrUpdateJson.itemStores= reducedData4Save.item2stores;
	//对“待传输的结构体”进行序列化；
	var artData2CreateOrUpdateJsonStr = JSON.stringify(artData2CreateOrUpdateJson);
	artSaveOrUpdateParam.artSaveOrUpdateParamJsonStr = artData2CreateOrUpdateJsonStr;
	artSaveOrUpdateParam.toDoFlag = toDoFlag;
	$.ajax({
		 url: ctx + '/prom/nondm/art/saveARTInfo?ti='+(new Date()).getTime(),
	     type: "post",
	     data: artSaveOrUpdateParam,
	     success: function(result) {
	     	if(result.error != null && result.error=="1"){
	     		top.jWarningAlert( result.message);
	     	}else{
	     		if(toDoFlag=="create"){
	     			top.jSuccessAlert( result.message,function(){
						window.location.href=ctx + '/prom/nondm/art/createARTPromo';        	
		        	});
	     		}else{
	     			top.jSuccessAlert(result.message);
	     		}
	     	}
	     }
	 });
};
/*
 * 界面操作：在门店列表区域，勾选[全选]按钮。
 */
function selectAllItemStores(/*Node*/ckbElem){
	pArtPromHandler.doSelectAllStoresOrNot(ckbElem.checked);
}
/*
 * 从当前的[商品门店]列表中删除选中的多笔[门店]数据.
 */
function doBatchItemStoresRemoval(/*Node*/delElem){
	//促销是否已经开始
	if(promIsBegin()){return;}
	//当前商品下至少要保留一个门店
	if(!pArtPromHandler.checkIfAnyItemHasAtLeastOneStore()){top.jWarningAlert('当前商品下至少要保留一个门店！');return;};
	//该代号是否有订单使用到
	var checkPromIsInOrderFlag = true;
	//判断是否是修改页面
	if(isUpdatePage()){
		var puItemNo = pArtPromHandler.getCurrentPromUnitItemNo();
		var storeNoArray =pArtPromHandler.getSelectItemsStoreNo();
		if(storeNoArray ==null || storeNoArray.length<1){return;}
		checkPromIsInOrderFlag = checkPromIsInOrder(1,0,0,puItemNo,storeNoArray);
	}
	if(checkPromIsInOrderFlag){
		pArtPromHandler.delStoresFromActivatedItem();
		setReSetItemStoreScroll();
	}else{
		top.jWarningAlert( '已经有没有作废的订单使用该促销期数!');
	}
}
/*
 * 选择某笔确定的代号后，将该笔代号数据加入到内部维护的数据结构中。
 */
function addStoreGrpTypeReturn(/*JSON*/data){
	if (!data) return;
	//0.检测代号是否已经存在；
	var newPromUnitNo = data.promUnitNo;
	var currUnitTypeVal = pArtPromHandler.getCurrentPromUnitType(); 
	if (pArtPromHandler.isPromUnitNoDuplicated(newPromUnitNo)){
		top.jWarningAlert('该代号已经存在，请重新选择！');
		pArtPromHandler.clearAllInputTextsAndButtons();
		return;
	}
	
	var itemsData = getTransformedItemsStoresMapping(data.list,false);
	var repeatItemNo = pArtPromHandler.doCheckItemNoIsOnlyOne(itemsData,currUnitTypeVal)
	if(repeatItemNo){
		top.jWarningAlert('商品号为'+repeatItemNo+'的商品已经添加！');
		return;
	};
	//1.将该笔代号的数据追加到内部的“数据结构”中；
	pArtPromHandler.replaceOnePromUnitNodeWithNewVal(pLastUnitNoInputElem, newPromUnitNo);
	//2.更新当前[代号]ROW的内容
	var unitData = {};
	unitData.unitNo = newPromUnitNo;
	unitData.unitName = data.promUnitName;
	//重要备注：小心！对@unitType的更新是非必须的。若一定要更新，则必须取正确的值。
	unitData.unitType = currUnitTypeVal;
	pArtPromHandler.updateOnePromUnitRowContent(pLastUnitNoInputElem, unitData);
	pArtPromHandler.activatePromUnitByAnyElement(pLastUnitNoInputElem, true);
	//3.提取商品/门店的映射关系
	
	pArtPromHandler.addNewItems2OnePromUnit(newPromUnitNo, itemsData);
	pArtPromHandler.resetOnePromUnitPriceToBlank(pLastUnitNoInputElem);
	setReSetItemStoreScroll();
	top.closePopupWin();
};
/*
 *选择单独的门店，当门店全部选中的时候选中全选按钮 
 */
function checkOneStore(/*None*/){
	if(pArtPromHandler.doSelectCheckAllCheckBox()){
		$("#ckbSelectAllStores").attr("checked",true);   
	}else{
		$("#ckbSelectAllStores").attr("checked",false);
	}
}
/*
 * 门店区域的滚动条恢复到初始状态
 */
function setReSetItemStoreScroll(/*None*/){
	 $("#m_cols_head").scrollLeft(0);
     $("#m_cols_body").scrollLeft(0);
     $("#m_cols_body").scrollTop(0);
}

/*
 * 当用户取消修改时间的时候，将时间的旧值还原回来
 */
function changeDateValue(/*String*/targetDateId){
	var beforeDateValue = "";
	if(targetDateId=="buyTimeStart"){
		beforeDateValue =  $("#oBuyBeginDate").val();
	}else if (targetDateId=="buyTimeEnd"){
		beforeDateValue =  $("#oBuyEndDate").val();
	}else if(targetDateId=="promTimeStart"){
		beforeDateValue =  $("#oSellBeginDate").val();
	}else{
		beforeDateValue =  $("#oSellEndDate").val();
	}
	$("#"+targetDateId).val(beforeDateValue);
}


/*
 * 修改时间，刷新页面所有的数据
 */
function refreshArray(/*Date*/buyts,/*Date*/buyte,/*Date*/promts,/*Date*/promte){
	var promNo="";
	if(isUpdatePage()){//如果是修改页面则要排除自己
		promNo = $("#promNo").val(); 
	}
	//循环数组，去除比较的参数
	var dataSnapshot = pArtPromHandler.getData();//获取页面的数据
	//页面保存的代号数据
	var units = dataSnapshot.units;
	//页面保存的代号，商品的关系数据
	var unitItems = dataSnapshot.unit2items;
	//页面保存的商品-门店的关系数据
	var itemStores = dataSnapshot.item2stores;
	//整理数据，将数据整理成代号@商品编号-门店编号的形式
	$("#refreshContxt").html("");
	popup(200, 120);
 	var count =0;
	//调用后台的方法
	refreshArrayAjax(buyts,buyte,promts,promte,promNo,unitNo,units,unitItems,itemStores,count)
}

/*
 * 修改时间，刷新页面所有的数据的Ajax请求
 */
function refreshArrayAjax(/*Date*/buyts,/*Date*/buyte,/*Date*/promts,/*Date*/promte,/*String*/promNo,/*String*/unitNo,/*Json*/units,/*Json*/unitItems,/*json*/itemStores,/*int*/count){
	var unitsJson = units[count];
	var refreshItemStoreArray = new Array();
	var unitNo =unitsJson.unitNo;//代号
	var ItemNoJson = unitItems[unitNo].data;//指定代号的商品的数组
	for (var itemIndex = 0; itemIndex < ItemNoJson.length; itemIndex++) {
		var itemNo = ItemNoJson[itemIndex].itemNo;//商品编号
		var storeJson = itemStores[itemNo].data;//指定商品的门店数组
		for (var storeIndex = 0; storeIndex < storeJson.length; storeIndex++) {
			var storeNo = storeJson[storeIndex].storeNo;
 			refreshItemStoreArray.push( unitNo+"@"+itemNo+"-"+storeNo)
		}
	}
	$.ajax({
		 url: ctx + '/prom/nondm/art/refreshArray?ti='+(new Date()).getTime(),
	     type: "post",
	     dataType:"json",
	     data:{"unitItemStoresStr":JSON.stringify(refreshItemStoreArray),"buyStartDate":buyts,"buyEndDate":buyte,"promStartDate":promts,"promEndDate":promte,"promNo":promNo,"unitNo":unitNo},
	     success: function(result) {
	     	//将后台的数据和当前数据做对比，并保留当前录入的数据，将appendBuy,appendProm,promNo更新
	     	for (var refrshStoreIndex = 0; refrshStoreIndex < result.itemStoreList.length; refrshStoreIndex++) {
     			var refrshStoreNo = result.itemStoreList[refrshStoreIndex].storeNo;
     			var refrshItemNo =  result.itemStoreList[refrshStoreIndex].itemNo;
     			var beforeStoreArray = itemStores[refrshItemNo].data;
     			for (var beforeStoreIndex = 0; beforeStoreIndex < beforeStoreArray.length; beforeStoreIndex++) {
     				var  beforeStoreNo = beforeStoreArray[beforeStoreIndex].storeNo;
     				if(refrshStoreNo == beforeStoreNo ){
     				 	beforeStoreArray[beforeStoreIndex].appendBuy = result.itemStoreList[refrshStoreIndex].appendBuy;
     				  	beforeStoreArray[beforeStoreIndex].appendProm = result.itemStoreList[refrshStoreIndex].appendProm;
     				  	beforeStoreArray[beforeStoreIndex].promNo = result.itemStoreList[refrshStoreIndex].promNo;
     				  	break;
     				}
     			}
	     	}
	     	count++;
	     	$("#refreshContxt").append("<li>"+count+". 代号为<font color=red><strong>"+ unitNo+"</strong></font>数据加载更新完毕...</li>");
	     	$(".mylist").scrollTop($(".mylist").scrollTop()+23);
	     	if(count < units.length){
	     		refreshArrayAjax(buyts,buyte,promts,promte,promNo,unitNo,units,unitItems,itemStores,count);
	     	}else{
	     		
	     	 	//当数据循环结束时，页面显示第一个代号的信息
	     		$("#refreshContxt").append("<li><font color='green'>数据已全部加载更新完毕...</font></li>");
	     		$(".mylist").scrollTop($(".mylist").scrollTop()+23);
				if(promIsBegin()&&isUpdatePage()){
					pArtPromHandler.changePromType(parseInt(promType),promIsBegin());
					$("#txtChangePromSellPriceAtItem").removeClass("Black").addClass("Black").removeAttr("onfocus");
					$("#txtChangePromBuyPriceAtItem").removeClass("Black").addClass("Black").removeAttr("onfocus");
				}
					     		pArtPromHandler.getUnitsCanvas().clickRowByIndex(0);
				$("#promUnitItemsPanel").attr("forced","true");
				pArtPromHandler.getItemsCanvas().clickRowByIndex(0);
				$("#promUnitItemsPanel").attr("forced","false");
				$(".pro_store_tb_edit").scrollTop(0);
	     	}
	     }
	 });
}

/*
 * 刷新数据的弹出框的脚本
 * 1.弹出框的位置
 * 2。弹出框的关闭事件
 */
function popup(/*int*/top, /*int*/left) {
    $(".panel1").css({"display":"block","top":top+"px","left":left+"px"});
}
function myclose(/*Node*/$selector) {
    $selector.css("display", "none");
}

/*
 * 促销价格，敲击回车选中相邻的下一个文本框
 * 1.促销进价
 * 2.促销售价
 */
$("input[name='promBuyPrice']").die("keyup").live("keyup",function(/*Event*/evt){
   var event=evt?evt:(window.event?window.event:null);//兼容IE和FF
   if (event.keyCode==13){
   		 //获取下一个促销进价
		  var nextVal=$(this).parents("tr").next().find("input[name='promBuyPrice']").val();
		  if(nextVal!=undefined){
			 $(this).parents("tr").next().find("input[name='promBuyPrice']").focus().val(nextVal);
		  }
		  else{			
		  	//当循环到最后一个促销进价了，光标跳转到促销售价的第一个
			  var nextSaleVal=$(this).parents("table").find("input[name='promSellPrice']:first").not(":disabled").val();
			  var isBlack =$(this).parents("table").find("input[name='promSellPrice']:first").not(":disabled").hasClass("Black");
			  if(nextSaleVal!=undefined && !isBlack){
			 	 $(this).parents("table").find("input[name='promSellPrice']:first").not(":disabled").focus().val(nextSaleVal);
			  }
		  }
	  }
});

$("input[name='promSellPrice']").die("keyup").live("keyup",function(/*Event*/evt){
   	var event=evt?evt:(window.event?window.event:null);//兼容IE和FF
	   if (event.keyCode==13){
		  var saleVal=$(this).parents("tr").next().find("input[name='promSellPrice']").val();
		  if(saleVal!=undefined){
			 $(this).parents("tr").next().find("input[name='promSellPrice']").focus().val(saleVal);
		  }
	  }
});