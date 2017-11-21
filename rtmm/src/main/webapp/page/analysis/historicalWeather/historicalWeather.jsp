<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/analysis/historicalWeather.js"
	type="text/javascript"></script>
<style>

td img{ 
	vertical-align: middle;
	padding-right:5px;
}  

#weatherHistory tr:nth-child(odd){
	background: #F2F2F2;
}
#weatherHistory tr:nth-child(even){
	background: #F9F9F9;
} 

#weatherHistory tr:hover{
	background:#9c6;
}
.firstColumn{ 
	width: 102px; 
	padding-left:5px;
}
</style>
<script type="text/javascript">
	//滚动条事件
	$(document).ready(function() {
		$(".Tools1").removeClass("Tools1").addClass("Tools1_disable").die().off("click");
		$("#Tools6").removeClass("Tools6_disable").addClass("Tools6").off("click").on("click", function(){
			search();
		});
		search();
		//switchToWeatherReport();
	});
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle" id="weatherHistoryTag">
	<!--第一个-->
	<div id="firstTag" class="tags1_left tags1_left_on"></div>
	<div id="weatherHistory" class="tagsM tagsM_on">历史天气查询</div>

	<!--中间-->
	<div id="midden" class="tags tags_left_on"></div>

	<!--最后一个-->
	<div id="cityWeatherReport" class="tagsM" onClick="switchToWeatherReport()">天气报表查询</div>
	<div id="last" class="tags tags3_r_off"></div>
</div>
<div class="CTitle" id="weatherReportTag" style="display:none;">
	<!--第一个-->
	<div id="first" class="tags1_left"></div>
	<div id="sec_info" class="tagsM" onClick="switchToHistoricalWeather()">历史天气查询</div>

	<!--中间-->
	<div id="midden" class="tags  tags_right_on"></div>

	<!--最后一个-->
	<div id="sec_attr" class="tagsM tagsM_on">天气报表查询</div>
	<div id="last" class="tags tags3_r_on"></div>
</div>
<div class="Container-1" id="historicalWeatherCon">
	<div class="Content">
		<div class="ig_top10">
			<div class="icol_text">查询日期&nbsp;&nbsp;</div>
			<input type="text" id="startDate" name="startDate"
				class="Wdate w10 fl_left" 
				onFocus="removeError(this);WdatePicker({isShowClear: false,readOnly: true, minDate:'2015-01-01', maxDate:'%y-%M-%d',onpicking:function(dp){checkDate(dp);}, onpicked:function(dp){endDate.focus();}})"
				value="">
			<div class="icol_text" style="padding-right:5px; padding-left:5px;">-</div>
			<input type="text" id="endDate" name="endDate"
				class="Wdate w10 fl_left"
				onFocus="removeError(this);var date = calcEndDate();WdatePicker({isShowClear: false,readOnly: true, minDate:'#F{$dp.$D(\'startDate\')}', maxDate:date, onpicked:function(dp){search();}})"
				value="">
		</div>
		<div id="weatherList">
			
		</div>
	</div>
</div>
<div class="Container-1" id="weatherReportCon" style="display:none;">

</div>
