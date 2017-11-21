var itemInfos;
var storeInfos;
/**
 * 列表查询
 * @param {} pageNo
 * @param {} pageSize
 */
function showListPage(pageNo,pageSize){
	var param = $('#searchForm').serialize();
	param = joinPostParam(param,'pageNo',pageNo||1);
	param = joinPostParam(param,'pageSize',pageSize||20);
	$.post(ctx + $('#searchForm').attr('action'),param,
			function(data) {
		$("#listDiv").html(data);
	});
}

/**
 * 删除计划
 * @param {} planId
 */
function deletePlan(/*String*/planId){
	//判断用户是否选择了要删除的记录
	if(planId==""||planId==null){top.jWarningAlert("请选择要删除的计划!");return;}
	top.jConfirm("确定要删除本条计划?", "提示信息",function (ret){
		if(ret){
			$.post(ctx+'/rp/plan/delete?rpPlanId='+planId+'&_t='+(new Date()).getTime(),function(data){
				if(data.status=='success'){
					top.jSuccessAlert(data.message);
					showListPage(1,20);
				}else if(data.status=='fail'){
					top.jSuccessAlert(data.message);
				}
			});
		}
	});
}

/**
 * 详情页面头部的分页
 * @param {} rpCondParam
 * @param {} page
 */
function showDetailPaginator(rpCondParam,page){
	var rpCondParamJson = JSON.parse(rpCondParam);
	var pageSize = 1;
	var pageNo=page;
	rpCondParamJson.pageSize = pageSize;
	rpCondParamJson.pageNo  = pageNo;
	rpCondParamJson.flag = 'page';
	$.ajax({
		 url: ctx + '/rp/plan/detail?ti='+(new Date()).getTime(),
	     type: "post",
	     data: rpCondParamJson,
	     dataType:"html",
	     success: function(rdata) {
	     	$("#detailDiv").html(rdata);
	     }
	 });

}
function toDetailPage(planElem){
	var planId = $(planElem).attr('planId');
	var num  = $(planElem).attr('num');
	showDetailPage(planId,num);
}
/**
 * 跳转到详情页面
 * @param {} planId
 * @param {} num
 */
function showDetailPage(/*String*/planId,/*Integer*/num){
	if(planId==""||planId==null){top.jWarningAlert("请选择要查看详情的计划!");return;}
	switchDetail("查看保留计划",'detail');
	//列表的当前显示条数
	var detailPageSize = $("#detailPageSize").val();
	//列表的当前的页数
	var detailPageNo = $("#detailPageNo").val();
	//计算进入详情也面的第几页和显示的条数
	var pageSize = 1;
	var pageNo = (((Number(detailPageNo)-1)*Number(detailPageSize))+Number(num));
	//获取其他的参数
	var rpNo = $("#rpNo").val();
	//主题 
	var rdmTopic = $("#rdmTopic").val();
	//物流中心
	var dcStoreNo = $("#dcStoreNo").val();
	//DM
	var rdmNo = $("#rdmNo").val();
	//课别
	var CatlgId = $("#CatlgId").val();
	//开始日期期间（开始）
	var rdmBeginDateBegin = $("#rdmBeginDateBegin").val();
	//开始日期期间（结束）
	var rdmBeginDateEnd = $("#rdmBeginDateEnd").val();
	//结束日期期间（开始）
	var  rdmEndDateBegin = $("#rdmEndDateBegin").val();
	//结束日期期间（结束）
	var  rdmEndDateEnd = $("#rdmEndDateEnd").val();
	//门店确认期间开始日期
	var stCnfrmBeginDate  = $("#stCnfrmBeginDate").val();
	//门店确认期间结束日期
	var stCnfrmEndDate = $("#stCnfrmEndDate").val();
	//门店补货日期开始日期
	var stRepBeginDate = $("#stRepBeginDate").val();
	//门店补货日期结束日期
	var stRepEndDate = $("#stRepEndDate").val();
	//总金额的开始金额
	var finalAmntBegin = $("#finalAmntBegin").val();
	//总金额的结束金额
	var finalAmntEnd = $("#finalAmntEnd").val();
	var detailParem ={};
	detailParem.pageSize = pageSize;
	detailParem.pageNo = pageNo;
	detailParem.rdmEndDateBegin = rdmEndDateBegin;
	detailParem.rdmBeginDateEnd = rdmBeginDateEnd;
	detailParem.rdmBeginDateBegin = rdmBeginDateBegin;
	detailParem.CatlgId = CatlgId;
	detailParem.rdmNo = rdmNo;
	detailParem.dcStoreNo = dcStoreNo;
	detailParem.rdmTopic = rdmTopic;
	detailParem.rpNo = rpNo;
	detailParem.rdmEndDateEnd = rdmEndDateEnd;
	detailParem.stCnfrmBeginDate = stCnfrmBeginDate;
	detailParem.stCnfrmEndDate = stCnfrmEndDate;
	detailParem.stRepBeginDate = stRepBeginDate;
	detailParem.stRepEndDate = stRepEndDate;
	detailParem.finalAmntBegin = finalAmntBegin;
	detailParem.finalAmntEnd = finalAmntEnd;
	detailParem.planId =planId;
	$.ajax({
		 url: ctx + '/rp/plan/detail?ti='+(new Date()).getTime(),
	     type: "post",
	     data: detailParem,
	     dataType:"html",
	     success: function(rdata) {
	     	$("#detailDiv").html(rdata);
	     }
	 });
	
}

/**
 * 初始化基础信息
 * @param {} basicInfos
 */
function initBasicInfo(basicInfos){
	var $detailPage = $("#detailDiv");
	$detailPage.find("input[id='rpNo']").val(basicInfos.rpNo);
	$detailPage.find("input[id='status']").val(basicInfos.status+"-"+basicInfos.statusName);
	$detailPage.find("input[id='rdmTopic']").val(basicInfos.rdmTopic);
	$detailPage.find("input[id='rdmBeginDate']").val(basicInfos.rdmBeginDate);
	$detailPage.find("input[id='rdmEndDate']").val(basicInfos.rdmEndDate);
	$detailPage.find("input[id='dcStoreNo']").val(basicInfos.dcStoreName);
	$detailPage.find("input[id='rdmNo']").val(basicInfos.rdmNo);
	$detailPage.find("input[id='catlgId']").val(basicInfos.catlgId);
	$detailPage.find("input[id='catlgName']").val(basicInfos.catlgName);
	$detailPage.find("input[id='stCnfrmBeginDate']").val(basicInfos.stCnfrmBeginDate);
	$detailPage.find("input[id='stCnfrmEndDate']").val(basicInfos.stCnfrmEndDate);
	$detailPage.find("input[id='stRepBeginDate']").val(basicInfos.stRepBeginDate);
	$detailPage.find("input[id='stRepEndDate']").val(basicInfos.stRepEndDate);
	if(basicInfos.status<3){
		$detailPage.find("input[id='finalAmnt']").addClass("Black");
	}
	$detailPage.find("input[id='finalAmnt']").val(basicInfos.finalAmnt==0?"":basicInfos.finalAmnt);
	if(basicInfos.stCnfrmInd=='1'){
		$detailPage.find("input[id='stCnfrmInd']").attr("checked",true);
	}
	
}

/**
 * 初始化商品门店信息
 * @param {} itemInfoStr
 * @param {} StoreInfoStr
 */
function initItemStoreInfo(itemInfoStr,StoreInfoStr){
	if (!itemInfoStr) {
		return ;
	}
	if (!StoreInfoStr) {
		return ;
	}
	var itemInfoJson = JSON.parse(itemInfoStr);
	var storesInfoJson = JSON.parse(StoreInfoStr);
	storeInfos=StoreInfoStr;
	itemInfos=itemInfoStr;
	var firstItemNo="";
	for (var itemInfoIndex = 0; itemInfoIndex < itemInfoJson.length; itemInfoIndex++) {
		var itemInfo = itemInfoJson[itemInfoIndex];
		if(itemInfoIndex==0){
			firstItemNo = itemInfo.itemNo;
		}
		var itemInfoHtml = drawItemInfoArea(itemInfo);
		$("#itemListFirstDivArea").append(itemInfoHtml);
	}
	
	for (var storeInfoIndex = 0; storeInfoIndex < storesInfoJson.length; storeInfoIndex++) {
		var itemNo = storesInfoJson[storeInfoIndex].itemNo;
		if(firstItemNo==itemNo){
			var storeJson = storesInfoJson[storeInfoIndex].data;
			for (var storeIndex = 0; storeIndex < storeJson.length; storeIndex++) {
				var storeInfo =storeJson[storeIndex];
				var storeInfohtml = drawStoresInfoArea(storeInfo);
				$("#storeListDivArea").append(storeInfohtml);
			}
			$("#itemListFirstDivArea").find("div[id='"+firstItemNo+"']").addClass("item_on");
			
		}
	}
	
}
/**
 * 点击商品，切换门店信息
 * @param {} obj
 */
function changeItem(obj){
	var firstItemNo = $(obj).attr("id");
	var storesInfoJson = JSON.parse(storeInfos);
	$("#storeListDivArea").html("");
	for (var storeInfoIndex = 0; storeInfoIndex < storesInfoJson.length; storeInfoIndex++) {
		var itemNo = storesInfoJson[storeInfoIndex].itemNo;
		if(firstItemNo==itemNo){
			var storeJson = storesInfoJson[storeInfoIndex].data;
			for (var storeIndex = 0; storeIndex < storeJson.length; storeIndex++) {
				var storeInfo =storeJson[storeIndex];
				var storeInfohtml = drawStoresInfoArea(storeInfo);
				$("#storeListDivArea").append(storeInfohtml);
			}
		}
	}
}

/**
 * 商品区域赋值
 * @param {} itemInfo
 * @return {}
 */
function drawItemInfoArea(itemInfo){
	var detailPage = $("#detailDiv");
	var itemHtml = detailPage.find("div[id='itemFirstTemplate']");
	itemHtml.find("div.item").attr("id",itemInfo.itemNo);
	itemHtml.find("input[id='itemNo']").attr("value",itemInfo.itemNo);
	itemHtml.find("input[id='itemName']").attr("value",itemInfo.itemName);
	itemHtml.find("input[id='ordMultiParm']").attr("value",itemInfo.ordMultiParm);
	itemHtml.find("input[id='buyPrice']").attr("value",itemInfo.buyPrice);
	itemHtml.find("input[id='normBuyPrice']").attr("value",itemInfo.normBuyPrice);
	itemHtml.find("input[id='dcSupNo']").attr("value",itemInfo.dcSupNo);
	itemHtml.find("input[id='comName']").attr("value",itemInfo.comName);
	itemHtml.find("input[id='stMinOrdQty']").attr("value",itemInfo.stMinOrdQty);
	var itemHtmlStr = itemHtml.html();
	return itemHtmlStr;
		
}
/**
 * 门店区域赋值
 * @param {} storeInfo
 * @return {}
 */
function drawStoresInfoArea(storeInfo){
	var detailPage = $("#detailDiv");
	var storeHtml = detailPage.find("div[id='itemStoreTemplate']");
	storeHtml.find("input[id='storeNo']").attr("value",storeInfo.storeNo+"-"+storeInfo.storeName);
	storeHtml.find("input[id='initQty']").attr("value",storeInfo.initQty);
	storeHtml.find("input[id='stCnfrmQty']").attr("value",storeInfo.stCnfrmQty);
	storeHtml.find("input[id='finalQty']").attr("value",storeInfo.finalQty);
	storeHtml.find("input[id='chngDate']").attr("value",new Date(storeInfo.chngDate).format("yyyy-MM-dd"));
	var storeHtmlStr = storeHtml.html();
	return storeHtmlStr;

}
//创建新	保留计划
function showCreatePage(){
	refreshFlag=1;
	$.post(ctx+'/rp/plan/create?_t='+(new Date()).getTime(),function(data){
		$('.Container-1').find('.Content.detail').html(data);
	});
	switchDetail('创建新保留计划');
	initEnventForPlan();
	$('#Tools2').removeClass('Tools2_disable').addClass('Tools2');
	$('#Tools23').removeClass('Tools23_disable').addClass('Tools23');
	// temp
	$('#Tools23').off().on("click", function(){
		showImportPage();
	});
}

//修改保留计划
function showEditPage(planId){
	refreshFlag=1;
	$.post(ctx+'/rp/plan/edit?rpNo='+planId+'&_t='+(new Date()).getTime(),function(data){
		$('.Container-1').find('.Content.detail').html(data);
	},'html');
	switchDetail('修改保留计划');
	initEnventForPlan();
	$('#Tools2').removeClass('Tools2_disable').addClass('Tools2');
	$('#Tools23').removeClass('Tools23_disable').addClass('Tools23');
	// temp
	$('#Tools23').off().on("click", function(){
		showImportPage();
	});
}

// 導入保留計畫頁面
function showImportPage(){
	refreshFlag = 1;
	$.post(ctx+'/rp/plan/startImport',function(data){
		$('.Container-1').html(data);
		switchDetail('导入新保留计划');
		$(".tags_close").off('click').removeAttr('click');
		$(".tags_close").on("click",function(){
			$.post(ctx + '/rp/plan', function(data){
				$("#content").html(data);
			},'html');
		});
	});
}


//======================================================初始化页面以及css的显示以及一些公用方法=======================================================
//查询表单校验
function checkSearchForm(){
	var returnVal=true;
	return returnVal;
}

//查询表单提交
function searchFormSubmit(){
	if(checkSearchForm()){
		//TODO;
	}
}


//判断当前是否是回车事件
function doCheckInputEvent(/*Event*/evtIn,/*Node*/anyElem){
	var evt = evtIn || window.event;
	var anyElem = evt.srcElement || evt.target;
	//0.判断当前keyin的值是否在[0~9]+ [.]之间;
	var charCode = evt.keyCode || evt.which;
	if (charCode == 13){//回车即“失去焦点”
		anyElem.blur();
		return;
	}
}

//合同模块toolbar初始化
function initEnventForPlan(){
	$('#Tools1,#Tools2,#Tools11,#Tools12,#Tools21,#Tools22,#Tools10').die().unbind().bind('click',function(){
		bindEvent($(this).attr('id'));
	});
}

//绑定函数,因为仅根据id绑定函数的话,到不同页面要来回绑定/取消,所以根据是否disable,disable的tool不执行相关函数
function bindEvent(toolId){
	var toolElem = $('#'+toolId);
	if(toolElem.hasClass(toolId+'_disable')){
		return ;
	}
	switch(toolId){
		case 'Tools1':showHideLeftSearchDiv();break;
		case 'Tools2':savePlan();break;
		case 'Tools11':showCreatePage();break;
		case 'Tools12':showEditPage($('.btable_checked').attr('planId'));break;
		case 'Tools21':showListPage();break;
		case 'Tools22':showDetailPage($('.btable_checked').attr('planId'),$('.btable_checked').attr('num'));break;
		case 'Tools10':deletePlan($('.btable_checked').attr('planId'));break;
		case 'Tools23':showImportPage();break;
		
	}
}

//点亮显示列表页面的toolbar
function showListToolbarPage(){
	$('.list').show();
	$('.detail').hide();
	$('#Tools1').removeClass('Tools1_disable').addClass('Tools1');
	$('#Tools2').removeClass('Tools2').addClass('Tools2_disable');
	$('#Tools11').removeClass('Tools11_disable').addClass('Tools11');
	$('#Tools21').removeClass("Tools21_disable").addClass("Tools21_on").parent().addClass("ToolsBg");
	$("#Tools18").removeClass("Tools18").addClass("Tools18_disable").removeAttr("onclick");
    $("#Tools19").removeClass("Tools19").addClass("Tools19_disable").removeAttr("onclick");
    $("#Tools16").removeClass("Tools16").addClass("Tools16_disable").removeAttr("onclick");
    $("#Tools17").removeClass("Tools17").addClass("Tools17_disable").removeAttr("onclick");
    
	if($('.btable_checked').size()<1){
		$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
		$('#Tools22').removeClass('Tools22').removeClass('Tools22_on').addClass('Tools22_disable').removeClass('Tools22_hover').parent().removeClass('ToolsBg');
		$('#Tools10').removeClass('Tools10').addClass('Tools10_disable');
	}
	else{
		$('#Tools12').addClass('Tools12').removeClass('Tools12_disable');
		$('#Tools22').addClass('Tools22').removeClass('Tools22_disable');
		$('#Tools10').removeClass('Tools10_disable').addClass('Tools10');
	}
}
function doChangeDetailIcon(/*Node*/planElem){
	$('#Tools22').removeClass("Tools22_disable").addClass("Tools22");
	$('#Tools10').removeClass("Tools10_disable").addClass("Tools10");
	//修改按钮可显示
	$('#Tools12').removeClass("Tools12_disable").addClass("Tools12");
}
//切换到详细页的toolbar
function switchDetail(title,flag){
	$('.newTitle').text(title);
	$('#newTitleDiv').text(title);
	$('.list').hide();
	$('.detail').show(); 
	hideLeft();
	$('#Tools1').removeClass('Tools1_on').parent().removeClass('Tools1Parent_bg');
	$('#Tools1').removeClass('Tools1').addClass('Tools1_disable');
	$('#Tools2').removeClass('Tools2').addClass('Tools2_disable');
	$('#Tools11').removeClass('Tools11').addClass('Tools11_disable');
	$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
	$('#Tools21').removeClass('Tools21').addClass('Tools21_disable').removeClass('Tools21_hover').removeClass('Tools21_on').parent().removeClass('ToolsBg');
	$('#Tools22').removeClass('Tools22').addClass('Tools22_disable');
	$('#Tools10').removeClass("Tools10").addClass("Tools10_disable");
}
function showList(){
	$('.list').show();
	$('.detail').hide(); 
	showListToolbarPage();
	$("#Tools10").attr("class","Tools10_disable");
	$("#Tools12").attr("class","Tools12_disable");
	$("#Tools12").attr("class","Tools12_disable");
	$($("#Tools22").parent()).attr("class","RightTool");
	$("#Tools22").attr("class","Icon-size1 Tools22_disable");
	showListPage("","");
}
/**
 * 隐藏显示搜索栏
 */
function showHideLeftSearchDiv(){
	if($('.Container-1 .Search').is(':visible')){
		hideLeft();
	}
	else{
		showLeft();
	}
}

//隐藏左边查询
function hideLeft(){
	if(!$('.Container-1 .Search').is(':visible')) return;
	$('.Container-1 .Search').hide();
	$('.Container-1 .Content').css('width','99%');
}

//显示左边查询
function showLeft(){
	if($('.Container-1 .Search').is(':visible')) return;
	$('.Container-1 .Search').show();
	$('.Container-1 .Content').css('width','74%');
}
//checkbox是否全选操作
function planCheckBoxAll(/*Node*/theCurrentElemetn){
    if(theCurrentElemetn.checked){
    	$($(theCurrentElemetn.parentNode).prev().get(0)).find(".isChecksPlan").attr("checked", true);
    }
    else{
    	$($(theCurrentElemetn.parentNode).prev().get(0)).find(".isChecksPlan").attr("checked", false);
    }
}

// 检查checkbox是否全部选择，是（全选checkbox为true）否（全选checkbox为false）
function planCheckBoxs(/*Node*/theCurrentElement) {
	//如果提供了事件对象，则这是一个非IE浏览器
    if ( theCurrentElement && theCurrentElement.stopPropagation ){
        //因此它支持W3C的stopPropagation()方法
    	theCurrentElement.stopPropagation();
    } else {
        //否则，我们需要使用IE的方式来取消事件冒泡
        window.event.cancelBubble = true;
	}
	var falg = true;
	var isChecksTempls = $(theCurrentElement.parentElement.parentElement).find(".isChecksPlan");
	for(var i = 0; i < isChecksTempls.length; i++){
		if(!isChecksTempls[i].checked){
			falg = false;
			break;
		}
	}
	if(falg){
		$(theCurrentElement.parentElement.parentNode).next().get(0).children[0].checked=true;
	}else{
		$(theCurrentElement.parentElement.parentNode).next().get(0).children[0].checked=false;
	}
}