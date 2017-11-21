<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/rp/plan/plan.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/rp/plan/planLeft.js"></script>
<div class="CTitle list">
    <div class="tags1_left tags1_left_on"></div>
    <div class="tagsM tagsM_on">保留计划</div>
    <div class="tags tags3_r_on"></div>
</div>

<div class="CTitle detail" style="display:none;">
    <!--第一个-->
    <div class="tags1_left"></div>
    <div class="tagsM">保留计划</div>
    <div class="tags tags3 tags_right_on"></div>

    <!--add-->
    <div class="tagsM_q tagsM_on newTitle">修改保留计划</div>
    <div class="tags3_close_on">
        <div class="tags_close" onclick="showList();"></div>
    </div>
</div>

<div class="Container-1">
<form id="searchForm" action="/rp/plan/serarch" onsubmit="searchFormSubmit();return false;">
	<div class="Search Bar_on" id="leftDiv" style="display:none;"><!-- Bar_on-->
	 	<%@ include file="/page/rp/plan/left.jsp"%>
	</div>
	<div class="Content list" id="listDiv" style="width:99%;">
 		<%@ include file="/page/rp/plan/list.jsp"%>
 	</div>
</form>
	<div class="Content detail" id="detailDiv" style="width:99%;">
	
 	</div>
</div>

<script type="text/javascript">
$(function(){
	$('.detail').hide();
	//绑定保留计划列表的toolbar时间
	initEnventForPlan();
	showListToolbarPage();
	showListPage();
	
	$(window).unload(function() {
		//0.清理资源;
		p.destroy();
	});
});
</script>