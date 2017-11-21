<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<script type="text/javascript">

	var orderTransArray  = new Array();

	$(function() {
		$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').bind('click',
				function() {
					DispOrHid('B-id');
					gridbar_B();
				});
		DispOrHid('B-id');
		pageQuery();
	});

	function search() {
		if (!validata())
			return;
		$("#pageNo").val(1);
		pageQuery();
	}

	function refresh(e) {
		if (e.keyCode == 13) {
			search();
			return false;
		}
	}
	//验证信息
	function validata(){
		var storeNo = $.trim($("#storeNo").val());
		var ordNo = $.trim($("#ordNo").val());
		var ordAccptmethd = $.trim($("#ordAccptmethd").val());
		var stransSttus = $.trim($("#stransSttus").val()); 
		var validataInfo = true;
		
		if (storeNo != '' && !isNumber(storeNo)) {
			$("#storeNo").addClass("errorInput");
			$("#storeNo").attr("title", "请输入正确的门店号(数字)");
			validataInfo = false;  
		}
		if (ordNo != '' && !isNumber(ordNo)) {
			$("#ordNo").addClass("errorInput");
			$("#ordNo").attr("title", "请输入正确的订单号(数字)");
			validataInfo = false;  
		}
		if (ordAccptmethd != '' && !isNumber(ordAccptmethd)) {
			$("#ordAccptmethd").addClass("errorInput");
			$("#ordAccptmethd").attr("title", "请输入正确的发送通道(数字)");
			validataInfo = false;  
		}
		if (stransSttus != '' && !isNumber(stransSttus)) {
			$("#stransSttus").addClass("stransSttus");
			$("#stransSttus").attr("title", "请输入正确的发送状态(数字)");
			validataInfo = false;  
		}
		return validataInfo;
		}
	//翻页信息
	function pageQuery() {
		var param = $("#queryForm").serialize();
		$.ajax({
			url : '${ctx}/order/orderSendStatTraceList?tt=' + new Date().getTime(),
			type : "post",
			dataType : "html",
			data : param,
			success : function(data) {
				$("#orderSendStatTracelist").empty();
				$("#orderSendStatTracelist").html(data);
			}
		});
		// 取消選取所有多選框
		$("[type=checkbox]").removeAttr("checked");
		// 計算勾選個數: 沒有則 disable delete 和 edit icon
		//countChecked();
		// 檢查權限, enable create icon
		//enableHoOrderCreate();
	}
</script>
<div class="CTitle" id="stOrderListTag">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">订单发送状态跟踪</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1" id="orderSendStatTraceListView">
	<form id="queryForm" class="clean_from">
	<div class="Search Bar_on" id="searchorderSendStatTraceInfos">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span><auchan:i18n id="100002013"></auchan:i18n></span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="SMiddle">
           <table class="SearchTable" id="searchorderSendStatTraceTable">
					<tr>
						<td class="ST_td1">
							<span>店号</span>
						</td>
						<td>
							<input class="w65 inputText inputNmuber" type="text" id="storeNo"
								name="storeNo" onkeyup="this.value=this.value.replace(/\D/g,'')"
								maxlength="10" onafterpaste="if(isNaN(this.value))execCommand('undo')" onkeydown="refresh(event)"/>
						</td>
					</tr>
					<tr>
						<td>
							<span>订单号码</span>
						</td>
						<td>
							<input class="w65 inputText inputNmuber" type="text" id="ordNo"
								name="ordNo" onkeyup="this.value=this.value.replace(/\D/g,'')"
								maxlength="10" onafterpaste="if(isNaN(this.value))execCommand('undo')" onkeydown="refresh(event)"/>
						</td>
					</tr>
					<tr>
						<td>
							<span>发送通道</span>
						</td>
						<td>
   							<auchan:select id="ordAccptmethd" _class="w65" mdgroup="SUPPLIER_ORDR_ACCPT_METHD" name="ordAccptmethd" onchange="search()"></auchan:select>

							<!--  <input class="w65 inputText inputNmuber" type="text" id="ordAccptmethd"
								name="ordAccptmethd" onkeyup="this.value=this.value.replace(/\D/g,'')"
								maxlength="10" />-->
						</td>
					</tr>
					<tr>
						<td>
							<span>发送状态</span>
						</td>
						<td>
							<auchan:select id="stransSttus" _class="w65" mdgroup="ORD_TRANS_STATE_TRACK_TRANS_STTUS" name="stransSttus" onchange="search()"></auchan:select>
							<!--  <input class="w65 inputText inputNmuber" type="text" id="stransSttus"
								name="stransSttus" onkeyup="this.value=this.value.replace(/\D/g,'')"
								maxlength="10" />-->
						</td>
					</tr>
					
				</table>
			</div>
			<div class="line"></div>
			<div class="SearchFooter">
				<div class="Icon-size1 Tools20" onclick="clean_form()"></div>
				<div class="Icon-size1 Tools6" onclick="search()"></div>
			</div>

		</div>
		<div class="Content" style="width: 74%;" id="orderSendStatTracelist"></div>
	</form>
</div>






