<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/contract/common.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/contract/template/validate.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/contract/history/main.js?t=0220001003990912"></script>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.fl_left{
	margin-right:3px;
} 
</style>
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">历史合同查询</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1" id="detailViewCon">
	<div class="Content search">
		<form id="searchForm">
			<%@ include file="/page/contract/history/detail.jsp"%>
		</form>
	</div>
	<div class="Content detail" style="width: 99%;"></div>
</div>
<div class="Container-1" id="listViewCon" style="display:none;">
</div>
