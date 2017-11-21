<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
._w120 {
	width: 120px;
}

._w80 {
	width: 80px;
}
.w16{width:16%}
</style>
<div style="height: 260px; margin-top: 2px;" class="CM">
	<div style="width: 48%; float: left; height: 100%;">
		<div class="CM-bar">
			<div>状态及价格信息</div>
			<auchan:operauth ifAnyGrantedCode="112111001" >
				<div class="icm Icon-size2" style="margin-top: 120px;" title="新增商品下传区域"></div>
			</auchan:operauth>
		</div>
		<div class="CM-div">
			<div class="ig" style="margin-top: 15px;">
				<div class="icol_text w15">
					<span>商品状态</span>
				</div>
				<!-- <div class="i_input2"></div> -->
					<input class="inputText w17 fl_left"  
                    <c:if test="${storeInfoVO.status != null}">
                    	value="<auchan:getDictValue code="${storeInfoVO.status}" mdgroup="ITEM_STORE_INFO_STATUS"></auchan:getDictValue>"
                    </c:if>
                     readonly="readonly"/>
				
				<div class="icol_text w15">
					<span>BNO属性</span>
				</div>
				<input class="inputText w30 InputBg fl_left" value="${storeInfoVO.mops}" readonly="readonly"/>
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>生效日期</span>
				</div>
				<input class="inputText w17 fl_left" type="text" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${storeInfoVO.activDate}"/>"  readonly="readonly"/>
				<div class="icol_text w15">
					<span>DC属性</span>
				</div>
                 <input class="inputText w30 fl_left" type="text" 
	                 <c:if test="${storeInfoVO.dcAttr != null}">
	                		 value="<auchan:getDictValue code="${storeInfoVO.dcAttr}" mdgroup="ITEM_STORE_INFO_DC_ATTR"></auchan:getDictValue>"
	                 </c:if>
                 readonly="readonly"/>
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>分店厂商</span>
				</div>
				<div class="iconPut iq" style="width:17%;">
					 <input type="text" style="width:77%" value="${storeInfoVO.mainComNo}"  readonly="readonly"/>
					<div class="ListWin"></div>
				</div>
				<input type="text" class="inputText w60"  style="margin-left:3px;" value="${storeInfoVO.mainComName}"  readonly="readonly"/>
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>正常进价</span>
				</div>
				<input type="text" class="w17 inputText align_right" value="<fmt:formatNumber value="${storeInfoVO.normBuyPrice}" pattern="#0.0000"/>"  readonly="readonly"/>&nbsp;元
				<span>&nbsp;&nbsp;当前进价&nbsp;</span>
				<input type="text" class="w16 inputText align_right" value="<fmt:formatNumber value="${storeInfoVO.promBuyPrice}" pattern="#0.0000"/>"  readonly="readonly"/>&nbsp;元					
				<span>&nbsp;&nbsp;进促&nbsp;</span>
				<input type="text" class="w16 inputText align_right" value="${storeInfoVO.bpPromNo}"  readonly="readonly"/>
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>正常售价</span>
				</div>
				<input type="text" class="w17 inputText align_right" value="<fmt:formatNumber value="${storeInfoVO.normSellPrice}" pattern="#0.00"/>"  readonly="readonly"/>&nbsp;元 
				<span>&nbsp;&nbsp;当前售价&nbsp;</span>
				<input type="text" class="w16 inputText align_right" value="<fmt:formatNumber value="${storeInfoVO.promSellPrice}" pattern="#0.00"/>"  readonly="readonly"/>&nbsp;元
				<span>&nbsp;&nbsp;售促&nbsp;</span>
				<input type="text" class="w16 inputText align_right" value="${storeInfoVO.spPromNo}"  readonly="readonly"/>
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>买价限制</span>
				</div>
				<input type="text" class="w17 inputText align_right"  value="<fmt:formatNumber value="${storeInfoVO.buyPriceLimit}" pattern="#0.0000"/>" readonly="readonly"/>&nbsp;元
				<span>&nbsp;&nbsp;最低售价&nbsp;</span>
				<input type="text" class="w16 inputText align_right" value="<fmt:formatNumber value="${storeInfoVO.minSellPrice}" pattern="#0.00"/>"  readonly="readonly"/>&nbsp;元
				<span>&nbsp;DMS&nbsp;</span>
				<input class="inputText w16" type="text" readonly="readonly" value="<fmt:formatNumber value="${itemStatVO.dms }" pattern="#0.00"/>"/> 
			</div>

			<div class="ig">
				<div class="icol_text w15">
					<span>净成本</span>
				</div>
				<input class="inputText w17 align_right" type="text" value="<fmt:formatNumber value="${storeInfoVO.netCost}" pattern="#0.0000"/>" readonly="readonly"/>&nbsp;元 
				<span>&nbsp;&nbsp;净毛利率&nbsp;</span>
				<input class="inputText w10" type="text" readonly="readonly" 
					<c:if test="${storeInfoVO.promSellPrice ne null && storeInfoVO.promSellPrice ne 0 && storeInfoVO.netCost ne null && vatValSell ne null}">
						<%-- value="<fmt:formatNumber value="${((storeInfoVO.promSellPrice/(1+(vatValSell/100)))-storeInfoVO.netCost)/(storeInfoVO.promSellPrice/(1+(vatValSell/100)))*100 }" type="percent" pattern="#0.00"/>"
						 --%>value="<fmt:formatNumber value="${((storeInfoVO.promSellPrice/(1+(vatValSell/100)))-storeInfoVO.netCost)/(storeInfoVO.promSellPrice/(1+(vatValSell/100)))*100 }" type="percent" pattern="#0.00"/>"
						
					</c:if>
				/>&nbsp;%  
				<span>&nbsp;&nbsp;&nbsp;促销DMS&nbsp;</span>
				<input type="text" class="w16 inputText" readonly="readonly" value="<fmt:formatNumber value="${itemStatVO.promDms }" pattern="#0.00"/>"/>
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>门店变价</span>
				</div>
                 <input class="inputText w15" type="text" 
                 <c:if test="${storeInfoVO.storeUpdtSpInd != null}">
                	 	value="<auchan:getDictValue code="${storeInfoVO.storeUpdtSpInd}" mdgroup="ITEM_STORE_INFO_STORE_UPDT_SP_IND"></auchan:getDictValue>"
                 </c:if>
                 readonly="readonly"/>
				<span>&nbsp;&nbsp;&nbsp;可否销售</span>
                <input class="inputText w15" type="text" 
                <c:if test="${storeInfoVO.sellAllow != null}">	
                	value="<auchan:getDictValue code="${storeInfoVO.sellAllow}" mdgroup="ITEM_STORE_INFO_SELL_ALLOW"></auchan:getDictValue>"
                </c:if>
                readonly="readonly"/>
				<span>&nbsp;&nbsp;&nbsp;价格段&nbsp;&nbsp;&nbsp;T</span>
                 <input type="text" class="w10 inputText" value="${storeInfoVO.priceTierVal}" readonly="readonly"/>
			</div>

		</div>
	</div>
	<div class="dhsc3">
		<div class="CM-bar">
			<div>订货及生产商信息</div>
		</div>
		<div class="CM-div">
			<div class="ig dhxx_info_1" style="margin-top: 15px;">
				<div class="icol_text w15">
					<span>订货方式</span>
				</div>
				<input id="ordCreatMethd" type="hidden"
					value="${storeInfoVO.ordCreatMethd}" />
				<c:forEach items="${ORD_CREAT_METHD}" var="obj">
					<input type="checkbox" name="ordCreatMethd" value="${obj.code}"
						id="${obj.code}" />
					<span>${obj.title}</span>
				</c:forEach>
			</div>
			<div style="height: 90px;">
				<div class="dh_info1">
					<div class="ig">
						<input type="radio" style="margin-left: 12px;" disabled="disabled"
						<c:if test="${storeInfoVO.oplCycle != null}">checked</c:if>
						/> <span>订货周期</span>
						<input type="text" class="w30 inputText"
							value="${storeInfoVO.oplCycle}" readonly="readonly" /> <span>周</span>
					</div>
					<div style="height: 60px;">
						<div class="dh_radio1">
							<input type="radio" disabled="disabled" style="margin-top: 20px;" <c:if test="${storeInfoVO.oplPoint != null || storeInfoVO.oplQty != null}">checked</c:if>/>
						</div>
						<div class="dh_radio2">
							<div class="ig">
								<span>&nbsp;订购点&nbsp;</span><input type="text"
									class="w50 inputText" value="${storeInfoVO.oplPoint}"
									readonly="readonly" />
							</div>
							<div class="ig">
								<span>&nbsp;订购量&nbsp;</span><input type="text"
									class="w50 inputText" value="${storeInfoVO.oplQty}"
									readonly="readonly" />
							</div>
						</div>
					</div>
				</div>
				<div class="dh_info2">
					<div class="ig">
						<div class="icol_text w44">
							<span>&nbsp;可否退货</span>
						</div>
						<input type="text" class="inputText w35"
							<c:if test="${storeInfoVO.rtnAllow != null}">
                                                        value="<auchan:getDictValue code="${storeInfoVO.rtnAllow}" mdgroup="ITEM_STORE_INFO_RTN_ALLOW"></auchan:getDictValue>"
                                                        </c:if>
							readonly="readonly" />
					</div>
					<div class="ig">
						<div class="icol_text w44">
							<span>&nbsp;可否收货</span>
						</div>
						<input type="text" class="inputText w35"
							<c:if test="${storeInfoVO.rcvAllow != null}">
                                                        value="<auchan:getDictValue code="${storeInfoVO.rcvAllow}" mdgroup="ITEM_STORE_INFO_RCV_ALLOW"></auchan:getDictValue>"
                                                        </c:if>
							readonly="readonly" />
					</div>
					<div class="ig">
						<div class="icol_text w44">
							<span>&nbsp;箱含量</span>
						</div>
						<input type="text" class="w35 inputText " readonly="readonly"
							value="${storeInfoVO.upb}" />
					</div>
				</div>
				<div class="dh_info3">
					<div class="ig">
						<div class="icol_text w44">
							<span>&nbsp;订购倍数</span>
						</div>
						<input type="text" class="w35 inputText" readonly="readonly"
							value="${storeInfoVO.ordMultiParm}" />
					</div>
					<div class="ig">
						<div class="icol_text w44">
							<span>&nbsp;允收天数</span>
						</div>
						<input type="text" class="w35 inputText" readonly="readonly"
							value="${storeInfoVO.rcvShelfLifeDays}" />&nbsp;天
					</div>
				</div>
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>产地</span>
				</div>
				<input type="text" class="inputText w30"
					<c:if test="${storeInfoVO.orignCode != null}">
	                                        value="<auchan:getDictValue code="${storeInfoVO.orignCode}" mdgroup="origin"></auchan:getDictValue>"
		                                    </c:if>
					readonly="readonly" />
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>生产单位</span>
				</div>
				<input class="w50 inputText" type="text"
					<c:if test="${storeInfoVO.prdcId != null && storeInfoVO.prdcrName != null}">
	                                        value="${storeInfoVO.prdcId}-${storeInfoVO.prdcrName}"  
	                                        </c:if>
					readonly="readonly" />
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>单位地址</span>
				</div>
				<div class="iconPut" style="width: 20%; float: left;">
					<input type="text" style="width: 75%;"
						value="${storeInfoVO.prdcProvName}" readonly="readonly" />
					<div style="color: #999999;">省</div>
				</div>
				<div class="iconPut"
					style="width: 28%; float: left; margin-left: 3px;">
					<input type="text" value="${storeInfoVO.prdcCityName}"
						readonly="readonly" class="w80" />
					<div style="color: #999999;">市</div>
				</div>
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>&nbsp;</span>
				</div>
				<input class="w50 inputText" value="${storeInfoVO.prdcDetllAddr}"
					readonly="readonly" />
			</div>
		</div>
	</div>
</div>