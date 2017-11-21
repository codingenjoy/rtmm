<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/contract/current/current.js?t=201900910990"></script>
<script type="text/javascript" src="${ctx}/shared/js/contract/common.js?t=02200010039909121"></script>
<style>
.wauto{width:auto;}
.CM-bar_disable{
	background: #A0A3A2;
	color: #FFFFFF;
	float: left;
	height: 100%;
	width: 20px;
	line-height: 14px;
	text-align: center;
}

</style>
<div class="CTitle list">
    <div class="tags1_left tags1_left_on"></div>
    <div class="tagsM tagsM_on">已生效合同</div>
    <div class="tags tags3_r_on"></div>
    
    
    
</div>

<div class="CTitle detail">
    <!--第一个-->
    <div class="tags1_left"></div>
    <div class="tagsM">已生效合同</div>

    <div class="tags tags3 tags_right_on"></div>
    <!--一定不要忘了tag3-->
    <!--add-->
    <div class="tagsM_q  tagsM_on newTitle">创建新合同</div>
    <div class="tags3_close_on">
        <div class="tags_close" onclick="showListPage();"></div>
    </div>
</div>
<div class="Container-1">
	<div class="Search Bar_on" style="display:none;"><!-- Bar_on-->
	 	<%@ include file="/page/contract/current/left.jsp"%>
	</div>
	<div class="Content list" style="width:99%;">
 		<%@ include file="/page/contract/current/list.jsp"%>
 	</div>
	<div class="Content detail" style="width:99%;">
 	</div>
</div>
<script type="text/javascript">
var refreshFlag = 0;
$(function(){
	$('.detail').hide();
	$('#Tools1').removeClass('Tools1_disable').addClass('Tools1');
	$('#Tools11').removeClass('Tools11_disable').addClass('Tools11');
	initEnventForContract();
	inputToInputIntNumber();
	searchFormSubmit();
	enterBind();
});
</script>