//查询表单校验
function checkSearchForm(){
	var returnVal=true;
	return returnVal;
}

//查询表单提交
function searchFormSubmit(){
	$("#pageNo").val(1);
	if(checkSearchForm()){
		pageQuery();
	}
}

//翻页信息
function pageQuery() {
	$.post(ctx + $('#searchForm').attr('action'),$('#searchForm').serialize(),
			function(data) {
		$('.Container-1 .Content.list').html(data);
	});
};

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

//显示列表页面
function showListPage(){
	if(1==refreshFlag){
		searchFormSubmit();
	}
	$('.list').show();
	$('.detail').hide();
	$('#Tools1').removeClass('Tools1_disable').addClass('Tools1');
	$('#Tools2').removeClass('Tools2').addClass('Tools2_disable');
	$('#Tools21').removeClass('Tools21').addClass('Tools21_disable');
	$('#Tools11').removeClass('Tools11_disable').addClass('Tools11');
	$('#Tools12').removeClass('Tools12_disable').addClass('Tools12');
	$('#Tools22').removeClass('Tools22_disable').removeClass('Tools22_on').addClass('Tools22').removeClass('Tools22_hover').parent().removeClass('ToolsBg');
}

//切换到详细页
function switchDetail(title){
	$('.newTitle').text(title);
	$('.list').hide();
	$('.detail').show(); 
	hideLeft();
	$('#Tools2').removeClass('Tools2').addClass('Tools2_disable');
	$('#Tools11').removeClass('Tools11').addClass('Tools11_disable');
	$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
	$('#Tools21').removeClass('Tools21').addClass('Tools21_disable').removeClass('Tools21_hover').removeClass('Tools21_on').parent().removeClass('ToolsBg');
	$('#Tools22').removeClass('Tools22').addClass('Tools22_disable');
}

//显示detail页面
function showDetailPage(){
	refreshFlag=0;
	$.ajaxSetup({
		async : false
	});
	var contractId = $('.btable_checked').attr('id');
	$.post(ctx+'/supplier/contract/history/detail',function(data){
		$('.Container-1').find('.Content.detail').html(data);
	});
	switchDetail('合同详情');
	$('#Tools21').removeClass('Tools21_disable').addClass('Tools21');
	$.ajaxSetup({
		async : true
	});
}

//修改合同
function showEditPage(){
	refreshFlag=1;
	var contractId = $('.btable_checked').attr('id');
	$.post(ctx+'/supplier/contract/history/edit',function(data){
		$('.Container-1').find('.Content.detail').html(data);
	});
	switchDetail('修改合同');
	$('#Tools2').removeClass('Tools2_disable').addClass('Tools2');
}


//合同模块toolbar初始化
function initEnventForContract(){
	$('#Tools1,#Tools2,#Tools12,#Tools21,#Tools22').die().unbind().bind('click',function(){
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
		case 'Tools2':saveContract();break;
		case 'Tools12':showEditPage();break;
		case 'Tools21':showListPage();break;
		case 'Tools22':showDetailPage();break;
	}
}

//选中一条记录
function selectContract(id){
	$('#Tools12').addClass('Tools12').removeClass('Tools12_disable');
	$('#Tools22').addClass('Tools22').removeClass('Tools22_disable');
}

function saveContract(){
	
}

function chooseOfSupplier(){
	openPopupWin(680,548,"/supplier/contract/history/chooseOfSupplierList");
}

function confirmSupplierSelected(supInfo){
	$('#supNo').attr('value',supInfo.supNo);
	$('#supName').attr('value',supInfo.comName);
}