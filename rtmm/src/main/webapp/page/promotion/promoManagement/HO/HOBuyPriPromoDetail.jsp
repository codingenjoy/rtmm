<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp" %>
<script type="text/javascript">
	$(function() {
		$(".CTitle").html($("#promotionDetail").html());
		$("#Tools1").attr('class', "Icon-size1 Tools1_disable B-id");
		$("#Tools12").attr('class', "Icon-size1 Tools12_disable");
		$("#Tools11").attr('class', "Icon-size1 Tools11_disable");
		$("#Tools10").attr('class', "Icon-size1 Tools10_disable");
		$("#Tools21").parent().removeClass("ToolsBg");
		$("#Tools21").attr('class','Icon-size1 Tools21');
		
		$("#Tools22").parent().addClass("ToolsBg");
		$("#Tools22").attr('class','Icon-size1 Tools22_on Tools22');
		$(".Content input").attr("readonly","readonly");
		var unitType = $("#unitTypeDetail").val();
		var promNo = $("#promNoDetail").val();
		getPromCodeMessList(promNo,unitType);
		showPromSupMess();
	});
	
	$(".pcmVOClickItem").die("click").live("click",function(){
		var itemNo = $(this).attr("name");
		if ($(this).hasClass("item_on")) {
			return ;
		}
		showItemStoreSupList(itemNo,"1");
	});
</script>
 <style type="text/css">
     .psi1 {
         margin-left:40px;
     }
     .psi2 {
         margin-left:73px;
     }
     .psi3 {
         margin-left:215px;
     }
     .psi4 {
         margin-left:32px;
     }
     .psi5 {
         margin-left:15px;
     }
     /*overwrite*/
     .item:hover {
         background:#99cc66;
     }
	.fl_left{
		margin-left:3px;
	}
 </style>

<%-- <%@ include file="/page/commons/toolbar.jsp"%> --%>
<!-- <div class="CTitle">
	第一个
	<div class="tags1_left "></div>
	<div class="tagsM " id="ovreviewTab">总部进价促销</div>
	<div class="tags tags_right_on"></div>
	最后一个
	<div class="tagsM tagsM_on">总部进价促销</div>
	<div class="tags3_close_on">
		<div class="tags_close" onclick="closeCreateProm()"></div>
	</div>
</div> -->
<div class="Content">
    <div class="CInfo">
<%--             <span>项</span>
            <span>${total}</span>
            <span>/</span>
            <span>${page}</span>
            <span>第</span> --%>
        <span>|</span>
        <span>${promPeriodVO.chngBy }</span>
        <span>修改人</span>
        <span><fmt:formatDate pattern="yyyy-MM-dd" value="${promPeriodVO.chngDate }" /></span>
        <span>修改日期</span>
        <span>${promPeriodVO.chngBy }</span>
        <span>建档人</span>
        <span><fmt:formatDate pattern="yyyy-MM-dd" value="${promPeriodVO.creatDate }" /></span>
        <span>创建日期</span>
    </div>
    <div class="CM" style="height:130px;">
         <div class="inner_half">
                <div class="CM-bar"><div>促销期数基本信息</div></div>
                <div class="CM-div">
                    <div class="ig_top20">
                        <div class="icol_text w14"><span>促销期数</span></div>
                        <input id="promNoDetail" type="text" class="inputText w20" value="${promPeriodVO.promNo }" />
                    </div>
                    <div class="ig">
                        <div class="icol_text w14"><span>主题</span></div>
                        <input type="text" class="inputText w50" value="${promPeriodVO.subjName }" />
                    </div>
                    <div class="ig">
                        <div class="icol_text w14"><span>采购期间</span></div>
                        <input type="text" class="inputText w20 fl_left" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promPeriodVO.buyBeginDate }" />" /><span class="fl_left">&nbsp;-&nbsp;</span><input type="text" class="inputText w20 fl_left" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promPeriodVO.buyEndDate }" />" />
                        <div class="icol_text"><span>&nbsp;&nbsp;促销天数</span></div>
                        <input type="text" class="inputText w12_5" value="${promPeriodVO.promDays }" >
                        &nbsp;天
                    </div>
                </div>
            </div>
         <div class="inner_half">
              <div class="CM-bar"><div>促销商品基本信息</div></div>
              <div class="CM-div">
              	  <div class="ig_top20">
                  <div class="icol_text w14"><span>代号类别</span></div>
		 <auchan:select mdgroup="PROM_UNIT_BY_ST_UNIT_TYPE" _class="w25" optionsCaption="全部 " iscaption="0" onchange="selectUnitTypeClick(this)" id="unitTypeDetail" />
                 </div>
                 <div class="ig">
                     <div class="icol_text w14"><span>代号</span></div>
                     <select id="unitNoDetail" class="w50" onchange="selectUnitNoClick(this)" >
                     	<option value="" selected="selected">全部</option>
                     </select>
                 </div>
                 <div class="ig">
<!-- 	                     <div class="icol_text w14"><span>备注</span></div>
	                     <input id="memo" type="text" class="inputText w71" value="备注信息" > -->
                 </div>
              </div>
         </div>      
    </div>

    <div class="CM" style="height:406px;margin-top:2px;">
        <div class="CM-bar"><div>促销商品门店信息</div></div>
        <div id="promItemStoreDiv" class="CM-div">
        </div>
    </div>
</div>
<script type="text/javascript">
var promNoDetail=$("#promNoDetail").val();
var buyEnd="${buyEnd}";
var buyBegin="${buyBegin}";
$(function(){
if (buyEnd=='1') {
	$("#Tools12").attr('class', "Icon-size1 Tools12_disable").unbind("click");
	$("#Tools10").attr('class', "Icon-size1 Tools10_disable").unbind("click");
} else {
	$("#Tools12").attr('class', "Icon-size1 Tools12").unbind("click").bind("click", function() {
		var updatePromNo = promNoDetail;
		window.location.href = ctx + "/prom/nondm/ho/createPromotionPage?updatePromNo="+updatePromNo+"&promType=update";
	});
}
if (buyBegin=='0') {
	$("#Tools10").attr('class', "Icon-size1 Tools10").unbind("click").bind("click", function() {
		$("#searchPromotionItem").find("input").removeAttr("readonly");
		deletePromotionMessage(promNoDetail);
	});
} else {
	$("#Tools10").attr('class', "Icon-size1 Tools10_disable").unbind("click");
}

});
</script>