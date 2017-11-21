/**
 * 查詢所有歷史天氣
 */
function search(){
	if ($("#historicalWeatherCon #startDate").val() != '' && $("#historicalWeatherCon #endDate").val() == ''){
		$("#historicalWeatherCon #endDate").addClass("errorInput");
		$("#historicalWeatherCon #endDate").attr("title", "请输入查询结束日期");
		return;
	}
	var param = {
			'startDate' : $('#historicalWeatherCon #startDate').val(),
			'endDate' : $('#historicalWeatherCon #endDate').val()
		};
	var url = ctx + "/weather/getWeather";
	$.post(url, param, function(data) {
		$("#historicalWeatherCon #weatherList").html(data);
	}, 'html');
	
}

/**
 * 歷史天氣查詢頁面: 選擇起始日期時, 清空結束日期
 * @param dp
 */
function checkDate(dp){
	if ($dp.cal.getNewDateStr()!= $dp.cal.getDateStr()){
		$('#historicalWeatherCon #endDate').val('');
	}
}

/**
 * 報表天氣查詢頁面: 選擇起始日期時, 清空結束日期
 * @param dp
 */
function clearEndDate(dp){
	if ($dp.cal.getNewDateStr()!= $dp.cal.getDateStr()){
		$('##weatherReportCon #reportEndDate').val('');
	}
}


/**
 * input onFocus 時將去除錯誤標記
 * @param object
 */
function removeError(object){
	$(object).removeAttr("title");
	$(object).removeClass("errorInput");
}

/**
 * 歷史天氣查詢頁面: 計算結束日期
 * @returns {String}
 */
function calcEndDate(){
	var startDate = new Date($("#historicalWeatherCon #startDate").val().replace(/-/g, '/'));
	var endDate = new Date(startDate);
	endDate.setDate(startDate.getDate()+14);
	var today = new Date();
	// 若起始日期+14 天大於今天, 則 end date 只能選到今天 
	if (endDate> today){
		if (today.getMonth()<10){
			return (today.getFullYear() + "-" + (today.getMonth()+1) + "-" + today.getDate());
		}
		else{
			return (today.getFullYear() + "-" + parseInt(today.getMonth()+1) + "-" + today.getDate());
		}
	}else{
		if (endDate.getMonth()<10){
			return (endDate.getFullYear() + "-" + (endDate.getMonth()+1) + "-" + endDate.getDate());
		}
		else{
			return (endDate.getFullYear() + "-" + (endDate.getMonth()+1) + "-" + endDate.getDate());
		}
	}
}

/**
 * 從歷史天氣頁面 切換到天氣報表查詢頁面
 */
function switchToWeatherReport(){
	// initiate "report page" in the first time
	if ($("#weatherReportCon .Content").length == 0){
		var url = ctx + "/weather/historicalCityWeather";
		$.post(url, function(data) {
			$("#weatherReportCon").html(data);
		}, 'html');
	}
	
	$("#historicalWeatherCon").hide();
	$("#weatherHistoryTag").hide();
	$("#weatherReportCon").show();
	$("#weatherReportTag").show();
	
	// 重新綁定天氣報表查詢的查詢按鈕
	$("#Tools6").attr("class", "Tools6").off("click").on("click", function(){
		searchByCity();
	});
	
	// 重新綁定天氣報表查詢的清除按鈕
	$("#Tools20").attr("class", "Tools20_disable").off("click");
	
}

/**
 * 從天氣報表查詢頁面 切換到歷史天氣頁面
 */
function switchToHistoricalWeather(){
	$("#weatherReportCon").hide();
	$("#weatherReportTag").hide();
	$("#historicalWeatherCon").show();
	$("#weatherHistoryTag").show();
	
	// 重新綁定天氣報表查詢的查詢按鈕
	$("#Tools6").attr("class", "Tools6").off("click").on("click", function(){
		search();
	});
	
	// 重新綁定天氣報表查詢的清除按鈕
	$("#Tools20").attr("class", "Tools20_disable").off("click");
}

/**
 * 天氣報表查詢頁面: 跳出查詢城市彈出框 
 */
function chooseCity() {
	var pass = 1;
	if ($("#reportStartDate").val() == ''){
		$("#reportStartDate").addClass("errorInput");
		$("#reportStartDate").attr("title", "请输入查询起始日期");
		pass = 0;
	}	
	if ($("#reportEndDate").val() == '') {
		$("#reportEndDate").addClass("errorInput");
		$("#reportEndDate").attr("title", "请输入查询结束日期");
		pass = 0;
	}
	if (pass == 0){
		return;
	}
	$("#citySelect").removeAttr("title");
	$("#citySelect").removeClass("errorInput");
	
	openPopupWin(550, 450,'/weather/chooseMultiCity?callback=confirmCity');
}

/**
 * 天氣報表查詢頁面: 在查詢城市彈出框裡按下確定 
 */
function confirmCity(){
	
	if ($("#cityOptions input[type=checkbox]:checked").length <1){
		top.jWarningAlert("请选择需要查询的城市");
		return;
	}
	var selected = $("#cityOptions input[type=checkbox]:checked");
	var regnNoList = [];
	var regnNameList = [];
	var id = '';
	var regnNo = '';
	var regnName = '';
	$.each(selected, function(index, val){
		id = $(val).attr('id');
		regnNo = id.substr(id.indexOf('-')+1,id.length);
		regnName = $(val).parent().find('.SubText_w').text();
		regnNoList.push(regnNo);
		regnNameList.push(regnName);
	});
	$("#regnNoList").val(regnNoList.toString());
	$("#regnNameList").val(regnNameList.toString());
	$("#citySelect").val(regnNameList.toString());
	
	searchByCity();
	closePopupWin();

}

/**
 * 天氣報表查詢頁面: 查詢城市彈出框裡點選每個城市 勾選或取消勾選
 */
function confirmChooseCity(regnNo,regnName){
	var checkbox = $.find("li input[id=cityCode-"+regnNo+"]");
	if ($(checkbox).attr("checked") == 'checked'){
		$(checkbox).removeAttr("checked");
	}
	else{
		$(checkbox).attr("checked", "checked");
	}
}

/**
 * 天氣報表查詢頁面: 查詢所選城市的天氣狀況 
 */
function searchByCity(){
	var pass = 1;
	if ($("#reportStartDate").val() == ''){
		$("#reportStartDate").addClass("errorInput");
		$("#reportStartDate").attr("title", "请输入查询起始日期");
		pass = 0;
	}	
	if ($("#reportEndDate").val() == '') {
		$("#reportEndDate").addClass("errorInput");
		$("#reportEndDate").attr("title", "请输入查询结束日期");
		pass = 0;
	}
	if ($("#regnNoList").val() == ''){
		$("#citySelect").addClass("errorInput");
		$("#citySelect").attr("title", "请选择查询城市");
		pass = 0;
	}
	if (pass == 0){
		return;
	}
	
	var param = {
			cityList : $("#regnNoList").val(),
			startDate: $("#reportStartDate").val(),
			endDate: $("#reportEndDate").val()
	};
	
	var url = ctx + "/weather/getWeatherByCity";
	$.post(url, param, function(data) {
		$("#weatherReportCon #cityWeatherList").html(data);
	}, 'html');
}
