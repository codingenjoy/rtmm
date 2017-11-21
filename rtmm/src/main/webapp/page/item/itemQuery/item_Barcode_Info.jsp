<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemBaseDoc.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#ovreviewContent").find("input").attr("readonly","readonly");
		$("#itemNo").attr("readonly",false);
		setToolsbarAllDisable();
		$("#Tools21").unbind().removeClass().addClass('Icon-size1 Tools21_disable');
		//传递参数 
		var param = {
			'itemNo' : '${sessionScope.itemNoSearch}',
			'itemName' : '${sessionScope.itemNameSearch}',
			'storeNo' : '${sessionScope.storeNoSearch}',
			'storeName' : '${sessionScope.storeNameSearch}'
		};
		//绑定条码修改
		if ($.trim($("#itemName").attr("value")) != ""){
			<auchan:operauth ifAnyGrantedCode="112114996" >
				$("#Tools12").attr('class', "Tools12").unbind("click").bind("click",
						function() {
								$('#ovreviewContent').load(ctx + '/item/update/updateItemBarCode', getParam());
				});
			</auchan:operauth>
			
		}
		//商品总览(tab)
		$('#ovreviewTab').unbind("click").bind( 'click', function() {
			//$('#ovreviewContent').load(ctx + '/item/query/itemBaseInfo', param);
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
/* 		$('#barcodeInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemBarcodeInfo', param);
		}); */
		//商品关联(tab)
		$('#realativeInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemRealativeInfo', param);
		});
		//商品厂商(tab)
		$('#supInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSupInfo',param);
		});
		//商品陈列(tab)
		$('#saleCtrlInfoTab').unbind("click").bind( 'click', function() {
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
		openCleanBtn('/item/query/itemBarcodeInfo',false);
		//直接点击后，打开查询按钮
		var itemNoSearch = '${sessionScope.itemNoSearch}';
		if((itemNoSearch == null || itemNoSearch == "") &&
				($("#itemNo").attr("value") == "" || $("#itemNo").attr("value") == "输入货号查询")){
			openSearchBtn('/item/query/itemBarcodeInfo',false);
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
	<div class="tags tags_right_on"></div>
	<div class="tagsM tagsM_on" id="barcodeInfoTab">商品条码</div>
	<div class="tags tags_left_on"></div>
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
	<div class="tags"></div>
	<div class="tagsM " id="itemOrderQuery">商品订单查询</div>
<div class="tags tags3_r_off"></div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo">
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
						<input id="itemNo" class ="w83 count_text" type="text" value="${itemBasicVO.itemNo }" placeholder="输入货号查询"
						onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
						<div class="ListWin" onclick="chooseItemNo()"></div>
					</div>
					<input id= "itemName" class="inputText iq" style="width: 20%;" type="text" value="${itemBasicVO.itemName }" /> 
				</div>
			</div>
		</div>
		<div style="height: 470px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>商品条码信息</div>
			</div>
			<div class="CM-div">
				<div class="txm_info">
					<div class="txm_title">
						<span style="margin-left: 80px;">条码</span><span
							style="margin-left: 100px;">创建日期</span> <span
							style="margin-left: 60px;">建档人</span>
					</div>
					<div class="sp_tb itemBarcodeList">
						<c:forEach items="${barcodeList}" var="barCode">
							<div class="ig">
								<input type="text" class="w110 inputText" value="${barCode.barcode}" /> 
								<input type="text" class="w20 inputText" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${barCode.creatDate}"/>" />
								<input type="text" class="w25 inputText" value="${barCode.creatBy}" />
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
