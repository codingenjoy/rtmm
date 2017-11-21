<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/rtmm.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/periodsToTheTopic.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script src="${ctx}/shared/js/jumpPage.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	getIssueNatAllList();
	$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind(
		"click", function() {
			DispOrHid('B-id');
	});
	$("#Tools21").attr('class', "Icon-size1 Tools21_on");
	$($("#Tools21").parent()).addClass("ToolsBg");
	//全国性DM期数与主题(tab)
	$('#countryTab').unbind("click").bind( 'click', function() {
		//$('#Container').load(ctx + '/promotion/DMManagement/periodAndTheme');
	});
	//全国性及门店DM期数与主题(tab)
	$('#countryAndShopTab').unbind("click").bind( 'click', function() {
		$(top.document).find("#contentIframe").attr("src",ctx + '/promotion/DMManagement/promoIssueAll');
		//window.location.href=ctx + '/promotion/DMManagement/promoIssueAllList';
	});
	
	$("#Tools22").attr('class', "Icon-size1 Tools22_disable").bind("click",
		function() {
			promoIssueAllDetailedness();
	});
	$("#Tools11").attr('class', "Icon-size1 Tools11").bind("click",
			function() {
		issueFormbySetCreateNew();
		}); 

	$(".promotionTable").live("click", function(){
		$("#Tools22").attr('class', "Icon-size1 Tools22");
	});
	searchPeriodToTheTopic();
});
function getIssueNatAllList(){
	var promotionForm = $("#promotion_form").serialize();
	$.ajax({
		url: ctx + '/promotion/DMManagement/promoIssueAllListBySeries',
        type: "post",
        dataType:"html",
        data:promotionForm,
        success: function(data) {
 			$("#promotionDiv").html(data);
        }
	});
}
function createIframeDialog() {
	top.window.$.fn.zWindow({
		width : 600,
		height : 390,
		titleable : true,
		title : '选择套系',
		moveable : true,
		windowBtn : [ 'close' ],
		windowType : 'iframe',
		targetWindow : top,
		windowSrc : ctx+'/promotion/DMManagement/openPromotionWindowAction',
		resizeable : false,
		/* 关闭后执行的事件 */
		afterClose : function(data) {

		},
		isMode : true
	});
}
	$(".btable_div tr").hover(
		function () {
			$(this).addClass("btable_hover");
		},
		function () {
			$(this).removeClass("btable_hover");
		  }
	);
</script>
<style>
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on" id="countryTab" target="">全国性DM期数与主题</div>
	<div class="tags tags_left_on"></div>
	<!--最后一个-->
	<div class="tagsM" id="countryAndShopTab">全国性及门店DM期数与主题</div>
	<div class="tags tags3_r_off"></div>
</div>
<div class="Search Bar_off">
	<!-- Bar_on-->
	<form id="promotion_form" method="post">
		<div class="SearchTop">
			<span>查询条件</span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="SMiddle">
			<table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="ST_td1">
						<span>档期</span>
					</td>
					<td>
						<input name="" value="" class="w65 inputText" type="text" />
					</td>
				</tr>
				<tr>
					<td class="ST_td1">
						<span>主题</span>
					</td>
					<td>
						<input class="w85 inputText" type="text" />
					</td>
				</tr>
				<tr>
					<td>
						<span>开始日</span>
					</td>
					<td>
						<input type="text" class="Wdate w65"
							onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
						&nbsp;-
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input type="text" class="Wdate w65"
							onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
					</td>
				</tr>
				<tr>
					<td>
						<span>结束日</span>
					</td>
					<td>
						<input type="text" class="Wdate w65"
							onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
						&nbsp;-
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input type="text" class="Wdate w65"
							onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
					</td>
				</tr>
				<tr>
					<td>
						<span>计划起日</span>
					</td>
					<td>
						<input type="text" class="Wdate w65"
							onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input type="text" class="Wdate w65" name="user."
							onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
					</td>
				</tr>
				<tr>
					<td>
						<span>计划迄日</span>
					</td>
					<td>
						<input type="text" class="Wdate w65"
							onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
						&nbsp;-
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input type="text" class="Wdate w65"
							onclick="WdatePicker({ isShowClear: false, readOnly: true })" />
					</td>
				</tr>
				<tr>
					<td>
						<span>套系</span>
					</td>
					<td>
						<div class="iconPut w65 fl_left">
							<input type="text" class="w80">
							<div class="ListWin" onclick="createIframeDialog()"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input class="w85 inputText" type="text" />
					</td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20"></div>
			<div class="Icon-size1 Tools6" onclick="searchPeriodToTheTopic()"></div>
		</div>
		<input type="hidden" name="pageNo" value="1" />
		<input type="hidden" name="pageSize" value="1" />
	</form>
</div>
<div id="promotionDiv" class="Content">
 
</div>

