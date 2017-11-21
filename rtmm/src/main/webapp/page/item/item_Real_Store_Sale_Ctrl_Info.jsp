<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
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
</style>
<script type="text/javascript">
	$(function() {
		
		$("input").attr("readonly","readonly");
		  //商品修改绑定
    	$("#Tools12").attr('class', "Tools12").unbind().bind("click", function(){
    		if ($.trim($('#itemNo').val())!=""&&$.trim($('#itemNo').val())!=undefined&&
    				$.trim($('#storeNo').val())!=""&&$.trim($('#storeNo').val())!=undefined) {
            $.ajax({
            	type : 'post',
            	url : ctx + '/item/update/checkItemStockAudit',
            	data : {
            		itemNo : $.trim($('#itemNo').val()),
            	    storeNo : $.trim($('#storeNo').val())
            	},
            	success : function(data){
            		if(data.status=='success'){
            		if(data.message==true){
            		    $('.Container').load(ctx + "/item/update/updateItemStock",getParam()); 
            		}
            		else{
            			top.jAlert('warning', '该商品处于审核中！','提示消息');
            		}
            		}
            		else{	
            			top.jAlert('error', '检查商品审核失败！','提示消息');
            		}
            	}
            	
            });
    		}
    		else{
    			top.jAlert('warning', '没有可修改的商品','提示消息');
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
		$('#ovreviewTab').unbind("click").bind( 'click', function() {
			//$('.Container').load(ctx + '/item/query/generalSearch', param);
			var itemNo = '${sessionScope.itemNoSearch}';
			if(itemNo != null && itemNo != ""){
				searchItemByItemNo('${sessionScope.itemNoSearch}','${sessionScope.storeNoSearch}');
				
			}else{
				$('.Container').load(ctx + '/item/query/generalSearch', param);
			}
		});
		//变价信息(tab)
		$('#priceChangeTab').unbind("click").bind( 'click', function() {
			$('.Container').load(ctx + '/item/query/itemPriceChangeInfo', param);
		});
		//规格信息(tab)
		$('#specInfoTab').unbind("click").bind('click', function() {
			$('.Container').load(ctx + '/item/query/itemSpecInfo', param);
		});
		//商品条码(tab)
		$('#barcodeInfoTab').unbind("click").bind('click', function() {
			$('.Container').load(ctx + '/item/query/itemBarcodeInfo', param);
		});
		//商品关联(tab)
		$('#realativeInfoTab').unbind("click").bind('click', function() {
			$('.Container').load(ctx + '/item/query/itemRealativeInfo', param);
		});
		//商品厂商(tab)
		$('#supInfoTab').unbind("click").bind('click', function() {
			$('.Container').load(ctx + '/item/query/itemSupInfo', param);
		});
		//商品陈列(tab)
		$('#saleCtrlInfoTab').unbind("click").bind( 'click', function() {
			$('.Container').load(ctx+ '/item/query/itemRealStoreSaleCtrlInfo',param);
	    });
		//DC信息(tab)
		$('#dcInfoTab').unbind("click").bind('click', function() {
			$('.Container').load(ctx + '/item/query/itemDCInfo', param);
		});
		//打开重置
		openCleanBtn('/item/query/itemRealStoreSaleCtrlInfo',true);
		//直接点击后，打开查询按钮
		var itemNoSearch = '${sessionScope.itemNoSearch}';
		if(itemNoSearch == null || itemNoSearch == ""){
			openSearchBtn('/item/query/itemRealStoreSaleCtrlInfo',true);
		}
		inputToInputIntNumber();
	});
	function changeSotreByCtrlInfo() {
		var shortParam = {
				'itemNo' : getPageItemNo(),
				'storeNo' : $.trim($('#storeNo').val())
		};
		$('.ctrl_info').load(ctx + '/item/query/changeSotreByCtrlInfo', shortParam,function(){
			grid_layer_close();
		});
	}
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
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
	<div class="tags tags_right_on"></div>
	<div class="tagsM tagsM_on" id="saleCtrlInfoTab">商品陈列</div>
	<div class="tags tags_left_on"></div>
	<div class="tagsM" id="dcInfoTab">DC信息</div>
	<div class="tags tags3_r_off"></div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo">
			<div style="float: left;" class="w25">
				<div class="cinfo_div">店号</div>
				<select class="w65" id="storeNo" name="storeNo" onchange="changeSotreByCtrlInfo();">
					<c:forEach items="${storeList}" var="store">
						<option value="${store.storeNo}"
						<c:if test="${sessionScope.storeNoSearch == store.storeNo}">selected</c:if>
						>${store.storeNo}-${store.storeName}</option>
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
						<span>货号</span>
					</div>
					<div class="iconPut iq" style="width: 13%;">
						<input class ="w83 count_text" type="text" id="itemNo" value="${itemBasicVO.itemNo }" placeholder="输入货号查询"/>
						<div class="ListWin" onclick="chooseItemNo()"></div>
					</div>
					<input class="inputText iq Black" style="width: 20%;" type="text" id="itemName" value="${itemBasicVO.itemName }"/>
				</div>
			</div>
		</div>
		<div class="ctrl_info">
			<%@ include file="/page/item/itemQuery/change_Store_Ctrl_Info.jsp"%>
		</div>
	</div>
</div>
