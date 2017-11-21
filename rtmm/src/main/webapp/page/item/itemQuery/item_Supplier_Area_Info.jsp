<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="${ctx}/shared/js/jquery/jquery.placeholder.js" ></script>
<script type="text/javascript" src="${ctx}/shared/js/workspace/report.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<style type="text/css">
.row {
	padding-top: 8px;
}

.zr_11 {
	margin-left: 10px;
}

.zr_12 {
	margin-left: 20px;
}

.zr_13 {
	margin-left: 25px;
}

.zr_14 {
	margin-left: 100px;
}

.zr_15 {
	margin-left: 72px;
}

.zr_16 {
	margin-left: 78px;
}

.zr_17 {
	margin-left: 8px;
}

.zr_18 {
	margin-left: 8px;
}
.zr_19 {
	margin-left: 3px;
}
.zr_20 {
	margin-left: 32px;
}

/*overwrite*/
.zz_2 {
	height: 360px;
}

.zz_info {
	width: 96%;
}

.fl_left {
	margin-right: 3px;
}

.fx_div21 {
	height: 20px;
	margin-top: 5px;
	margin-bottom: 5px;
}

.fx_div21_1 {
	height: 20px;
	width: 80px;
	text-align: center;
	cursor: pointer;
	float: left;
}

.fx_div21_2 {
	height: 20px;
	width: 80px;
	text-align: center;
	cursor: pointer;
	margin-left: 5px;
	float: left;
}

.fx_div21_3 {
	height: 20px;
	width: 80px;
	text-align: center;
	cursor: pointer;
	margin-left: 5px;
	float: left;
}
</style>
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
		//DC信息(tab)
		$('#dcInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemDCInfo', param);
		});
		//商品产地(tab)
		$('#supAreaInfoTab').unbind("click").bind('click', function() {
			$('#ovreviewContent').load(ctx + '/item/query/itemSupplierAreaInfo', param);
		});
		//商品订单查询(tab)
		$('#itemOrderQuery').unbind("click").bind('click',function(){
			$('#ovreviewContent').load(ctx + '/item/query/itemOrderQuery', param);
		});
		//打开重置
		openCleanBtn('/item/query/itemSupplierAreaInfo',false);
		//直接点击后，打开查询按钮
		var itemNoSearch = '${sessionScope.itemNoSearch}';
		if(itemNoSearch == null || itemNoSearch == ""){
			openSearchBtn('/item/query/itemSupplierAreaInfo',false);
		}
		$('.fx_div21>div').unbind("click").bind('click', function() {
			if($(this).hasClass("fx_div21_1")) $('#searchType').val('bizType0102');
			if($(this).hasClass("fx_div21_2")) $('#searchType').val('bizType08');
			if($(this).hasClass("fx_div21_3")) $('#searchType').val('bizType07');
			if($('#Tools6').hasClass('Tools6_disable')){
				pageQuery();
			}
		});
		$("#itemNo").unbind().bind('keypress', function(e) {
			var code=e.keyCode;
			if (13==code) {
				$('#Tools6').click();
			}
		});
		pageQuery();
		
	});
	function pageQuery() {
/* 		var pageNo = $.trim($('#pageNo').val()) == ""?1: $.trim($('#pageNo').val());
		var pageSize = $.trim($('#pageSize').val()) == ""?99999:$.trim($('#pageSize').val()); */
		var storeNo = $.trim($('#storeNo').val());
		var itemNo = $.trim($('#itemNo').val()) == '输入货号查询' ? '' : $.trim($('#itemNo').val());
		var searchType = $.trim($('#searchType').val());
		$.ajax({
			type : "post",
			data : {
				pageNo : 1,
				pageSize : 99999,
				storeNo : storeNo,
				itemNo : itemNo,
				searchType : searchType
			},
			dataType : "html",
			url : ctx + "/item/query/getItemSupplierArea",
			success : function(data) {
				$('#itemSuppAreaList').empty();
				$('#itemSuppAreaList').html(data);
			}
		});
	}
	function setSearchType(searchTypeVal){
		$('#searchType').val(searchTypeVal);
	}
	<c:if test="${itemBasicVO ne null}">
	   //导出信息
	$('#Tools23').removeClass('Tools23_disable').addClass('Tools23').unbind().bind('click',function() {
		if($("#itemNo").val()!=null && $('#searchType').val()!=null){
			if('${page.totalCount}'>5000){
				 top.jAlert('warning', '请缩小查询范围到5000项以下', '提示消息');
				 return false;
			 }  
			 top.jAlert('success', '数据正在导出，请稍候...！', '提示消息');
			 var paramsObj= {};
			 paramsObj.itemNo="${itemBasicVO.itemNo}";
			 paramsObj.bizTypeStr=$('#searchType').val();
			 exportReport('sync','112120005',paramsObj); 
		}
	});	
	</c:if>
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
	<div class="tags "></div>
	<div class="tagsM" id="dcInfoTab">DC信息</div>
	<div class="tags "></div>
	<div class="tagsM " id="originInfoTab">商品产地</div>
	<div class="tags tags_right_on"></div>
	<div class="tagsM tagsM_on" id="supAreaInfoTab">商品供应区域</div>
	<div class="tags tags_left_on"></div>
	<div class="tagsM " id="itemOrderQuery">商品订单查询</div>
	<div class="tags tags3_r_off"></div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo"></div>
		<div style="height: 60px;" class="CM">
			<div class="CM-bar">
				<div>货号</div>
			</div>
			<div class="CM-div">
				<div class="hh_item">
					<div class="icol_text w7">
						<span>货号</span>
					</div>
					<div class="iconPut iq" style="width: 10%;">
						<input style="width: 80%" type="text" id="itemNo" value="${itemBasicVO.itemNo}" placeholder="输入货号查询" readonly="readonly"
						onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
						<div class="ListWin" onclick="chooseItemNo()"></div>
					</div>
					<input class="inputText iq Black" style="width: 40%;" type="text" id="itemName" value="${itemBasicVO.itemName}"/>

					<span class="fl_left" style="line-height: 20px;">&nbsp;&nbsp;&nbsp;课别&nbsp;&nbsp;</span>
					<!-- <select class="w15"><option></option></select> ${itemBasicVO.secNo}-${itemBasicVO.secName}-->
					<input class="inputText iq Black" style="width: 22%;" type="text" 
					<c:if test="${itemBasicVO.secNo ne null && itemBasicVO.secName ne null}">
						value="${itemBasicVO.secNo}-${itemBasicVO.secName}"
					</c:if>
					/>
					<input type="hidden" id="searchType" value="bizType0102">
				</div>
			</div>
		</div>
		<div style="height: 470px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>业态和区域</div>
			</div>
			<div class="CM-div">
				<div class="zz_info">

					<div class="fx_div21">
						<div class="fx_div21_1 item item_on" onclick="setSearchType('bizType0102')">大卖场</div>
						<div class="fx_div21_2 item" onclick="setSearchType('bizType08')">加工中心</div>
						<!-- <div class="fx_div21_3 item" onclick="setSearchType('bizType07')">物流中心</div> -->
					</div>
					<hr />
					<div id="itemSuppAreaList"></div>
				</div>
			</div>
		</div>
	</div>
</div>
