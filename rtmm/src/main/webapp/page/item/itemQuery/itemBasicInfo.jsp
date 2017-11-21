<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/item/itemUpdate.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
	
<style type="text/css">
._w120 {
	width: 120px;
}

._w80 {
	width: 80px;
}

._w83 {
	width: 83px;
}

._w90 {
	width: 90px;
}

.i_input1_2 {
	float: left;
	height: 30px;
	width: 33%;
}

.ib_2 {
	float: left;
	width: 32%;
}

.edit_div {
	width: 20px;
	height: 20px;
	float: left;
	margin-left: 5px;
}

.iq {
	width: 25%;
}

.tiaoma {
	float: left;
	line-height: 25px;
	margin-left: 10px;
	margin-right: 5px;
}
</style>



<div id="itemBaseInfoContainer">
	<!-- 商品信息管理 -->
	<div class="CTitle" id="itemOverViewTitle">
		<!--第一个-->
		<div class="tags1_left tags1_left_on"></div>
		<div class="tagsM tagsM_on" id="ovreviewTab">商品总览</div>
		<div class="tags tags_left_on"></div>
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
		<div class="tags "></div>
		<div class="tagsM" id="originInfoTab">商品产地</div>
		<div class="tags "></div>
		<div class="tagsM " id="supAreaInfoTab">商品供应区域</div>
		<div class="tags tags3_r_off"></div>		
	</div>



	<div class="Container-1">
		<div class="Content" id="Content">
			<!-- 标头信息 -->
			<div class="CInfo">
				<div style="float: left;" class="w25">
					<div class="cinfo_div">店号</div>
					<select class="w65" id="storeNo" name="storeNo"
						onchange="changeStoreNo(this.value)">
						<c:forEach items="${storeList}" var="store">
							<option value="${store.storeNo}" title="${store.storeNo}-${store.storeName}"
								<c:if test="${storeNo == store.storeNo}">selected</c:if>>${store.storeNo}-${store.storeName}</option>
						</c:forEach>
					</select>
				</div>
				<span>项</span> <span class="canEmpty">${total}</span> <span>/</span>
				<span class="canEmpty">${page}</span> <span>第</span> <span>|</span>
				<span class="canEmpty"><auchan:getStuffName value="${itemBasicVO.chngBy}"/></span> <span>修改人</span>
				<span class="canEmpty"><fmt:formatDate pattern="yyyy-MM-dd"
						value="${itemBasicVO.chngDate}" /></span> <span>修改日期</span> <span
					class="canEmpty"><auchan:getStuffName value="${itemBasicVO.creatBy}"/></span> <span>建档人</span> <span
					class="canEmpty"><fmt:formatDate pattern="yyyy-MM-dd"
						value="${itemBasicVO.creatDate}" /></span> <span>创建日期</span>
			</div>
			<!-- 基本信息 -->
			<div style="height: 270px;" id="baseItemInfo" class="CM">
				<div class="CM-bar">
					<div>基本信息</div>
				</div>
				<div class="CM-div">
					<div class="ic">
						<div class="pic_1">
							<!-- 图片信息 -->
							<img width="111" height="111" id="itemBaseInfoImg"
								src="${ctx}/shared/themes/theme1/images/defaultImg.png">
								<c:if test="${itemBasicVO ne null}"> 
							<div class="pic_21">
								<div class="look_pic edit_div" id="lookandUpdateItemPic"></div>
								<div class="edit_pic edit_div" id="readAndUpdateItemPic"></div>
							</div>
							</c:if>
						</div>
						<div class="item11_1">
							<!--1-->
							<div class="icol_text w7">
								<span>货号</span>
							</div>
							<div class="i_input1_2">
								<div class="iconPut ib_2">
									<input type="text" class="w75 count_text" id="itemNo"
										value="${itemBasicVO.itemNo}" placeholder="输入货号"
										readonly="readonly" onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
									<div class="ListWin" onclick="chooseItemNo();"></div>
								</div>
								<div class="icol_text w12_5">
									<span>条码</span>
								</div>
								<div class="iconPut ib">
									<input type="text" class="w80" id="barcode"  placeholder="输入条码" readonly="readonly" maxlength="14" value="${barcodeSearch}"/>
									<div class="ListWin" onclick="chooseItemBarcode();"></div>
								</div>
							</div>
							<div class="icol_text w10">
								<span>采购方式</span>
							</div>
							<div class="i_input2">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.buyMethd != null}">
		                                   	value="<auchan:getDictValue code="${itemBasicVO.buyMethd}" mdgroup="ITEM_BASIC_BUY_METHD"></auchan:getDictValue>"
		                            </c:if> />
							</div>
							<div class="icol_text w10">
								<span>项目类型</span>
							</div>
							<div class="i_input3">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.projLabel != null}">
	                                   	value="<auchan:getDictValue code="${itemBasicVO.projLabel}" mdgroup="ITEM_BASIC_PROJ_LABEL">
	                                   		   </auchan:getDictValue>"
                                   	</c:if> />
							</div>
							<!--1-->
							<div class="icol_text w7">
								<span>品名</span>
							</div>
							<div class="i_input1_2">
								<input type="text" id="itemName" class="inputText w90_5"
									value="${itemBasicVO.itemName}" readonly="readonly" />
							</div>
							<div class="icol_text w10">
								<span>商品类别</span>
							</div>
							<div class="i_input2">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.itemType != null}">
	                                   	value="<auchan:getDictValue code="${itemBasicVO.itemType}" mdgroup="ITEM_BASIC_ITEM_TYPE">
	                                   		   </auchan:getDictValue>"
                                   	</c:if> />
							</div>
							<div class="icol_text w10">
								<span>加工类别</span>
							</div>
							<div class="i_input3">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.prcssType != null}">
	                                    value="<auchan:getDictValue code="${itemBasicVO.prcssType}" mdgroup="ITEM_BASIC_PRCSS_TYPE"></auchan:getDictValue>"
                                    </c:if> />
							</div>
							<!--1-->
							<div class="icol_text w7">
								<span>英文品名</span>
							</div>
							<div class="i_input1_2">
								<input type="text" class="inputText w90_5"
									value="${itemBasicVO.itemEnName}" readonly="readonly" />
							</div>
							<div class="icol_text w10">
								<span>商品包装</span>
							</div>
							<div class="i_input2">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.itemPack != null}">
                                    	value="<auchan:getDictValue code="${itemBasicVO.itemPack}" mdgroup="ITEM_BASIC_ITEM_PACK"></auchan:getDictValue>"
                                   	</c:if> />
							</div>
							<div class="icol_text w10">
								<span>采购期限</span>
							</div>
							<div class="i_input3">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.buyPerd != null}">	
                                    	value="<auchan:getDictValue code="${itemBasicVO.buyPerd}" mdgroup="ITEM_BASIC_BUY_PERD"></auchan:getDictValue>"
                                    </c:if> />
							</div>
							<!--1-->
							<div class="icol_text w7">
								<span>主厂商</span>
							</div>
							<div class="i_input1_2">
								<input type="text" class="inputText w28" readonly="readonly"
									value="${itemBasicVO.comNo}" /> <input type="text"
									class="inputText w60" value="${itemBasicVO.comName}"
									readonly="readonly" />
							</div>
							<div class="icol_text w10">
								<span>季节期数</span>
							</div>
							<input type="text" class="inputText ik" style="width: 10%;" id="topic" readonly="readonly" />
							<div class="icol_text w7">
								<span>有效期间</span>
							</div>
							<input class="inputText fl_left _w83" type="text" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${itemBasicVO.validStartDate}"/>" readonly="readonly" /> 
							<span class="fl_left">&nbsp;-&nbsp;</span> 
							<input class="inputText _w83" type="text" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${itemBasicVO.validEndDate}"/>" readonly="readonly" />
						</div>
					</div>
					<div class="ic">
						<div class="ig">
							<span class="icol_text2">主状态</span>
							<div class="ia">
								<input id="itemMainStatus" class="inputText _w90"
									readonly="readonly"
									<c:if test="${itemBasicVO.status != null}">
	                                   	value="<auchan:getDictValue code="${itemBasicVO.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>"
                                   	</c:if> />
							</div>
							<span class="icol_text2">品牌</span> <input type="text"
								class="inputText ih" value="${itemBasicVO.brandId}"
								readonly="readonly" /> <input type="text" class="inputText ik"
								value="${itemBasicVO.brandName}" readonly="readonly" />
							<div class="icol_text w11">
								<span>产地维护</span>
							</div>
							<div class="i_input2">
								<input class="inputText _w120" readonly="readonly"
									<c:if test="${itemBasicVO.orignCtrl != null}">
                                   		value="<auchan:getDictValue code="${itemBasicVO.orignCtrl}" mdgroup="ITEM_BASIC_ORIGIN_CTRL"></auchan:getDictValue>"
                                   	</c:if> />
							</div>
							<span class="tiaoma">条码贴标</span> <input class="inputText _w120"
								style="width: 143px"
								<c:if test="${itemBasicVO.barcodeLabel != null}">
		                           	value="<auchan:getDictValue code="${itemBasicVO.barcodeLabel}" mdgroup="ITEM_BASIC_BARCODE_LABEL"></auchan:getDictValue>"
		                        </c:if>
								readonly="readonly" />
						</div>
						<div class="io">
							<div class="ig">
								<span class="icol_text2">处别</span> <input class="inputText iq"
									value="${itemBasicVO.divNo}" readonly="readonly" /> <input
									class="longText inputText w50" value="${itemBasicVO.divName}"
									readonly="readonly" />
							</div>
							<div class="ig">
								<span class="icol_text2">课别</span> <input class="inputText iq"
									value="${itemBasicVO.secNo}" readonly="readonly" /> <input
									class="longText inputText w50" value="${itemBasicVO.secName}"
									readonly="readonly" />
							</div>
							<div class="ig">
								<span class="icol_text2">系列</span> <input class="inputText iq"
									value="${itemBasicVO.clstrId}" readonly="readonly" /> <input
									class="longText inputText w50" value="${itemBasicVO.clstrName}"
									readonly="readonly" id="clstrName"/>
							</div>
						</div>
						<div class="io2">
							<div class="ig">
								<span class="icol_text2">大分类</span> <input class="inputText iq"
									value="${itemBasicVO.grpNo}" readonly="readonly" /> <input
									class="longText inputText w37" type="text"
									value="${itemBasicVO.grpName}" readonly="readonly" />
							</div>
							<div class="ig">
								<span class="icol_text2">中分类</span> <input class="inputText iq"
									value="${itemBasicVO.midgrpNo}" readonly="readonly" /> <input
									class="longText inputText w37"
									value="${itemBasicVO.midgrpName}" readonly="readonly" />
							</div>
							<div class="ig">
								<span class="icol_text2">小分类</span> <input class="inputText iq"
									value="${itemBasicVO.catlgNo}" readonly="readonly" /> <input
									class="longText inputText w37" value="${itemBasicVO.catlgName}"
									readonly="readonly" /><input type="hidden" id="catlgId" value="${itemBasicVO.catlgId}">
							</div>
						</div>
						<div class="ip">
							<div class="ip1 w12_5">
								<div>
									<span>销售单位</span>
								</div>
								<div>
									<span>成本时点</span>
								</div>
								<div>
									<span>采购备注</span>
								</div>
							</div>
							<div class="ip2 w25">
								<div class="ig">
									<div class="iconPut iq1">
										<input type="text" class="w100" readonly="readonly"
											<c:if test="${itemBasicVO.sellUnit != null}">
					                           	value="<auchan:getDictValue code="${itemBasicVO.sellUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
					                        </c:if> />
									</div>
								</div>
								<div class="ig">
									<input class="inputText w90" readonly="readonly" id="buyWhen"
										<c:if test="${itemBasicVO.buyWhen != null}">
                                   			value="<auchan:getDictValue code="${itemBasicVO.buyWhen}" mdgroup="ITEM_BASIC_BUY_WHEN"></auchan:getDictValue>"
                                   		</c:if> />
								</div>
							</div>
							<div class="ip3 w60">
								<div class="ig">
									<span class="icol_text2">进价税率</span>
									<div class="iconPut iq" style="width: 20%">
										<input type="text" class="w60 longText"
											value="${itemBasicVO.buyVatNo}" readonly="readonly" />
										<div class="ListWin"></div>
									</div>
									<input class="longText inputText w35" type="text"
										value="${itemBasicVO.buyVatVal}" readonly="readonly" />%
								</div>
								<div class="ig">
									<span class="icol_text2">售价税率</span>
									<div class="iconPut iq" style="width: 20%">
										<input type="text" class="w60 longText"
											value="${itemBasicVO.sellVatNo}" readonly="readonly" />
										<div class="ListWin"></div>
									</div>
									<input class="longText inputText w35" type="text"
										value="${itemBasicVO.sellVatVal}" readonly="readonly" />%
								</div>
							</div>
							<input class=" inputText" style="width: 347px"
								value="${itemBasicVO.buyerMemo}" readonly="readonly" />
						</div>

					</div>
				</div>
			</div>
			<!-- 状态及价格信息 -->
			<div id="storeInfo">
				<%@ include file="/page/item/itemQuery/item_Overview_Store_Info.jsp"%>
			</div>
		</div>
		<!-- 添加图片信息
		<div id="updateItemPicInfo" class="Content">
		</div> -->
	</div>
</div>
