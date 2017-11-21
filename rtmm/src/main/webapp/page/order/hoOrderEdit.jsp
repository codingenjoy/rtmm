<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/loading/loading.css" />
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js" ></script>
<script type="text/javascript" src="${ctx}/shared/js/order/hoOrderEdit.js" ></script>
<script type="text/javascript" src="${ctx}/shared/js/order/hoOrderCommon.js" ></script>
<script type="text/javascript" src="${ctx}/shared/js/loading/loading.js" charset="utf-8"></script>
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
	margin-left: 39px;
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
	margin-left: 35px;
}

.psi11 {
	margin-left: 30px;
}

.pso1 {
	margin-left: 67px;
}

.pso2 {
	margin-left: 120px;
}

.pso3 {
	margin-left: 174px;
}

.pso4 {
	margin-left: 135px;
}

.pso5 {
	margin-left: 50px;
}

.pso6 {
	margin-left: 65px;
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
	width: 10%;
	margin-left: 30px;
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
}

.s_tit2,.s_tit .fu_div {
	width: 940px;
	padding-right: 20px;
}

.s_tit {
	margin-top: 15px;
	width: 100%;
	overflow: hidden;
}
</style>

<script type="text/javascript">
	$(function() {
		orderItemArr = ${orderItemArray};
		$("#storeDetailInfo").scroll(function(e) {
			var left = $(e.target).scrollLeft();
			//alert(left);
			$("#gstore").scrollLeft(left);
		});
	});
</script>

<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div class="tagsM">
		<auchan:i18n id="104001001"></auchan:i18n>
	</div>
	<div class="tags tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div class="tagsM_q  tagsM_on">修改总部订单</div>
	<div class="tags3_close_on">
		<div class="tags_close"></div>
	</div>
</div>
	<div class="Container-1">
		<div class="Content">
			<div class="CInfo">
				<span>${ordBasicInfo.chngBy }</span> <span><auchan:i18n id="100002014"></auchan:i18n></span> <span><fmt:formatDate
						pattern="yyyy-MM-dd" value="${ordBasicInfo.chngDate }" /></span> <span><auchan:i18n id="100002015"></auchan:i18n></span>
				<span>${ordBasicInfo.creatBy }</span> <span><auchan:i18n id="100002016"></auchan:i18n></span> <span><fmt:formatDate
						pattern="yyyy-MM-dd" value="${ordBasicInfo.creatDate }" /></span> <span><auchan:i18n id="100002017"></auchan:i18n></span>
			</div>
			<div class="CM" style="height: 120px;">
				<div class="inner_half">
					<div class="CM-bar">
						<div><auchan:i18n id="104002002"></auchan:i18n></div>
					</div>
					<div class="CM-div">
						<div class="ig_top20">
							<div class="icol_text w14">
								<span><auchan:i18n id="104002005"></auchan:i18n></span>
							</div>
							<input type="text" id="ordNo" class="inputText w50 Black"
								readOnly value="${ordBasicInfo.ordNo }" />
						</div>
						<div class="ig">
							<div class="icol_text w14">
								<span>*<auchan:i18n id="104002007"></auchan:i18n></span>
							</div>
							<div class="iconPut w20 fl_left">
								<input class="w80" type="text" id="catlgId" name='catlgIdQuery'
									value="${ordBasicInfo.catlgId }" readonly="readonly" />
								<div class="ListWin" name="catlgId"></div>
							</div>
							<input type="text" class="inputText w50 fl_left Black" readOnly
								id="addCatlgName" name="addCatlgName"
								value="${ordBasicInfo.catlgName }" />
						</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>*<auchan:i18n id="104002006"></auchan:i18n></span>
						</div>
						<!--<input type="text" class="inputText w20 fl_left" />-->
						<div class="iconPut w20 fl_left">
<%-- 							<input type="hidden" id="comNo" name="comNo"
								value="${ordBasicInfo.supComNo }" /> --%>
								<input type="hidden"
								id="supUnifmNo" name="supUnifmNo"
								value="${ordBasicInfo.supUnifmNo }" />  <input type="hidden"
								id="supType" name="supType" value="${ordBasicInfo.supType }" />

							<input class="w80" type="text" id="supId"
								value="${ordBasicInfo.supNo }" readonly="readonly" />
							<div class="ListWin" name="supId"></div>
						</div>
						<input type="text" class="inputText w50 fl_left Black"
							id="addSupName" name="addSupName" readOnly
							value="${ordBasicInfo.comName }" />
					</div>
				</div>
			</div>

			<div class="inner_half">
				<div class="CM-div">
					<div class="ig_top20">
						<div class="icol_text w14">
							<span><auchan:i18n id="104002008"></auchan:i18n></span>
						</div>
						<input type="text" class="inputText w20 fl_left Black"
							id="orderDate" name="orderDate" readOnly
							value='<fmt:formatDate pattern="yyyy-MM-dd" value="${ordBasicInfo.ordDate }"/>' />
						<span class="w12_5 fl_left">&nbsp;<auchan:i18n
								id="1040020011"></auchan:i18n></span> <input type="text"
							class="inputText w20 fl_left Black" name="orderStatusName"
							readonly="readonly"
							value='<auchan:getDictValue code="${ordBasicInfo.ordSttus }" mdgroup="ORDERS_ORD_STTUS"></auchan:getDictValue>' />
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>*<auchan:i18n id="104002009"></auchan:i18n></span>
						</div>
						<!--<input type="text" class="inputText w20 fl_left" />-->
						<input type="text" class="Wdate w20 fl_left" id="planRecptDate"
							name="planRecptDate" 
							onclick="WdatePicker({isShowClear: false, readOnly: true, onpicking:function(dp){dateChangeConfirm(dp);} })"
							value='<fmt:formatDate pattern="yyyy-MM-dd" value="${ordBasicInfo.planRecptDate }"/>' />
						<span class="w12_5 fl_left">&nbsp;<auchan:i18n
								id="104002012"></auchan:i18n></span> <input type="text"
							class="inputText w20 fl_left Black" id="bpDisc" name="bpDisc"
							readonly="readonly" value="${ordBasicInfo.bpDisc }" />&nbsp;% <%-- <input
							type="hidden" id="invDisc" name="invDisc"
							value="${ordBasicInfo.invDisc }" /> <input type="hidden"
							id="discMemo" name="discMemo" value="${ordBasicInfo.discMemo}" /> --%>
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span><auchan:i18n id="104002010"></auchan:i18n></span>
						</div>
						<input type="text" id="buyerName" name="buyerName" value=""
							readonly="readonly" class="inputText w20 fl_left Black" /> <input
							type="hidden" id="buyer" name="buyer" value=""
							readonly="readonly" class="inputText w20 fl_left Black" />
						<div class="icol_text w12_5">
							<span><auchan:i18n id="104002013"></auchan:i18n></span>
						</div>
						<input type="text" name="demo" id="demo"
							class="inputText w20 fl_left" value="${ordBasicInfo.memo }"
							maxlength="30" />
					</div>
				</div>
			</div>
		</div>

		<div class="CM" style="height: 180px; margin-top: 2px;">
			<div class="CM-bar">
				<div>
					<auchan:i18n id="104002003"></auchan:i18n>
				</div>
			</div>
			<div class="CM-div">
				<div class="pro_store_item hoOrderEditStore">
					<div class="top15">
						<span class="pso1"><auchan:i18n id="104002014"></auchan:i18n></span><span
							class="pso2"><auchan:i18n id="104002015"></auchan:i18n></span> <span
							class="pso3"><auchan:i18n id="104002016"></auchan:i18n></span><span
							class="pso4"><auchan:i18n id="104002017"></auchan:i18n></span> <span
							class="pso5"><span class="pso5"><auchan:i18n
									id="104002018"></auchan:i18n></span></span><span class="pso6"><auchan:i18n
								id="104002019"></auchan:i18n></span>
					</div>
					<div class="pro_store_tb_edit w100" id="pro_store_tb_edit">
						<c:forEach items="${OrditemInfo}" var="orderItem">
							<div class="item">
								<input type="hidden" value="${orderItem.itemType }"
									name="itemType" /> <input type="text"
									class="inputText pedit_f Black " id="itemNo" name='itemNo'
									readonly="readonly" value="${orderItem.itemNo }" /> <input
									type="text" name='itemName' readonly="readonly"
									title="${orderItem.itemName }"
									class="inputText w20 fl_left Black"
									value="${orderItem.itemName }" /> <input type="text"
									readonly="readonly" name='itemEnName'
									title="${orderItem.itemEnName }"
									class="inputText w25 fl_left Black"
									value="${orderItem.itemEnName }" /> <input type="text"
									readonly="readonly" name='sellUnit'
									class="inputText w10 fl_left Black"
									value="${orderItem.sellUnitDesc }" /> <input type="text"
									readonly="readonly" name='buyMethd'
									class="inputText pedit_fth Black"
									value="${orderItem.buyMethd }-${orderItem.buyMethdDesc }" /> <input
									readonly="readonly" type="text" name='buyWhen' id="buyWhen"
									class="inputText w15 fl_left Black"
									value="${orderItem.buyWhen }-${orderItem.buyWhenDesc }" />
								<div class='pstb_del'></div>
							</div>

						</c:forEach>
					</div>
					<div class="ig_top10">
						<div class="first_ztdb createNewBar fl_left" name="addOrderItem"></div>
						<div class="lineToolbar fl_left"></div>
						<div class="copyBar fl_left" name="addOrderPasteItem"></div>
						<div class="lineToolbar fl_left"></div>
						<div class="listBar fl_left" name="addOrderPopWin"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="CM" style="height: 230px; margin-top: 2px;">
			<div class="CM-bar">
				<div>
					<auchan:i18n id="104002004"></auchan:i18n>
				</div>
			</div>
			<div class="CM-div">
				<div class="pro_store_item hoOrderEditStore">
					<div id="gstore"> 
						<div class="tits">
							<div class="s_tit2">
								<span class="psi1"><auchan:i18n id="104002020"></auchan:i18n></span><span
									class="psi2"><auchan:i18n id="104002021"></auchan:i18n></span>
								<span class="psi3"><auchan:i18n id="104002022"></auchan:i18n></span><span
									class="psi4"><auchan:i18n id="104002023"></auchan:i18n></span>
								<span class="psi5"><auchan:i18n id="104002024"></auchan:i18n></span><span
									class="psi6"><auchan:i18n id="104002025"></auchan:i18n></span>
								<span class="psi6_2"><auchan:i18n id="104002026"></auchan:i18n></span>
								<span class="psi7"><auchan:i18n id="104002027"></auchan:i18n></span><span
									class="psi8"><auchan:i18n id="104002028"></auchan:i18n></span>
								<span class="psi9"><auchan:i18n id="104002029"></auchan:i18n></span></span><span
									class="psi10"><auchan:i18n id="104002030"></auchan:i18n></span>
								<span class="psi11"><auchan:i18n id="104002031"></auchan:i18n></span>
							</div>
							<div class="fu_div" id="batchEdit">
								<input type="text" class="inputText w7 ordMultiParmBody"
									style="margin-left: 273px;" /> <input type="text"
									class="inputText w7  promotionalItemsBody" /> <input
									type="text" class="inputText w10  buyPriceChangeBody Black"
									readonly="readonly" />
							</div>
						</div>
 					</div> 
					<div id="storeDetailInfo" class="pro_store_tb"
						style="height: 65%;"></div>
					<div class="top5">
						<input class="fl_left top3 checkAll" name="storeNoCk" type="checkbox" />
						<div class="deleteBar fl_left deleteBar"></div>
						<div class="lineToolbar fl_left"></div>
						<div class="listBar fl_left showStoresBar"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="orderItemTemplate" style="display: none;">
	<div class='item'>
		<input type='hidden' name='itemType' value='' /> <input type='text'
			name='itemNo' value="" class='inputText pedit_f mustInput' length=8 />
		<input type='text' readonly='readonly' name='itemName' value=''
			class='inputText w20 fl_left Black' /> <input type='text'
			readonly='readonly' name='itemEnName' value=''
			class='inputText w25 fl_left Black' /> <input type='text'
			readonly='readonly' name='sellUnit' value=''
			class='inputText w10 fl_left Black' /> <input type='text'
			readonly='readonly' name='buyMethd' value=''
			class='inputText pedit_fth Black' /> <input type='text'
			readonly='readonly' name='buyWhen' value=''
			class='inputText w15 fl_left Black' realvalue='' />
		<div class='pstb_del'></div>
	</div>
</div>
<script type="text/javascript">
	$(".tags_close").unbind("click").bind("click", function() {
		showContent("${ctx}/order/hoOrder");
	});
</script>