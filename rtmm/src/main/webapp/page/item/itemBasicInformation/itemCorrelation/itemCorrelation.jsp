<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemBaseDoc.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.iq {
	margin-left: 3px;
	background: #ccc;
}

.zz_info {
	width: 960px;
	margin-left: 20px;
}

.zz_2 input {
	margin-left: 3px;
}

.zz_2 input[type="checkbox"] {
	float: left;
	margin-top: 4px;
	margin-right: 3px;
	margin-left: 0px;
}

.zz_2 {
	height: 300px;
}

.sp_icon1 {
	margin-left: 9px;
}

.zz_11 {
	margin-left: 50px;
}

.zz_12 {
	margin-left: 75px;
}

.zz_13 {
	margin-left: 40px;
}

.zz_14 {
	margin-left: 3px;
}

.zz_15 {
	margin-left: 5px;
}

.zz_16 {
	margin-left: 275px;
}

.zz_17 {
	margin-left: 60px;
}

.zz_18 {
	margin-left: 27px;
}
.tagsM{
    min-width: 55px;
}
</style>
<script type="text/javascript">
	$(function() {
	    /*disabled the all toolbar.*/
	    setToolsbarAllDisable();
	    
		$('#ovreviewTab').bind('click', function() {
			showContent(ctx + '/item/query/itemBaseInfo', null);
		});
		$('#Tools2').attr("class","Tools2").bind('click', function() {
			
			var itemType = $("#itemType").val();
			if (itemType == "1" || itemType == "5") {
				saveItemCorrelation_1_5();
			} else if (itemType == "2" || itemType == "3" || itemType == "4") {
				saveItemCorrelation_2();
			}
		});
		//传递参数 
		var param = {
			'itemNo' : '${sessionScope.itemNoSearch}',
			'itemName' : '${sessionScope.itemNameSearch}',
			'storeNo' : '${sessionScope.storeNoSearch}',
			'storeName' : '${sessionScope.storeNameSearch}'
		};		
		//商品总览(tab)
		$('#ovreviewTab').unbind("click").bind('click', function() {
			var itemNo = '${sessionScope.itemNoSearch}';
			if(itemNo != null && itemNo != ""){
				searchItemByItemNo('${sessionScope.itemNoSearch}','${sessionScope.storeNoSearch}');
				
			}else{
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
		//关闭修改商品关联信息页面
			$("#itemRealInfoClose").unbind().bind('click',function(){
				param.itemNo = $('#sel_itemArticleNo').val();
				closeUptItemInfo('itemRealInfoClose',param);
			});
			itemArticleNoSelect();
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
	<div class="tagsM" id="dcInfoTab">DC信息</div>
	<div class="tags "></div>
	<div class="tagsM" id="originInfoTab">商品产地</div>
	<div class="tags "></div>
	<div class="tagsM " id="supAreaInfoTab">商品供应区域</div>
	<div class="tags tags3 tags_right_on"></div>
	<div class="tagsM_q  tagsM_on">修改商品关联信息</div>
	<div class="tags3_close_on">
		<div class="tags_close" id="itemRealInfoClose"></div>
	</div>
</div>
<div class="Container-1">
	<div class="Content">
		<div style="height: 180px;" class="CM">
			<div class="CM-bar">
				<div>母货号</div>
			</div>
			<div class="CM-div">
				<div class="inner_half">
					<div class="ig" style="margin-top: 15px;">
						<div class="msg_txt">母货号</div>
						<div class="iconPut fl_left w20">
							<input id="sel_itemArticleNo" type="text" class="w75" value="${itemBasicVO.itemNo}" readonly="readonly" />
							<div class="ListWin" ></div>
						</div>
						<input id="sel_itemArticleName" class="inputText iq Black"
							value="${itemBasicVO.itemName}" type="text" readonly="readonly" />
					</div>
					<div class="ig">
						<div class="msg_txt">英文名称</div>
						<input type="text" class="inputText w50 Black"
							value="${itemBasicVO.itemEnName}" readonly="readonly" />
					</div>
					<div class="ig">
						<div class="msg_txt">销售单位</div>
						<span class="jksp">1&nbsp;</span>
						<input class="inputText iq" type="text" style="width: 10%;" 
							<c:if test="${itemBasicVO.sellUnit != null}">
	                           	value="<auchan:getDictValue code="${itemBasicVO.sellUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
	                        </c:if>
	                        readonly="readonly"
						/>
						<span class="jksp">&nbsp;=&nbsp;</span> 
						<input class="inputText iq w10" type="text" value="${itemBasicVO.numOfPackUnit }" readonly="readonly" /> 
						<input class="inputText iq w10" type="text" 
							<c:if test="${itemBasicVO.packUnit != null}">
								value="<auchan:getDictValue code="${itemBasicVO.packUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>" 
							</c:if>	
						readonly="readonly" /> 
						<span class="fl_left">&nbsp;x&nbsp;</span> 
						<input class="inputText iq w10" type="text" value="${itemBasicVO.baseVol }" readonly="readonly" /> 
						<input class="inputText iq w10" type="text" 
						    <c:if test="${itemBasicVO.baseVolUnit != null}">
								value="<auchan:getDictValue code="${itemBasicVO.baseVolUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>" 
							</c:if>	
						 readonly="readonly" />
					</div>
					<div class="ig">
						<div class="msg_txt">母货类型</div>
						<!-- <select class="w23 Black"><option>1-整箱</option></select> -->
						<auchan:select mdgroup="ITEM_RELATIVE_RLTN_TYPE" value="${itemBasicVO.rltnType}" _class="w23" disabled="disabled" id="itemType" name="status" />
						<!-- <input class="inputText w23 Black downSelect" type="text" value="1-整箱" readonly="readonly"/> -->
					</div>
					<div id="effectiveDateDiv" class="ig" style="display: none;">
						<div class="msg_txt">生效期间</div>
						<input id="startDate" class="Wdate" value="" type="text"
							style="width: 100px;"
							onClick="WdatePicker({isShowClear:false,readOnly:true})">
						<span>&nbsp;-&nbsp;</span>
						<input id="endDate" class="Wdate" type="text"
							style="width: 100px;"
							onClick="WdatePicker({isShowClear:false,readOnly:true})">
					</div>
				</div>
				<div class="inner_half">
					<div class="ig" style="margin-top: 15px;">
						<div class="msg_txt">商品状态</div>
						<input type="text" class="inputText w20 Black"
							<c:if test="${itemBasicVO.status != null}">
	                           	value="<auchan:getDictValue code="${itemBasicVO.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>"
	                        </c:if>	readonly="readonly"						
						 />
					</div>
					<div class="ig">
						<div class="msg_txt">厂商</div>
						<div class="iconPut fl_left w20 Black">
							<input type="text" class="w75 Black" value="${itemBasicVO.comNo}" readonly="readonly" />
							<div class="ListWin"></div>
						</div>
						<input class="inputText iq Black" style="width: 55%;" type="text" value="${itemBasicVO.comName}"  readonly="readonly" />
					</div>
					<div class="ig">
						<div class="msg_txt">进价</div>
						<input class="w20 inputText Black" type="text" value="${itemBasicVO.stdBuyPrice }" readonly="readonly" />
						<span>元&nbsp;&nbsp;&nbsp;进价税率&nbsp;</span>
						<input class="w10 inputText Black" type="text" value="${itemBasicVO.buyVatNo}" readonly="readonly" />
						<span>-</span>
						<input class="w10 inputText Black" type="text" value="${itemBasicVO.buyVatVal}" readonly="readonly" />
						<span>&nbsp;%</span>
					</div>
					<div class="ig">
						<div class="msg_txt">售价</div>
						<input class="w20 inputText Black" type="text" value="${itemBasicVO.stdSellPrice }" readonly="readonly" />
						<span>元&nbsp;&nbsp;&nbsp;售价税率&nbsp;</span>
						<input class="w10 inputText Black" type="text" value="${itemBasicVO.sellVatNo}" readonly="readonly" />
						<span>-</span>
						<input class="w10 inputText Black" type="text" value="${itemBasicVO.sellVatVal}" readonly="readonly" />
						<span>&nbsp;%</span>
					</div>
				</div>

			</div>
		</div>

		<div id="sonItemNoDiv">
			<div style="height: 380px; margin-top: 2px;" class="CM">
				<div class="CM-bar">
					<div>子货号</div>
				</div>
			</div>
		</div>
	</div>
</div>