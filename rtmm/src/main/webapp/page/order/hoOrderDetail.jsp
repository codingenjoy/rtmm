<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/default.css" />

<style type="text/css">
.psi1 {
	width: 106px;
}

.psi2 {
	width: 77px;
	margin-left: 3px;
}

.psi3 {
	width: 78px;
	margin-left: 3px;
}

.psi4 {
	width: 77px;
	margin-left: 3px;
}

.psi5 {
	width: 49px;
	margin-left: 3px;
}

.psi6 {
	width: 78px;
	margin-left: 3px;
}

.psi7 {
	width: 77px;
	margin-left: 3px;
}

.psi8 {
	width: 49px;
	margin-left: 3px;
}

.psi9 {
	width: 78px;
	margin-left: 3px;
}

.psi10 {
	width: 77px;
	margin-left: 3px;
}

.psi11 {
	width: 49px;
	margin-left: 18px;
}

.psi12 {
	width: 78px;
	margin-left: 20px;
}

.pso1 {
	margin-left: 37px;
}

.pso2 {
	margin-left: 82px;
}

.pso4 {
	margin-left: 52px;
}

.pso5 {
	margin-left: 45px;
}

.pso6 {
	margin-left: 42px;
}
/*overwrite*/
.ordItem {
	height: 25px;
	padding-top: 3px;
}

.ordItem:hover {
	background: #9c6;
	color: #fff;
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

.pro_store_tb_edit {
	height: 72%;
}

.iconPut div {
	cursor: default;
}
</style>
<div class="Content">
	<div class="CInfo">
		<span><auchan:getStuffName value="${ordBasicInfo.chngBy }"/></span> <span> <auchan:i18n
				id="100002014" /> <!-- 修改人 -->
		</span> <span> <fmt:formatDate pattern="yyyy-MM-dd"
				value="${ordBasicInfo.chngDate }" />
		</span> <span> <auchan:i18n id="100002015" /> <!-- 修改日期 -->
		</span> <span><auchan:getStuffName value="${ordBasicInfo.creatBy }"/></span> <span> <auchan:i18n
				id="100002016" /> <!-- 建档人 -->
		</span> <span> <fmt:formatDate pattern="yyyy-MM-dd"
				value="${ordBasicInfo.creatDate }" />
		</span> <span> <auchan:i18n id="100002017" /> <!-- 创建日期 -->
		</span>
	</div>
	<div class="CM" style="height: 120px;">
		<div class="inner_half">
			<div class="CM-bar">
				<div>
					<auchan:i18n id="104002002" />
					<!-- 订单基本信息 -->
				</div>
			</div>
			<div class="CM-div">
				<div class="ig_top20">
					<div class="icol_text w14">
						<span> <auchan:i18n id="104002005" /> <!-- 订单号码 -->
						</span>
					</div>
					<input id="ordNo" type="text" class="inputText w50 "
						value="${ordBasicInfo.ordNo }" readonly="readonly" />
				</div>
				<div class="ig">
					<div class="icol_text w14">
						<span> <auchan:i18n id="104002006" /> <!-- 厂商 -->
						</span>
					</div>
					<!--<input type="text" class="inputText w20 fl_left" />-->
					<div class="iconPut w20 fl_left">
						<input class="w80 " type="text" value="${ordBasicInfo.supNo }"
							readonly="readonly" />
						<div class="ListWin"></div>
					</div>
					<input type="text" class="inputText w50 fl_left "
						title="${ordBasicInfo.comName }" readonly="readonly"
						value="${ordBasicInfo.comName }" />
				</div>
				<div class="ig">
					<div class="icol_text w14">
						<span> <auchan:i18n id="104002007" /> <!-- 课别 -->
						</span>
					</div>
					<div class="iconPut w20 fl_left">
						<input class="w80 " type="text" value="${ordBasicInfo.catlgId }"
							readonly="readonly" />
						<div class="ListWin"></div>
					</div>
					<input type="text" class="inputText w50 fl_left "
						readonly="readonly" value="${ordBasicInfo.catlgName }" />
				</div>
			</div>
		</div>
		<div class="inner_half">
			<div class="CM-div">
				<div class="ig_top20">
					<div class="icol_text w14">
						<span> <auchan:i18n id="104002008" /> <!-- 订单日期  -->
						</span>
					</div>
					<input type="text" class="inputText w20 fl_left "
						readonly="readonly"
						value='<fmt:formatDate pattern="yyyy-MM-dd" value="${ordBasicInfo.ordDate }"/>' />
					<span class="w12_5 fl_left"> &nbsp; <auchan:i18n
							id="104002011" /> <!-- 订单状态 -->
					</span>
					<input type="text" class="inputText w20 fl_left "
						readonly="readonly"
						value='<auchan:getDictValue code="${ordBasicInfo.ordSttus }" mdgroup="ORDERS_ORD_STTUS"></auchan:getDictValue>' />
				</div>
				<div class="ig">
					<div class="icol_text w14">
						<span> <auchan:i18n id="104002009" /> <!-- 预订收货日 -->
						</span>
					</div>
					<!--<input type="text" class="inputText w20 fl_left" />-->
					<input type="text" class="Wdate w20 fl_left " readonly="readonly"
						value='<fmt:formatDate pattern="yyyy-MM-dd" value="${ordBasicInfo.planRecptDate }"/>' />
					<span class="w12_5 fl_left "> &nbsp; <auchan:i18n
							id="104002012" /> <!-- 进价折扣 -->
					</span>
					<input type="text" readonly="readonly"
						class="inputText w10 fl_left align_right"
						value="${ordBasicInfo.bpDisc }" />
					&nbsp;%
				</div>
				<div class="ig">
					<div class="icol_text w14">
						<span> <auchan:i18n id="104002010" /> <!-- 采购 -->
						</span>
					</div>
					<input type="text" class="inputText w20 fl_left "
						value="${ordBasicInfo.buyerName }" readonly="readonly" />
					<span class="w12_5 fl_left"> &nbsp; <auchan:i18n
							id="104002013" /> <!-- 备注 -->
					</span>
					<input type="text" class="inputText w40 fl_left "
						value="${ordBasicInfo.memo }" readonly="readonly" />
				</div>
			</div>
		</div>
	</div>

	<div class="CM" style="height: 180px; margin-top: 2px;">
		<div class="CM-bar">
			<div>
				<auchan:i18n id="104002003" />
				<!-- 订单商品 -->
			</div>
		</div>
		<div class="CM-div">
			<div class="pro_store_item">
				<div class="tb_tits">
					<span class="pso1"> <auchan:i18n id="104002014" /> <!-- 货号 --> </span> 
					<span class="pso2"> <auchan:i18n id="104002015" /> <!-- 品名 --> </span> 
					<%-- <span class="pso3"> <auchan:i18n id="104002016" /> <!-- 英文名 --> </span>  --%>
					<span class="pso2" style="margin-left: 90px;"> <auchan:i18n id="104002017" /> <!-- 销售单位 --> </span>
					<span class="pso4"> <auchan:i18n id="104002018" /> <!-- 採購方式 --> </span> 
					<span class="pso4"> <auchan:i18n id="104002019" /> <%-- 成本时点 --%> </span>
					<span class="pso4">总订购量 </span>
					<span class="pso5">总赠品数量</span>
					<span class="pso6">总在途量</span>
					<span class="pso4">总库存量</span>
				</div>
				<div class="pro_store_tb_edit w100">
					<c:forEach items="${OrditemInfo}" var="orderItem">
						<div class="ordItem"
							onclick="itemInfoByStore(${orderItem.itemNo },this)">
							<input type="text" class="inputText pedit_f  w8" id="itemNo"
								readonly="readonly" value="${orderItem.itemNo }" />
							<input type="text" readonly="readonly"
								title="${orderItem.itemName }" class="inputText w17 fl_left "
								value="${orderItem.itemName }" />
							<input type="text" readonly="readonly"
								class="inputText w7 fl_left "
								value="${orderItem.sellUnitTitle}" />
							<input type="text" readonly="readonly"
								class="inputText w10 pedit_fth "
								value='<auchan:getDictValue code="${orderItem.buyMethd }" mdgroup="ITEM_BASIC_BUY_METHD"></auchan:getDictValue>' />
							<input readonly="readonly" type="text"
								class="inputText w10 fl_left "
								value='<auchan:getDictValue code="${orderItem.buyWhen }" mdgroup="ITEM_BASIC_BUY_WHEN"></auchan:getDictValue>' />
							<input type="text" readonly="readonly" class="inputText w10 fl_left align_right"
								value="${orderItem.ordQtyAmnt}" />
							<input type="text" readonly="readonly" class="inputText w10 fl_left align_right"
								value="<fmt:formatNumber value="${orderItem.presOrdQtyAmnt}" pattern="#.###" minFractionDigits="3"/>" />
							<input type="text" readonly="readonly" class="inputText w10 fl_left align_right"
								value="<fmt:formatNumber value="${orderItem.recvBleQtyAmnt}" pattern="#.###" minFractionDigits="3"/>" />
							<input type="text" readonly="readonly" class="inputText w10 fl_left align_right"
								value="<fmt:formatNumber value="${orderItem.stockAmnt}" pattern="#.###" minFractionDigits="3"/>" />	
						</div>
					</c:forEach>
				</div>
				<div class="ig_top10">
					<!-- 
						<div class="first_ztdb createNewBar fl_left"></div>
						<div class="lineToolbar fl_left"></div>
						<div class="copyBar fl_left"></div>
						 -->
				</div>
			</div>
		</div>
	</div>
	<div class="CM" style="height: 230px; margin-top: 2px;">
		<div class="CM-bar">
			<div>
				<auchan:i18n id="104002004" />
				<!-- 订单商品分店信息 -->
			</div>
		</div>
		<div class="CM-div">
			<div class="pro_store_item">

				<div class="tb_tits">
					<span class="psi1"> <auchan:i18n id="104002020" /> <!-- 分店 -->
					</span> <span class="psi2"> <auchan:i18n id="104002021" /> <!-- 商品状态 -->
					</span> <span class="psi3"> <auchan:i18n id="104002022" /> <!-- 促销期数 -->
					</span> <span class="psi4"> <auchan:i18n id="104002023" /> <!-- 订购数量 -->
					</span> <span class="psi5"> <auchan:i18n id="104002024" /> <!-- 赠品数量 -->
					</span> <span class="psi6"> <auchan:i18n id="104002025" /> <!-- 买价(元) -->
					</span> <span class="psi7"> <auchan:i18n id="104002026" /> <!-- 订购倍数 -->
					</span> <span class="psi8"> <auchan:i18n id="104002027" /> <!-- 税率 -->
					</span> <span class="psi9"> <auchan:i18n id="104002028" /> <!-- 净成本(元) -->
					</span> <span class="psi10"> <auchan:i18n id="104002029" /> <!-- 均销量 -->
					</span> <span class="psi11"> <auchan:i18n id="104002030" /> <!-- 在途量 -->
					</span> <span class="psi12"> <auchan:i18n id="104002031" /> <!-- 库存量 -->
					</span>
				</div>
				<!-- <div class="fu_div">
						<input type="text" class="inputText w8"
							style="margin-left: 257px;" /> <input type="text"
							class="inputText w8" />
					</div> -->
				<div id="storeList" class="pro_store_tb">
				</div>
				</div>	
				<div class="top5">
					<!-- 
						<input class="fl_left top3" type="checkbox" />
						<div class="deleteBar fl_left"></div>
						<div class="lineToolbar fl_left"></div>
						<div class="listBar fl_left"></div>
						 -->
				</div>
			</div>
		</div>
	</div>
<!-- </div> -->
<script src="${ctx}/shared/js/order/hoOrderDetail.js"
	type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	toolbar.disable('Tools11');
	enableSingleOrderDelete();
	enableSingleOrderEdit();	
		
	// 按下"總部訂單信息"標籤 和 "close icon" 時, 隱藏詳細頁面, 顯示列表頁面
	$(".tags_close, #hoOrderList").off("click").on("click",function(){
		switchToListView();
	});
	
	// 預設選定顯示第一支商品 
	$('.pro_store_tb_edit .ordItem:first').click();
});

// 允許刪除此筆訂單
function enableSingleOrderDelete(){
	toolbar.disable('Tools10');
	<auchan:operauth ifAnyGrantedCode="113111998">
	toolbar.enable('Tools10', function(){
		top.jConfirm('是否要删除此订单?', '提示消息', function(ret) {
			if (ret) {
				deleteThisOrder();
				return;
			}
			else{
				return;
			}
		});
	});
	</auchan:operauth>
}

//允許修改此筆訂單
function enableSingleOrderEdit(){
	toolbar.disable('Tools12');
	<auchan:operauth ifAnyGrantedCode="113111998">
	toolbar.enable('Tools12', function(){
		var param = {'ordNo' : $(".CM-div #ordNo").val(),'action':'update'};
		var url = ctx + "/hoOrderCreateNew/hoOrderCreatePage";
		$.post(url, param, function(data) {
			$("#content").html(data);
		}, 'html'); 
	});
	</auchan:operauth>
}
</script>