<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/default.css" />
<link href="${ctx}/shared/js/freezenColums/f.css" rel="stylesheet"
	type="text/css" />
<script src="${ctx}/shared/js/freezenColums/f.js" type="text/javascript"></script>

<style type="text/css">
.psi1 {
	margin-left: 42px;
}

.psi2 {
	margin-left: 53px;
}

.psi3 {
	margin-left: 43px;
}

.psi4 {
	margin-left: 43px;
}

.psi5 {
	margin-left: 26px;
}

.psi6 {
	margin-left: 35px;
}

.psi7 {
	margin-left: 43px;
}

.psi8 {
	margin-left: 38px;
}

.psi9 {
	margin-left: 32px;
}

.psi10 {
	margin-left: 45px;
}

.psi11 {
	margin-left: 40px;
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
	margin-left: 112px;
}

.pso5 {
	margin-left: 45px;
}

.pso6 {
	margin-left: 65px;
}

.ddother_info1,.ddother_info3 {
	width: 195px;
	margin-top: 20px;
	height: 115px;
	float: left;
}

.ddother_info2 {
	width: 250px;
	margin-top: 20px;
	height: 115px;
	float: left;
	border-left: 1px dashed #ccc;
}

.ddother_info3 {
	border-left: 1px dashed #ccc;
}

.ddother_info4 {
	width: 320px;
	margin-top: 20px;
	height: 115px;
	float: left;
	border-left: 1px dashed #ccc;
}

.ddohter_tb {
	height: 85px;
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	overflow-x: hidden;
	overflow-y: scroll;
	margin-left: 10px;
}

.ddother4_text1 {
	margin-left: 150px;
}

.ddother4_text2 {
	margin-left: 55px;
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
	text-align: right;
	margin-right: 3px;
}

.ig,.ig_top20 {
	line-height: 25px;
}

/*frozen table*/
.frozen_div {
	height: 230px;
	overflow: hidden;
	border-bottom: 1px solid #ccc;
}

#frozen_cols {
	height: 100%;
	width: 400px;
}

#move_cols {
	height: 100%; /* equals #frozen_cols.height */
	width: 560px;
}

#f_cols_head,#m_cols_head {
	height: 30px;
	border-bottom: 1px solid #808080;
}

#f_cols_body,#m_cols_body {
	height: 200px;
}
</style>
<script type="text/javascript">
	$(".Content input").attr("readonly", "readonly");
	$(".Content select").attr("disabled", "disabled");
	function closeSTOrderDetail() {
		// 隱藏 detail view 的tag和頁面
		$("#stOrderDetailTag").hide();
		$("#stOrderDetailView").hide();
		// 顯示 list view 的tag和頁面
		$("#stOrderListTag").show();
		$("#stOrderListView").show();
		//showContent("${ctx}/order/stOrder"); 	
		$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').on('click',
				function() {
					DispOrHid('B-id');
					gridbar_B();
				});
	};
</script>
<div class="Content">
	<div class="CInfo">
		<div class="icol_text">
			<auchan:i18n id="104004005"></auchan:i18n>
			&nbsp;
		</div>
		<select class="w15" disabled="disabled">
			<option value="${stvo.orderSTDetailVO.storeNo }">${stvo.orderSTDetailVO.storeNo }-${stvo.orderSTDetailVO.storeName }</option>
		</select> <span><auchan:getStuffName value="${stvo.orderSTDetailVO.chngBy }"/></span> <span><auchan:i18n
				id="100002014"></auchan:i18n></span> <span><c:if
				test="${stvo.orderSTDetailVO.chngDate  ne null}">
				<fmt:formatDate value="${stvo.orderSTDetailVO.chngDate }"
					pattern="yyyy-MM-dd" />
			</c:if></span> <span><auchan:i18n id="100002015"></auchan:i18n></span><span><auchan:getStuffName value="${stvo.orderSTDetailVO.creatBy }"/></span>
		<span><auchan:i18n id="100002016"></auchan:i18n></span> <span><c:if
				test="${stvo.orderSTDetailVO.creatDate  ne null}">
				<fmt:formatDate value="${stvo.orderSTDetailVO.creatDate }"
					pattern="yyyy-MM-dd" />
			</c:if></span> <span><auchan:i18n id="100002017"></auchan:i18n></span>
	</div>
	<div class="CM" style="height: 120px;">
		<div class="inner_half">
			<div class="CM-bar">
				<div>
					<auchan:i18n id="104004002"></auchan:i18n>
				</div>
			</div>
			<div class="CM-div">
				<div class="ig_top20">
					<div class="icol_text w14">
						<span><auchan:i18n id="104004006"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w23 fl_left"
						value="${stvo.orderSTDetailVO.ordNo }" /> <span class="fl_left">&nbsp;<auchan:i18n
							id="104004007"></auchan:i18n>&nbsp;
					</span> <input type="text" class="inputText w11 fl_left"
						value="${stvo.orderSTDetailVO.sectionNo }" /> <input type="text"
						class="inputText w28 fl_left"
						value="${stvo.orderSTDetailVO.catlgName }" />
				</div>
				<div class="ig">
					<div class="icol_text w14">
						<span><auchan:i18n id="104004008"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w20 fl_left"
						value="${stvo.orderSTDetailVO.supNo }" /> <input type="text"
						class="inputText w50 fl_left"
						value="${stvo.orderSTDetailVO.comName }" />
				</div>
				<div class="ig">
					<div class="icol_text w14">
						<span><auchan:i18n id="104004009"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w23 fl_left"
						value="${stvo.orderSTDetailVO.refNo }" /> <span class="fl_left">&nbsp;<auchan:i18n
							id="104004010"></auchan:i18n>&nbsp;
					</span> <input type="text" class="inputText w11 fl_left"
						value="${stvo.orderSTDetailVO.invDisc }" /> &nbsp;<span class="fl_left">%</span>
						
				<span class="fl_left">&nbsp;采购&nbsp;
					</span> <input type="text" class="inputText w11 fl_left" style="width:65px;"
						value="<auchan:getStuffName value="${stvo.orderSTDetailVO.buyer }"/>" /> &nbsp;
				</div>
			</div>
		</div>
		<div class="inner_half">
			<div class="CM-div">
				<div class="ig_top20">
					<div class="icol_text w14">
						<span><auchan:i18n id="104004011"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w15 fl_left"
						value="${stvo.orderSTDetailVO.leadTime }" /> <span
						class="fl_left">&nbsp;<auchan:i18n id="104004012"></auchan:i18n></span>
					<input type="text" class="inputText w20 fl_left"
						value="${stvo.orderSTDetailVO.minOrdAmt }" /> <span
						class="fl_left">&nbsp;<auchan:i18n id="104004013"></auchan:i18n></span>
					<input type="text" class="inputText w11 fl_left"
						value="${stvo.orderSTDetailVO.bpDisc }" /> &nbsp;%
				</div>
				<div class="ig">
					<div class="icol_text w14">
						<span><auchan:i18n id="104004014"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w70"
						value="${stvo.orderSTDetailVO.detllAddr }" />
				</div>
				<div class="ig">
					<div class="icol_text w14">
						<span><auchan:i18n id="104004015"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w70"
						value="${stvo.orderSTDetailVO.memo }" />
				</div>
			</div>
		</div>
	</div>

	<div class="CM" style="height: 150px; margin-top: 2px;">
		<div class="CM-bar">
			<div>
				<auchan:i18n id="104004003"></auchan:i18n>
			</div>
		</div>
		<div class="CM-div">
			<div class="ddother_info1">
				<div class="ig">
					<div class="icol_text w36">
						<span><auchan:i18n id="104004016"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w55"
						value="<auchan:getDictValue code='${stvo.orderSTDetailVO.ordCreatParty }' mdgroup='ORDERS_ORD_CREAT_PARTY' />" />
				</div>
				<div class="ig">
					<div class="icol_text w36">
						<span><auchan:i18n id="104004017"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w55"
						value="<auchan:getDictValue code='${stvo.orderSTDetailVO.ordType }' mdgroup='ORDERS_ORD_TYPE' />" />
				</div>
				<div class="ig">
					<div class="icol_text w36">
						<span><auchan:i18n id="104004018"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w55"
						<c:if test="${stvo.orderSTDetailVO.dlvryType ne null}"> value="<auchan:getDictValue code='${stvo.orderSTDetailVO.dlvryType }' mdgroup='ORDERS_DELIV_TYPE' />"</c:if> />
				</div>
				<div class="ig">
					<div class="icol_text w36">
						<span><auchan:i18n id="104004019"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w55"
						value="<auchan:getDictValue code='${stvo.orderSTDetailVO.ordSttus }' mdgroup='ORDERS_ORD_STTUS' />" />
				</div>
			</div>
			<div class="ddother_info2">
				<div class="ig">
					<div class="icol_text w45">
						<span><auchan:i18n id="104004020"></auchan:i18n></span>
					</div>

					<input type="text" class="inputText w35"
						<c:if test="${stvo.orderSTDetailVO.ordDate ne null}"> value="<fmt:formatDate value='${stvo.orderSTDetailVO.ordDate }' pattern='yyyy-MM-dd' />"</c:if> />


				</div>
				<div class="ig">
					<div class="icol_text w45">
						<span><auchan:i18n id="104004021"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w35"
						<c:if test="${stvo.orderSTDetailVO.planRecptDate ne null}"> value="<fmt:formatDate value='${stvo.orderSTDetailVO.planRecptDate }' pattern='yyyy-MM-dd' />"</c:if> />
				</div>
				<div class="ig">
					<div class="icol_text w45">
						<span><auchan:i18n id="104004022"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w50"
						value="${stvo.orderSTDetailVO.transStoreNo }" />
				</div>
				<div class="ig">
					<div class="icol_text w45">
						<span><auchan:i18n id="104004023"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w50"
						value="${stvo.orderSTDetailVO.transOrdNo }" />
				</div>
			</div>
			<div class="ddother_info3">
				<div class="ig">
					<div class="icol_text w45">
						<span><auchan:i18n id="104004024"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w50"
						value="${stvo.orderSTDetailVO.recptNo }" />
				</div>
				<div class="ig">
					<div class="icol_text w45">
						<span><auchan:i18n id="104004025"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w50"
						<c:if test='${stvo.orderSTDetailVO.realRecptDate  ne null }'> value="<fmt:formatDate value='${stvo.orderSTDetailVO.realRecptDate }' pattern='yyyy-MM-dd'/>" </c:if> />
				</div>
				<div class="ig">
					<div class="icol_text w45">
						<span><auchan:i18n id="104004026"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w50"
						value="<auchan:getDictValue code='${stvo.orderSTDetailVO.printInd }' mdgroup='ORDERS_PRINT_IND' />" />
				</div>
				<div class="ig">
					<div class="icol_text w45">
						<span><auchan:i18n id="104004027"></auchan:i18n></span>
					</div>
					<input type="text" class="inputText w50"
						value="<%-- ${stvo.orderSTDetailVO.detllAddr } --%>" />
				</div>
			</div>
			<div class="ddother_info4">
				<div class="ig">
					<span class="ddother4_text1"><auchan:i18n id="104004028"></auchan:i18n></span>
					<span class="ddother4_text2"><auchan:i18n id="104004029"></auchan:i18n></span>
				</div>
				<div class="ddohter_tb">
					<div class="ig">
						<div class="icol_text w40">
							<span><auchan:i18n id="104004030"></auchan:i18n></span>
						</div>
						<input type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totOrdQty }" /> <input
							type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totRecptQty }" />
					</div>
					<div class="ig">
						<div class="icol_text w40">
							<span><auchan:i18n id="104004031"></auchan:i18n></span>
						</div>
						<input type="text" class="inputText w25"
							value="<fmt:formatNumber value="${stvo.orderSTSumInfoVO.totNetOrdAmnt }" type="number" pattern="######.##"/>" />
						<input type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totNetRecptAmnt }" />
					</div>
					<div class="ig">
						<div class="icol_text w40">
							<span><auchan:i18n id="104004032"></auchan:i18n></span>
						</div>
						<input type="text" class="inputText w25"
							value="<fmt:formatNumber value="${stvo.orderSTSumInfoVO.totBuyOrdAmnt }" type="number" pattern="######.####"/>" />
						<input type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totBuyRecptAmnt }" />
					</div>
					<div class="ig">
						<div class="icol_text w40">
							<span><auchan:i18n id="104004033"></auchan:i18n></span>
						</div>
						<input type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totOrdAmnt }" /> <input
							type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totRecptAmnt }" />
					</div>
					<div class="ig">
						<div class="icol_text w40">
							<span><auchan:i18n id="104004034"></auchan:i18n></span>
						</div>
						<input type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totSellOrdAmnt }" /> <input
							type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totSellRecptAmnt }" />
					</div>
					<div class="ig">
						<div class="icol_text w40">
							<span><auchan:i18n id="104004035"></auchan:i18n></span>
						</div>
						<input type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totNetCostOrdAmnt }" /> <input
							type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totNetCostRecptAmnt }" />
					</div>
					<div class="ig">
						<div class="icol_text w40">
							<span><auchan:i18n id="104004036"></auchan:i18n></span>
						</div>
						<input type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totNetCostPercOrdAmnt }" /> <input
							type="text" class="inputText w25"
							value="${stvo.orderSTSumInfoVO.totNetCostPercRecptAmnt }" />
					</div>
					<div class="ig">
						<div class="icol_text w40">
							<span><auchan:i18n id="104004037"></auchan:i18n></span>
						</div>
						<input type="text" class="inputText w25"
							value="<fmt:formatNumber value="${stvo.orderSTSumInfoVO.totPresOrdQty}" type="number" pattern="#.####"/>" /> <input
							type="text" class="inputText w25"
							value="<fmt:formatNumber value="${stvo.orderSTSumInfoVO.totPresRecptQty}" type="number" pattern="#.####"/>" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="CM" style="height: 260px; margin-top: 2px;">
		<div class="CM-bar">
			<div>
				<auchan:i18n id="104004004"></auchan:i18n>
			</div>
		</div>
		<div class="CM-div">
			<div class="pro_store_item">

				<div class="frozen_div">
					<!--left frozen parts of a table-->
					<div id="frozen_cols">
						<!--frozen top head parts-->
						<div id="f_cols_head">
							<div class="f_head_1">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td>
											<div style="width: 30px;">&nbsp;</div>
										</td>
										<td>
											<div style="width: 80px;">
												<auchan:i18n id="104004038"></auchan:i18n>
											</div>
										</td>
										<td>
											<div style="width: 200px;">
												<auchan:i18n id="104004039"></auchan:i18n>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<!--frozen body parts-->
						<div id="f_cols_body">
							<table cellpadding="0" cellspacing="0">
								<c:forEach items="${stvo.orderSTItemInfoVOList}"
									var="orderSTSumInfoVO">
									<tr>
										<td style="width: 30px;">&nbsp;</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95 "
													value="${orderSTSumInfoVO.itemNo }" />
											</div>
										</td>
										<td>
											<div style="width: 300px;">
												<input type="text" class="inputText w95 "
													title="${orderSTSumInfoVO.itemName }"
													value="${orderSTSumInfoVO.itemName }" />
											</div>
										</td>
									</tr>
								</c:forEach>
							</table>
							<div class="ig"></div>
						</div>
					</div>
					<!--right parts that can scroll-->
					<div id="move_cols">
						<!--frozen top head parts when drag the y-scroll -->
						<div id="m_cols_head">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004040"></auchan:i18n>
										</div>
									</td>
									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004041"></auchan:i18n>
										</div>
									</td>
									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004042"></auchan:i18n>
										</div>
									</td>
									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004043"></auchan:i18n>
										</div>
									</td>
									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004044"></auchan:i18n>
										</div>
									</td>
									<td>
										<div style="width: 120px;">
											<auchan:i18n id="104004045"></auchan:i18n>
										</div>
									</td>

									<td>
										<div style="width: 120px;">
											<auchan:i18n id="104004046"></auchan:i18n>
										</div>
									</td>
									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004047"></auchan:i18n>
										</div>
									</td>
									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004048"></auchan:i18n>
										</div>
									</td>

									<td>
										<div style="width: 110px;">
											<auchan:i18n id="104004049"></auchan:i18n>
										</div>
									</td>

									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004050"></auchan:i18n>
										</div>
									</td>
									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004051"></auchan:i18n>
										</div>
									</td>

									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004052"></auchan:i18n>
										</div>
									</td>
									<td>
										<div style="width: 80px;">
											<auchan:i18n id="104004053"></auchan:i18n>
										</div>
									</td>

									<td>
										<div style="width: 80px;">&nbsp;</div>
									</td>
									<!--占位-->
								</tr>
							</table>
						</div>
						<!--this parts can be scrolled all the time-->
						<div id="m_cols_body">
							<table cellpadding="0" cellspacing="0">
								<c:forEach items="${stvo.orderSTItemInfoVOList}"
									var="orderSTSumInfoVO">
									<tr>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w93 "
													value="<auchan:getDictValue code='${orderSTSumInfoVO.status }' mdgroup='ITEM_STORE_INFO_STATUS' />" />
											</div>
										</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95"
													value="${orderSTSumInfoVO.ordQty }" />
											</div>
										</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95 "
													value="${orderSTSumInfoVO.recptQty }" />
											</div>
										</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95"
													value="${orderSTSumInfoVO.presOrdQty }" />
											</div>
										</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95 "
													value="${orderSTSumInfoVO.presRecptQty }" />
											</div>
										</td>
										<td>
											<div style="width: 120px;">
												<input type="text" class="inputText w95"
													value="<fmt:formatNumber value="${orderSTSumInfoVO.buyOrdAmnt }" type="number" pattern="######.####"/>" />
											</div>
										</td>
										<td>
											<div style="width: 120px;">
												<input type="text" class="inputText w95 "
													value="<fmt:formatNumber value="${orderSTSumInfoVO.buyRecptAmnt }" type="number" pattern="######.####"/>" />
											</div>
										</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95 "
													value="<fmt:formatNumber value="${orderSTSumInfoVO.recvBleQty }" type="number" pattern="######.####"/>" />
											</div>
										</td>
										<td>
											<div style="width: 110px;">
												<input type="text" class="inputText w95 "
													value="<fmt:formatNumber value="${orderSTSumInfoVO.stock }" type="number" pattern="######.####"/>" />
											</div>
										</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95"
													value="<fmt:formatNumber value="${orderSTSumInfoVO.buyPrice }" type="number" pattern="######.####"/>" />
											</div>
										</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95"
													value="${orderSTSumInfoVO.buyVatVal }" />
											</div>
										</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95"
													value="${orderSTSumInfoVO.normSellPrice }" />
											</div>
										</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95"
													value="${orderSTSumInfoVO.sellVatVal }" />
											</div>
										</td>
										<td>
											<div style="width: 80px;">
												<input type="text" class="inputText w95"
													value="${orderSTSumInfoVO.promNo }" />
											</div>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

</div>
