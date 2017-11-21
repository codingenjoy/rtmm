/**
 * 读取页面itemNo
 */
function getPageItemNo(){
	var itemNo = $.trim($('#itemNo').val()) == '输入货号查询' ? '' : $.trim($('#itemNo').val());
	if(itemNo == '输入货号'){
		itemNo = '';
	}
	return itemNo;
}
/**
 * 商品总览-打开详情图标
 */
 function openOverviewCont(){
	$("#Tools22").attr('class', "Icon-size1 Tools22_on");
	$("#Tools21").attr('class', "Icon-size1 Tools21");
	$($("#Tools22").parent()).addClass("ToolsBg");
	$($("#Tools21").parent()).removeClass("ToolsBg");
 }
 function openOverviewList(){
	 	//显示页面控制
	 	$('#ovreviewContent').hide();
		$('#ovreviewList').show();
		//列表和详情切换
		$("#Tools21").attr('class', "Icon-size1 Tools21_on");
		$("#Tools22").attr('class', "Icon-size1 Tools22");
		$($("#Tools21").parent()).addClass("ToolsBg");
		$($("#Tools22").parent()).removeClass("ToolsBg");
		//toolbar控制
		$("#Tools6").removeClass().addClass('Tools6_disable');
		$("#Tools11").removeClass().addClass('Tools11_disable');
		$("#Tools12").removeClass().addClass('Tools12_disable');
		$("#Tools16").removeClass().addClass('Tools16_disable');
		$("#Tools17").removeClass().addClass('Tools17_disable');
		$("#Tools18").removeClass().addClass('Tools18_disable');
		$("#Tools19").removeClass().addClass('Tools19_disable');
		$("#Tools20").removeClass().addClass('Tools20_disable');
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",
				function() {
					DispOrHid('B-id');
					gridbar_B();
		});
		 $("#Tools22").unbind().bind("click",function(){
				$('#ovreviewList').hide();
				$('#ovreviewContent').show();
				openOverviewCont();
				bindOverviewCon();
				$("#Tools1").removeClass().addClass("Icon-size1 Tools1_disable B-id").unbind();
				$('.CInfo').find('select').empty();
				$('.canEmpty').text('');
				$('#baseItemInfo').find('input').val('');
				$('#storeInfo').find('input').val(''); 
				overviewSearch();
				$("#barcode").attr("readonly",false);
				$("#itemNo").attr("readonly",false);
				$('#Tools11').removeClass('Tools11_disable');
				$('#Tools11').addClass('Tools11');
				$('#Tools11').unbind('click').bind('click',createItemPage);
			});
	 }
 
 function createItemPage(){
	 	lastTabObj = $('.tagsM_on');
		var addStr = '<div class="item_create_tab tagsM_q  tagsM_on">创建新商品</div>';
		addStr += '<div class="item_create_tab tags3_close_on">';
		addStr += '<div class="tags_close" onclick="$(lastTabObj).click();"></div>';
		addStr += '</div>';
		$('.CTitle:visible').append(addStr);
		$('.CTitle:visible .tags_right_on').removeClass('tags_right_on');
		$('.CTitle:visible .tags_left_on').removeClass('tags_left_on');
		$('.CTitle:visible .tags1_left_on').removeClass('tags1_left_on');
		$('.CTitle:visible .tagsM_on').removeClass('tagsM_on');
		$('.CTitle:visible .tags3_r_on').addClass('tags3').addClass(
				'tags_right_on');
		$('.CTitle:visible .tags3_r_off').addClass('tags3').addClass(
				'tags_right_on');
		$('.CTitle:visible .tags3_r_on').removeClass('tags3_r_on');
		$('.CTitle:visible .tags3_r_off').removeClass('tags3_r_off');
		$('.CTitle:visible .item_create_tab').show();
		$('.CTitle:visible .tagsM_q').addClass('tagsM_on');
		$('.Container-1:visible').load(ctx + "/item/create/baseInfo");
 }
 
 function bindOverviewCon(){
	 $("#Tools22").unbind();
	 $("#Tools21").unbind().bind('click', function (){
		 openOverviewList();
	 });
 }
 function bindOverviewList(){
	 $("#Tools21").unbind();
	 $("#Tools22").unbind().bind('click', function (){
		 openOverviewCont();
	 });
	 
 }
 function setToolsbarDisable(){
	//toolbar控制
	//$("#Tools6").unbind().removeClass().addClass('Tools6_disable');
	$("#Tools11").unbind().removeClass().addClass('Tools11_disable');
	$("#Tools16").unbind().removeClass().addClass('Tools16_disable');
	$("#Tools17").unbind().removeClass().addClass('Tools17_disable');
	$("#Tools18").unbind().removeClass().addClass('Tools18_disable');
	$("#Tools19").unbind().removeClass().addClass('Tools19_disable');
	$("#Tools20").unbind().removeClass().addClass('Tools20_disable');
	$("#Tools21").unbind().removeClass().addClass('Icon-size1 Tools21_disable');
 }
 function setToolsbarAllDisable(){
		//toolbar控制
		$("#Tools1").unbind().removeClass().addClass('Icon-size1 Tools1_disable B-id');
		$("#Tools2").unbind().removeClass().addClass('Tools2_disable');
		$("#Tools3").unbind().removeClass().addClass('Tools3_disable');
		$("#Tools23").unbind().removeClass().addClass('Tools23_disable');
		$("#Tools6").unbind().removeClass().addClass('Tools6_disable');
		$("#Tools20").unbind().removeClass().addClass('Tools20_disable');
		$("#Tools11").unbind().removeClass().addClass('Tools11_disable');
		$("#Tools10").unbind().removeClass().addClass('Tools10_disable');
		$("#Tools12").unbind().removeClass().addClass('Tools12_disable');
		$("#Tools16").unbind().removeClass().addClass('Tools16_disable');
		$("#Tools17").unbind().removeClass().addClass('Tools17_disable');
		$("#Tools19").unbind().removeClass().addClass('Tools19_disable');
		$("#Tools18").unbind().removeClass().addClass('Tools18_disable');
		$("#Tools24").unbind().removeClass().addClass('Tools24_disable');
		$("#Tools25").unbind().removeClass().addClass('Tools25_disable');
		$("#Tools26").unbind().removeClass().addClass('Tools26_disable');
		$("#Tools27").unbind().removeClass().addClass('Tools27_disable');
		$("#Tools28").unbind().removeClass().addClass('Tools28_disable');
		$("#Tools29").unbind().removeClass().addClass('Tools29_disable');
		$("#Tools22").unbind().removeClass().addClass('Icon-size1 Tools22_disable');
		$("#Tools21").unbind().removeClass().addClass('Icon-size1 Tools21_disable');
	 }
/**
 * 查询条件缓存方法
 * 从session中获取
 */
function getParamSearch() {
	    var itemNoSearch =  $('#itemNoSearch').val();
	    var itemNameSearch =  $('#itemNameSearch').val();
	    var storeNoSearch =  $('#storeNoSearch').val();
	    var storeNameSearch =  $('#storeNameSearch').val();
		var param = {
			'itemNo' : itemNoSearch,
			'itemName' : itemNameSearch,
			'storeNo' : storeNoSearch,
			'storeName' : storeNameSearch
		};
		return param;
	}
/**
 * 获得页面的itemNo、itmeName、storeNo、sotreName
 */
function getParam() {
	var itemNo =  getPageItemNo();
	var itemName =  $.trim($('#itemName').val());
	var storeNo =  $.trim($('#storeNo').val());
	var storeName =  $.trim($('#storeName').val());
	var param = {
			'itemNo' : itemNo,
			'itemName' : itemName,
			'storeNo' : storeNo,
			'storeName' : storeName
	};
	return param;
}
/**
 * 商品总览-重置按钮
 */
function openCleanBtn(url,hasStoreNo){
	// 让itemNo可输入和点击
	$("#itemNo").attr("readonly",true);
	$("#itemNo+.ListWin").removeAttr("onclick");
	$('#Tools6').removeClass('Tools6').addClass('Tools6_disable').unbind("click");
	$('#Tools20').removeClass('Tools20_disable').addClass('Tools20').unbind().bind('click', function() {
		//清空页面
		$("#ovreviewContent").find("input").val(null);
		$('.canEmpty').text('');
		//隐藏创建人等信息
		$("#message").hide();
		if($("#storeNo")){
			$("#storeNo").html("");
		}
		//删除dom节点
		//商品变价-删除进价与售价
		if($('.price_tb')){
			$('.price_tb').remove();
		}
		//商品规格-删除证照
		if($('.itemLicList')){
			$('.itemLicList').remove();
		}
		//商品条码-删除条码
		if($('.itemBarcodeList')){
			$('.itemBarcodeList').remove();
		}
		//商品关联-删除子货号
		if($('.itemRealative')){
			$('.itemRealative').remove();
		}
		//商品厂商-删除厂商列表
		if($('.itemSupplierList')){
			$('.itemSupplierList .sp_tb').remove();
			$('.itemSupplierList .paging').remove();
		}
		//商品DC厂商-删除DC厂商列表
		if($('.dcStroeList')){
			$('.dcStroeList').remove();
		}
		//商品供应区域-删除列表
		if($('.itemSuppAreaList')){
			$('.itemSuppAreaList').remove();
		}
		//点亮查询
		openSearchBtn(url,hasStoreNo);
		//置灰重置
		$('#Tools12').removeClass('Tools12').addClass('Tools12_disable').unbind("click");
		$('#Tools20').removeClass('Tools20').addClass('Tools20_disable').unbind("click");
		$('#Tools23').removeClass('Tools23').addClass('Tools23_disable').unbind("click");
	});
}
/**
 * 打开查询按钮，并屏蔽重置
 * @param url
 * @param hasStoreNo 页面有店号，传true;没有传false或不传
 */
function openSearchBtn(url,hasStoreNo){
	//让itemNo可输可选
	$("#itemNo").attr("readonly",false);
	$("#itemNo+.ListWin").attr("onclick","chooseItemNo()");
	$('#Tools20').removeClass('Tools20').addClass('Tools20_disable').unbind("click");
	$('#Tools6').removeClass('Tools6_disable').addClass('Tools6').unbind().bind('click', function() {
		var itemNo = getPageItemNo();
		if(itemNo){
			$.ajax( {
				type : 'post',
				url : ctx + url,
				data :{itemNo:itemNo},
				success : function(data) {
					if(data){
						//用于没有数据时，弹出提示框
						try {
							//var output=JSON.parse(data);
							if(data.message){
								top.jAlert('warning',data.message,'消息提示',function(){
									$('#itemNo').val('');
									$('#itemNo').attr("placeholder","输入货号查询");
								});
								return false;
							}
						} catch (e) {
							top.jAlert('warning','请尝试重试,或联系系统维护或管理人员！','消息提示');
							return false;
						}
						/*$("#content").children().remove();
						$("#content").html(data);*/
						$("#ovreviewContent").empty();
						$("#ovreviewContent").html(data);
						//屏蔽查询
						$('#Tools6').removeClass('Tools6').addClass('Tools6_disable').unbind("click");
						//重置按钮
						openCleanBtn(url,hasStoreNo);
						//图标点亮
						//openOverviewCont();
						//存在商品下传门店，默认选中第一个
						if(hasStoreNo){
							$('#storeNo').get(0).selectedIndex =0;
						}
					}
				}
			}); 
			//屏蔽查询

		}else{
			//commonAlert("请输入或选择货号！");
			top.jAlert('warning','请输入或选择货号！','消息提示');
		}
	});
}
/**
 * 商品总览-根据itmeNo查询
 */
function overviewSearchByItemNo(){
	$('#Tools6').removeClass('Tools6_disable').addClass('Tools6').bind('click', function() {
		var itemNo = getPageItemNo();
		$.ajax( {
			type : 'post',
			url : ctx + '/item/query/itemBaseInfoPage',
			data :{itemNo:itemNo},
			success : function(data) {
				//用于没有数据时，弹出提示框
				try {
					//var output=JSON.parse(data);
					if(data.message){
						top.jAlert('warning',data.message,'消息提示',function(){
							$('#itemNo').val('');
							$('#itemNo').attr("placeholder","输入货号");
							$('#barcode').val('');
							$('#barcode').attr("placeholder","输入条码");
						});
						return false;
					}
				} catch (e) {
					
				}
				if(data != null){
					/*$("#content").children().remove();
					$("#content").html(data);*/
					$("#ovreviewContent").empty();
					$("#ovreviewContent").html(data);
					//设置订货方式为选中
					setItemStoreInfoOrdCreatMethd();
					//设置条码
					setItemBarcode("");
					//屏蔽查询
					$("#itemNo").attr("readonly",true);
					$("#barcode").attr("readonly",true);
					$('#Tools6').removeClass('Tools6').addClass('Tools6_disable').unbind("click");
					//重置按钮
					overviewReset();
					//图标点亮
					openOverviewCont();
				}
			}
		}); 
	});
}
/**
 * 商品总览-重置按钮
 */
function overviewReset(){
	// 屏蔽查询
	$('#Tools6').removeClass('Tools6').addClass('Tools6_disable').unbind("click");
	$("#itemNo+.ListWin").removeAttr("onclick");
	$("#barcode+.ListWin").removeAttr("onclick");
	$('#Tools20').removeClass('Tools20_disable').addClass('Tools20').bind('click', function() {
		//清空session查询条件
		$.get(ctx + '/item/query/cleanSessionSearch');
		//清空页面
		//$("#ovreviewContent").find("input").val(null);;
		$("#ovreviewContent").find("input").val(null);
		$("#storeNo").html("");
		$('.canEmpty').text('');
		$(':input:checkbox').attr('checked',false);
		//点亮查询
		$("#itemNo").attr("readonly",false);
		$("#barcode").attr("readonly",false);
		
		$("#itemNo+.ListWin").attr("onclick","chooseItemNo()");
		$("#barcode+.ListWin").attr("onclick","chooseItemBarcode()");
		//overviewSearchByItemNo();
		overviewSearch();
		$('#Tools20').removeClass('Tools20').addClass('Tools20_disable').unbind("click");
		//清空图片信息
		itemLookInfos = new Array();
		//设置图片为默认图片
		$("#itemBaseInfoImg").attr("src","shared/themes/theme1/images/defaultImg.png");
		//隐藏创建人等信息
		$("#message").hide();
	});
}
/**
 * 商品总览-改变门店
 * @param storeNo
 */
   function changeStoreNo(storeNo) {
	   if(!storeNo){return;}
	   var itemNo = getPageItemNo();
	   if (itemNo != null && itemNo != "") {
		$.ajax({
			type : 'post',
			url : ctx + '/item/query/changeStore',
			data : {
				storeNo : storeNo,
				itemNo : itemNo
			},
			success : function(data) {
				$("#storeInfo").children().remove();
				$("#storeInfo").html(data);
				setItemStoreInfoOrdCreatMethd();
			}
		});
	}
}
/**
 * 商品总览-设置storeName的值
 */
function setItremName() {
	if ($('#storeNo').val() != null && $.trim($('#storeNo').val()).length > 0) {
		var storeName = $('#storeNo option:selected').text().substring(
				$('#storeNo').val().length + 1,
				$('#storeNo option:selected').text().length);
		$('#storeName').val(storeName);
	}
}
 /**
 * 商品总览-设置订货方式
 */
function setItemStoreInfoOrdCreatMethd() {
	$("input[type='checkbox']").prop("disabled", false);
	// 全部设置为取消
	$("input[type='checkbox']").prop("checked", false);
	// 选中存在的值
	var ordCreatMethdStr = $('#ordCreatMethd').val();
	if (ordCreatMethdStr != null && ordCreatMethdStr.length > 0) {
		var lst = ordCreatMethdStr.split(",");
		for (var i = 0; i < lst.length; i++) {
			document.getElementById(lst[i]).checked = true;
		}
	}
	$("input[type='checkbox']").prop("disabled", true);
}
/**
 * 商品总览-设置季节期数
 */
function setItemSeTopic(buyPerd) {
	// 如果为采购类型为2-季节性，季节期数为空
	//var itemNo = $('#itemNo').val();
	var itemNo = getPageItemNo();
	if (itemNo != null && itemNo != "") {
		$.ajax({
			type : 'post',
			url : ctx + '/item/query/getItemSeTopicListByItemNo',
			data : {
				itemNo : itemNo,
				page : 1,
				rows : 1
			},
			success : function(data) {
				// 存在季节期数时，给表单中的Input赋值
				if (data.total > 0) {
					$('#topic').val(data.rows[0].topicNo + ","+ data.rows[0].topicName);
				}
			}
		});
	}
}
/**
 * 商品总览-显示当前商品下的季节期数
 */
function showSETopic(){
	var itemNoSearch = $('#itemNo').val();
	openPopupWin(550, 430,'/commons/window/showItemSETopic?itemNoSearch='+itemNoSearch);
}
/**
 * 商品总览-显示当前商品下的系列
 */
function showCluster(){
	var itemNoSearch = $('#itemNo').val();
	openPopupWin(550, 430,'/commons/window/showItemCluster?itemNoSearch='+itemNoSearch);
}
/**
 * 非总览页面返回总览界面(带itemNo)
 */
function searchItemByItemNo(itemNo,storeNo,itemBarcode) {
	$.ajax({
		type : 'post',
		url : ctx + '/item/query/itemBaseInfoPage',
		data : {
			itemNo : itemNo,
			storeNo : storeNo,
			barcode:itemBarcode
		},
		success : function(data) {
			// 用于没有数据时，弹出提示框
			try {
				//var output = JSON.parse(data);
				if (data.message) {
					top.jAlert('warning',data.message,'消息提示',function(){
						$('#itemNo').val('');
						$('#itemNo').attr("placeholder","输入货号");
						$('#barcode').val('');
						$('#barcode').attr("placeholder","输入条码");
					});
					return false;
				}
			} catch (e) {

			}
			if (data != null) {
				/*$("#content").children().remove();
				$("#content").html(data);*/
				$('#ovreviewList').hide();
				$('#ovreviewContent').show();
				$("#ovreviewContent").empty();
				$("#ovreviewContent").html(data);
				//显示创建人等信息
				$("#message").show();
				// 设置订货方式
				setItemStoreInfoOrdCreatMethd();
				//设置条码
				setItemBarcode(itemBarcode);
				// 重置按钮
				overviewReset();
				// 图标点亮
				openOverviewCont();
				if(storeNo){
					changeStoreNo(storeNo);
				}
			}
		}
	});
}

 /**
  * 商品总览-上下翻页
  * @param pageNo 页码
  */
function searchItemByPageNo(pageNo) {
	$.ajax({
		type : 'post',
		url : ctx + '/item/query/itemBaseInfoPage',
		data : {
			page : $.trim(pageNo)
		},
		success : function(data) {
			/*$("#content").children().remove();
			$("#content").html(data);*/
			$("#ovreviewContent").empty();
			$("#ovreviewContent").html(data);
			//显示创建人等信息
			$("#message").show();
			// 设置订货方式
			setItemStoreInfoOrdCreatMethd();
			//设置条码
			setItemBarcode("");
			// 屏蔽查询
			$('#Tools6').removeClass('Tools6').addClass('Tools6_disable').unbind("click");
			//重置按钮
			overviewReset();
		}
	});
}
   /**
    * 商品变价
    */
	function setSearchTypeVal(searchType){
		$('#searchType').val(searchType);
	}
   /**
    * 商品变价
    */

   //根据itemNo查询
	function searchItemPriceInfoByItemNo(){
		var itemNo = getPageItemNo();
		$.ajax( {
	   		type : 'post',
	   		url : ctx + '/item/query/itemDCInfo',
	   		data :{
	   			itemNo:itemNo
	   		},
	   		success : function(data) {
	   			$("#content").children().remove();
	 			$("#content").html(data);
	   		}
	   	}); 
	}
   function changeStoreNoOnPrice(storeNo) {
	    var itemNo = getPageItemNo();
	    if(itemNo != null && itemNo != ""){
	       	$.ajax( {
	      		type : 'post',
	      		url : ctx + '/item/query/changeStore',
	      		data : {
	      			storeNo : storeNo,
	      			itemNo : itemNo
	   		},
	  		success : function(data) {
	  			$("#storeInfo").children().remove();
				$("#storeInfo").html(data);
				setItemStoreInfoOrdCreatMethd(); 
				setItremName();
	  		}
	      	}); 
	    }
	   }
	/*
	 * 商品规格
	 */
   //根据itemNo查询
	function searchItemSpecInfoByItemNo(){
		 var itemNo = getPageItemNo();
		 $.ajax( {
	   		type : 'post',
	   		url : ctx + '/item/query/itemSpecInfo',
	   		data :{
	   			itemNo:itemNo
	   		},
	   		success : function(data) {
	   			$("#content").children().remove();
	 			$("#content").html(data);
	   		}
	   	}); 
	}
	//显示当前商品下的广告列表
	function showAdDesc(){
		var itemNoSearch = $('#itemNo').val();
		openPopupWin(550, 430,'/commons/window/showItemAdDesc?itemNoSearch='+itemNoSearch);
	}
	/*
	 * 商品规格
	 */

	/*DC信息
	 * 
	 */
   //根据itemNo查询
	function searchItemDCInfoByItemNo(){
		 var itemNo = getPageItemNo();
		$.ajax( {
	   		type : 'post',
	   		url : ctx + '/item/query/itemDCInfo',
	   		data :{
	   			itemNo:itemNo
	   		},
	   		success : function(data) {
	   			$("#content").children().remove();
	 			$("#content").html(data);
	   		}
	   	}); 
	}
	//货号选择弹出框
	function chooseItemNo(){
		openPopupWin(650,548,"/commons/window/chooseItem?callback=confirmRtn");
	}
	function confirmRtn(itemNoRtn,itemNameRtn){
		if($('#itemNo').attr("style")){
			$('#itemNo').css("color","");
		}
		$('#itemNo').val(itemNoRtn);
		$('#itemName').val(itemNameRtn);
	}
	//货号选择弹出框
	function chooseItemBarcode(){
		openPopupWin(550,548,"/commons/window/chooseItemBarcode?callback=confirmBarcodeRtn");
	}
	function confirmBarcodeRtn(itemNoRtn,itemNameRtn,barcode){
		$('#itemNo').removeAttr("style");
		$('#barcode').removeAttr("style");
		$('#itemNo').val(itemNoRtn);
		$('#itemName').val(itemNameRtn);
		$('#barcode').val(barcode);
		
	}
	//商品的下传门店
	function getItemStoreInfoByItemNo(){
		var itemNo = getPageItemNo();
		$.ajax({
	   		type : 'post',
	   		url : ctx + '/item/query/getItemStoreInfoByItemNo',
	   		data :{
	   			itemNo:itemNo
	   		},
	   		success : function(data) {
	 			if(data != null){
	 				var select = $("#storeNo");
	 				select.empty();
	 				$.each(data, function(index, itemStore) {
	 					var option = "<option value="+itemStore.storeNo+">"+itemStore.storeNo+"-&nbsp;"+itemStore.storeName+"</option>";
	 					select.append(option);
	 				});
	 			}
	   		}
	   	}); 
	}
	/**
	 * 读取页面itemBarcode
	 */
	function getPageBarcode(){
		var itemNo = $.trim($('#barcode').val()) == '输入条码' ? '' : $.trim($('#barcode').val());
		return itemNo;
	}
	/**
	 * 商品总览-根据itmeNo查询
	 */
	function overviewSearch(){
		$('#Tools6').removeClass('Tools6_disable').addClass('Tools6').unbind().bind('click', function() {
			var itemNo = getPageItemNo();
			var itemBarcode = getPageBarcode();
			$.ajax( {
				type : 'post',
				url : ctx + '/item/query/itemBaseInfoPage',
				data :{itemNo:itemNo,
					   barcode:itemBarcode
					  },
				success : function(data) {
					if(data){
						//用于没有数据时，弹出提示框
						try {
							///var output=JSON.parse(data);
							if(data.message){
								top.jAlert('warning',data.message,'消息提示',function(){
									$('#itemNo').val('');
									$('#itemNo').attr("placeholder","输入货号");
									$('#barcode').val('');
									$('#barcode').attr("placeholder","输入条码");
								});
								return false;
							}
						} catch (e) { 
							top.jAlert('warning','请尝试重试,或联系系统维护或管理人员！','消息提示');
							return false;
						}
						
						/*$("#content").children().remove();
						$("#content").html(data);*/
						$("#ovreviewContent").empty();
						$("#ovreviewContent").html(data);
						//显示创建人等信息
						$("#message").show();
						//设置条码
						setItemBarcode(itemBarcode);
						//屏蔽查询
						$("#itemNo").attr("readonly",true);
						$('#Tools6').removeClass('Tools6').addClass('Tools6_disable').unbind("click");
						//重置按钮
						overviewReset();
						//图标点亮
						openOverviewCont();
					}
				}
			}); 
		});
	}
	 /**
	 * 商品总览-设置barcode
	 */
	function setItemBarcode(itemBarcode) {/*
		if(itemBarcode){
			$('#barcode').removeAttr("style");
			$('#barcode').removeAttr("placeholder");
			$('#barcode').val(itemBarcode);
			$("#barcode").attr("readonly",true);
		}else{
			var itemNo = getPageItemNo();
			if(itemNo){
				$.ajax({
					type : 'post',
					url : ctx + '/item/query/getItemBarcodeListByItemNo',
					data : {
						itemNo : itemNo,
						page : 1,
						rows : 1
					},
					success : function(data) {
						if (data.total > 0) {
							$('#barcode').val(data.rows[0].barcode);
							$('#barcode').removeAttr("style");
							$('#barcode').removeAttr("placeholder");
							$("#barcode").attr("readonly",true);
						}else{
							$('#barcode').val("");
							$('#barcode').removeAttr("style");
							$('#barcode').removeAttr("placeholder");
							$("#barcode").attr("readonly",true);
						}
					}
				});
			}
		}
	*/}
	/**
	 * 列表点击进入详情
	 */
	function goToDetail(itemNo){
		$.post( ctx + '/item/query/getItemBasicInfoByItemNo',
				{itemNo : itemNo},
				function(data){
					$('#ovreviewList').hide();
					$('#itemBaseInfoContainer').html(data);
					$('#itemBaseInfoContainer').show();
					$("#Tools1").removeClass().addClass("Icon-size1 Tools1_disable B-id").unbind();
				}
		);
	}
	function enterQuery(url,hasStoreNo){
		$('#Tools6').removeClass('Tools6_disable').addClass('Tools6').unbind().bind('click', function() {
			var itemNo = getPageItemNo();
			if(itemNo){
				$.ajax( {
					type : 'post',
					url : ctx + url,
					data :{itemNo:itemNo},
					success : function(data) {
						if(data){
							//用于没有数据时，弹出提示框
							try {
								//var output=JSON.parse(data);
								if(data.message){
									top.jAlert('warning',data.message,'消息提示',function(){
										$('#itemNo').val('');
										$('#itemNo').attr("placeholder","输入货号查询");
									});
									return false;
								}
							} catch (e) {
								top.jAlert('warning','请尝试重试,或联系系统维护或管理人员！','消息提示');
								return false;
							}
							/*$("#content").children().remove();
							$("#content").html(data);*/
							$("#ovreviewContent").empty();
							$("#ovreviewContent").html(data);
							//屏蔽查询
							$('#Tools6').removeClass('Tools6').addClass('Tools6_disable').unbind("click");
							//重置按钮
							openCleanBtn(url,hasStoreNo);
							//图标点亮
							//openOverviewCont();
							//存在商品下传门店，默认选中第一个
							if(hasStoreNo){
								$('#storeNo').get(0).selectedIndex =0;
							}
						}
					}
				}); 
				//屏蔽查询

			}else{
				//commonAlert("请输入或选择货号！");
				top.jAlert('warning','请输入或选择货号！','消息提示');
			}
		});
	}
	function openStatusDistributeWind(){
		var itemNoSearch = getPageItemNo();
		if(itemNoSearch){
			openPopupWin(800, 500,'/item/query/getItemStatusDistributeByItemNo?itemNo='+itemNoSearch);
		}
	}
	function showStoreSelect() {
		$.ajax( {
			type : "post",
			url : ctx + "/commons/window/listAllStoreData",
			success : function(data) {
				var select = $("#storeNoSearch");
				select.empty();
				select.append("<option value=''>请选择</option>");
				$.each(data, function(index, value) {
					var option = "<option value=" + value.storeNo + ">" + "<p align='right'>" + value.storeNo
					+ "</p>" + "-&nbsp;" + value.storeName + "</option>";
					select.append(option);
				});
			}
		});
	}