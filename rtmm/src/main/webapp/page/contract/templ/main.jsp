<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/contract/template/template.js"></script>
<script type="text/javascript">
$(function(){
	$('.detail').hide();
	$('#Tools1').removeClass('Tools1_disable').addClass('Tools1');
	$('#Tools11').removeClass('Tools11_disable').addClass('Tools11');
	$('#Tools21').attr('class', 'Icon-size1 Tools21_on');
	$("#Tools21").parent().addClass("ToolsBg");
	initEnventForContract();
});
</script>
<div id="templListDiv" class="CTitle ">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">系统界面模板</div>
	<div class="tags tags3_r_on"></div>
</div>

<div id="templOtherDiv" class="CTitle detail" style="display:none;">
    <!--第一个-->
    <div class="tags1_left"></div>
    <div class="tagsM" onclick="pageQuery();showListPage();">系统界面模版</div>

    <div class="tags tags3 tags_right_on"></div>
    <!--一定不要忘了tag3-->
    <!--add-->
    <div class="tagsM_q  tagsM_on newTitle"></div>
    <div class="tags3_close_on">
        <div class="tags_close" onclick="pageQuery();showListPage();"></div>
    </div>
</div>
<div class="Container-1">
	<div class="Search Bar_on" style="display:none;">
	 	<%@ include file="/page/contract/templ/left.jsp"%>
	</div>
	<div class="Content list" style="width:99%;">
		<%@ include file="/page/contract/templ/list.jsp"%>
 	</div>
	<div class="Content detail" style="width:99%;">
  	</div>
</div>
<input id="parameterTempl" type="hidden" ></input> 
