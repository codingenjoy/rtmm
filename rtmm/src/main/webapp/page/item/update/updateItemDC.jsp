<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.ListWin {
	height: 20px;
	width: 20px;
	margin-top: 5px;
	margin-left: 3px;
}

.CInfo .combo,.CInfo input {
	background-color: #cccccc;
}

.license2:hover {
	background-position: -3px -19px;
}

.zz_info {
	width: 95%;
}

.iconPut {
	float: left;
	margin-left: 3px;
}

.zz_2 {
	height: 140px;
}

.zz_2 input {
	margin-left: 3px;
}

.zz_2 input[type="checkbox"] {
	margin-top: 5px;
}

.zz_11 {
	margin-left: 70px;
}

.zz_12 {
	margin-left: 80px;
}

.zz_13 {
	margin-left: 60px;
}

.zz_14 {
	margin-left: 55px;
}

.zz_15 {
	margin-left: 220px;
}

.zz_16 {
	margin-left: 30px;
}

.zz_17 {
	margin-left: 30px;
}

.sp_icon1 {
	margin-left: 12px;
}

.tb_top {
	margin-top: 10px;
	margin-left: 20px;
	margin-bottom: 5px;
	border-bottom: 1px solid #ccc;
}
</style>
<script>
	$('#barcodeInfoTab').unbind("click").bind('click', function() {
		showContent(ctx + '/item/query/itemBarcodeInfo', getParam());
	});
	$('#dcInfoTab').unbind("click").bind("click", function() {
		showContent(ctx + '/item/query/itemDCInfo', getParam());
	});
	if ('${dcInfoVo.dcGoodsDlvryAttr }' != null) {
		$('#dcGoodsDlvryAttr').val('${dcInfoVo.dcGoodsDlvryAttr }');
	}
	if ('${dcInfoVo.storeOrdUnit }' != null) {
		$('#storeOrdUnit').val('${dcInfoVo.storeOrdUnit}');
	}
	if ('${dcInfoVo.perdUnitName }' != null) {
		$('#perdUnitName').val('${dcInfoVo.perdUnitName }');
		if ('${dcInfoVo.stdShelfLifeDays }' != null) {
			switch ('${dcInfoVo.perdUnitName }') {
			case 1:
				$('#stdShelfLifeIntoDays').val('${dcInfoVo.stdShelfLifeDays }');
				break;
			case 2:
				$('#stdShelfLifeIntoDays').val('${dcInfoVo.stdShelfLifeDays }'*30);
				break;
			case 3:
				$('#stdShelfLifeIntoDays').val('${dcInfoVo.stdShelfLifeDays }'*365);
				break;
			}
		}
	}

	$('#Tools2').attr("class", "Tools2");
	$('#Tools2').unbind("click").bind("click", function() {
		saveDCupdate();
	});

	inputCheck();

	function calCaseVolume() {
		if ($('#caseFace').val() != '' && $('#caseHght').val() != ''
				&& $('#caseDepth').val() != '') {
			var value = ($('#caseFace').val()) * ($('#caseHght').val())
					* ($('#caseDepth').val());
			$('#caseValumn').val(value.toFixed(2));
		}
	}
	function calSubcaseVolume() {
		if ($('#subcaseFace').val() != '' && $('#subcaseHght').val() != ''
				&& $('#subcaseDepth').val() != '') {
			var value = ($('#subcaseFace').val()) * ($('#subcaseHght').val())
					* ($('#subcaseDepth').val());
			$('#subcaseValumn').val(value.toFixed(2));
		}
	}
	function calPlltTotal() {
		if ($('#plltTier').val() != '' && $('#plltHier').val() != '') {
			$('#plltTotal')
					.val(($('#plltTier').val()) * ($('#plltHier').val()));
		}
	}
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div id="ovreviewTab" class="tagsM">商品总览</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="priceChangeTab" class="tagsM">商品变价</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="specInfoTab" class="tagsM">商品规格</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="barcodeInfoTab" class="tagsM">商品条码</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="realativeInfoTab" class="tagsM">商品关联</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="supInfoTab" class="tagsM">商品厂商</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="saleCtrlInfoTab" class="tagsM">商品陈列</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="jinxiaocun" class="tagsM">商品进销存</div>
	<div class="tags"></div>

	<!--最后一个-->
	<div id="dcInfoTab" class="tagsM">DC信息</div>
	<div class="tags tags3 tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div class="tagsM_q  tagsM_on">修改DC信息</div>
	<div class="tags3_close_on">
		<div class="tags_close"></div>
	</div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo">
			<span>项</span> <span>10，000</span> <span>/</span> <span>1</span> <span>第</span> <span>|</span> <span>'${dcInfoVO.chngBy}'</span> <span>修改人</span> <span>'${dcInfoVO.chngDate}'</span>
			<span>修改日期</span> <span>李四</span> <span>建档人</span> <span>2014-02-02</span> <span>创建日期</span>
		</div>
		<input id="storeNo" type="hidden" value='${storeNo }' />
		<input id="storeName" type="hidden" value='${storeName }' />
		<form action="" id="dcInfo" url="/item/update/saveDCupdate" onsubmit="return false;">
			<div style="height: 60px;" class="CM">
				<div class="CM-bar">
					<div>货号</div>
				</div>
				<div class="CM-div">
					<div class="hh_item">
						<div class="icol_text w7">
							<span>货号</span>
						</div>
						<div class="w10 iconPut iq Black">
							<input id="itemNo" name="itemNo" type="text" value='${itemNo }' class="w75 Black" readonly="readonly" />
							<div class="ListWin"></div>
						</div>
						<!-- 					<input class="inputText iq Black" style="width: 20%;" type="text" value='${itemName }' readonly="readonly" /> -->
						<input id="itemName" name="itemName" class="inputText iq Black" type="text" value='${itemName }' readonly="readonly" />
						<span class="fl_left" style="line-height: 20px;">&nbsp;&nbsp;&nbsp;保质期&nbsp;&nbsp;</span>
						<input type="text" class="w5 inputText fl_left Black align_right" name="stdShelfLifePerd" value="${dcInfoVo.stdShelfLifeDays }"
							readonly="readonly" />
						<div class="fl_left" style="width: 50px; margin-left: 5px;">
							<%-- <input class="w80 inputText Black" style="height: 20px;" name="perdUnitName" value="${dcInfoVo.perdUnitName}" readonly="readonly" /> --%>
							<select id="perdUnitName" class="Black" disabled="disabled">
								<c:forEach var="perdUnit" items="${perdUnitNameList }">
									<option value="${perdUnit.code }">${perdUnit.title }</option>
								</c:forEach>
							</select>
						</div>
						<span>或</span>
						<input id="stdShelfLifeIntoDays" type="text" class="w5 Black inputText align_right" name="stdShelfLifeIntoDays" />
						<span>天</span>
					</div>
				</div>
			</div>
			<div style="height: 252px;">
				<div class="tb50">
					<div style="height: 140px; margin-top: 2px;" class="CM">
						<div class="CM-bar">
							<div>D C基本信息</div>
						</div>
						<div class="CM-div">
							<div class="ig" style="margin-top: 15px;">
								<div class="msg_txt">*货物属性</div>
								<div class="i_input3">
									<auchan:select mdgroup="ITEM_DC_INFO_DC_GOODS_DLVRY_ATTR" _class="select1 required" name="dcGoodsDlvryAttr" />
								</div>
							</div>
							<div class="ig">
								<div class="msg_txt">DC订购单位</div>
								<input type="text" class="inputText w15 align_right number" name="dcMinOrdQty" maxLength="6" value="${dcInfoVo.dcMinOrdQty }" />
							</div>
							<div class="ig">
								<div class="msg_txt">*门店补货方式</div>
								<div class="i_input3">
									<auchan:select mdgroup="ITEM_DC_INFO_STORE_ORD_UNIT" _class="select1 required" name="storeOrdUnit" />
								</div>
							</div>
							<div class="ig">
								<div class="msg_txt">补货单位</div>
								<input type="text" class="w15 inputText align_right number" name="storeMinOrdQty" maxLength="6" value="${dcInfoVo.storeMinOrdQty }" />
							</div>
						</div>
					</div>
					<div style="height: 110px; margin-top: 2px;" class="CM">
						<div class="CM-bar">
							<div>托盘信息</div>
						</div>
						<div class="CM-div">
							<div class="ig" style="margin-top: 15px;">
								<div class="msg_txt">每层箱数TI</div>
								<input id="plltTier" type="text" class="inputText w15 align_right number" name="plltTier" maxLength="2" value="${dcInfoVo.plltTier }"
									onchange="calPlltTotal()" />
								<span style="margin-left: 10px; margin-right: 10px;">托盘层数HI</span>
								<input id="plltHier" type="text" class="inputText w15 align_right number" name="plltHier" maxLength="2" value="${dcInfoVo.plltHier }"
									onchange="calPlltTotal()" />
							</div>
							<div class="ig">
								<div class="msg_txt">每托盘箱数</div>
								<input id="plltTotal" type="text" class="inputText w15 align_right Black"
									value="<c:if test="${dcInfoVo.plltTier != null && dcInfoVo.plltHier != null }" >${ dcInfoVo.plltTier*dcInfoVo.plltHier} </c:if>"
									readonly="readonly" />
							</div>
						</div>
					</div>
				</div>
				<div class="tb50">
					<div style="height: 252px; margin-top: 2px;" class="CM">
						<div class="CM-bar">
							<div>箱含量信息</div>
						</div>
						<div class="CM-div">
							<div class="tb_top">
								<span style="margin-left: 140px;">外箱</span> <span style="margin-left: 130px;">内箱</span>
							</div>
							<div class="ig">
								<div class="msg_txt">箱含量</div>
								<input class="inputText w30 align_right scale62" name="upb" value="${dcInfoVo.upb }" />
								<input class="inputText w30 align_right scale62" name="subUpb" value="${dcInfoVo.subUpb}" />
							</div>
							<div class="ig">
								<div class="msg_txt">面(CM)</div>
								<input id="caseFace" class="inputText w30 align_right scale62" name="caseFace" value="${dcInfoVo.caseFace }" onchange="calCaseVolume()" />
								<input id="subcaseFace" class="inputText w30 align_right scale62" name="subcaseFace" value="${dcInfoVo.subcaseFace }"
									onchange="calSubcaseVolume()" />
							</div>
							<div class="ig">
								<div class="msg_txt">高(CM)</div>
								<input id="caseHght" class="inputText w30 align_right scale62" name="caseHght" value="${dcInfoVo.caseHght }" onchange="calCaseVolume()" />
								<input id="subcaseHght" class="inputText w30 align_right scale62" name="subcaseHght" value="${dcInfoVo.subcaseHght }"
									onchange="calSubcaseVolume()" />
							</div>
							<div class="ig">
								<div class="msg_txt">深(CM)</div>
								<input id="caseDepth" class="inputText w30 align_right scale62" name="caseDepth" value="${dcInfoVo.caseDepth }" onchange="calCaseVolume()" />
								<input id="subcaseDepth" class="inputText w30 align_right scale62" name="subcaseDepth" value="${dcInfoVo.subcaseDepth }"
									onchange="calSubcaseVolume()" />
							</div>
							<div class="ig">
								<div class="msg_txt">体积(M3)</div>
								<input id="caseValumn" class="inputText w30 align_right Black"
									value=" <c:if test="${dcInfoVo.caseFace != null && dcInfoVo.caseHght != null && dcInfoVo.caseDepth != null }" >${ dcInfoVo.caseFace*dcInfoVo.caseHght*dcInfoVo.caseDepth} </c:if>"
									readonly="readonly" />
								<input id="subcaseValumn" class="inputText w30 align_right Black"
									value="<c:if test="${dcInfoVo.subcaseFace != null && dcInfoVo.subcaseHght != null && dcInfoVo.subcaseDepth != null }" >${ dcInfoVo.subcaseFace*dcInfoVo.subcaseHght*dcInfoVo.subcaseDepth}.toFixed(2) </c:if>"
									readonly="readonly" />
							</div>
							<div class="ig">
								<div class="msg_txt">毛重(KG)</div>
								<input class="inputText w30 align_right scale103" name="caseGrossWght" value="${dcInfoVo.caseGrossWght }" />
								<input class="inputText w30 align_right scale103" name="subcaseGrossWght" value="${dcInfoVo.subcaseGrossWght }" />
							</div>
							<div class="ig">
								<div class="msg_txt">净重(KG)</div>
								<input class="inputText w30 align_right scale103" name="caseNetWght" value="${dcInfoVo.caseNetWght }" />
								<input class="inputText w30 align_right scale103" name="subcaseNetWght" value="${dcInfoVo.subcaseNetWght }" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
		<div style="height: 220px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>物流中心信息</div>
			</div>
			<div class="CM-div">
				<div class="zz_info">
					<div class="zz_1">
						<span class="zz_11">物流店号</span> <span class="zz_12">状态</span> <span class="zz_13">DC属性</span> <span class="zz_14">供应商</span> <span class="zz_15">进价(元)</span>
						<span class="zz_16">允收天数(天)</span> <span class="zz_17">配送天数(天)</span>
					</div>
					<c:forEach items="${dcStoreList}" var="dcStore">
						<div class="zz_2">
							<div class="ig" style="margin-top: 5px; margin-left: 10px;">
								<input type="text" class="w120 inputText fl_left Black" readonly="readonly"
									value="<c:if test="${dcStore.storeNo != null && dcStore.storeName != null }">${dcStore.storeNo}-${dcStore.storeName}</c:if>" />
								<input type="text" class="w10 inputText fl_left Black" readonly="readonly"
									value="<c:if test="${dcStore.status != null }"><auchan:getDictValue code="${dcStore.status}" mdgroup="STORE_STATUS"></auchan:getDictValue></c:if>" />
								<input type="text" class="w10 inputText fl_left Black" readonly="readonly"
									value="<c:if test="${dcStore.dcAttr != null }"><auchan:getDictValue code="${dcStore.dcAttr}" mdgroup="ITEM_STORE_INFO_DC_ATTR"></auchan:getDictValue></c:if>" />
								<div class="iconPut w10 Black">
									<input type="text" class="w70 Black" value="${dcStore.stMainSupNo}" readonly="readonly" />
									<div class="ListWin"></div>
								</div>
								<input type="text" class="w17 inputText fl_left Black " value="${dcStore.comName}" readonly="readonly" />
								<input type="text" class="w10 inputText align_right fl_left Black" value="${dcStore.normBuyPrice}" readonly="readonly" />
								<input type="text" class="w10 inputText align_right Black" value="${dcStore.rcvShelfLifeDays}" readonly="readonly" />
								<input type="text" class="w10 inputText align_right Black" value="${dcStore.dcShelfLifeDays}" readonly="readonly" />
							</div>
						</div>
					</c:forEach>
					<div class="ig">
						<input type="checkbox" class="sp_icon1" />
						<div class="Icon-size2 Tools10_disable sp_icon2"></div>
						<div class="Icon-size2 Line-1 sp_icon3 "></div>
						<div class="Icon-size2 Tools11_disable sp_icon4"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>