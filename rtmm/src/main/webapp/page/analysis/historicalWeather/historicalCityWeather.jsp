<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<div class="Content">
	<form id="searchForm" name="searchForm" action="/weather/getWeatherByCity" onsubmit="queryHistoricalCityWeather();return false;">
		<div class="ig_top10">
			<div class="icol_text">查询日期&nbsp;&nbsp;</div>
			<input type="text" id="reportStartDate" name="startDate" class="Wdate w10 fl_left"
				onFocus="removeError(this);WdatePicker({isShowClear: false,readOnly: true, minDate:'2015-01-01', maxDate:'%y-%M-%d',onpicking:function(dp){clearEndDate(dp);}, onpicked:function(dp){reportEndDate.focus();}})"
				value="">
			<div class="icol_text" style="padding-right: 5px; padding-left: 5px;">-</div>
			<input type="text" id="reportEndDate" name="endDate" class="Wdate w10 fl_left"
				onFocus="removeError(this);WdatePicker({isShowClear: false,readOnly: true, minDate:'#F{$dp.$D(\'reportStartDate\')}', maxDate:'%y-%M-%d'})"
				value="">
		</div>
		<div class="ig_top10">
			<div class="icol_text">查询城市&nbsp;&nbsp;</div>
			<input type="hidden" name="regnNoList" id="regnNoList">
			<input type="hidden" name="regnNameList" id="regnNameList" >
			<div class="iconPut w40 fl_left" onclick="chooseCity();">
				<input type="text" id="citySelect" readonly="readonly" style="width:95%">
				<div class="ListWin" ></div>
			</div>
		</div>
	</form>
	<div id="cityWeatherList">
		<div class="htable_div">
			<table>
				<thead>
					<tr>
						<td>
							<div class="t_cols" style="width: 100px; padding-left: 5px;">日期</div>
						</td>
						<td>
							<div class="t_cols" style="width: 150px;"></div>
						</td>
						<td>
							<div class="t_cols" style="width: 16px;"></div>
						</td>
					</tr>
				</thead>
			</table>
		</div>
		<div class="btable_div weather" style="height: 450px;">
			<table class="single_tb w100" id="weatherHistory">
				<tr>
					<td style="width: 102px; padding-left: 5px;" title="${inner.regnName }">${inner.regnName }</td>
					<td style="width: 152px;" class="align_left"></td>
					<td style="width: auto;">&nbsp;</td>
				</tr>
			</table>
		</div>
	</div>
</div>


