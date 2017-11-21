<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />

<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.CInfo input[type="text"] {
	margin-left: 3px;
}

.iconPut {
	margin-right: 3px;
	float: left;
}

.iconPut span {
	color: #999;
}

.zz_info {
	width: 95%;
}

.zz_2 {
	height: 340px;
}

.zz_2 input {
	margin-left: 3px;
}

.zz_11 {
	margin-left: 50px;
}

.zz_12 {
	margin-left: 43px;
}

.zz_13 {
	margin-left: 185px;
}

.zz_14 {
	margin-left: 75px;
}

.row {
	margin-top: 15px;
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
		$('#ovreviewTab').unbind("click").bind(
				'click',
				function() {
					var itemNo = '${sessionScope.itemNoSearch}';
					if (itemNo != null && itemNo != "") {
						searchItemByItemNo('${sessionScope.itemNoSearch}',
								'${sessionScope.storeNoSearch}');
					} else {
						$('.Container').load(ctx + '/item/query/generalSearch',
								param);
					}
				});

		//变价信息(tab)
		$('#priceChangeTab').unbind("click").bind(
				'click',
				function() {
					$('#ovreviewContent').load(
							ctx + '/item/query/itemPriceChangeInfo', param);
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
			$('#ovreviewContent').load( ctx + '/item/query/itemRealStoreSaleCtrlInfo', param);
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
		openCleanBtn('/item/query/itemOriginInfo', false);
		//直接点击后，打开查询按钮
		var itemNoSearch = '${sessionScope.itemNoSearch}';
		if (itemNoSearch == null || itemNoSearch == "") {
			openSearchBtn('/item/query/itemOriginInfo', false);
		}
		
		/*modify the item origin info*/
		<auchan:operauth ifAnyGrantedCode="112119996">	
	    	$("#Tools12").attr('class', "Tools12").unbind().bind("click", function() {
	    		if ($.trim($('#itemNo').val())!=""&&$.trim($('#itemNo').val())!=undefined) {
	    		 $.ajax({
	            	type : 'post',
	            	url : ctx + '/item/update/checkItemOriginAudit',
	            	data : {
	            		itemNo : $.trim($('#itemNo').val())
	            	},
	            	success : function(data){
	            		if(data.status=='success'){
	            		if(data.message==true){	 
	            		   $('#ovreviewContent').load(ctx + "/item/update/updateItemOrigin",param); 
		            		}
	            		else{
	            			top.jAlert('warning', '该商品处于审核中！','提示消息');
	            		}
	            		}
	            		else{	
	            			top.jAlert('error', '检查商品审核失败！','提示消息');
	            		}
	            	}});  
	    		}
	    		else{
	    			top.jAlert('warning', '没有可修改的商品','提示消息');
	    		}
	    	});
    	</auchan:operauth>
		$("#itemNo").unbind().bind('keypress', function(e) {
			var code=e.keyCode;
			if (13==code) {
				$('#Tools6').click();
			}
		});
		
	});
</script>
<div class="CTitle" id="itemOverViewTitle">
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
	<div class="tags tags_right_on"></div>
	<div class="tagsM tagsM_on" id="originInfoTab">商品产地</div>
	<div class="tags tags_left_on"></div>
	<div class="tagsM " id="supAreaInfoTab">商品供应区域</div>
	<div class="tags"></div>
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
					<div class="icol_text w10">
						<span>货号</span>
					</div>
					<div class="iconPut iq" style="width: 13%;">
						<input id="itemNo" class="w83 count_text" type="text" value="${itemBasicVO.itemNo }" placeholder="输入货号查询"
							onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8" />
						<div class="ListWin" onclick="chooseItemNo()"></div>
					</div>
					<input id="itemName" class="inputText iq" style="width: 40%;" type="text" value="${itemBasicVO.itemName }" title="${itemBasicVO.itemName }"/>
				</div>
			</div>
		</div>
		<div style="height: 90px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>主产地信息</div>
			</div>
			<div class="CM-div">
				<div class="inner_half">
					<div class="ig row">
						<div class="msg_txt">主产地</div>
						<%-- <input type="text" class="w15 inputText" value="${itemMajorOrig.orignCode}" />  --%>
						<div class="iconPut iq" style="width:129px;">
							<input  class="w83 count_text" type="text" value="${itemMajorOrig.orignCode}"/>
							<div class="ListWin"></div>
						</div>						
						<input type="text" style="width:198px;" class="inputText" 
						value="<c:if test="${itemMajorOrig.orignCode ne null }"><auchan:getDictValue code="${itemMajorOrig.orignCode}" mdgroup="origin" showType="2"/></c:if>
						" />
					</div>
					<div class="ig">
						<div class="msg_txt">主生产单位</div>
						<input type="text" class="inputText" style="width:332px;" value="${itemMajorOrig.prdcrName}" />
					</div>
				</div>
				<div class="inner_half">
					<div class="ig row">
						<div class="msg_txt">单位地址</div>
						<div class="iconPut w20">
							<input type="text" class="w80" value="${itemMajorOrig.provName}" />
							<span>省</span>
						</div>
						<div class="iconPut w20">
							<input type="text" class="w80" value="${itemMajorOrig.cityName}" />
							<span>市</span>
						</div>
					</div>
					<div class="ig">
						<div class="msg_txt">&nbsp;</div>
						<input type="text" class="w65 inputText"
							value="${itemMajorOrig.detllAddr}" />
					</div>
				</div>
			</div>
		</div>
		<div style="height: 380px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>其他产地信息</div>
			</div>
			<div class="CM-div">
				<div class="zz_info">
					<div class="zz_1">
						<span class="zz_11">城市</span> <span class="zz_12">其他产地</span> <span
							class="zz_13">生产单位</span> <span class="zz_14">单位地址</span>
					</div>
					<div class="zz_2">
						<c:if test="${itemOthOrignVOs ne null and itemOthOrignVOs.size() > 0 }">
							<c:forEach items="${itemOthOrignVOs}" var="itemOthOrignVO">
									<div class="ig" style="margin-top: 5px; margin-left: 10px;">
										<input type="text" class="w10 inputText fl_left" value="${itemOthOrignVO.cityName }" /> 
										<div class="iconPut" style="margin-left: 3px;">
											<input type="text" class="count_text" style="width:60px;" value="${itemOthOrignVO.orignCode }" /> 
											<div class="ListWin"></div>
										</div>	
										<input type="text" class="w10 inputText fl_left" value="<auchan:getDictValue code="${itemOthOrignVO.orignCode}" mdgroup="origin" showType="2"/>" />
										<input type="text" class="w20 inputText fl_left" value="${itemOthOrignVO.prdcrName }" />
										<div class="iconPut w10" style="margin-left: 3px;">
											<input type="text" class="w80" value="${itemOthOrignVO.provName }" /> <span>省</span>
										</div>
										<div class="iconPut w10">
											<input type="text" class="w80" value="${itemOthOrignVO.cityName }" /> <span>市</span>
										</div>
										<input type="text" class="w20 inputText fl_left" value="${itemOthOrignVO.detllAddr }" />
									</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
