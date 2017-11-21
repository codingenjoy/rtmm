/**
 * 課別屬性: 初始化課別屬性頁面
 */
function sectionAttribute(){
    $("#first").attr("class", "tags1_left");
    $("#sec_info").attr("class", "tagsM");
    $("#midden").attr("class", "tags tags_right_on");
    $("#sec_attr").attr("class", "tagsM tagsM_on");
    $("#last").addClass("class", "tags tags3_r_on");
	showContent(ctx+'/catalog/sectionAttribute');
}


/**
 * 處課信息 : 初始化處課信息頁面
 */
function divisionInfo(){
	$('#first').attr("class", "tags1_left tags1_left_on");
	$('#sec_info').attr("class", "tagsM tagsM_on");
	$('#midden').attr("class" , "tags tags_left_on");
	$('#sec_attr').attr("class" , "tagsM");
	$('#last').attr("class", "tags tags3_r_off");
	showContent(ctx+'/catalog/catalogDivisionAction');
}

/**
 * 課別屬性: 課別選擇彈出框
 */
function selectSection(){
	openPopupWin(615, 200, '/catalog/openChooseSectionAction');
}

/**
 * 課別屬性: 確認選擇的課別 
 */
function chooseSection(sectionNo) {
	var flag = 1;
	if (sectionNo == undefined && $('#sectionAttrDivNo :selected').val() == '' || $('#sectionAttrSecNo :selected').val() == ''){
		top.jAlert('warning', '请选择处课', window.v_messages);
		return;
	}else if (sectionNo == undefined){
		flag = 0;
		var sectionNo = $("#sectionAttrSecNo").val();
		var section = $('#sectionAttrSecNo :selected').text();
		var sectionName = $.trim(section.substring(section.indexOf('-')+1, section.length));
	}	
	$.ajax({
		async: false,
		type : 'post',
		url : ctx + '/catalog/showSecAttrList',
		dataType  : 'html',
		data : {
			sectionId :  $.trim(sectionNo)
		},
		success : function(data){
			$(".Con_tb").html(data);
		}
	});
	
	if (flag == 0){
		closePopupWin();
		$("#secAttrSecNo").val(sectionNo);
		$("#secAttrSecName").val(sectionName);
	}
	$("#secAttrName").click();
}

/**
 * 課別屬性: 顯示所選的課別屬性對應值列表
 * @param attrId
 */
function showAttrContent(attrId){
	var showCatlgId = $.trim($("#secAttrSecNo").val());
	
	if (showCatlgId == ''){
		showCatlgId = 1;
		attrId = 1;
	}
	// Enable edit Section Attribute Function
	enableSecAttrEdit();
	
	// Enable create Section Attribute Value Function
	$('#attrValCreate').attr("class", "Icon-size2 Tools11");
	
	if (p_attrId != attrId) {
		$("#Point_L" + p_attrId).removeClass("Point_L2");
		$("#sectionTr" + p_attrId).removeClass("item_on2");
	}
	$("#attrId" + attrId).addClass("item_on2");
	$("#Point_L" + attrId).addClass("Point_L2");
	p_attrId = attrId;
	
	$('#pageNo').val('1');
	$('#pageSize').val('');
	pageQuery(showCatlgId, attrId);
}

/**
 * 課別屬性: 彈出修改課別屬性視窗
 */
function editSecAttrFormPopWin(){
	openPopupWin(615, 200, '/catalog/editSecAttrFormPopWin');
}

/**
 * 課別屬性: 彈出修改課別屬性對應屬性值視窗
 * @param mode
 */
function editSecAttrValFormPopWin(mode){
	
	var select = $('.item_on2 > #seqNo').text();
	if (select != '' ){
		if ($('.item_on2 > #secAttrName').text() == ''){
			top.jAlert('warning', '请先设定课别属性中文名称', window.v_messages);
		}
		else{
			openPopupWin(615, 300, '/catalog/editSecAttrValFormPopWin?mode=' + mode);
		}
	}
}

/**
 * 課別屬性: 儲存課別屬性修改
 */
function saveSecAttr() {
	var flag = true;
	var editcatlgId = $('#editcatlgId').val();
	if ($('#editsecAttrValName').val() == '') {
		$('#editsecAttrValName').addClass("errorInput");
		flag = false;
	} else {
		// 檢查是否這個屬性中文名稱已有重覆

	}
	if (flag) {
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/saveSecAttr',
			async : false,
			data : {
				catlgId : $('#editcatlgId').val(),
				seqNo : $('#editseqNo').val(),
				secAttrValName : $.trim($('#editsecAttrValName').val())
			},
			success : function(data) {
				if (data.status == "SUCCESS") {
					top.jAlert('success', window.v_operationSuc,window.v_messages);
				} else {
					top.jAlert('error', window.v_operationFail,window.v_messages);
				}
			}
		});
		closePopupWin();

		// 重新整理課別屬性列表
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/showSecAttrList',
			dataType : 'html',
			async : false,
			data : {
				sectionId : editcatlgId
			},
			success : function(result) {
				$(".Con_tb").html('');
				$(".Con_tb").html(result);
			}
		});
		showAttrContent(0);
		disableSecAttrEdit();
	}
}

/**
 * 課別屬性: 儲存課別屬性的 對應屬性值
 */
function saveSecAttrVal() {
	var flag = true;
	if ($.trim($('#valSecAttrValName').val()) == '') {
		$('#valSecAttrValName').addClass("errorInput");
		flag = false;
	}

	if (flag) {
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/checkSecAttrVal',
			data : {
				catlgId : $('#valCatlgId').val(),
				secAttrSeqNo : $('#valSecAttrSeqNo').val(),
				secAttrValName : $('#valSecAttrValName').val(),
				pr_secAttrValName : $('#prSecAttrValName').val()
			},
			success : function(data) {
				if (data.exist == true) {
					$('#valSecAttrValName').addClass("errorInput");
					$('#valSecAttrValName').attr("title", "属性值中文描述不能重复");
				} else {
					$.ajax({
						type : 'post',
						url : ctx + '/catalog/saveSecAttrVal',
						async : false,
						data : {
							catlgId : $('#valCatlgId').val(),
							secAttrSeqNo : $('#valSecAttrSeqNo').val(),
							secAttrValNo : $('#valSecAttrValNo').val(),
							secAttrValName : $('#valSecAttrValName').val(),
							secAttrId : $('#secAttrId').val()
						},
						success : function(data) {
							if (data.status == "SUCCESS") {
								top.jAlert('success', window.v_operationSuc, window.v_messages);
								$('#attrContentList').html('');
								showAttrContent($('#valSecAttrSeqNo').val());
								closePopupWin();
							} else {
								top.jAlert('error', window.v_operationFail, window.v_messages);
							}
						}
					});
				}
			}
		});
	}

}

//手动查询公司
function searchSectionMess(sectionNo){
	$.ajax( {
		type : 'post',
		url : ctx + '/catalog/searchSectionMessAction',
		data : {
			catlgId : sectionNo},
		success : function(data) {
			var sectionInfoVO = data.sectionInfoVO;
			$(".tbx").html("");
			if (sectionInfoVO != null) {
	 			$("#secAttrSecName").val(sectionInfoVO.catlgName);
				chooseSection($.trim(sectionNo));
			} else {
				top.jAlert("warning","课别有误, 请重新输入", window.v_messages);
				$("#secAttrSecName").val('');
				$("#secAttrSecNo").val('');
				// 清空右邊的對應屬性質列表
				showAttrContent(0);
				$(".Point_L .Point_L2").removeClass("Point_L2");
			}
		}
	});
}