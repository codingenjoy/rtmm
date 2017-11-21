<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/Highcharts-4.0.3/js/highcharts.js"></script> 
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<%@ include file="/page/commons/datepick.jsp"%>
<%-- <script type="text/javascript" src="${ctx}/shared/js/analysis/storesPerformanceDetail.js" charset="utf-8"></script> --%>
<%@ include file="/page/analysis/storesPerformance/query/showDetailBase.jsp"%>
<link href="${ctx}/shared/js/freezenColums/f.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/shared/js/freezenColums/f.js" type="text/javascript"></script> 
<script type="text/javascript">
	$(function (){
		var flag = '${flag}';
		var analysisDate = '${analysisDate}';
		var areaStr = '${areaStr}';
		var category='${categoryStr}';
		if(flag=="1"){
			getSalesDataD(analysisDate,areaStr,category);
		}else if(flag=="2"){
			getVisitorsDataD(analysisDate,areaStr,category);
		}else if(flag=="3"){
			getGrossMarginDataD(analysisDate,areaStr,category);
		}else if(flag=="4"){
			getCustPriceDataD(analysisDate,areaStr,category);
		}
	});	
</script>
<div id="show" style="width:800px;height: 500px;" align="center"></div>

