<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/js/loading/loading.css" />
<script type="text/javascript"
	src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript"
	src="${ctx}/shared/js/promotion/promotionStoreCreate.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/common.js" charset="utf-8"></script>	
<script type="text/javascript" src="${ctx}/shared/js/loading/loading.js"
	charset="utf-8"></script>

<style type="text/css">


.hiLightInput {
	color: red;
}
.hiLightYellowInput {
	color: yellow;
}

.pro1 {
	margin-left: 60px;
}

.pro2 {
	margin-left: 90px;
}

.pro3 {
	margin-left: 120px;
}

.pro4 {
	margin-left: 85px;
}

.pro5 {
	margin-left: 45px;
}

.pro6 {
	margin-left: 40px;
}

.pro7 {
	margin-left: 45px;
}

.pro8 {
	margin-left: 40px;
}

.pro9 {
	margin-left: 45px;
}

.pso1 {
	margin-left: 45px;
}

.pso2 {
	margin-left: 65px;
}

.pso3 {
	margin-left: 130px;
}

.pso4 {
	margin-left: 120px;
}

.pso5 {
	margin-left: 125px;
}

.pso6 {
	margin-left: 35px;
}

.pso7 {
	margin-left: 40px;
}

.zt_top15 {
	height: 20px;
	width: 1300px;
	margin-top: 15px;
}

.cx_tj {
	background: #e0e0e0;
	width: 1300px;
}

.cx_tj_inner {
	width: 1200px;
	height: 26px;
	padding-top: 4px;
}
/*overwrite*/
.listIcon {
	margin: 1px 35px;
}

.pstb_del {
	margin-left: 35px;
}

.item {
	height: 25px;
	padding-top: 3px;
}

.iconPut {
	background: #fff;
}

.fl_left {
	margin-right: 3px;
}

.lineToolbar {
	margin-top: 0;
}

.pro_store_tb {
	overflow-x: auto;
}

.pro_ig {
	padding-top: 5px;
	width: 1200px;
	height: 24px;
}

.fixed_div3,.fixed_div2,.fixed_div {
	width: 12.5%;
}

.CM {
	width: 100%;
}

.pro_store_tb {
	width: 100%;
}

.ws17_5 {
	width: 9%;
	*width: 17.5%;
}

.ws10 {
	width: 9%;
	*width: 10%;
}
</style>

<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<!--最后一个-->
	<div class="tagsM">门店促销信息</div>
	<div class="tags tags3 tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div class="tagsM_q  tagsM_on">创建新门店促销</div>
	<div class="tags3_close_on">
		<div class="tags_close" onclick="closeCreateStoreProm()"></div>
	</div>
</div>
<div class="Container-1">
	<div class="Content">
		<%@ include file="parts/storeArea.jsp"%>
		<%@ include file="parts/basicInfo.jsp"%>
		<%@ include file="parts/unitsArea.jsp"%>
	    <%@ include file="parts/itemsAndStoresArea.jsp"%>
	</div>
</div>
<%@ include file="parts/cloneUnitArea.jsp"%>
