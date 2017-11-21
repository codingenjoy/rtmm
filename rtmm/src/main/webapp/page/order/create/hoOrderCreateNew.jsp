<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" rel="Stylesheet" />
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js"></script>

<script type="text/javascript" src="${ctx}/shared/js/order/prototype_rowBasedCanvas.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/order/prototype_orderItemsCanvas.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/order/prototype_orderItemStoresCanvas.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/order/prototype_HOOrderMgmtHandler.js"></script>

<script type="text/javascript" src="${ctx}/shared/js/order/hoOrderCreate_Page.js"></script>

<style type="text/css">
.errorInput {
	border-color: #f00 !important;
	background-color: #FFC1C1 !important;
}
.psi1 {
	margin-left: 52px;
}

.psi2 {
	margin-left: 55px;
}

.psi3 {
	margin-left: 27px;
}

.psi4 {
	margin-left: 25px;
}

.psi5 {
	margin-left: 25px;
}

.psi6 {
	margin-left: 28px;
}

.psi6_2 {
	margin-left: 20px;
}

.psi7 {
	margin-left: 12px;
}

.psi8 {
	margin-left: 26px;
}

.psi9 {
	margin-left: 25px;
}

.psi10 {
	margin-left: 32px;
}

.psi11 {
	margin-left: 30px;
}

.pso1 {
	margin-left: 37px;
}

.pso2 {
	margin-left: 80px;
}

.pso3 {
	margin-left: 174px;
}

.pso4 {
	margin-left: 48px;
}

.pso5 {
	margin-left: 40px;
}

.pso6 {
	margin-left: 35px;
}
/*overwrite*/
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
	margin-left: 3px;
	margin-right: 6px;
}

.pedit_f {
	float: left;
	margin-left: 10px;
	margin-right: 3px;
}

.pedit_fth {
	float: left;
	width: 10%;
	text-align: left;
	margin-right: 3px;
}

.ig,.ig_top20 {
	line-height: 25px;
}

.pro_store_tb input[type="checkbox"] {
	margin-top: 5px;
}

.pro_store_tb .ig_padding {
	width: 940px;
	height: 25px;
	padding-top: 3px;
}

.s_tit2,.s_tit .fu_div {
	width: 940px;
	padding-right: 20px;
}

.pro_store_item .store_tb2 {
	overflow-x: auto;
}

.s_tit {
	margin-top: 15px;
	width: 100%;
	overflow: hidden;
}

.store_on {
	background-color: #3F9673;
	color: #fff;
}

.pro_store_item .fu_div .ListWin {
	background: url(../rtmm/shared/themes/theme1/images/copy.png) no-repeat center;
}
</style>

<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div class="tagsM" id="hoOrderTag">总部订单信息</div>
	<div class="tags tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div class="tagsM_q  tagsM_on">
	<c:if test="${action =='create' }">
		创建新总部订单
	</c:if>
	<c:if test="${action =='update' }">
		修改新总部订单
	</c:if>
	</div>
	<div class="tags3_close_on">
		<div class="tags_close"></div>
	</div>
</div>
<div class="Container-1">
	<div class="Content">
		<%@ include file="parts/orderBasicInfo_panel.jsp" %>
		<%@ include file="parts/orderItems_panel.jsp" %>
		<%@ include file="parts/orderItemStores_panel.jsp" %>
	</div>
</div>
<div id="orderItemTemplate" style="display: none;">
	<jsp:include page="/page/order/create/template/hoOrderItemTemplate.jsp"></jsp:include>
</div>
<div id="orderItemStoreTemplate" style="display: none;">
	<jsp:include page="/page/order/create/template/hoOrderItemStoreTemplate.jsp"></jsp:include>
</div>

<script type="text/javascript">
	$(function(){
		if('update'==$('#action').val() && $.trim($('#ordNo').val())!=''){
			//修改的时候，根据订单号加载商品
			loadItemByOrdNo($.trim($('#ordNo').val()));
			//修改的时候，设置厂商和课别不可以修改
			$('#catlgId').attr('readonly',true);
			$('#catlgId').addClass('Black').addClass('w100');
			$('#catlgId').next().remove();
			$('#supNo').attr('readonly',true);
			$('#supNo').addClass('Black').addClass('w100');
			$('#supNo').next().remove();
		}

		$('#orderItemStoreList').find('input').off().on('focus',function(){
			$(self).attr('title', '');
			$(self).removeClass('errorInput');
		});
		
	});
	
	$('.store_tb2').scroll(function() {
		var left = $(this).scrollLeft();
		$(".s_tit").scrollLeft(left);
	});

	$("#Tools2").attr('class', "Tools2").unbind('click').bind("click",function() {
		preSaveOrder();
	});

	$("#Tools23").attr('class', "Tools23").unbind('click').bind("click",function() {
		$.post(ctx + '/order/uploadTemplateNew', function(data) {
			$('#content').html(data);
		});
	});

	$("#hoOrderTag, .tags_close").unbind("click").bind("click", function() {
		showContent("${ctx}/order/hoOrder");
	});

	
</script>