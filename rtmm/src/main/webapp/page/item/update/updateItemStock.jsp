<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ include file="/page/commons/knockout.jsp"%>
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

.tb50 {
	width: 40%;
}
.tagsM{
    min-width: 55px;
}
</style>
<script type="text/javascript">
	$(function() {
	    /*disabled the all toolbar.*/
	    setToolsbarAllDisable();
		//商品总览(tab)
		$('#ovreviewTab').unbind("click").bind( 'click', function() {
			var itemNo = '${sessionScope.itemNoSearch}';
			if(itemNo != null && itemNo != ""){
				searchItemByItemNo('${sessionScope.itemNoSearch}');
			}else{
				$('.Container').load(ctx + '/item/query/generalSearch', getParam());
			}
		});
		//变价信息(tab)
		$('#priceChangeTab').unbind("click").bind( 'click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemPriceChangeInfo', getParam());
		});
		//商品条码(tab)
		$('#barcodeInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemBarcodeInfo', getParam());
		});
		//商品关联(tab)
		$('#realativeInfoTab').unbind("click").bind('click', function() {
			$('.Container').load(ctx + '/item/query/itemRealativeInfo', getParam());
		});
		//商品厂商(tab)
		$('#supInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSupInfo', getParam());
		});
		//商品陈列(tab)
		$('#saleCtrlInfoTab').unbind("click").bind( 'click', function() {
			$('#ovreviewContent').load(ctx+ '/item/query/itemRealStoreSaleCtrlInfo',getParam());
	    });
		//DC信息(tab)
		$('#dcInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemDCInfo', getParam());
		});
		//商品产地(tab)
		$('#originInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemOriginInfo', getParam());
		});
		//商品供应区域(tab)
		$('#supAreaInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSupplierAreaInfo', getParam());
		});
		$("#itemStockClose").unbind().bind('click',function(){
			closeUptItemInfo('itemStockClose',getParam());
		});
		$("#Tools2").die().unbind().removeClass('Tools2_disable').addClass(
				'Tools2').bind('click', function() {
			valItemStockMsg();
	           if($('#updateItemSockForm').find(".errorInput").hasClass('errorInput')){
	        	      top.jAlert('warning','请更正不合法的修改信息','提示消息');
		        	  return false;
		           }
							$.ajax({
								type : 'post',
								url : ctx + '/item/update/saveUpdateItemStock',
								data : $('#updateItemSockForm').serialize(),
								success : function(data) {
									if (data.status == 'success') {
										top.jAlert('success','修改成功！','提示消息',function(){
											$('#ovreviewContent').load(ctx + '/item/query/itemRealStoreSaleCtrlInfo', getParam());
										});
									} else {
										top.jAlert('error','修改失败！','提示消息');
									}
								}

							});
		});

	});
</script>
<div class="CTitle">
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
	<div class="tagsM_q  tagsM_on">修改商品陈列信息</div>
	<div class="tags3_close_on">
		<div class="tags_close" id="itemStockClose"></div>
	</div>
</div>
<div class="Container-1">
	<div class="Content">
		<form id="updateItemSockForm">
			<div class="CInfo">
				<div style="float: left;" class="w25">
					<div class="cinfo_div">*店号</div>
					<select class="w65" id="storeNo" name="storeNo"
						onchange="changeItemStockByStoreNo(this.value)">
						<c:forEach items="${storeList}" var="store">
							<c:choose>
								<c:when test="${store.storeNo==storeNo}">
									<option value="${store.storeNo}" selected="selected">${store.storeNo}-${store.storeName}</option>
								</c:when>
								<c:otherwise>
									<option value="${store.storeNo}">${store.storeNo}-${store.storeName}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</div>
			</div>
			<div style="height: 60px;" class="CM">
				<div class="CM-bar">
					<div>货号</div>
				</div>
				<div class="CM-div">
					<div class="hh_item">
						<div class="icol_text w7">
							<span>*货号</span>
						</div>
						<div class="iconPut iq" style="width: 6%;">
							<input id="itemNo" name="itemNo" style="width: 100%;" type="text" value="${itemNo}" readonly="readonly"/>
						</div>
						<input id="itemName" name="itemName" class="inputText iq Black" style="width: 20%;" type="text" value="${itemName }" readonly="readonly"/>
					</div>
				</div>
			</div>
			<div style="height: 300px;margin-top: 2px;"  class="CM">
				<div class="tb50">
					<div style="height: 180px;" class="CM">
						<div class="CM-bar">
							<div>陈列信息</div>
						</div>
						<div class="CM-div">
							<div class="ig" style="margin-top: 15px;">
								<div class="msg_txt">*陈列等级</div>
								<auchan:select id="displyLvl" mdgroup="ITEM_REAL_STORE_SALE_CTRL_DISPLY_LVL" name="displyLvl" value="${itemRealStoreSaleCtrlVO.displyLvl}"></auchan:select>
							</div>
							<div style="height: 120px;">
								<div class="tb50">
									<div class="ig">
										<div class="msg_txt" style="width: 45%; margin-right: 9px;">首排面量</div>
										<input id="width" class="w44 inputText" name="width" value="${itemRealStoreSaleCtrlVO.width}" onblur="valWidth(this)"/>
									</div>
									<div class="ig">
										<div class="msg_txt" style="width: 45%; margin-right: 9px;">层数</div>
										<input id="layer" class="w44 inputText" name="layer" value="${itemRealStoreSaleCtrlVO.layer}" onblur="valLayer(this)" />
									</div>
									<div class="ig">
										<div class="msg_txt" style="width: 45%; margin-right: 9px;">深度</div>
										<input id="depth" class="w44 inputText" name="depth" value="${itemRealStoreSaleCtrlVO.depth}" onblur="valDepth(this)"  />
									</div>
									<div class="ig">
										<div class="msg_txt" style="width: 45%; margin-right: 9px;">排面容量</div>
										<input id="sumCapacity" class="w44 inputText" readonly="readonly"/>
									</div>
								</div>
								<div class="tb49">
									<div class="ig">
										<div class="msg_txt" style="width: 45%;">最小首排面量(y)</div>
										<input class="w35 inputText" id="minWidth" name="minWidth" value="${itemRealStoreSaleCtrlVO.minWidth}"  onblur="valMinWidth(this)"/>
									</div>
									<div class="ig">
										<div class="msg_txt" style="width: 45%;">最小层数(x)</div>
										<input class="w35 inputText" id="minLayer" name="minLayer" value="${itemRealStoreSaleCtrlVO.minLayer}"  onblur="valMinLayer(this)"/>
									</div>
									<div class="ig">
										<div class="msg_txt" style="width: 45%;">最小深度(z)</div>
										<input class="w35 inputText" id="minDepth" name="minDepth" value="${itemRealStoreSaleCtrlVO.minDepth}" onblur="valMinDepth(this)"/>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 118px; margin-top: 2px;" class="CM">
						<div class="CM-bar">
							<div>货架卡信息</div>
						</div>
						<div class="CM-div">
							<div class="ig" style="margin-top: 15px;">
								<div class="msg_txt">*货架卡</div>
								<auchan:select mdgroup="ITEM_REAL_STORE_SALE_CTRL_RAILCARD" name="railcard" value="${itemRealStoreSaleCtrlVO.railcard}"></auchan:select>
								<span>&nbsp;&nbsp;&nbsp;下架临保天数&nbsp;</span>
								<input type="text" class="w10 inputText" name="offShelfDays" onblur="valNumOnBlur(this,4)"/>
								<span>&nbsp;天</span>
							</div>
							<div class="ig">
								<div class="msg_txt">列印序号</div>
								<input type="text" class="inputText w15" name="printSeq" value="${itemRealStoreSaleCtrlVO.printSeq}" onblur="valNumOnBlur(this,3)"/>
							</div>
							<div class="ig">
								<div class="msg_txt">货架卡列印张数</div>
								<input type="text" class="inputText w15" name="numRailcard" value="${itemRealStoreSaleCtrlVO.numRailcard}" onblur="valNumOnBlur(this,2)"/>
							</div>
						</div>
					</div>
				</div>
				<div class="tb50">
					<div style="height: 300px;" class="CM">
						<div class="CM-bar">
							<div>磅秤机信息</div>
						</div>
						<div class="CM-div">
							<div class="ig" style="margin-top: 15px;">
								<div class="msg_txt">磅秤机品名</div>
								<div style="float: left; width: 295px;">
									<input type="text" class="inputText w95" name="scaleName" value="${itemRealStoreSaleCtrlVO.scaleName}" onblur="valStrOnBlur(this,24)"/>
								</div>
							</div>
							<div style="height: 60px;">
								<div class="msg_txt">
									<div>磅秤机备注</div>
								</div>
								<textarea class="w70 txtarea" rows="2" name="scaleMemo" onblur="valStrOnBlur(this,10)" >${itemRealStoreSaleCtrlVO.scaleMemo} </textarea>
							</div>
							<div class="ig">
								<div class="msg_txt">*磅秤机变价</div>
								<auchan:select mdgroup="ITEM_REAL_STORE_SALE_CTRL_SCALE_UPDT_SP_IND" name="scaleUpdtSpInd" value="${itemRealStoreSaleCtrlVO.scaleUpdtSpInd}"></auchan:select>
								<span>&nbsp;&nbsp;&nbsp;*磅秤机标签类型&nbsp;</span>
								<auchan:select mdgroup="ITEM_REAL_STORE_SALE_CTRL_SCALE_LABEL_TYPE" name="scaleLabelType" value="${itemRealStoreSaleCtrlVO.scaleLabelType}"></auchan:select>
							</div>
							<div class="ig">
								<div class="msg_txt">*下传包装机</div>
								<auchan:select mdgroup="ITEM_REAL_STORE_SALE_CTRL_DWNLD_TO_PACKG_MACH" name="dwnldToPackgMach"
									value="${itemRealStoreSaleCtrlVO.dwnldToPackgMach}"></auchan:select>
								<span>&nbsp;&nbsp;&nbsp;*追溯码&nbsp;</span>
								<auchan:select mdgroup="ITEM_REAL_STORE_SALE_CTRL_QLTY_TRACE_TYPE" name="qltyTraceType" value="${itemRealStoreSaleCtrlVO.qltyTraceType}">
								</auchan:select>
							</div>
							<div class="ig">
								<div class="msg_txt">去皮</div>
								<input class="w20 inputText" type="text" name="scalePeelWght" value="${itemRealStoreSaleCtrlVO.scalePeelWght}" onblur="valFloatNumOnBlur(this,2,2)"/>
								<span>&nbsp;g</span>

							</div>
						</div>
					</div>
				</div>
			</div>
<!-- 			<div style="height: 140px; margin-top: 2px;" class="CM">
				<div class="CM-bar">
					<div>证照信息</div>
				</div>
				<div class="CM-div">
					<div class="zz_info">
						<div class="zz_1">
							<span class="zz_11">证件类型</span>
							<span class="zz_12">证件号码</span>
							<span class="zz_13">发证机关</span>
							<span class="zz_14">截止日期</span>
							<span class="zz_15" style="margin-left: 40px">是否列印在货架卡上</span>
						</div>
						<div class="zz_2">
							<div class="ig" style="margin-top: 5px; margin-left: 10px;">
								<div class="license1 fl_left">
									<div class="license2"></div>
								</div>
								<input type="text" class="w17 inputText Black" />
								<input type="text" class="w20 inputText Black" />
								<input type="text" class="w17 inputText Black" />
								<input type="text" class="w17 inputText Black" />
								<select class="w17">
									<option></option>
								</select>
							</div>
							<div class="ig" style="margin-left: 10px;">
								<div class="license1 fl_left">
									<div class="license2"></div>
								</div>
								<input type="text" class="w17 inputText" />
								<input type="text" class="w20 inputText" />
								<input type="text" class="w17 inputText" />
								<input type="text" class="w17 inputText" />
								<select class="w17">
									<option></option>
								</select>
							</div>
						</div>
					</div>
				</div>
			</div> -->
		</form>
	</div>
</div>