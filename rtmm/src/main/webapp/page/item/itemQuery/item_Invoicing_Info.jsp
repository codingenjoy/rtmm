<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
<style type="text/css">
        .jxc_1 .CM {
            background:#eeeeee;
        }
</style>
<script>
$(function() {
	$('#itemNo').attr('readonly',false);
	$('#Tools6').removeClass().addClass('Tools6').unbind().bind('click',function(){
		searchInfo();
	});
	$("#itemNo").unbind().bind('keypress', function(e) {
		var code=e.keyCode;
		if (13==code) {
			$('#Tools6').click();
		}
	});
	searchInvo();
});

function setSearchType(searchType){
	$('#searchType').val(searchType);
	searchInvo();
}
function searchInfo(){
	var itemNo = $.trim($('#itemNo').val()) == '输入货号查询' ? '' : $.trim($('#itemNo').val());
	if(itemNo){
		$.ajax({
			type : "post",
			data : {
				itemNo : itemNo
			},
			url : ctx + "/itemQueryManagement/invoicingInfo",
			success : function(data) {
			 //用于没有数据时，弹出提示框
				try {
					if(data.message){
						top.jAlert('warning',data.message,'消息提示',function(){
							$('#itemNo').val('');
							$('#itemNo').attr("placeholder","输入货号查询");
						});
						return false;
					}
				} catch (e) {
					top.jAlert('warning','请尝试重试,或联系系统维护或管理人员！','消息提示');
					return false;
				} 
				//显示查询结构
				$('#content').html(data);
				//屏蔽查询
				$('#Tools6').removeClass('Tools6').addClass('Tools6_disable').unbind("click");
				$("#itemNo").attr("readonly",true);
				$("#itemNo+.ListWin").removeAttr("onclick");
				//打开擦出
				 $('#Tools20').removeClass('Tools20_disable').addClass('Tools20').unbind().bind('click', function() {
					$('.Container-1').find("input").val(null);
					$('.Container-1').find("select").empty();
					$("#itemNo").attr("readonly",false);
					$("#itemNo+.ListWin").attr("onclick","chooseItemNo()");
					$('#Tools20').removeClass('Tools20').addClass('Tools20_disable').unbind("click");
					$('#Tools6').removeClass().addClass('Tools6').unbind().bind('click',function(){
						searchInfo();
					});
				}); 
			}
		});
	}else{
		top.jAlert('warning','请输入或选择货号！','消息提示');
	}
	
}
function searchInvo(){
	var searchType = $.trim($('#searchType').val());
	var storeNo = $.trim($('#storeNo').val());
	var itemNo = $.trim($('#itemNo').val()) == '输入货号查询' ? '' : $.trim($('#itemNo').val());
	$.ajax({
		type : "post",
		data : {
			storeNo : storeNo,
			itemNo : itemNo,
			searchType : searchType
		},
		dataType : "html",
		url : ctx + "/itemQueryManagement/searchInvoicing",
		success : function(data) {
			$('#showInfo').html(data);
		}
	});
}
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on" id="supAreaInfoTab">进销存</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo">
			<div style="float: left;" class="w25">
				<div class="cinfo_div">店号</div>
				<select class="w70" id="storeNo" name="storeNo" onchange="searchInvo();">
				<c:if test="${not empty storeList}">
					<c:forEach items="${storeList}" var="store">
						<option value="${store.storeNo}" title="${store.storeNo}-${store.storeName}"
						<c:if test="${sessionScope.storeNoSearch == store.storeNo}">selected</c:if>
						>${store.storeNo}-${store.storeName}</option>
					</c:forEach>
				</c:if>
				</select>
				<input type="hidden" id="searchType" value="store" />
			</div>
		</div>
		<div style="height: 60px;" class="CM">
			<div class="CM-bar">
				<div>货号</div>
			</div>
			<div class="CM-div">
				<div class="hh_item">
					<div class="icol_text w9">
						<span>货号</span>
					</div>
					<div class="iconPut iq" style="width: 10%;">
						<input style="width: 80%" type="text" id="itemNo" value="${itemBasicVO.itemNo}" placeholder="输入货号查询" readonly="readonly"
						onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
						<div class="ListWin" onclick="chooseItemNo()"></div>
					</div>
					<input class="inputText iq Black" style="width: 40%;" type="text" id="itemName" value="${itemBasicVO.itemName}"/>
					<input type="hidden" id="searchType" value="bizType0102">
				</div>
			</div>
		</div>
		<div id="showInfo">
			<%@ include file="/page/item/itemQuery/item_Invoicing_Store.jsp"%>
		</div>
	</div>
</div>
