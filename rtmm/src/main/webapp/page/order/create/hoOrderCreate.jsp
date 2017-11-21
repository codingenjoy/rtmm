<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <link type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" rel="Stylesheet" />
    <link type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" rel="Stylesheet" />
    <script type="text/javascript" src="${ctx}/shared/js/iframeContent.js" ></script>
    
 
 <%-- <%@ include file="/page/order/create/hoOrderCreateJs.jsp"%> --%>
   
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

.pro_store_item .store_tb2 {
	overflow-x: auto;
}

.s_tit {
	margin-top: 15px;
	width: 100%;
	overflow: hidden;
}

.pro_store_item .fu_div .ListWin {
	/* background: url(../images/copy.png) no-repeat center; */
	background: url(../rtmm/shared/themes/theme1/images/copy.png) no-repeat center;
}
</style>


<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div class="tagsM" id="hoOrderTag"><auchan:i18n id="104001001"></auchan:i18n></div>
	<div class="tags tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div class="tagsM_q  tagsM_on">创建新总部订单</div>
	<div class="tags3_close_on">
		<div class="tags_close"></div>
	</div>
</div>
<div class="Container-1">
	<div class="Content">

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
						<input type="text" readonly="readonly" class="inputText w50 Black" />
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>*<auchan:i18n id="104002007"></auchan:i18n></span>
						</div>
						<div class="iconPut w20 fl_left">
							<input class="w80" type="text" id="catlgId" name='catlgIdQuery'
								value="<c:if test="${not empty initCatId.catlgId}">${initCatId.catlgId}</c:if>" />
							<div class="ListWin" name="catlgId"></div>
						</div>
						<input type="text" class="inputText w50 fl_left Black"
							id="addCatlgName" name="addCatlgName" readonly="readonly"
							value="<c:if test="${not empty initCatId.catlgName}">${initCatId.catlgName}</c:if>" />
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>*<auchan:i18n id="104002006"></auchan:i18n></span>
						</div>
						<input type="hidden" id="comNo" name="comNo" /> <input
							type="hidden" id="supUnifmNo" name="supUnifmNo" /> <input
							type="hidden" id="supType" name="supType" />


						<div class="iconPut w20 fl_left">
							<input type="text" class="w80" id="supId" name="supIdQuery" />
							<div class="ListWin" name="supId"></div>
						</div>
						<input type="text" class="inputText w50 fl_left Black"
							id="addSupName" name="addSupName" readonly="readonly" />
					</div>

				</div>
			</div>
			<div class="inner_half">
				<div class="CM-div">
					<div class="ig_top20">
						<div class="icol_text w15">
							<span><auchan:i18n id="104002008"></auchan:i18n></span>
						</div>
						<input type="text" id="orderDate" name="orderDate"
							value="${orderDate }" readonly="readonly"
							class="inputText w20 fl_left Black" /> <span
							class="w12_5 fl_left">&nbsp;<auchan:i18n id="104002011"></auchan:i18n></span> <input type="text"
							name="orderStatusName"
							value="<auchan:getDictValue code='${orderStatus}' mdgroup='ORDERS_ORD_STTUS' />"
							readonly="readonly" class="inputText w20 fl_left Black" /> <input
							type="hidden" name="orderStatus" value="${orderStatus }"
							readonly="readonly" class="inputText w20 fl_left Black" />
					</div>
					<div class="ig">
						<div class="icol_text w15">
							<span>*<auchan:i18n id="104002009"></auchan:i18n></span>
						</div>
						<!--<input type="text" class="inputText w20 fl_left" />-->
						<input type="text" id="planRecptDate" name="planRecptDate"
							class="Wdate w20 fl_left" 
							onclick="WdatePicker({isShowClear: false,readOnly: true, onpicking:function(dp){dateChangeConfirm(dp);} })" />
						<span class="w12_5 fl_left">&nbsp;<auchan:i18n id="104002012"></auchan:i18n></span> <input type="text"
							id="bpDisc" name="bpDisc" class="inputText w20 fl_left Black"
							readonly="readonly" />&nbsp;% <input type="hidden" id="invDisc"
							name="invDisc" /> <input type="hidden" id="discMemo"
							name="discMemo" />
					</div>
					<div class="ig">
						<div class="icol_text w15">
							<span><auchan:i18n id="104002010"></auchan:i18n></span>
						</div>
						<input type="text" id="buyerName" name="buyerName" value=""
							readonly="readonly" class="inputText w20 fl_left Black" /> <input
							type="hidden" id="buyer" name="buyer" value=""
							readonly="readonly" class="inputText w20 fl_left Black" /> <span
							class="w12_5 fl_left">&nbsp;<auchan:i18n id="104002013"></auchan:i18n></span> <input type="text"
							name="demo" id="demo" class="inputText w30" maxlength="30" />
					</div>
				</div>
			</div>
		</div>

		<div class="CM" style="height: 180px; margin-top: 2px;">
			<div class="CM-bar">
				<div><auchan:i18n id="104002003"></auchan:i18n></div>
			</div>
			<div class="CM-div">
				<div class="pro_store_item hoOrderCreateStore">
					<div class="top15">
						<span class="pso1"><auchan:i18n id="104002014"></auchan:i18n></span><span class="pso2"><auchan:i18n id="104002015"></auchan:i18n></span> <span
							class="pso3"><auchan:i18n id="104002016"></auchan:i18n></span><span class="pso4"><auchan:i18n id="104002017"></auchan:i18n></span> <span
							class="pso5"><auchan:i18n id="104002018"></auchan:i18n></span><span class="pso6"><auchan:i18n id="104002019"></auchan:i18n></span>
					</div>
					<div class="pro_store_tb_edit w100" id="pro_store_tb_edit"></div>
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
		<div class="CM" style="height: 290px; margin-top: 2px;">
			<div class="CM-bar">
				<div><auchan:i18n id="104002004"></auchan:i18n></div>
			</div>
			<div class="CM-div">
				<div class="pro_store_item hoOrderCreateStore">
					<div class="s_tit">
						<div class="s_tit2">
							<span class="psi1"><auchan:i18n id="104002020"></auchan:i18n></span><span class="psi2"><auchan:i18n id="104002021"></auchan:i18n></span> <span
								class="psi3"><auchan:i18n id="104002022"></auchan:i18n></span><span class="psi4"><auchan:i18n id="104002023"></auchan:i18n></span> <span
								class="psi5"><auchan:i18n id="104002024"></auchan:i18n></span><span class="psi6"><auchan:i18n id="104002025"></auchan:i18n></span> <span
								class="psi6_2"><auchan:i18n id="104002026"></auchan:i18n></span> <span class="psi7"><auchan:i18n id="104002027"></auchan:i18n></span><span
								class="psi8"><auchan:i18n id="104002028"></auchan:i18n></span> <span class="psi9"><auchan:i18n id="104002029"></auchan:i18n></span></span><span
								class="psi10"><auchan:i18n id="104002030"></auchan:i18n></span> <span class="psi11"><auchan:i18n id="104002031"></auchan:i18n></span>
						</div>

						<div class="fu_div">
							<!-- <input type="text" class="inputText w7 ordMultiParmBody" style="margin-left: 274px;" /> -->
							<div class="iconPut w7 fl_left" style="margin-left: 274px;">
								<input type="text" class="inputText w60 ordMultiParmBody" style="width:40px; border:none;" value="">
									<div class="ListWin" onclick="pasteOrdQty()"></div>
							</div>
							<input type="text" class="inputText w7  promotionalItemsBody" />
							<input type="text"
								class="inputText w10  buyPriceChangeBody Black"
								readonly="readonly" />
						</div>

					</div>
					<div class="pro_store_tb store_tb2" style="height: 65%;"></div>
					<div class="top5">
						<input class="fl_left top3 checkAll" name="storeNoCk" type="checkbox" />
						<div class="deleteBar fl_left"></div>
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

<script type="text/javascript" src="${ctx}/shared/js/order/hoOrderCommon.js" ></script>
<script type="text/javascript" src="${ctx}/shared/js/order/hoOrderCreate.js" ></script>
<script type="text/javascript">

	$('.store_tb2').scroll(function () {
        var left = $(this).scrollLeft();
        $(".s_tit").scrollLeft(left);
    });
	
	$("#Tools23").attr('class', "Tools23").unbind('click').bind("click", function() {
		$.post(ctx+'/order/uploadTemplateNew',function(data){
			$('#content').html(data);
		});
	});
	
	$("#hoOrderTag, .tags_close").unbind("click").bind("click",function(){
		showContent("${ctx}/order/hoOrder");
	});
</script>
		