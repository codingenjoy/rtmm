//查询全国性DM期数与主题
function searchPeriodToTheTopic(){
	var promotion_form = $("#promotion_form").serialize();
	$.ajax({
		type : 'post',
		dataType:'html',
		data:promotion_form,
		url : ctx + '/promotion/DMManagement/searchPeriodToTheTopicAction',
		success : function(data){
			$("#promotionDiv").html(data);
		}
	});
}

//显示全国性DM期数与主题详细
function promoIssueAllDetailedness(){
	var tools22 = $("#Tools22").attr("class");
	if (tools22.indexOf("disable") < 0) {
		window.location.href=ctx + '/promotion/DMManagement/promoIssueAllDetailednessAction';
	}
}

//创建DM期数与主题
function issueFormbySetCreateNew(){
	window.location.href=ctx + '/promotion/DMManagement/issueFormbySetCreateNewAction';
}
//创建全国性及门店DM期数与主题
function issueFormbyStoreSetCreateNew(){
	window.location.href=ctx + '/promotion/DMManagement/issueFormbyStoreSetCreateNew';
}

function openPromotionWindow(){
	openPopupWinThree(500,500,ctx + '/promotion/DMManagement/openPromotionWindowAction');
}

// 打开弹出框
function openPopupWinThree(windowWidth, windowHeight, actionUrl) {
	var selector = "#popupWinTwo";
	top.document.find(selector).window({
		width : windowWidth,
		height : windowHeight,
		draggable : true,
		resizable : false,
		modal : true,
		shadow : false,
		border : false,
		noheader : true
	});
	top.document.find(selector).css("display", "block");
	top.document.find(selector).window("open");
	top.document.find(selector).window('refresh', ctx + actionUrl);
	window.windowSelector = selector;
}

// 关闭弹出框
function closePopupWinTwo() {
	top.document.find("#popupWinTwo").html('');
	top.document.find("#popupWinTwo").window("close");
}
