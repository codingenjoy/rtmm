<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<%@ include file="/page/commons/datepick.jsp"%>
<%-- <script type="text/javascript" src="${ctx}/shared/js/analysis/storesPerformance.js" charset="utf-8"></script> --%>
<%@ include file="/page/analysis/storesPerformance/query/storePerformancePageBase.jsp"%>
<%-- 当前写法不太规范,已替换成上一行<script type="text/javascript" src="${ctx}/page/analysis/storesPerformance/query/storePerformancePageBase.jsp" charset="utf-8"></script> --%>
<link href="${ctx}/shared/js/freezenColums/f.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
</script>
<style type="text/css">
/*overwrite heightcharts*/

/*overwrite*/
.CInfo span {
	margin: 0;
}

.frozen_div {
	height: 533px;
	width: 100%;
	margin-top: 2px;
	overflow: hidden;
	background: #f9f9f9;
}
/*frozen table*/
.m_cols_head div,.f_cols_head div {
	border-right: 1px solid #ccc;
}

.frozen_cols {
	height: 100%;
	width: 160px;
}

.move_cols {
	height: 100%; /* equals #frozen_cols.height */
	width: 870px;
}

.f_cols_head,.m_cols_head {
	height: 61px;
	border-bottom: 1px solid #ccc;
}

.f_cols_body,.m_cols_body {
	height: 469px;
	/* equals #frozen_cols.height - #f_cols_head.height(default value is 40px) */
}
.analysis_tby .f_cols_body,.analysis_tby .m_cols_body {
     height:230px;
 }
 .analysis_tby .frozen_div {
     height:295px;
 }
 .CInfo .fl_left {
     margin-left:2px;
 }
</style><!-- \analysis\storesPerformance\query\storePerformancePageBase.jsp -->
<jsp:include page="/page/analysis/storesPerformance/query/storePerformancePageBase.jsp" />
<%@ include file="/page/commons/toolbar.jsp"%> 
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="106001001"></auchan:i18n></div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content analysis_tby">
		<div class="CInfo">
			<div class="icol_text"><auchan:i18n  id="106001003"></auchan:i18n>&nbsp;</div>
			<input type="text" class="Wdate w10" value="${workDate}" onFocus="WdatePicker({onpicked:changeDate,isShowClear: false, readOnly: true,lang:'${calendarL}'})"  id="analysisDate" /> 
			<span class="analysisIcon analysis_on"></span>
		</div>
		<div class="analysis_part1">
			<div class="check_area">
				<div class="carea">
				   <c:forEach items="${areaList}" var="area" varStatus="step">
					<div class="ca_div">
						<input type="checkbox" class="isChecks" name="area" checked="checked" value="${area.regnNo }" colorIndex="${step.index }" title="${area.regnName }" /> <span>${area.regnName }</span> <span
							class="carea_color c${step.index+1 }"></span>
					</div>
					</c:forEach>
					<div class="ca_div_s">
						<input type="checkbox" id="checkAll" checked="checked"/> <span><auchan:i18n id="106001011"></auchan:i18n></span>
					</div>
				</div>
			</div>
			<div class="analysis_img">
				<div class="an_tit bk1"><auchan:i18n id="106001012"></auchan:i18n></div>
				<div class="an_block bk2" id="first_pie" style="width:225px;height: 205px;"></div>
			</div>
			<div class="analysis_img">
				<div class="an_tit bk2"><auchan:i18n id="106001013"></auchan:i18n></div>
				<div class="an_block" id="second_pie" style="width:225px;height: 205px;"></div>
			</div>
			<div class="analysis_img">
				<div class="an_tit bk1"><auchan:i18n id="106001014"></auchan:i18n></div>
				<div class="an_block bk2" id="third_column" style="min-width:225px;height: 205px;"></div>
			</div>
			<div class="analysis_img">
				<div class="an_tit bk2"><auchan:i18n id="106001015"></auchan:i18n></div>
				<div class="an_block" id="forth_column" style="width:225px;height: 205px;"></div>
			</div>
		</div>	
		<div id="paList"></div>
	</div>
</div>
