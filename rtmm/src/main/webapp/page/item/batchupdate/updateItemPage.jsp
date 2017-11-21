<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/catalog/catalog.js" type="text/javascript"></script>
<%-- <link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/noticeInfoPage.css" /> --%>
<style>
.CInfo .combo,.CInfo input {
	background-color: #cccccc;
}

.iq {
	width: 95%;
}

.htable_div div {
	border-right: solid 1px #ccc;
}

.btable_div td {
	border-right: solid 1px #fff;
}

.btable_checked td {
	border-right: 1px solid #3F9673;
}

.btable_div tr:hover td {
	border-right: 1px solid #9c6;
}

.iconPut {
	background: #fff;
}

.is_col0 {
	width: 2px;
}

.his_col0 {
	width: 20px;
}

.s1_col {
	width: 145px;
}

.t2_col {
	width: 291px;
}

.right_c {
	text-align: right;
}
.btable_div tr {
	line-height : 20px;
}
</style>
<div class="htable_div">
	<table>
		<thead>
			<tr class="tr_special1">
				<td>
					<div class="s1_col">货号</div>
				</td>
				<c:if test='${fn:indexOf(fields, "itemName")>=0}'>
					<td colspan="2">
						<div class="t2_col">品名</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "itemEnName")>=0}'>
					<td colspan="2">
						<div class="t2_col">英文名</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "catlgId")>=0}'>
					<td colspan="2">
						<div class="t2_col">大中小分类</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "brandId")>=0}'>
					<td colspan="2">
						<div class="t2_col">品牌</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "itemType")>=0}'>
					<td colspan="2">
						<div class="t2_col">商品类别</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "validDate")>=0}'>
					<td colspan="2">
						<div class="t2_col" style="width: 400px;">有效期间</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "itemPack")>=0}'>
					<td colspan="2">
						<div class="t2_col">商品包装</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "prcssType")>=0}'>
					<td colspan="2">
						<div class="t2_col">加工类别</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyPerd")>=0}'>
					<td colspan="2">
						<div class="t2_col">采购期限</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "barcodeLabel")>=0}'>
					<td colspan="2">
						<div class="t2_col">条码标签</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "sellUnit")>=0}'>
					<td colspan="2">
						<div class="t2_col">销售单位</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyVatNo")>=0}'>
					<td colspan="2">
						<div class="t2_col">进价税率</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "sellVatNo")>=0}'>
					<td colspan="2">
						<div class="t2_col">售价税率</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyWhen")>=0}'>
					<td colspan="2">
						<div class="t2_col">成本时点</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "txtCode")>=0}'>
					<td colspan="2">
						<div class="t2_col">纺织项目编号</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "orignCtrl")>=0}'>
					<td colspan="2">
						<div class="t2_col">产地维护</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyMemo")>=0}'>
					<td colspan="2">
						<div class="t2_col">采购备注</div>
					</td>
				</c:if>
				<td colspan="2">
					<div class="t2_col">&nbsp;</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="s1_col">&nbsp;</div>
				</td>
				<c:if test='${fn:indexOf(fields, "itemName")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "itemEnName")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "catlgId")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "brandId")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "itemType")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "validDate")>=0}'>
					<td>
						<div class="s1_col" style="width: 200px;">旧</div>
					</td>
					<td>
						<div class="s1_col" style="width: 200px;">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "itemPack")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "prcssType")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyPerd")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "barcodeLabel")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "sellUnit")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyVatNo")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "sellVatNo")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyWhen")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "txtCode")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "orignCtrl")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyMemo")>=0}'>
					<td>
						<div class="s1_col">旧</div>
					</td>
					<td>
						<div class="s1_col">新</div>
					</td>
				</c:if>
				<td colspan="2">
					<div class="t2_col">&nbsp;</div>
				</td>
			</tr>
		</thead>
	</table>
</div>

<div class="btable_div" style="height: 400px;">
	<form id="myForm">
		<input type="hidden" name="fields" value="${fields}">
		<table>
			<tr>
				<td>
					<div class="s1_col">&nbsp;</div>
				</td>
				<c:if test='${fn:indexOf(fields, "itemName")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col ">
							<input type="text" class="w95 inputText" name="itemNameHeader"
								onkeydown="return valiChar(this,event,20)">
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "itemEnName")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<input type="text" class="w95 inputText" name="itemEnNameHeader"
								onkeydown="return valiChar(this,event,20)">
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "catlgId")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<input type="text" class="w95 inputText" readonly="readonly"
								name="catlgCodeHeader" onclick="selectSubGroupNo()"> <input
								type="hidden" name="catlgIdHeader">
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "brandId")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<input type="text" class="w95 inputText" name="brandCodeHeader"
								onclick="openBrandWindow()" readonly="readonly"> <input
								type="hidden" name="brandIdHeader">
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "itemType")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<auchan:select mdgroup="ITEM_BASIC_ITEM_TYPE"
								name="itemTypeHeader" style="width:70px;"></auchan:select>
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "validDate")>=0}'>
					<td>
						<div class="s1_col" style="width: 200px;"></div>
					</td>
					<td>
						<div class="s1_col" style="width: 200px;">
							<input class="Wdate w45" type="text" name="validStartDateHeader"
								onclick="WdatePicker({readOnly:true})" readonly="readonly" /> <input
								class="Wdate w45" type="text" name="validEndDateHeader"
								onclick="WdatePicker({readOnly:true})" readonly="readonly" />
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "itemPack")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<auchan:select mdgroup="ITEM_BASIC_ITEM_PACK"
								name="itemPackHeader" _class="w95"></auchan:select>
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "prcssType")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<auchan:select mdgroup="ITEM_BASIC_PRCSS_TYPE"
								name="prcssTypeHeader" _class="w95"></auchan:select>
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyPerd")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<auchan:select mdgroup="ITEM_BASIC_BUY_PERD" name="buyPerdHeader"
								_class="w95"></auchan:select>
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "barcodeLabel")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<auchan:select mdgroup="ITEM_BASIC_BARCODE_LABEL"
								name="barcodeLabelHeader" _class="w95"></auchan:select>
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "sellUnit")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<auchan:select mdgroup="UNIT" name="sellUnitHeader"
								_class="w50"></auchan:select>
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyVatNo")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<select name="buyVatNoHeader" class="w95">
								<option>请选择</option>
								<c:forEach items="${rates}" var="rate">
									<option value="${rate.vatNo}">${rate.vatVal}%</option>
								</c:forEach>
							</select>
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "sellVatNo")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<select name="sellVatNoHeader" class="w95">
								<option>请选择</option>
								<c:forEach items="${rates}" var="rate">
									<option value="${rate.vatNo}">${rate.vatVal}%</option>
								</c:forEach>
							</select>
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyWhen")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<auchan:select mdgroup="ITEM_BASIC_BUY_WHEN" name="buyWhenHeader"
								_class="w70"></auchan:select>
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "txtCode")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<input type="text" class="w95 inputText" name="txtCodeHeader"
								onkeydown="return valiChar(this,event,10)">
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "orignCtrl")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<auchan:select mdgroup="ITEM_BASIC_ORIGIN_CTRL"
								name="orignCtrlHeader" style="width:70px;"></auchan:select>
						</div>
					</td>
				</c:if>
				<c:if test='${fn:indexOf(fields, "buyMemo")>=0}'>
					<td>
						<div class="s1_col"></div>
					</td>
					<td>
						<div class="s1_col">
							<input type="text" class="w95 inputText" name="buyMemoHeader"
								onkeydown="return valiChar(this,event,16)">
						</div>
					</td>
				</c:if>
			</tr>
			<c:forEach items="${page.result}" var="data">
				<tr>
					<td>
						<div class="s1_col align_right">${data.itemNo}&nbsp;&nbsp;<input
								type="hidden" name="itemNo" value="${data.itemNo}">
						</div>
					</td>
					<c:if test='${fn:indexOf(fields, "itemName")>=0}'>
						<td>
							<div class="s1_col" title="${data.itemName}">${data.itemName}</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="itemName"
									maxlength="30" onkeydown="return valiChar(this,event,20)">
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "itemEnName")>=0}'>
						<td>
							<div class="s1_col" title="${data.itemEnName}">${data.itemEnName}</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="itemEnName"
									maxLength="60" onkeydown="return valiChar(this,event,20)" />
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "catlgId")>=0}'>
						<td>
							<div class="s1_col">
								<div class="s1_col" title="${data.catlgName}">${data.catlgName}</div>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" id="catlgCode_${data.itemNo}"
									class="w95 inputText" readonly="readonly" name="catlgCode"
									onclick="selectSubGroupNo('${data.itemNo}')"> <input
									type="hidden" id="catlgId_${data.itemNo}" name="catlgId">
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "brandId")>=0}'>
						<td>
							<div class="s1_col align_right">${data.brandId}</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" id="brandCode_${data.itemNo}"
									class="w95 inputText" name="brandCode"
									onclick="openBrandWindow('${data.itemNo}')" readonly="readonly">
								<input type="hidden" id="brandId_${data.itemNo}" name="brandId">
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "itemType")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_BASIC_ITEM_TYPE"
									code="${data.itemType}"></auchan:getDictValue>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_BASIC_ITEM_TYPE" name="itemType"
									style="width:70px;"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "validDate")>=0}'>
						<td>
							<div class="s1_col" style="width: 200px;">
								<fmt:formatDate pattern="yyyy-MM-dd"
									value="${data.validStartDate}" />
								&nbsp;
								<fmt:formatDate pattern="yyyy-MM-dd"
									value="${data.validEndDate}" />
							</div>
						</td>
						<td>
							<div class="s1_col" style="width: 200px;">
								<input class="Wdate w45" type="text" name="validStartDate"
									onclick="WdatePicker({readOnly:true})" readonly="readonly" />
								<input class="Wdate w45" type="text" name="validEndDate"
									onclick="WdatePicker({readOnly:true})" readonly="readonly" />
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "itemPack")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_BASIC_ITEM_PACK"
									code="${data.itemPack}"></auchan:getDictValue>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_BASIC_ITEM_PACK" name="itemPack"
									_class="w95"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "prcssType")>=0}'>
						<td>
							<div class="s1_col"
								title="<auchan:getDictValue mdgroup="ITEM_BASIC_PRCSS_TYPE" code="${data.prcssType}"></auchan:getDictValue>">
								<auchan:getDictValue mdgroup="ITEM_BASIC_PRCSS_TYPE"
									code="${data.prcssType}"></auchan:getDictValue>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_BASIC_PRCSS_TYPE" name="prcssType"
									_class="w95"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "buyPerd")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_BASIC_BUY_PERD"
									code="${data.buyPerd}"></auchan:getDictValue>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_BASIC_BUY_PERD" name="buyPerd"
									_class="w95"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "barcodeLabel")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_BASIC_BARCODE_LABEL"
									code="${data.barcodeLabel}"></auchan:getDictValue>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_BASIC_BARCODE_LABEL"
									name="barcodeLabel" _class="w95"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "sellUnit")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="UNIT" code="${data.sellUnit}"></auchan:getDictValue>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="UNIT" name="sellUnit"
									_class="w50"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "buyVatNo")>=0}'>
						<td>
							<div class="s1_col align_right">${data.buyVatVal}&nbsp;&nbsp;</div>
						</td>
						<td>
							<div class="s1_col">
								<select name="buyVatNo" class="w95">
									<option>请选择</option>
									<c:forEach items="${rates}" var="rate">
										<option value="${rate.vatNo}">${rate.vatVal}%</option>
									</c:forEach>
								</select>
							</div> <!-- 							<input type="text" class="w95 inputText" name="buyVatNo"> -->
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "sellVatNo")>=0}'>
						<td>
							<div class="s1_col align_right">${data.sellVatVal}&nbsp;&nbsp;</div>
						</td>
						<td>
							<div class="s1_col">
								<select name="sellVatNo" class="w95">
									<option>请选择</option>
									<c:forEach items="${rates}" var="rate">
										<option value="${rate.vatNo}">${rate.vatVal}%</option>
									</c:forEach>
								</select>
							</div> <!-- 		<div class="s1_col">
								<input type="text" class="w95 inputText" name="sellVatNo">
							</div> -->
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "buyWhen")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_BASIC_BUY_WHEN"
									code="${data.buyWhen}"></auchan:getDictValue>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_BASIC_BUY_WHEN" name="buyWhen"
									_class="w70"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "txtCode")>=0}'>
						<td>
							<div class="s1_col " title="${data.txtCode}">${data.txtCode}</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="txtCode"
									onkeydown="return valiChar(this,event,10)">
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "orignCtrl")>=0}'>
						<td>
							<div class="s1_col">
								<auchan:getDictValue mdgroup="ITEM_BASIC_ORIGIN_CTRL"
									code="${data.orignCtrl}"></auchan:getDictValue>
							</div>
						</td>
						<td>
							<div class="s1_col">
								<auchan:select mdgroup="ITEM_BASIC_ORIGIN_CTRL" name="orignCtrl"
									style="width:70px;"></auchan:select>
							</div>
						</td>
					</c:if>
					<c:if test='${fn:indexOf(fields, "buyMemo")>=0}'>
						<td>
							<div class="s1_col">${data.buyMemo}</div>
						</td>
						<td>
							<div class="s1_col">
								<input type="text" class="w95 inputText" name="buyMemo"
									onkeydown="return valiChar(this,event,16)">
							</div>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
	</form>
</div>
<script type="text/javascript">
	$(function() {
		$(".btable_div").scroll(function() {
			$(".htable_div").scrollLeft($(this).scrollLeft());
		});
		if ('${fn:indexOf(fields, "itemName")>=0}' == 'true') {
			$('input[name=itemNameHeader]').bind('change', function() {
				$('input[name=itemName]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "itemEnName")>=0}' == 'true') {
			$('input[name=itemEnNameHeader]').bind('change', function() {
				$('input[name=itemEnName]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "catlgId")>=0}' == 'true') {
			$('input[name=catlgCodeHeader]').bind(
					'change',
					function() {
						$('input[name=catlgCode]').attr('value', this.value);
						$('input[name=catlgId]').attr('value',
								$('input[name=catlgIdHeader]').val());
					});
		}
		if ('${fn:indexOf(fields, "brandId")>=0}' == 'true') {
			$('input[name=brandCodeHeader]').bind(
					'change',
					function() {
						$('input[name=brandCode]').attr('value', this.value);
						$('input[name=brandId]').attr('value',
								$('input[name=brandIdHeader]').val());
					});
		}
		if ('${fn:indexOf(fields, "itemType")>=0}' == 'true') {
			$('select[name=itemTypeHeader]').bind('change', function() {
				$('select[name=itemType]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "validDate")>=0}' == 'true') {
			/*judge if the start date header is bigger than the end date header.*/
			$('input[name=validStartDateHeader]').unbind().bind(
					'blur',
					function() {
						var validEndDateHeader = $(
								'input[name=validEndDateHeader]').val();
						if (validEndDateHeader != undefined
								&& validEndDateHeader != ""
								&& $(this).val() != undefined
								&& $(this).val() != "") {
							if (this.value > validEndDateHeader) {
								$(this).addClass("errorInput");
								$(this).attr("title", "开始日期应小于结束日期");
							} else {
								$(this).removeClass("errorInput");
								$(this).removeAttr("title");
								$('input[name=validEndDateHeader]')
										.removeClass("errorInput");
								$('input[name=validEndDateHeader]')
										.removeClass("errorInput");
							}
						} else {
							$(this).removeClass("errorInput");
							$(this).removeAttr("title");
							$('input[name=validEndDateHeader]').removeClass(
									"errorInput");
							$('input[name=validEndDateHeader]').removeClass(
									"errorInput");
						}
						$('input[name=validStartDate]').attr('value',
								this.value);
						$('input[name=validStartDate]').blur();
					});
			/*judge if the start date header is bigger than the end date header.*/
			$('input[name=validEndDateHeader]').unbind()
					.bind('blur',
							function() {
								var validStartDateHeader = $(
										'input[name=validStartDateHeader]')
										.val();
								if (validStartDateHeader != undefined
										&& validStartDateHeader != ""
										&& $(this).val() != undefined
										&& $(this).val() != "") {
									if (this.value < validStartDateHeader) {
										$(this).addClass("errorInput");
										$(this).attr("title", "开始日期应小于结束日期");
									} else {
										$(this).removeClass("errorInput");
										$(this).removeAttr("title");
										$('input[name=validStartDateHeader]')
												.removeClass("errorInput");
										$('input[name=validStartDateHeader]')
												.removeClass("errorInput");
									}
								} else {
									$(this).removeClass("errorInput");
									$(this).removeAttr("title");
									$('input[name=validStartDateHeader]')
											.removeClass("errorInput");
									$('input[name=validStartDateHeader]')
											.removeClass("errorInput");
								}
								$('input[name=validEndDate]').attr('value',
										this.value);
								$('input[name=validEndDate]').blur();
							});
			/*judge if the start date is bigger than the end date.*/
			$('input[name=validStartDate]').unbind().bind(
					'blur',
					function() {
						var thisEndDate = $(this).parent().find(
								"input[name=validEndDate]");
						if ($(thisEndDate).val() != undefined
								&& $(thisEndDate).val() != ""
								&& $(this).val() != undefined
								&& $(this).val() != "") {
							if ($(this).val() > $(thisEndDate).val()) {
								$(this).addClass("errorInput");
								$(this).attr("title", "开始日期应小于或等于结束日期");
							} else {
								$(this).removeClass("errorInput");
								$(this).removeAttr("title");
								$(thisEndDate).removeClass("errorInput");
								$(thisEndDate).removeAttr("title");
							}
						} else {
							$(this).removeClass("errorInput");
							$(this).removeAttr("title");
							$(thisEndDate).removeClass("errorInput");
							$(thisEndDate).removeAttr("title");
						}
					});
			/*judge if the start date is bigger than the end date.*/
			$('input[name=validEndDate]').unbind().bind(
					'blur',
					function() {
						var thisStartDate = $(this).parent().find(
								"input[name=validStartDate]");
						if ($(thisStartDate).val() != undefined
								&& $(thisStartDate).val() != ""
								&& $(this).val() != undefined
								&& $(this).val() != "") {
							if ($(this).val() < $(thisStartDate).val()) {
								$(this).addClass("errorInput");
								$(this).attr("title", "开始日期应小于或等于结束日期");
							} else {
								$(this).removeClass("errorInput");
								$(this).removeAttr("title");
								$(thisStartDate).removeClass("errorInput");
								$(thisStartDate).removeAttr("title");
							}
						} else {
							$(this).removeClass("errorInput");
							$(this).removeAttr("title");
							$(thisStartDate).removeClass("errorInput");
							$(thisStartDate).removeAttr("title");
						}
					});

		}
		if ('${fn:indexOf(fields, "itemPack")>=0}' == 'true') {
			$('select[name=itemPackHeader]').bind('change', function() {
				$('select[name=itemPack]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "prcssType")>=0}' == 'true') {
			$('select[name=prcssTypeHeader]').bind('change', function() {
				$('select[name=prcssType]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "buyPerd")>=0}' == 'true') {
			$('select[name=buyPerdHeader]').bind('change', function() {
				$('select[name=buyPerd]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "barcodeLabel")>=0}' == 'true') {
			$('select[name=barcodeLabelHeader]').bind('change', function() {
				$('select[name=barcodeLabel]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "sellUnit")>=0}' == 'true') {
			$('select[name=sellUnitHeader]').bind('change', function() {
				$('select[name=sellUnit]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "buyVatNo")>=0}' == 'true') {
			$('select[name=buyVatNoHeader]').bind('change', function() {
				$('select[name=buyVatNo]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "sellVatNo")>=0}' == 'true') {
			$('select[name=sellVatNoHeader]').bind('change', function() {
				$('select[name=sellVatNo]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "buyWhen")>=0}' == 'true') {
			$('select[name=buyWhenHeader]').bind('change', function() {
				$('select[name=buyWhen]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "txtCode")>=0}' == 'true') {
			$('input[name=txtCodeHeader]').bind('change', function() {
				$('input[name=txtCode]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "orignCtrl")>=0}' == 'true') {
			$('select[name=orignCtrlHeader]').bind('change', function() {
				$('select[name=orignCtrl]').attr('value', this.value);
			});
		}
		if ('${fn:indexOf(fields, "buyMemo")>=0}' == 'true') {
			$('input[name=buyMemoHeader]').bind('change', function() {
				$('input[name=buyMemo]').attr('value', this.value);
			});
		}

		$("#Tools2").attr('class', "Tools2").unbind('click')
				.bind(
						"click",
						function() {
							if ($('#myForm').find(".errorInput").hasClass(
									'errorInput')) {
								top.jAlert('warning', '请更正不合法的修改信息', '提示消息');
								return false;
							}
							$.ajax({
								async : false,
								url : ctx + '/item/batchupdate/saveBaseInfo',
								data : $('#myForm').serialize(),
								type : 'POST',
								success : function(data) {
									if (data.status == 'success') {
										top.jAlert("success", '保存成功！', "提示信息");
										$("#flag").val("false");
									} else if (data.status == 'warn') {
										top.jAlert('warning', data.message,
												'提示消息');
									} else {
										top.jAlert('error', '保存失败！！', '提示消息');
									}
								},
								error : function() {
									isValid = false; // however you would like to handle this
								}
							});
						});
	});
</script>
<input type="hidden" name="fields" value="${fields}">
<input type="hidden" name="itemNumModStr" value="${itemNumModStr}">