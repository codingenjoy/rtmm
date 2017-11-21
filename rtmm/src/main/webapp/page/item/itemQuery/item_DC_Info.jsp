<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
._w120 {
	width: 120px;
}

._w80 {
	width: 80px;
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
    margin-left:60px;
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
<script type="text/javascript">
	$(function() {
		$("#ovreviewContent").find("input").attr("readonly","readonly");
		$("#itemNo").attr("readonly",false);
		setToolsbarAllDisable();
		$("#Tools21").unbind().removeClass().addClass('Icon-size1 Tools21_disable');
/*     
		<auchan:operauth ifAnyGrantedCode="112118996" >
			$("#Tools12").attr('class', "Tools12").unbind().bind("click", function() {
	    		$('#ovreviewContent').load(ctx + '/item/update/updateItemDC',getParam());	
	    	}); 
		</auchan:operauth>
*/
		//传递参数 
		var param = {
			'itemNo' : '${sessionScope.itemNoSearch}',
			'itemName' : '${sessionScope.itemNameSearch}',
			'storeNo' : '${sessionScope.storeNoSearch}',
			'storeName' : '${sessionScope.storeNameSearch}'
		};
		//商品总览(tab)
		$('#ovreviewTab').unbind("click").bind( 'click', function() {
			var itemNo = '${sessionScope.itemNoSearch}';
			if(itemNo != null && itemNo != ""){
				searchItemByItemNo('${sessionScope.itemNoSearch}','${sessionScope.storeNoSearch}');
				
			}else{
				$('.Container').load(ctx + '/item/query/generalSearch', param);
			}
		});
		
		//变价信息(tab)
		$('#priceChangeTab').unbind("click").bind( 'click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemPriceChangeInfo', param);
		});
		//规格信息(tab)
		$('#specInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSpecInfo', param);
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
		$('#saleCtrlInfoTab').unbind("click").bind( 'click', function() {
			$('#ovreviewContent').load(ctx+ '/item/query/itemRealStoreSaleCtrlInfo',param);
	    });
		//商品产地(tab)
		$('#originInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemOriginInfo', param);
		});	
		//商品供应区域(tab)
		$('#supAreaInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSupplierAreaInfo', param);
		});	
		//商品订单查询(tab)
		$('#itemOrderQuery').unbind("click").bind('click',function(){
			$('#ovreviewContent').load(ctx + '/item/query/itemOrderQuery', param);
		});
		//DC信息(tab)
		//打开重置
		openCleanBtn('/item/query/itemDCInfo',false);
		//直接点击后，打开查询按钮
		var itemNoSearch = '${sessionScope.itemNoSearch}';
		if(itemNoSearch == null || itemNoSearch == ""){
			openSearchBtn('/item/query/itemDCInfo',false);
		}
		$("#itemNo").unbind().bind('keypress', function(e) {
			var code=e.keyCode;
			if (13==code) {
				$('#Tools6').click();
			}
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
	<div class="tags tags_right_on"></div>
	<div class="tagsM tagsM_on" id="dcInfoTab">DC信息</div>
	<div class="tags tags_left_on"></div>
	<div class="tagsM" id="originInfoTab">商品产地</div>
	<div class="tags "></div>
	<div class="tagsM " id="supAreaInfoTab">商品供应区域</div>
	<div class="tags"></div>
	<div class="tagsM " id="itemOrderQuery">商品订单查询</div>
	<div class="tags tags3_r_off"></div>
</div>
<div class="Container-1">
	<div class="Content" id="Content">
	<div class="CInfo">
	<div style="float: left;" class="w25">
	</div>
	<c:if test="${not empty itemBasicVO}">
		<div id="message">
			<span>项</span> 
			<span class="canEmpty">${total}</span> 
			<span>/</span> 
			<span class="canEmpty">${page}</span>
			<span>第</span> 
			<span>|</span> 
			<span class="canEmpty">${dcInfoVo.chngBy}</span> 
			<span>修改人</span>
			<span class="canEmpty"><fmt:formatDate pattern="yyyy-MM-dd" value="${dcInfoVo.chngDate}" /></span> 
			<span>修改日期</span> <span class="canEmpty">${itemBasicVO.creatBy}</span>
			<span>建档人</span> <span class="canEmpty"><fmt:formatDate pattern="yyyy-MM-dd" value="${itemBasicVO.creatDate}" /></span> 
			<span>创建日期</span>
		</div>
	</c:if>
	</div>
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
						<input class ="w83 count_text" type="text" id="itemNo" value="${itemBasicVO.itemNo}" placeholder="输入货号查询"
						onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
						<div class="ListWin" onclick="chooseItemNo()"></div>
					</div>
					<input class="inputText iq Black" style="width: 20%;" type="text" id="itemName" value="${itemBasicVO.itemName }"/>

					<span class="fl_left" style="line-height: 20px;">&nbsp;&nbsp;&nbsp;保质期&nbsp;&nbsp;</span>
					<input type="text" class="w5 inputText fl_left align_right" value="${dcInfoVo.stdShelfLifeDays }"/>
					<div class="fl_left" style="width: 50px; margin-left: 5px;">
						<input class="w80  inputText" style="height: 20px;" 
							<c:if test="${dcInfoVo.perdUnitName != null}">
	                           	value="<auchan:getDictValue code="${dcInfoVo.perdUnitName }" mdgroup="ITEM_SPEC_PERD_UNIT_NAME" showType="2"></auchan:getDictValue>"
	                        </c:if>	
						/>
					</div>
					<span>或</span> <input type="text" class="w5 align_right inputText" value="${dcInfoVo.stdShelfLifeDays}"/> <span>天</span>
				</div>
			</div>
		</div>
		<div style="height: 252px;">
			<div class="tb50">
				<div style="height: 140px; margin-top: 2px;" class="CM">
					<div class="CM-bar">
						<div>陈列信息</div>
					</div>
					<div class="CM-div">
						<div class="ig" style="margin-top: 15px;">
							<div class="msg_txt">货物属性</div>
							<input type="text" class="inputText w20" value="<c:if test="${dcStore.dcGoodsDlvryAttr != null }"><auchan:getDictValue code="${dcStore.dcGoodsDlvryAttr}" mdgroup="ITEM_DC_INFO_DC_GOODS_DLVRY_ATTR"></auchan:getDictValue></c:if>"/>
						</div>
						<div class="ig">
							<div class="msg_txt">DC订购单位</div>
							<input type="text" class="inputText w20 align_right" value="${dcInfoVo.dcMinOrdQty }"/>
						</div>
						<div class="ig">
							<div class="msg_txt">门店补货方式</div>
							<input class="inputText w10 align_right" type="text" value="${dcInfoVo.storeOrdType }"/> 
							<input class="inputText w20" type="text" value="<c:if test="${dcStore.storeOrdType != null }"><auchan:getDictValue code="${dcStore.storeOrdType}" mdgroup="ITEM_DC_INFO_STORE_ORD_UNIT"></auchan:getDictValue></c:if>"/>
						</div>
						<div class="ig">
							<div class="msg_txt">补货单位</div>
							<input type="text" class="w10 inputText align_right" value="${dcInfoVo.storeMinOrdQty }"/>
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
							<input type="text" class="inputText w15 align_right" value="${dcInfoVo.plltTier }"/> 
							<span>托盘层数HI</span> 
							<input type="text" class="inputText w15 align_right" value="${dcInfoVo.plltHier }"/>
						</div>
						<div class="ig">
							<div class="msg_txt">每托盘箱数</div>
							<input type="text" class="inputText w15 align_right" value="<c:if test="${dcStore.plltTier != null &&  dcStore.plltHier != null}">${dcInfoVo.plltTier*dcInfoVo.plltHier }</c:if>"/>
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
							<span style="margin-left: 140px;">外箱</span> 
							<span style="margin-left: 130px;">内箱</span>
						</div>
						<div class="ig">
							<div class="msg_txt">箱含量</div>
							<input class="inputText w30 align_right" value="${dcInfoVo.upb }" /> 
							<input class="inputText w30 align_right" value="${dcInfoVo.subUpb }"/>
						</div>
						<div class="ig">
							<div class="msg_txt">面(CM)</div>
							<input class="inputText w30 align_right" value="${dcInfoVo.caseFace }" /> 
							<input class="inputText w30 align_right" value="${dcInfoVo.subcaseFace }"/>
						</div>
						<div class="ig">
							<div class="msg_txt">高(CM)</div>
							<input class="inputText w30 align_right" value="${dcInfoVo.caseHght }" /> 
							<input class="inputText w30 align_right" value="${dcInfoVo.subcaseHght }"/>
						</div>
						<div class="ig">
							<div class="msg_txt">深(CM)</div>
							<input class="inputText w30 align_right" value="${dcInfoVo.caseDepth }" /> 
							<input class="inputText w30 align_right" value="${dcInfoVo.subcaseDepth }"/>
						</div>
						<div class="ig">
							<div class="msg_txt">体积(M3)</div> 
							<input class="inputText w30 align_right" value="<c:if test="${dcInfoVo.caseFace != null && dcInfoVo.caseHght != null && dcInfoVo.caseDepth != null}">${dcInfoVo.caseFace*dcInfoVo.caseHght*dcInfoVo.caseDepth }</c:if>" /> 
							<input class="inputText w30 align_right" value="<c:if test="${dcInfoVo.subcaseFace != null && dcInfoVo.subcaseHght != null && dcInfoVo.subcaseDepth != null}">${dcInfoVo.subcaseFace*dcInfoVo.subcaseHght*dcInfoVo.subcaseDepth }</c:if>"/>
						</div>
						<div class="ig">
							<div class="msg_txt">毛重(KG)</div>
							<input class="inputText w30 align_right" value="${dcInfoVo.caseGrossWght }" /> 
							<input class="inputText w30 align_right" value="${dcInfoVo.subcaseGrossWght }"/>
						</div>
						<div class="ig">
							<div class="msg_txt">净重(KG)</div>
							<input class="inputText w30 align_right" value="${dcInfoVo.caseNetWght }" /> 
							<input class="inputText w30 align_right" value="${dcInfoVo.subcaseNetWght }"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div style="height: 220px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>物流中心信息</div>
			</div>
			<div class="CM-div">
				<div class="zz_info">
					<div class="zz_1">
						<span class="zz_11">物流店号</span> <span class="zz_12">状态</span> <span
							class="zz_13">DC属性</span> <span class="zz_14">供应商</span> <span
							class="zz_15">进价(元)</span> <span class="zz_16">允收天数(天)</span> <span
							class="zz_17">配送天数(天)</span>
					</div>
						<div class="zz_2 dcStroeList">
							<c:forEach items="${dcStoreList}" var="dcStore">
								<div class="ig" style="margin-top: 5px; margin-left: 10px;">
									<input type="text" class="w120 inputText fl_left" value="<c:if test="${dcStore.storeNo != null && dcStore.storeName != null }">${dcStore.storeNo}-${dcStore.storeName}</c:if>"/>
									<!-- <select class="w12_5 fl_left"><option></option></select>  -->
									<input type="text" class="w10 inputText fl_left" value="<c:if test="${dcStore.status != null }"><auchan:getDictValue code="${dcStore.status}" mdgroup="ITEM_STORE_INFO_STATUS"></auchan:getDictValue></c:if>"/> 
									<input type="text" class="w10 inputText fl_left Black" value="<c:if test="${dcStore.dcAttr != null }"><auchan:getDictValue code="${dcStore.dcAttr}" mdgroup="ITEM_STORE_INFO_DC_ATTR"></auchan:getDictValue></c:if>"/>
									<div class="iconPut w10">
										<input type="text" class="w70" value="${dcStore.stMainSupNo}"/>
										<div class="ListWin"></div>
									</div>
									<input type="text" class="w17 inputText fl_left" value="${dcStore.comName}"/> 
									<input type="text" class="w10 inputText fl_left" value="${dcStore.normBuyPrice}"/> 
									<input type="text" class="w10 inputText" value="${dcStore.rcvShelfLifeDays}"/> 
									<input type="text" class="w10 inputText" value="${dcStore.dcShelfLifeDays}"/>
								</div>
							</c:forEach>
						</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
