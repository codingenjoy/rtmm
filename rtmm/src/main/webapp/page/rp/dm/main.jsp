<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/rp/dm/dm.js"></script>
<style type="text/css">
        .align_right {
            padding-right:10px;
        }
</style>
<div class="CTitle list">
    <div class="tags1_left tags1_left_on"></div>
    <div class="tagsM tagsM_on">RP_DM</div>
    <div class="tags tags3_r_on"></div>
</div>

<div class="Container-1">
<form id="searchForm" action="/rp/dm/search" onsubmit="searchFormSubmit();return false;">
	<div class="Search Bar_on" style="display: none"><!-- Bar_on-->
	 	<%@ include file="/page/rp/dm/left.jsp"%>
	</div>
	<div class="Content list" style="width:100%;">
 	</div>
</form>
</div>

<script type="text/javascript">
$(function(){
	initEnventForDm();
	showListPage();
	//默认查询数据
	searchFormSubmit();
	enterBind();
});
</script>