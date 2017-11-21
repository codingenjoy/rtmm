//模板toolbar初始化
function initEnventForContract() {
	$('#Tools1,#Tools2,,#Tools11,#Tools12,#Tools21,#Tools22').die().unbind().bind('click',function(){
		bindEvent($(this).attr('id'));
	});
}

// 绑定函数,因为仅根据id绑定函数的话,到不同页面要来回绑定/取消,所以根据是否disable,disable的tool不执行相关函数
function bindEvent(toolId) {
	var toolElem = $('#' + toolId);
	if (toolElem.hasClass(toolId + '_disable')) {
		return;
	}
	switch (toolId) {
	case 'Tools1':
		showHideLeftSearchDiv();
		break;
	case 'Tools2':
		saveTemplate();
		break;
	case 'Tools11':
		bindCreateEvent();
		break;
	case 'Tools12':
		bindEditEvent();
		break;
	case 'Tools21':
		if($('#Tools21').parent().hasClass('ToolsBg')){
			return false;
		}else{
			pageQuery();
			showListPage();
		}
		break;
	case 'Tools22':
		switchDetailPage(obj);
		break;
	}
}
/**
 * 隐藏显示搜索栏
 */
function showHideLeftSearchDiv() {
	if ($('.Container-1 .Search').is(':visible')) {
		hideLeft();
	} else {
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
/**
 * 查询模板列表
 */
function pageQuery() {
	var chngDate = $("#queryForm input[name='chngDate']");
	var createDate = $("#queryForm input[name='creatDate']");
	if(chngDate.hasClass('errorInput')||createDate.hasClass('errorInput')){
		return;
	}
	$.ajax({
		type : 'post',
		data : $('#queryForm').serialize(),
		url : ctx + '/supplier/contract/templ/list',
		success : function(data, status) {
			if (status == 'success') {
				$('.Container-1').find('.list').html(data);
				$('#pageNo').val(1);
				if($('#Tools12').hasClass('Tools12')){
					$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
				}
				if($('#Tools22').hasClass('Tools22')){
					$('#Tools22').removeClass('Tools22').addClass('Tools22_disable');
				}
			}
		},
		error : function(data) {
			top.jAlert('error', '查询失败', '消息提示');
		}
	});
}
/**
 * 验证只能输入数字
 * 
 * @param obj
 */
function inputNumbers(obj) {
	if ($(obj).val() != '' && !(/^\d{0,10}$/).test($(obj).val())) {
		if ($(obj).val() == ' ') {
			$(obj).val('');
			return false;
		}
		if ($(obj).val() != '') {
			$(obj).val($(obj).attr('preval'));
		}
		return true;
	}
	$(obj).attr('preval', $(obj).val());
	if ($(obj).val() != '') {
		$(obj).removeClass('errorInput');
	}
}
/**
 * 切换到详情页面
 */
function switchDetailPage(obj) {
	if($("#Tools22").parent().hasClass("ToolsBg")||$('#Tools22').hasClass('Tools22_disable')){
		return false;
	}
	// 模板编号
	var templ_id = {
		'templ_id' : obj.children[0].children[0].innerHTML
	};
	// 跳转到模板详情页
	$.ajax({
		type : 'post',
		url : ctx + '/supplier/contract/templ/detail',
		data : templ_id,
		success : function(data) {
			$('.Container-1').find('.detail').html(data);
			switchDetail('系统界面模板详情');
			$('#Tools21').removeClass('Tools21_disable').addClass('Tools21');
			$('#Tools22').removeClass('Tools22_disable').addClass('Tools22').addClass('Tools22_on');
		}
	});
	$('#Tools22').parent().addClass('ToolsBg');
}
/**
 * 单击选中某条数据后，显示Tools12和Tools22
 */
function showTools(obj) {
	//设置模版编号
	$("#parameterTempl").val(obj.children[0].children[0].innerHTML);
	$("#Tools12").attr('class', "Icon-size1 Tools12");
	$("#Tools22").attr('class', "Icon-size1 Tools22").unbind().bind('click',
			function() {
				switchDetailPage(obj);
			});
}
/**
 * 清空搜索列表里的数据
 */
function clearQuery() {
	var chngDate = $("#queryForm input[name='chngDate']");
	var createDate = $("#queryForm input[name='creatDate']");
	if(chngDate.hasClass('errorInput')){
		chngDate.removeClass('errorInput');
	}
	if(createDate.hasClass('errorInput')){
		createDate.removeClass('errorInput');
	}
	$('#tmpl_id').val('');
	$('#inUseInd').val('');
	$('.inputText').val('');
}
/**
 * 查询列表键盘enter事件
 */
$('#queryForm').keydown(function(e) {
	if (e.keyCode == 13) {
		pageQuery();
	}
});
/**
 * 详情页面tab切换,刷新term
 */
function changeTab(obj) {
	if ($(obj).hasClass('item_on'))
		return;
	var tabId = $(obj).find('input[name=tabId]').val();
	$('.cm_table2 .term').hide();
	$('.cm_table2 .item_on').removeClass('item_on');
	changeAcc($('#term-'+ tabId).show().find('.item').first().addClass('item_on'));
}
/**
 * 详情页面term切换，刷新acc
 */
function changeAcc(obj) {
	var termId = $(obj).find('input[name=termId]').val();
	$('.cm_table3 .term').hide();
	$('#acc-'+ termId).show();
}
/**
 * List item 列表点击 单选
 */
$('.item').die().live('click', function() {
	$(this).parent().find(".item_on").removeClass("item_on");
	$(this).addClass("item_on");
});
//验证修改时间大于创建日期
function createDateChangeConfirm(dp){
	var chngDate = $("#queryForm input[name='chngDate']");
	chngDate.removeClass('errorInput');
	if($.trim(chngDate.val())==''){
		return;
	}else{
		var creatDate = dp.cal.getNewDateStr();
		var iDays = getSubDays(chngDate.val(),creatDate);
		if(iDays>0){
			chngDate.addClass('errorInput').attr('title','修改日期必须大于等于创建日期');
		}
	}
}
	//验证修改时间大于创建日期
	function chngDateChangeConfirm(dp){
		var createDate = $("#queryForm input[name='creatDate']");
		$("#queryForm input[name='chngDate']").removeClass('errorInput');
		if($.trim(createDate.val())==''){
			return;
		}else{
			var chngDate = dp.cal.getNewDateStr();
			var iDays = getSubDays(chngDate,createDate.val());
			if(iDays>0){
				$("#queryForm input[name='chngDate']").addClass('errorInput').attr('title','修改日期必须大于等于创建日期');;
			}
		}
}
/**
 * *********************************************************************************************
 * 以下是系统界面模版新增和修改功能
 */

// 绑定新增事件
function bindCreateEvent() {
	// 新增按钮
	if ($(this).hasClass("Tools11_disable")) {
		return;
	}
	openCreatePage();
}
// 打开新增页面
function openCreatePage() {
	$.post(ctx + '/supplier/contract/templ/create', function(data) {
		$('.Container-1').find('.detail').html(data);
	});
	switchDetail('新增系统界面模版');
	$('#Tools2').removeClass('Tools2_disable').addClass('Tools2');
}
// 关闭新增页面
function closeCreatePage() {
	showListPage();
}
// 绑定修改事件
function bindEditEvent() {
	// 修改按钮
	if ($(this).hasClass("Tools12_disable")) {
		return;
	}
	openEditPage();
}
// 打开修改页面
function openEditPage() {
	var parameterTempl = $("#parameterTempl").val();
	$.post(ctx + "/supplier/contract/templ/edit",{templId : parameterTempl}, function(data) {
		$('.Container-1').find('.detail').html(data);
	});
	switchDetail('修改系统界面模版');
	$('#Tools2').removeClass('Tools2_disable').addClass('Tools2');
}

// 关闭修改页面
function closeEditPage() {
	showListPage();
}
// 绑定修改事件
function saveTemplate() {
	// 修改按钮
	if ($(this).hasClass("Tools2_disable")) {
		return;
	}
	save();
}

//checkbox是否全选操作
function templCheckBoxAll(theCurrentElemetn){
    if(theCurrentElemetn.checked){
    	$($(theCurrentElemetn.parentNode).prev().get(0)).find(".isChecksTempl").attr("checked", true);
    }
    else{
    	$($(theCurrentElemetn.parentNode).prev().get(0)).find(".isChecksTempl").attr("checked", false);
    }
}

// 检查checkbox是否全部选择，是（全选checkbox为true）否（全选checkbox为false）
function templCheckBoxs(theCurrentElement) {
	//如果提供了事件对象，则这是一个非IE浏览器
    if ( theCurrentElement && theCurrentElement.stopPropagation ){
        //因此它支持W3C的stopPropagation()方法
    	theCurrentElement.stopPropagation();
    } else {
        //否则，我们需要使用IE的方式来取消事件冒泡
        window.event.cancelBubble = true;
	}
	var falg = true;
	var isChecksTempls = $(theCurrentElement.parentElement.parentElement).find(".isChecksTempl");
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

function switchDetail(title) {
	if (title == "") {
		$("#templListDiv").show();
		$("#templOtherDiv").hide();
	} else {
		$("#templListDiv").hide();
		$("#templOtherDiv").show();
		$('.newTitle').text(title);
	}
	$('.list').hide();
	$('.detail').show();
	hideLeft();
	if ($('#Tools1').parent().hasClass("Tools1Parent_bg")) {
		$('#Tools1').parent().removeClass("Tools1Parent_bg");
		$("#Tools1").removeClass("Tools1_on ");
	}
	$('#Tools1').removeClass('Tools1').addClass('Tools1_disable');
	$('#Tools2').removeClass('Tools2').addClass('Tools2_disable');
	$('#Tools11').removeClass('Tools11').addClass('Tools11_disable');
	$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
	$('#Tools21').removeClass('Tools21').addClass('Tools21_disable').removeClass('Tools21_hover').removeClass('Tools21_on').parent().removeClass('ToolsBg');
	$('#Tools22').removeClass('Tools22').addClass('Tools22_disable');
}
// 显示列表页面
function showListPage() {
	$("#templListDiv").show();
	$("#templOtherDiv").hide();
	$('.list').show();
	$('.detail').hide();
	$('#Tools1').removeClass('Tools1_disable').addClass('Tools1');
	$('#Tools2').removeClass('Tools2').addClass('Tools2_disable');
	$('#Tools21').removeClass('Tools21').addClass('Tools21_disable');
	$('#Tools11').removeClass('Tools11_disable').addClass('Tools11');
	$('#Tools12').addClass('Tools12_disable');
	$('#Tools22').removeClass('Tools22').addClass('Tools22_disable');
	$('#Tools21').attr('class', 'Icon-size1 Tools21_on');
	$("#Tools21").parent().addClass("ToolsBg");
	if($('#Tools22').parent().hasClass('ToolsBg')){
		$('#Tools22').parent().removeClass('ToolsBg');
	}
}