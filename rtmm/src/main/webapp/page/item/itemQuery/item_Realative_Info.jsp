<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jumpPage.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
._w120 {
	width: 120px;
}

._w80 {
	width: 80px;
}
.iq {
	margin-left: 3px;
	background: #ccc;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#ovreviewContent").find("input").attr("readonly","readonly");
		$("#itemNo").attr("readonly",false);
		setToolsbarAllDisable();
		$("#Tools21").unbind().removeClass().addClass('Icon-size1 Tools21_disable');
		var itemNo = $.trim('${sessionScope.itemNoSearch}');
		if ($.trim($("#itemNo").val()) != ""){
			itemNo = $.trim($("#itemNo").val()) ;
		}
		
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
		$('#saleCtrlInfoTab').unbind("click").bind('click',
				function() {
					$('#ovreviewContent').load(ctx+ '/item/query/itemRealStoreSaleCtrlInfo',param);
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
		//商品订单查询(tab)
		$('#itemOrderQuery').unbind("click").bind('click',function(){
			$('#ovreviewContent').load(ctx + '/item/query/itemOrderQuery', param);
		});
		//打开重置
		openCleanBtn('/item/query/itemRealativeInfo',false);
		//直接点击后，打开查询按钮
		var itemNoSearch = '${sessionScope.itemNoSearch}';
		var rltnType = '${itemBasicVO.rltnType}';
		if(itemNo == '' && (itemNoSearch == null || itemNoSearch == "")){
			openSearchBtn('/item/query/itemRealativeInfo',false);
		}
		
		// 如果有值, 代表是可以編輯的商品類型
		if ('${itemBasicVO.itemNo}' != ""){
			
			<auchan:operauth ifAnyGrantedCode="112115996" >
				$('#Tools12').removeClass('Tools12_disable').addClass('Tools12').bind('click', function() {
					param.itemNo = itemNo;
					$('#ovreviewContent').load(ctx + '/item/basicInformation/composedEditAction', param);
				});
			</auchan:operauth>
		
			if (rltnType != null && rltnType != "" ){
				//bring the sub_item detail
				pageQuery();
			}else{
				$("#ovreviewContent").find("input").val(null);
				$('.canEmpty').text(''); 
				openSearchBtn('/item/query/itemRealativeInfo',false);
			}
		}else{
			// 沒值, 則清空不显示
			$("#ovreviewContent").find("input").val(null);
			$('.canEmpty').text(''); 
			openSearchBtn('/item/query/itemRealativeInfo',false);
		}
		$("#itemNo").unbind().bind('keypress', function(e) {
			var code=e.keyCode;
			if (13==code) {
				$('#Tools6').click();
			}
		});
	});
	function pageQuery(){
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		var rltnType = $('#rltnType').val();
		var itemNo = $('#itemNo').val();
		if(rltnType != null && rltnType != ''){
			$.ajax({
				type : "post",
				data : {
					pageNo : pageNo,
					pageSize : pageSize,
					rltnType : rltnType,
					itemNo : itemNo
				},
				dataType : "html",
				url : ctx + "/item/query/getSubItemsByParentItemNo",
				success : function(data) {
					$('#subItemDiv').html(data);
					if(rltnType == 5){
						$('#reltvDateDiv').show();
					}
				}
			});
		}
	}
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
	<div class="tags tags_right_on"></div>
	<div class="tagsM tagsM_on" id="realativeInfoTab">商品关联</div>
	<div class="tags tags_left_on"></div>
	<div class="tagsM" id="supInfoTab">商品厂商</div>
	<div class="tags "></div>
	<div class="tagsM " id="saleCtrlInfoTab">商品陈列</div>
	<div class="tags "></div>
	<div class="tagsM" id="dcInfoTab">DC信息</div>
	<div class="tags "></div>
	<div class="tagsM" id="originInfoTab">商品产地</div>
	<div class="tags "></div>
	<div class="tagsM " id="supAreaInfoTab">商品供应区域</div>
	<div class="tags"></div>
	<div class="tagsM " id="itemOrderQuery">商品订单查询</div>
<div class="tags tags3_r_off"></div>
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
							<input type="text" class="w80 count_text" id="itemNo" value="${itemBasicVO.itemNo}"  placeholder="输入货号查询"
							onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
							<div class="ListWin" onclick="chooseItemNo()"></div>
						</div>
						<input class="inputText iq " type="text" id="itemName" value="${itemBasicVO.itemName }"/>
					</div>
					<div class="ig">
						<div class="msg_txt">英文名称</div>
						<input type="text" class="inputText w50 " value="${itemBasicVO.itemEnName}"/>
					</div>
					<div class="ig">
						<div class="msg_txt">销售单位</div>
						<span class="jksp">1&nbsp;</span> 
						<input class="inputText iq" type="text" style="width: 10%;" 
							<c:if test="${itemBasicVO.sellUnit != null}">
	                           	value="<auchan:getDictValue code="${itemBasicVO.sellUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
	                        </c:if>							
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
						<input class="inputText iq w120" type="hidden" id="rltnType" value="${itemBasicVO.rltnType}"/>
						<input class="inputText iq w120" type="text"
							<c:if test="${itemBasicVO.rltnType != null}">
	                           	value="<auchan:getDictValue code="${itemBasicVO.rltnType}" mdgroup="ITEM_RELATIVE_RLTN_TYPE" showType="3"></auchan:getDictValue>"
	                        </c:if>	
						/>
					</div>
					<div id="reltvDateDiv" class="ig" style="display: none;">
						<div class="msg_txt">生效期间</div>
						<input class="inputText" type="text" style="width: 100px;" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${itemBasicVO.reltvStartDate}"/>">
						<span>&nbsp;-&nbsp;</span>
						<input class="inputText" type="text" style="width: 100px;" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${itemBasicVO.reltvEndDate}"/>">
					</div>
				</div>
				<div class="inner_half">
					<div class="ig" style="margin-top: 15px;">
						<div class="msg_txt">商品状态</div>
						<input type="text" class="inputText w20 "
							<c:if test="${itemBasicVO.status != null}">
	                           	value="<auchan:getDictValue code="${itemBasicVO.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>"
	                        </c:if>							
						 />
					</div>
					<div class="ig">
						<div class="msg_txt">厂商</div>
						<div class="iconPut fl_left w20 ">
							<input type="text" class="w75 " value="${itemBasicVO.comNo}"/>
							<div class="ListWin"></div>
						</div>
						<input class="inputText iq " style="width: 55%;" type="text" value="${itemBasicVO.comName}" />
					</div>
					<div class="ig">
						<div class="msg_txt">进价</div>
						<input class="w20 inputText " type="text" value="${itemBasicVO.stdBuyPrice}"/> 
						<span>元&nbsp;&nbsp;&nbsp;进价税率&nbsp;</span>
						<input class="w10 inputText " type="text" value="${itemBasicVO.buyVatNo}"/> 
						<span>-</span>
						<input class="w10 inputText " type="text" value="${itemBasicVO.buyVatVal}"/>
						<span>&nbsp;%</span>
					</div>
					<div class="ig">
						<div class="msg_txt">售价</div>
						<input class="w20 inputText " type="text" value="${itemBasicVO.stdSellPrice}"/> 
						<span>元&nbsp;&nbsp;&nbsp;售价税率&nbsp;</span>
						<input class="w10 inputText " type="text" value="${itemBasicVO.sellVatNo}"/> 
						<span>-</span>
						<input class="w10 inputText " type="text" value="${itemBasicVO.sellVatVal}"/>
						<span>&nbsp;%</span>
					</div>
				</div>

			</div>
		</div>
		<div id="subItemDiv" class="itemRealative">
		</div>
	</div>
</div>
