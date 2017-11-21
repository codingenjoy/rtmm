<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<link href="${ctx}/shared/themes/theme2/css/jquery.autocomplete.css"
	rel="stylesheet" type="text/css" />
<script src="${ctx}/shared/js/jquery/auto/jquery.autocomplete.js"
	type="text/javascript"></script>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>

<style type="text/css">
._w120 {
	width: 120px;
}

._w80 {
	width: 80px;
}

.jksp {
	margin-left: 38px;
}

.bz_1 {
	margin-right: 100px;
}

.bz_4 {
	margin-right: 7px;
}
.tagsM{
    min-width: 55px;
}
</style>
<script type="text/javascript">
    ${healthLblList };
	${itemUnitList };
	${itemSecExtendAttrValList1 };
	${itemSecExtendAttrValList2 };
	${itemSecExtendAttrValList3 };
	${itemSecExtendAttrValList4 };
	loadKebieAttrInputSelectAlter($('#attrNo1'), itemSecExtendAttrValList1,
			'167px');
	loadKebieAttrInputSelectAlter($('#attrNo2'), itemSecExtendAttrValList2,
			'167px');
	loadKebieAttrInputSelectAlter($('#attrNo3'), itemSecExtendAttrValList3,
			'167px');
	loadKebieAttrInputSelectAlter($('#attrNo4'), itemSecExtendAttrValList4,
			'167px');
	$(function() {
		
		//传递参数 
		var param = {
			'itemNo' : '${sessionScope.itemNoSearch}',
			'itemName' : '${sessionScope.itemNameSearch}',
			'storeNo' : '${sessionScope.storeNoSearch}',
			'storeName' : '${sessionScope.storeNameSearch}'
		};
		/*disabled the all toolbar.*/
		setToolsbarAllDisable();
		inputToInputDoubleNumber();
		inputToInputIntNumber();
		loadSelectDiv($('.healthLbl'), healthLblList, 1);
		$.each(healthLblList, function(index, val) {
			if ($.trim($('.healthLbl').val()) == val.code) {
				$('.healthLblName').val(val.title);
			}
		});
		//保质期
		loadSelectDiv($('.unitName'), itemUnitList, 2);
		//loadDownLoadDivByName($(".unitName"),itemUnitList,null,'50px',0);
		$.each(itemUnitList, function(index, val) {
			if ($.trim($('input[name="perdUnitName"]').val()) == val.code) {
				$('input[name="perdUnitName"]').val(val.title);
			}
			if ($.trim($('input[name="baseVolUnit"]').val()) == val.code) {
				$('input[name="baseVolUnit"]').val(val.title);
			}
			if ($.trim($('input[name="avgUnit"]').val()) == val.code) {
				$('input[name="avgUnit"]').val(val.title);
			}
		});
		//保存修改的信息
		$('#Tools2').removeClass('Tools2_disable').addClass('Tools2').bind(
				'click', function() {
					saveItemSpecMess(param);
				});
		//商品总览(tab)
		$('#ovreviewTab').unbind("click").bind('click', function() {
			var itemNo = '${sessionScope.itemNoSearch}';
			if (itemNo != null && itemNo != "") {
				searchItemByItemNo('${sessionScope.itemNoSearch}');
			} else {
				$('.Container').load(ctx + '/item/query/generalSearch', param);
			}
		});
		//变价信息(tab)
		$('#priceChangeTab').unbind("click").bind('click',function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemPriceChangeInfo', param);
	    });
		//商品条码(tab)
		$('#barcodeInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemBarcodeInfo', param);
		});
		//商品关联(tab)
		$('#realativeInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemRealativeInfo', param);
		});
		//商品厂商(tab)
		$('#supInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSupInfo', param);
		});
		//商品陈列(tab)
		$('#saleCtrlInfoTab').unbind("click").bind('click',function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemRealStoreSaleCtrlInfo',param);
		});
		//DC信息(tab)
		$('#dcInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemDCInfo', param);
		});
		//商品产地(tab)
		$('#originInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemOriginInfo', param);
		});
		//商品供应区域(tab)
		$('#supAreaInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSupplierAreaInfo', param);
		});
		$("#itemSpecClose").unbind().bind('click', function() {
			closeUptItemInfo('itemSpec', getParam());
		});
	});
</script>
<div class="CTitle">
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
	<div class="tags"></div>
	<div id="dcInfoTab" class="tagsM">DC信息</div>
	<div class="tags"></div>
	<div class="tagsM" id="originInfoTab">商品产地</div>
	<div class="tags "></div>
	<div class="tagsM " id="supAreaInfoTab">商品供应区域</div>
	<div class="tags tags3 tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div class="tagsM_q  tagsM_on">修改商品规格信息</div>
	<div class="tags3_close_on">
		<div class="tags_close" id="itemSpecClose"></div>
	</div>
	<input type="hidden" id="param">
</div>
<form id="alterItemSpec_from">
	<input type="hidden" name="chngBy" value="${itemSpecInfoVO.chngBy}" />
	<div style="height: 60px;" class="CM">
		<div class="CM-bar">
			<div>货号</div>
		</div>
		<div class="CM-div">
			<div class="hh_item">
				<div class="icol_text w7">
					<span>货号</span>
				</div>
				<div class="iconPut iq" style="width: 13%;">
					<input style="width: 83%" type="text" id="itemNo" name="itemNo"
						readonly="readonly" value="${itemBasicVO.itemNo }" />
					<div class="ListWin"></div>
				</div>
				<input class="inputText iq Black" style="width: 20%;" type="text"
					readonly="readonly" id="itemName" value="${itemBasicVO.itemName }" />
			</div>
		</div>
	</div>
	<div style="height: 330px; margin-top: 2px;">
		<div class="tb50">
			<div style="height: 120px;" class="CM">
				<div class="CM-bar">
					<div>基本信息</div>
				</div>
				<div class="CM-div">
					<div class="ig" style="margin-top: 15px;">
						<div class="msg_txt">商品规格</div>
						<input type="text" name="specDesc" class="inputText w70"
							maxlength="20" value="${itemSpecInfoVO.specDesc }" />
					</div>
					<div class="ig">
						<div class="msg_txt">等级</div>
						<auchan:select mdgroup="ITEM_SPEC_ITEM_GRD" _class="w20"
							name="itemGrd"
							value="${itemSpecInfoVO.itemGrd }" />
						<span>&nbsp;&nbsp;型号&nbsp;&nbsp;</span> <input type="text"
							name="model" class="inputText w36" maxlength="13"
							value="${itemSpecInfoVO.model }" />
					</div>
					<div class="ig">
						<div class="msg_txt">长</div>
						<input type="text" name="face" class="inputText w10 double_text"
							maxlength="6" value="${itemSpecInfoVO.face }" /> <span>&nbsp;cm&nbsp;&nbsp;&nbsp;&nbsp;宽</span>
						<input type="text" name="depth" class="inputText w10 double_text"
							maxlength="6" value="${itemSpecInfoVO.depth }" /> <span>&nbsp;cm&nbsp;&nbsp;&nbsp;&nbsp;高</span>
						<input type="text" name="hght" class="inputText w10 double_text"
							maxlength="6" value="${itemSpecInfoVO.hght }" /> <span>&nbsp;cm</span>
					</div>
				</div>
			</div>
			<div style="height: 205px; margin-top: 2px;" class="CM">
				<div class="CM-bar">
					<div>其他信息</div>
				</div>
				<div class="CM-div">
					<div class="ig" style="margin-top: 10px;">
						<div class="msg_txt">保存方式</div>
						<input class="inputText w20" name="storgCond" maxlength="13"
							value="${itemSpecInfoVO.storgCond}" /> <span>&nbsp;&nbsp;&nbsp;保质期标注方式&nbsp;</span>
						<auchan:select mdgroup="ITEM_SPEC_SHELF_LIFE_IND_METHD"
							_class="w20" name="shelfLifeIndMethd"
							value="${itemSpecInfoVO.shelfLifeIndMethd }" />
					</div>
					<div class="ig">
						<div class="msg_txt">保质期</div>
						<input type="text" name="stdShelfLifePerd" id="stdShelfLifePerd"
							class="w15 inputText fl_left count_text"
							onchange="getStdShelfLifeDaysAlter();" maxlength="4"
							value="${itemSpecInfoVO.stdShelfLifePerd }" />
						<div class="fl_left" style="width: 70px; margin-left: 5px;">
							<auchan:select mdgroup="ITEM_SPEC_PERD_UNIT_NAME"
								id="perdUnitName" _class="w90" 
								name="perdUnitName" value="${itemSpecInfoVO.perdUnitName }"
								onchange="getStdShelfLifeDaysAlter()" iscode="0" />
							<!-- <select class="w90"><option>年</option><option>月</option><option>日</option></select> -->
						</div>
						<span>或</span> <input type="text" id="stdShelfLifeDays"
							name="stdShelfLifeDays" class="w10 Black inputText count_text"
							maxlength="4" readonly="readonly"
							value="${itemSpecInfoVO.stdShelfLifeDays }" /> <span>天</span>
					</div>
					<div class="ig">
						<div class="msg_txt">健康商品</div>
						<div class="iconPut iq fl_left" style="width: 13%;">
							<input type="text" style="width: 60%" class="healthLbl"
								setValueObjId="healthLblName" clean="1" acWidth="100px"
								name="hlthLabel" value="${itemSpecInfoVO.hlthLabel }" />
							<div class="ListWin"
								onclick="$(this).prev().focus();$(this).prev().click();"></div>
						</div>
						<input class="inputText iq Black healthLblName"
							readonly="readonly" type="text" style="width: 20%;" />
					</div>
					<div class="ig">
						<div class="msg_txt">食用方法</div>
						<input type="text" name="edbleMethd" class="inputText w70"
							maxlength="13" value="${itemSpecInfoVO.edbleMethd }" />
					</div>
					<div style="height: 60px;">
						<div class="msg_txt">
							<div>成分说明</div>
						</div>
						<textarea class="w70 txtarea" name="ingrOrCntntDesc"
							maxlength="333" rows="2">${itemSpecInfoVO.ingrOrCntntDesc }</textarea>
					</div>
				</div>
			</div>
		</div>
		<div class="tb50">
			<div style="height: 120px;" class="CM">
				<div class="CM-bar">
					<div>包装与均价信息</div>
				</div>
				<div class="CM-div">
					<div class="bz_info">
						<div>
							<span class="bz_1">计量单位</span> <span class="bz_2">单位含量（容量）</span>
							<span class="bz_3">包装单位</span> <span class="bz_4">包装计数</span>
						</div>
					</div>
					<div class="ig">
						<span class="jksp">1&nbsp;</span> <input
							class="inputText iq Black" readonly="readonly" type="text"
							style="width: 10%;"
							<c:if test="${itemSpecInfoVO.sellUnit != null}">
	                           	value="<auchan:getDictValue code="${itemSpecInfoVO.sellUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
	                        </c:if> />
						<span class="fl_left">&nbsp;=&nbsp;</span> <input
							class="inputText iq count_text" name="numOfPackUnit" type="text"
							maxlength="2" style="width: 10%;"
							value="${itemSpecInfoVO.numOfPackUnit }" />
						<div class="iconPut iq fl_left" style="width: 10%;">
							<input type="text" acWidth="60px" class="w60 longText unitName"
								setValueObjId="packUnitName" name="perdUnitName" clean="1"
								value="${itemSpecInfoVO.packUnit }">
							<div class="ListWin"
								onclick="$(this).prev().focus();$(this).prev().click();"></div>
							<input type="hidden" class="packUnitName" name="packUnit" />
						</div>
						<span class="fl_left">&nbsp;x&nbsp;</span> <input
							class="inputText iq count_text" name="baseVol" type="text"
							maxlength="4" style="width: 20%;"
							value="${itemSpecInfoVO.baseVol }" />
						<div class="iconPut iq fl_left" style="width: 12%;">
							<input type="text" acWidth="60px" class="w60 longText unitName"
								setValueObjId="baseVolUnitName" clean="1"
								<c:if test="${itemSpecInfoVO.baseVolUnit != null}">
	                           	value="<auchan:getDictValue code="${itemSpecInfoVO.baseVolUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
	                        </c:if> />
							<div class="ListWin"
								onclick="$(this).prev().focus();$(this).prev().click();"></div>
							<input type="hidden" class="baseVolUnitName" name="baseVolUnit" />
						</div>
					</div>
					<div class="ig">
						<div class="msg_txt">均价倍数</div>
						<input type="text" name="avgMulti"
							class="inputText w20 fl_left double_text" maxlength="9"
							value="${itemSpecInfoVO.avgMulti }" />
						<div class="msg_txt">均价单位</div>
						<div class="iconPut iq fl_left" style="width: 12%;">
							<input type="text" acWidth="60px" class="w60 longText unitName"
								setValueObjId="avgUnitCode" clean="1"
								<c:if test="${itemSpecInfoVO.baseVolUnit != null}">
	                           	value="<auchan:getDictValue code="${itemSpecInfoVO.baseVolUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
	                        </c:if> />
							<div class="ListWin"
								onclick="$(this).prev().focus();$(this).prev().click();"></div>
							<input type="hidden" class="avgUnitCode" name="avgUnit" />
						</div>
					</div>
				</div>
			</div>
			<div style="height: 60px; margin-top: 2px;" class="CM">
				<div class="CM-bar">
					<div>广告语</div>
				</div>
				<div class="CM-div">
					<div class="ig" style="margin-top: 15px;">
						<div class="msg_txt">广告语</div>
						<div class="iconPut iq fl_left" style="width: 70%;">
							<input type="text" class="w93" id="advShowList"
								readonly="readonly" value="${adList2Str}">
							<div class="ListWin" onclick="openAdvWindowAlter();"></div>
							<input type="hidden" id="itemAdDescSet" name="itemAdDescSet" />
						</div>
					</div>
				</div>
			</div>
			<div style="height: 145px; margin-top: 2px;" class="CM">
				<div class="CM-bar">
					<div>课别属性</div>
				</div>
				<div class="CM-div">
					<div class="ig" style="margin-top: 15px;">
						<div class="msg_txt">属性1</div>
						<input class="inputText iq Black" type="text" readonly="readonly"
							style="width: 20%;" value="${clSecCtrl.secAttr1Name }" />
						<div class="iconPut iq fl_left" style="width: 13%;">
							<c:if test="${not empty clSecCtrl.secAttr1Name}">
								<input type="hidden" class="attrId" name="secAttr1ValId"
									id="secAttr1ValId">
							</c:if>
							<input type="text" style="width: 60%"
								<c:if test="${empty clSecCtrl.secAttr1Name}">readonly="readonly"</c:if>
								<c:if test="${not empty clSecCtrl.secAttr1Name}"> id="attrNo1" acCode="secAttrId" acTitle="secAttrValName" acWidth="66px" class="count_text" setValueObjId="attrVal" value="${secAttr1Val.secAttrValNo }" </c:if> />
							<div class="ListWin"></div>
						</div>
						<input class="inputText iq Black attrVal" type="text"
							readonly="readonly" style="width: 20%;" name="secAttr1Value"
							id="secAttr1Value" value="${secAttr1Val.secAttrValName }" />
					</div>
					<div class="ig">
						<div class="msg_txt">属性2</div>
						<input class="inputText iq Black" type="text" readonly="readonly"
							style="width: 20%;" value="${clSecCtrl.secAttr2Name }" />
						<div class="iconPut iq fl_left" style="width: 13%;">
							<c:if test="${not empty clSecCtrl.secAttr2Name}">
								<input type="hidden" class="attrId" name="secAttr2ValId"
									id="secAttr2ValId">
							</c:if>
							<input type="text" style="width: 60%"
								<c:if test="${empty clSecCtrl.secAttr2Name}">readonly="readonly"</c:if>
								<c:if test="${not empty clSecCtrl.secAttr2Name}"> id="attrNo2" acCode="secAttrId" acTitle="secAttrValName" acWidth="66px" class="count_text" setValueObjId="attrVal" value="${secAttr2Val.secAttrValNo }" </c:if> />
							<div class="ListWin"></div>
						</div>
						<input class="inputText iq Black attrVal" type="text"
							readonly="readonly" style="width: 20%;" name="secAttr2Value"
							id="secAttr2Value" value="${secAttr2Val.secAttrValName }" />
					</div>
					<div class="ig">
						<div class="msg_txt">属性3</div>
						<input class="inputText iq Black" type="text" readonly="readonly"
							style="width: 20%;" value="${clSecCtrl.secAttr3Name }" />
						<div class="iconPut iq fl_left" style="width: 13%;">
							<c:if test="${not empty clSecCtrl.secAttr3Name}">
								<input type="hidden" class="attrId" name="secAttr3ValId"
									id="secAttr3ValId">
							</c:if>
							<input type="text" style="width: 60%"
								<c:if test="${empty clSecCtrl.secAttr3Name}">readonly="readonly"</c:if>
								<c:if test="${not empty clSecCtrl.secAttr3Name}"> id="attrNo3" acCode="secAttrId" acTitle="secAttrValName" acWidth="66px" class="count_text" setValueObjId="attrVal" value="${secAttr3Val.secAttrValNo }" </c:if> />
							<div class="ListWin"></div>
						</div>
						<input class="inputText iq Black attrVal" type="text"
							readonly="readonly" style="width: 20%;" name="secAttr3Value"
							id="secAttr3Value" value="${secAttr3Val.secAttrValName }" />
					</div>
					<div class="ig">
						<div class="msg_txt">属性4</div>
						<input class="inputText iq Black" type="text" readonly="readonly"
							style="width: 20%;" value="${clSecCtrl.secAttr4Name }" />
						<div class="iconPut iq fl_left " style="width: 13%;">
							<c:if test="${not empty clSecCtrl.secAttr4Name}">
								<input type="hidden" class="attrId" name="secAttr4ValId"
									id="secAttr4ValId">
							</c:if>
							<input type="text" style="width: 60%"
								<c:if test="${empty clSecCtrl.secAttr4Name}">readonly="readonly"</c:if>
								<c:if test="${not empty clSecCtrl.secAttr4Name}"> id="attrNo4" acWidth="66px" class="count_text" setValueObjId="attrVal" value="${secAttr4Val.secAttrValNo }" </c:if> />
							<div class="ListWin"></div>
						</div>
						<input class="inputText iq Black attrVal" type="text"
							readonly="readonly" style="width: 20%;"
							value="${secAttr4Val.secAttrValName }" />
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<%-- <div style="height: 140px; margin-top: 2px;" class="CM">
	<div class="CM-bar">
		<div>证照信息</div>
	</div>
	<div class="CM-div">
		<div class="zz_info">
			<div class="zz_1">
				<span class="zz_11">证件类型</span> <span class="zz_12">证件号码</span> <span
					class="zz_13">发证机关</span> <span class="zz_14">截止日期</span> <span
					class="zz_15">起始日期</span>
			</div>
			<div class="zz_2">
				<c:forEach items="${listComLic}" var="lic">
					<div class="ig" style="margin-top: 5px; margin-left: 10px;">
						<div class="license1 fl_left">
							<div class="license2">${lic.licnceId}</div>
						</div>
						<input type="text" class="w17 inputText " value="${lic.licnceType}" /> 
						<input type="text" class="w20 inputText" value="${lic.licnceNo}" /> 
						<input type="text" class="w17 inputText" value="${lic.issueBy}" /> 
						<input type="text" class="w17 inputText" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${lic.vaildEndDate}"/>" />
						<input type="text" class="w17 inputText" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${lic.vaildStartDate}"/>"/>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div> --%>
