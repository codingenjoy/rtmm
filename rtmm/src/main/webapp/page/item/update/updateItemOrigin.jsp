<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<link href="${ctx}/shared/themes/theme2/css/jquery.autocomplete.css"
	rel="stylesheet" type="text/css" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js"
	type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery/auto/jquery.autocomplete.js"
	type="text/javascript"></script>
<script src="${ctx}/item/create/citys" type="text/javascript"></script>
<script src="${ctx}/item/create/getRegionNodeListAndUnt"
	type="text/javascript"></script>
<script src="${ctx}/shared/js/item/item_create.js"
	type="text/javascript"></script>

<style type="text/css">
.CInfo input[type="text"] {
	margin-left: 3px;
}

input[type="checkbox"] {
	margin-top: 4px;
}

.iconPut {
	margin-left: 3px;
	float: left;
}

.iconPut span {
	color: #999;
}

.zz_info {
	width: 95%;
}

.zz_2 {
	height: 290px;
}

.zz_2 input {
	margin-left: 3px;
}

.zz_11 {
	margin-left: 50px;
}

.zz_12 {
	margin-left: 43px;
}

.zz_13 {
	margin-left: 185px;
}

.zz_14 {
	margin-left: 75px;
}

.row {
	margin-top: 15px;
}

.tagsM {
	min-width: 55px;
}
</style>

<script type="text/javascript">
	$(function() {
		loadSelectDiv($('.regionNode'),regionNodeList,2);
		loadSelectDiv($('.orignTitle'),cityList,3);
		loadProducerList($('.producerComName'));
		$("#itemNo").attr("readonly", false);
		setToolsbarAllDisable();
		//传递参数 
		var param = {
			'itemNo' : '${sessionScope.itemNoSearch}',
			'itemName' : '${sessionScope.itemNameSearch}',
			'storeNo' : '${sessionScope.storeNoSearch}',
			'storeName' : '${sessionScope.storeNameSearch}'
		};
		//商品总览(tab)
		$('#ovreviewTab').unbind("click").bind('click',
				function() {
					var itemNo = '${sessionScope.itemNoSearch}';
					if (itemNo != null && itemNo != "") {
						searchItemByItemNo('${sessionScope.itemNoSearch}',
								'${sessionScope.storeNoSearch}');
					} else {
						$('.Container').load(ctx + '/item/query/generalSearch',
								param);
					}
				});

		//变价信息(tab)
		$('#priceChangeTab').unbind("click").bind('click',
				function() {
					$('#ovreviewContent').load(
							ctx + '/item/query/itemPriceChangeInfo', param);
				});
		//规格信息(tab)
		$('#specInfoTab').unbind("click").bind('click',
				function() {
					$('#ovreviewContent').load(
							ctx + '/item/query/itemSpecInfo', param);
				});
		//商品条码(tab)
		$('#barcodeInfoTab').unbind("click").bind('click',
				function() {
					$('#ovreviewContent').load(
							ctx + '/item/query/itemBarcodeInfo', param);
				});
		//商品关联(tab)
		$('#realativeInfoTab').unbind("click").bind('click',
				function() {
					$('#ovreviewContent').load(
							ctx + '/item/query/itemRealativeInfo', param);
				});
		//商品厂商(tab)
		$('#supInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSupInfo', param);
		});
		//商品陈列(tab)
		$('#saleCtrlInfoTab').unbind("click").bind('click',
				function() {
					$('#ovreviewContent').load(
							ctx + '/item/query/itemRealStoreSaleCtrlInfo',
							param);
				});
		//DC信息(tab)
		$('#dcInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemDCInfo', param);
		});
		//商品产地(tab)
		$('#originInfoTab').unbind("click").bind('click',
				function() {
					$('#ovreviewContent').load(
							ctx + '/item/query/itemOriginInfo', param);
				});
		//商品供应区域(tab)
		$('#supAreaInfoTab').unbind("click").bind('click',
				function() {
					$('#ovreviewContent').load(
							ctx + '/item/query/itemSupplierAreaInfo', param);
				});
		//close the page that updating the item origin info.
		$("#itemOriginClose").unbind().bind('click', function() {
			closeUptItemInfo('itemOriginClose', param);
		});
		//save the update item origin message.
		$('#Tools2').removeClass('Tools2_disable').addClass('Tools2').bind("click", function() {
			saveUpdateItemOrigin();
		});

	});
</script>
<div class="CTitle" id="itemOverViewTitle">
	<!--第一个-->
	<div class="tags1_left "></div>
	<div class="tagsM " id="ovreviewTab">商品总览</div>
	<div class="tags "></div>
	<div class="tagsM" id="priceChangeTab">商品变价</div>
	<div class="tags"></div>
	<div class="tagsM" id="specInfoTab">商品规格</div>
	<div class="tags"></div>
	<div class="tagsM" id="barcodeInfoTab">商品条码</div>
	<div class="tags"></div>
	<div class="tagsM" id="realativeInfoTab">商品关联</div>
	<div class="tags"></div>
	<div class="tagsM" id="supInfoTab">商品厂商</div>
	<div class="tags "></div>
	<div class="tagsM" id="saleCtrlInfoTab">商品陈列</div>
	<div class="tags "></div>
	<div class="tagsM" id="dcInfoTab">DC信息</div>
	<div class="tags"></div>
	<div class="tagsM" id="originInfoTab">商品产地</div>
	<div class="tags"></div>
	<div class="tagsM " id="supAreaInfoTab">商品供应区域</div>
	<div class="tags tags3 tags_right_on"></div>
	<div class="tagsM_q  tagsM_on">修改商品产地信息</div>
	<div class="tags3_close_on">
		<div class="tags_close" id="itemOriginClose"></div>
	</div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo"></div>
		<div style="height: 60px;" class="CM">
			<div class="CM-bar">
				<div>货号</div>
			</div>
			<div class="CM-div">
				<div class="hh_item">
					<div class="icol_text w10">
						<span>货号</span>
					</div>
					<div class="iconPut iq" style="width: 13%;">
						<input id="itemNo" class="w83 count_text" type="text"
							value="${itemBasicVO.itemNo }"
							onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8" />
						<div class="ListWin" onclick="chooseItemNo()"></div>
					</div>
					<input id="itemName" class="inputText iq" style="width: 20%;"
						type="text" value="${itemBasicVO.itemName }" readonly="readonly" />
				</div>
			</div>
		</div>
		<div style="height: 90px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>主产地信息</div>
			</div>
			<div class="CM-div">
				<form id="majorRegn" action="" onsubmit="return false;">
					<div class="cdsc">
						<div class="tb50">
							<div class="ig">
								<div class="msg_txt">*主产地</div>
								<input type="hidden" tabindex="37" class="count_text orignCode "
									readonly="readonly" style="width: 60%"
									value="${itemMajorOrig.orignCode}" id="otherOrignCode"
									name="otherOrignCode">
								<input type="text" style="width: 35%;"
									class="inputText iq orignTitle mustInput"
									setValueObjId="orignCode" clean="1"
									value="<c:if test="${itemMajorOrig.orignCode ne null }"><auchan:getDictValue code="${itemMajorOrig.orignCode}" mdgroup="origin" showType="2"/></c:if>">
							</div>
							<div class="ig">
								<div class="msg_txt">*主生产单位</div>
								<input type="hidden" id="producerId" name="producerId"
									class="producerId" value="${itemMajorOrig.prdcrId}">
								<input type="text" style="width: 70%;" id="comNo2" tabindex="38"
									tagNameTitle="主生产单位"
									class="inputText iq producerComName mustInput"
									name="producerName" value="${itemMajorOrig.prdcrName}"
									maxlength="20">
							</div>
						</div>
						<div class="tb50">
							<div class="ig">
								<div class="msg_txt">*单位地址</div>
								<div style="width: 20%; float: left;" class="iconPut">
									<input type="text" class="provName mustInput"
										name="provinceName" readonly="readonly"
										value="${itemMajorOrig.provName}" style="width: 75%;">
									<div style="color: #999999;">省</div>
								</div>
								<div style="width: 28%; float: left; margin-left: 3px;"
									class="iconPut">
									<input type="text" readonly="readonly"
										class="cityName mustInput" name="cityName"
										value="${itemMajorOrig.cityName}" style="width: 70%;">
									<span class="cdsp">市</span>
									<div class="ListWin"
										onclick="currentPopObj = $(this);openCityAndProvWindow();"></div>
									<input type="hidden" name="provinceCode" class="provCode"
										value="">
									<input type="hidden" name="cityCode" class="cityCode">
								</div>
							</div>
							<div class="ig">
								<div class="msg_txt">&nbsp;</div>
								<input type="hidden" class="w50 inputText addressId"
									name="addressId" value="${itemMajorOrig.detllAddr}">
								<input class="w50 inputText address mustInput" name="address"
									value="${itemMajorOrig.detllAddr}" maxlength="30" readonly="readonly">
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div style="height: 380px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>其他产地信息</div>
			</div>
			<div class="CM-div">

				<div class="zz_info">
					<div class="zz_1">
						<span class="zz_11">城市</span> <span class="zz_12">其他产地</span> <span
							class="zz_13">生产单位</span> <span class="zz_14">单位地址</span>
					</div>
					<div>
					<div class="zz_2" id="otherRegList">
						<c:if
							test="${itemOthOrignVOs ne null and itemOthOrignVOs.size() > 0 }">
							<c:forEach items="${itemOthOrignVOs}" var="itemOthOrignVO">
								<form class="otherRegn" action="" onsubmit="return false;">
									<div class="ig">
										<input type="hidden" class="regionNodeCode" name="cityRegnNo">
										<input type="checkbox" class="cdsc0 fl_left"
											onclick="resetCheckAll($(this).parent().parent().parent())" />
										<input type="text" setValueObjId="regionNodeCode"
											acCode="regnNo" acTitle="regnName"
											class="cdsc1 inputText regionNode fl_left w10" acWidth="95px"
											value="${itemOthOrignVO.orignCode }">
										<input type="hidden" style="width: 70%"
											class="orignCode mustInput" name="otherOrignCode">
										<input type="text"
											class="inputText cdsc3 orignTitle fl_left w20"
											setValueObjId="orignCode"
											value="<auchan:getDictValue code="${itemOthOrignVO.orignCode}" mdgroup="origin" showType="2"/>">

										<input type="hidden" name="comNo" class="comNo">
										<input type="hidden" name="producerId" class="producerId">
										<input type="text"
											class="inputText cdsc3_1 producerComName fl_left w20"
											name="producerName" maxlength="20"
											value="${itemOthOrignVO.prdcrName }">
										<div class="iconPut cdsc2_1 w10">
											<input type="text" class="provName fl_left"
												readonly="readonly" style="width: 82%"
												value="${itemOthOrignVO.provName }">
											<span class="cdsp">省</span>
										</div>
										<div class="iconPut cdsc2_1 w10">
											<input type="text" class="fl_left cityName"
												readonly="readonly" style="width: 65%"
												value="${itemOthOrignVO.cityName }">
											<div class="ListWin"
												onclick="currentPopObj = $(this);openCityAndProvWindow();"></div>
											<span class="cdsp">市</span>
										</div>
										<input type="text" class="w20 inputText address fl_left"
											name="address" maxlength="30"
											value="${itemOthOrignVO.detllAddr }" readonly="readonly">
										<input type="hidden" class="w50 inputText addressId"
											name="addressId">
										<input type="hidden" name="provinceCode" class="provCode">
										<input type="hidden" name="cityCode" class="cityCode">
									</div>
								</form>
							</c:forEach>
						</c:if>
					</div>
					<div class="ig divHide">
						<input type="checkbox" class="sp_icon1"
							onclick="selectCheckbox($(this).parent().prev(),$(this).attr('checked'));"
							style="margin-top: 9px;">
						<div class="Icon-size2 Tools10 sp_icon2"
							onclick="deleteCheckbox($(this).parent().prev());"></div>
						<div class="Icon-size2 Line-1 sp_icon3 "></div>
						<div class="Icon-size2 Tools11 sp_icon4"
							onclick="var obj=$(this).parent().prev();addOtherSupList(obj);nullInputCheck();"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 
  append the other produce origin and produce company 
  when click the Tools11 button.
 -->
<div id="provCityDiv" style="display: none;">
	<form class="otherRegn" action="" onsubmit="return false;">
		<div class="ig">
			<input type="hidden" class="regionNodeCode" name="cityRegnNo">
			<input type="checkbox" class="cdsc0 fl_left"
				onclick="resetCheckAll($(this).parent().parent().parent())" />
			<input type="text" setValueObjId="regionNodeCode" acCode="regnNo"
				acTitle="regnName" class="cdsc1 inputText regionNode fl_left w10"
				acWidth="95px">
			<input type="hidden" style="width: 70%" class="orignCode mustInput"
				name="otherOrignCode">
			<input type="text" class="inputText cdsc3 orignTitle fl_left w20"
				setValueObjId="orignCode">

			<input type="hidden" name="comNo" class="comNo">
			<input type="hidden" name="producerId" class="producerId">
			<input type="text"
				class="inputText cdsc3_1 producerComName fl_left w20"
				name="producerName" maxlength="20">
			<div class="iconPut cdsc2_1 w10">
				<input type="text" class="provName fl_left" readonly="readonly"
					style="width: 82%">
				<span class="cdsp">省</span>
			</div>
			<div class="iconPut cdsc2_1 w10">
				<input type="text" class="fl_left cityName" readonly="readonly"
					style="width: 65%">
				<div class="ListWin"
					onclick="currentPopObj = $(this);openCityAndProvWindow();"></div>
				<span class="cdsp">市</span>
			</div>
			<input type="text" class="w20 inputText address fl_left"
				name="address" maxlength="30">
			<input type="hidden" class="w50 inputText addressId" name="addressId">
			<input type="hidden" name="provinceCode" class="provCode">
			<input type="hidden" name="cityCode" class="cityCode">
		</div>
	</form>
</div>
