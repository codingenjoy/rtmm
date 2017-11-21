function getGrpAccount(cntrtId,tabType) {
	var param = {
		'tabType' : tabType,
		'cntrtId' : cntrtId
	};
	$.post(ctx + '/supplier/contract/history/grpAccount', param,
			function(data) {
				$('.detailGrpAccount').html(data);
			}, 'html');
}

/**
 * 清空查詢結果, 重新查詢
 */
function resetDetailSearch(){
	
	$.ajaxSetup({
		async : false
	});
	$.post(ctx + '/supplier/contract/history/', function(data) {
		$("#content").html(data);
	}, 'html');
	$.ajaxSetup({
		async : true
	});
	
	/* 與上段程式碼同樣效果, 但是不向server 送出 request
	$('.detail').hide();
	$('.detail').empty();
	$('.contract  .tkbody').empty();
	$('#searchForm input').val('');
	$('.search ').show();
	// 停用清除按鈕
	$("#Tools20").off("click").removeClass("Tools20").addClass("Tools20_disable");
	// 啟用搜尋按鈕
	$("#Tools6").off().removeClass("Tools6_disable").addClass("Tools6").on("click", function(){
		doGeneralSearch(1);
	});
	// 停用搜尋結果導覽按鈕
	$("#Tools16").removeClass("Tools16").addClass("Tools16_disable").off();
	$("#Tools17").removeClass("Tools17").addClass("Tools17_disable").off();
	$("#Tools18").removeClass("Tools18").addClass("Tools18_disable").off();
	$("#Tools19").removeClass("Tools19").addClass("Tools19_disable").off();
	*/
}

/**
 * 清空查詢介面, 顯示查詢結果
 */
function disableSearch(){
	$('.detail').show();
	$('.search ').hide();
	// 停用搜尋按鈕
	$("#Tools6").off().removeClass("Tools6").addClass("Tools6_disable");
	// 啟用清除按鈕
	$("#Tools20").off().removeClass("Tools20_disable").addClass("Tools20").on("click", function(){
		resetDetailSearch();
	});
	// 限制編輯查詢條件
	$("#detailViewCon .detail input").attr("readonly","readonly");
	
}
/**
 * 切換至Detail View. 若是 double click 進來的, 則顯示該筆. 否則顯示該頁的第一筆
 * @param record 
 */
function switchToDetailView(record){
	var cntrtId = $("#listViewCon #searchForm #cntrtId").val();
	var year = $("#listViewCon #searchForm #year").val();
	var supNo = $("#listViewCon #searchForm #supNo").val();
	var supName = $("#listViewCon #searchForm #supName").val();
	// 如果有查詢結果, 就進去詳細介面. 若沒資料, 則進去詳細介面的查詢頁面
	if ($(".Bar_on:visible").length!=0){
		$('#Tools1').trigger('click');
	}
	if ($("#totalCount").val()>0){
		var toViewRecord = 0;
		// 計算要顯示第幾筆
		var recordStartFrom = (parseInt(historyContract.page)-1) * parseInt(historyContract.itemsPerPage);
		if (record){
			toViewRecord = recordStartFrom + parseInt(record) + 1;
		}
		else{
			toViewRecord = recordStartFrom +1; 
		}
		// 將List View 的查詢條件帶到 Detail View 並開始查詢
		$("#detailViewCon #searchForm #cntrtId").val(cntrtId);
		$("#detailViewCon #searchForm #year").val(year);
		$("#detailViewCon #searchForm #supNo").val(supNo);
		$("#detailViewCon #searchForm #supName").val(supName);
		
		doGeneralSearch(toViewRecord);
		$("#listViewCon").hide();
		$("#detailViewCon .search").hide();
		$("#detailViewCon .detail").show();
		$("#detailViewCon").show();
	}else{
		resetDetailSearch();
	}
}

/**
 * 切換至List View
 */
function switchToListView(){
	var cntrtId ;
	var year;
	var supNo;
	var supName;
	if ($("#detailViewCon #searchForm #cntrtId").val()!='输入合同编号'){
		cntrtId = $("#detailViewCon #searchForm #cntrtId").val();
	}
	if ($("#detailViewCon #searchForm #supNo").val()!='输入厂编'){
		supNo = $("#detailViewCon #searchForm #supNo").val();
	}
	if ($("#detailViewCon #searchForm #year").val()!='输入年份'){
		year = $("#detailViewCon #searchForm #year").val();
	}
	if ($("#detailViewCon #searchForm #supName").val() != ''){
		supName = $("#detailViewCon #searchForm #supName").val();
	}

	$.ajaxSetup({
		async : false
	});
	$.post(ctx + '/supplier/contract/history/listView', function(data) {
		$("#listViewCon").html(data);
		// copy param from detail view to list view
		$('#listViewCon #searchForm #cntrtId').val(cntrtId);
		$('#listViewCon #searchForm #year').val(year);
		$('#listViewCon #searchForm #supNo').val(supNo);
		$('#listViewCon #searchForm #supName').val(supName);
		
		$("#detailViewCon").hide();
		$('#listViewCon').show();
		enableListViewIcon();
		historyContractPageQuery(1,20);
	}, 'html');
	$.ajaxSetup({
		async : true
	});
	
}

/**
 * 根據查詢條件送出查詢
 */
function historyContractPageQuery(pageNo,pageSize){
	if (loadSupName()){
		// 計算有沒有超過頁數
		if ((pageNo-1) * pageSize > $('#listViewCon #totalCount').val()){
			pageNo = 1;
		}
		var param = $('#listViewCon #searchForm').serialize();
		param = joinPostParam(param,'pageNo',pageNo);
		param = joinPostParam(param,'pageSize',pageSize);
		$.post(ctx+$('#listViewCon #searchForm').attr('action'),param, function(data){
			$('#listViewCon .Content').html(data);
		});
	}
}

/**
 * 在 List View 中翻頁
 */
function pagination(currentPage,pageSize) {
	$("#listViewCon #searchForm #pageNo").val(currentPage);
	if(pageSize){
		$("#listViewCon #searchForm #pageSize").val(pageSize);
	}
	enableDetailViewIcon();
}
/**
 * 啟用所有 Detail View 所需的工具, 並關閉 List View 的工具
 */
function enableDetailViewIcon(){
	// Tools21:listView, Tools22:detailView, Tools20:eraser, Tools6:query, Tools1:queryForm
	$("#Tools22").attr("class","Icon-size1 Tools22_disable");
	$("#Tools22").parent().attr("class", "RightTool checked");
	$("#Tools22").off("click");
	
	$("#Tools21").attr("class","Icon-size1 Tools21");
	$("#Tools21").parent().attr("class", "RightTool");
	$("#Tools21").off().on("click", function(){
		switchToListView();	
	});
	$("#Tools1").off().attr("class", "Icon-size1 Tools1_disable B-id");
	bindEnterTrigger();
}

/**
 * 啟用所有 List View 所需的工具, 並關閉 Detail View 的工具
 */
function enableListViewIcon(){
	$("#Tools21").attr("class","Icon-size1 Tools21_disable");
	$("#Tools21").parent().attr("class", "RightTool checked");
	$("#Tools21").off("click");
	
	$("#Tools22").attr("class","Icon-size1 Tools22");
	$("#Tools22").parent().attr("class", "RightTool");
	$("#Tools22").off().on("click", function(){
		switchToDetailView();
	});
	// Disable Tools20,6,16,17,18,19
	$("#Tools20").off().attr("class", "Tools20_disable");
	$("#Tools6").off().attr("class", "Tools6_disable");
	$("#Tools16").off().attr("class", "Tools16_disable");
	$("#Tools17").off().attr("class", "Tools17_disable");
	$("#Tools18").off().attr("class", "Tools18_disable");
	$("#Tools19").off().attr("class", "Tools19_disable");
	
	$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').off().on('click',function() {
		DispOrHid('B-id');
		gridbar_B();
	});
	bindEnterTrigger();
}
/**
 * 將彈出窗裡選中的供應商帶到頁面上
 * @param supInfo
 */
function confirmSupplierSelected(supInfo) {
	$(".Container-1:visible form").find('#supNo').val(supInfo.supNo);
	$(".Container-1:visible form").find('#supName').val(supInfo.comName);
}

/**
 * 清除目前看到頁面的查詢條件
 */
function reset(){
	$(".Container-1:visible form input:visible").val('');
	$(".Container-1:visible form select").val('');
}

/**
 * 在查詢條件欄位按Enter時, 開始查詢
 */
function bindEnterTrigger(){
	$(".Container-1:visible form [name=supNo], .Container-1:visible form [name=cntrtId], .Container-1:visible form [name=year], .Container-1:visible form [name=supVatNo], .Container-1:visible form [name=payMethd], .Container-1:visible form [name=grpAcctAbbrs]").keydown(function(e) {
		if (e.keyCode == 13) {
			if ($("#detailViewCon:visible").length ==1){
				doGeneralSearch(1);
			}
			else{
				historyContractPageQuery(1,20);
			}
		}
	});
}

function loadSupName() {
	var supNo = $('#listViewCon #searchForm #supNo').val();
	if (supNo){
		$.ajaxSetup({
			async : false
		});
		readSupInfoBySupNo("", supNo, function(data) {
			if (data != "" && data.length > 0) {
				$("#listViewCon #searchForm #supName").val(data[0].comName);
			} else {
				$("#listViewCon #searchForm #supNo").val('');
				$("#listViewCon #searchForm #supName").val('');
				top.jAlert('warning', '该厂商不存在', '提示消息');
			}
		});
		$.ajaxSetup({
			async : true
		});
		if ($("#listViewCon #searchForm #supName").val()){
			return true;
		}
	}else{
		return true;
	}
	return false;
}

/** 输入整数值 */
function inputToInputIntNumber() {
	$("input.count_text").each(function() {
		$(this).keyup(function() {
			if ($(this).val() != '' && !(/^\d+$/).test($(this).val())) {
				if ($(this).val() == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
		$(this).attr('preval', $(this).val());
		});
		$(this).blur(function(){
			$(this).attr('preval', $(this).val());
			if ($(this).val() != '' && !(/^\d+$/).test($(this).val())) {
				if ($(this).val() == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
		});
	});
}