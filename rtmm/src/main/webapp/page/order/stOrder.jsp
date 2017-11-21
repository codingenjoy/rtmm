<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<script src="${ctx}/shared/js/order/stOrder.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {		
		$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').bind('click',function() {
			DispOrHid('B-id');
			gridbar_B();
		});
		DispOrHid('B-id');
		//设置默认的订单时间
		$("#ordDateBegin").val(new Date().format('yyyy-MM-dd'));
		$("#ordDateEnd").val(new Date().format('yyyy-MM-dd'));
		search();
	});
	
	function search() {
		if (!validata())
			return;
		$("#pageNo").val(1);
		pageQuery();
	}
	
	//翻页信息
	function pageQuery() {
		var param = $("#queryForm").serialize();
		$.ajax({
			url : '${ctx}/order/stOrderList?tt=' + new Date().getTime(),
			type : "post",
			dataType : "html",
			data : param,
			success : function(data) {
				$("#orderStlist").empty();
				$("#orderStlist").html(data);
			}
		});
	}
	
	//课别添加弹出层事件
	function selectCatlg(){
		//打开弹出层
		openPopupWin(600, 500, '/commons/window/chooseSection');
	}
	
	//课别回调信息
	function confirmChooseSection(id, name) {
		$('#catlgId').attr('value', id);
		$('#catlgName').attr('value', name);
		//关闭弹出层
		closePopupWin();
	}
	
	//厂商信息弹出层
	function selectSup(){
		//打开弹出层
		openPopupWin(550, 510,'/commons/window/chooseSupNo?callback=confirmChooseSupNo');
	}
	
	//厂商信息回调
	function confirmChooseSupNo(supNo, comName) {
		$('#supNo').attr('value', supNo);
		$('#supName').attr('value', comName);
		$('#supName').attr('title', comName);
		//关闭弹出层
		closePopupWin();
	}
	
	//验证信息
	function validata() {
		var storeNo = $.trim($("#storeNo").val());
		var ordNo = $.trim($("#ordNo").val());
		var secNo = $.trim($("#catlgId").val());
		var supNo = $.trim($("#supNo").val());
		var recptNo = $.trim($("#recptNo").val());
		var totOrdAmntFrom = $.trim($("#totOrdAmntFrom").val());
		var totOrdAmntEnd = $.trim($("#totOrdAmntEnd").val());
		var validataInfo = true;
		if (storeNo !='' && !isNumber(storeNo)) {
			$("#storeNo").addClass("errorInput");
			$("#storeNo").attr("title", "请输入正确的店号(数字)");
			validataInfo = false;
		}
		if (ordNo !='' && !isNumber(ordNo)) {
			$("#ordNo").addClass("errorInput");
			$("#ordNo").attr("title", "请输入正确的订单号(数字)");
			validataInfo = false;
		}
		if (secNo != '' && !isNumber(secNo)) {
			$("#catlgId").addClass("errorInput");
			$("#catlgId").attr("title", "请输入正确的课别号信息");
			validataInfo = false;
		}
		if (supNo != '' && !isNumber(supNo)) {
			$("#supNo").addClass("errorInput");
			$("#supNo").attr("title", "请输入正确的厂编信息");
			validataInfo = false;
		}
		if (totOrdAmntFrom != '' && !isFloat(totOrdAmntFrom,11,2)) {
			$("#totOrdAmntFrom").addClass("errorInput");
			$("#totOrdAmntFrom").attr("title", "请输入正确的订购总额");
			validataInfo = false;
		}
		if (totOrdAmntEnd != '' && !isFloat(totOrdAmntEnd,11,2)) {
			$("#totOrdAmntEnd").addClass("errorInput");
			$("#totOrdAmntEnd").attr("title", "请输入正确的订购总额");
			validataInfo = false;
		}
		if (recptNo != '' && !isNumber(recptNo)) {
			$("#recptNo").addClass("errorInput");
			$("#recptNo").attr("title", "请输入正确的收货号码");
			validataInfo = false;
		}
		if(ifHaveErrorInputInSearch()){
			validataInfo = false;
		}
		return validataInfo;
	}
	
	//检测
	$(".inputNmuber").each(function(index, item) {
		$(this).focus(function() {
			$(this).removeClass("errorInput");
		});
	});
	
	function loadCatlgName(){
		var catlgId = $('#catlgId').val();
		if(catlgId!=''){
			//加载课别信息
			readCatalogInfoBySecNo(catlgId, function(data) {
				if (data != "" && data.length > 0) {
					$("#catlgName").val(data[0].secName);
					//search();
				}else{
					$("#catlgId").val('');
					$("#catlgName").val('');
					top.jWarningAlert('该课别不存在');
					return false;
					
				}
			});
		}else{
			$("#catlgName").val('');
		}
	}
	
	function loadSupName(){
		var supNo = $('#supNo').val();
		if($.trim($("#supName").val()))return;
		if(supNo!=''){
			$.ajax({
				type : "post",
				data : {
					supNo : supNo
				},
				url : ctx + '/order/readSupInfoBySupNo',
				success : function(data) {
                    if(!data.result){
            			$("#supNo").val('');
        				$("#supName").val('');
        				top.jWarningAlert('该厂商不存在');
    					return;
    				}
        			$("#supName").val(data.result[0].comName);
					search();
  				  }
			});
/* 			readSupInfoBySupNo(catlgId, supNo, function(data) {
				if (data !=""  && data.length > 0) {
					$("#supName").val(data[0].comName);
					search();
				}else{
					$("#supNo").val('');
					$("#supName").val('');
					top.jWarningAlert('该厂商不存在');
					
				}
			}); */
		}else{
			$("#addSupName").val('');
		}
	}
	
	$("#supNo").keydown(function(e){ 
		if(e.keyCode == 13){
			loadSupName();
			search(); 
	    	return false;
		} 
	});
	
	$("#catlgId").keydown(function(e){ 
		if(e.keyCode == 13){
			loadCatlgName();
			search(); 
	    	return false;
		} 
	});
	
	$("#queryForm").find('input').not('#supNo').not('#catlgId').keydown(function(e){ 
		if(e.keyCode == 13){
			search(); 
	    	return false;
		} 
	});

	function clean_form(){
		//将日期文本域重置为空,其他元素的重置在common.js中使用clean_from清空
		$('.Wdate').attr('value','');
	}   
</script>
<div class="CTitle" id="stOrderListTag">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="104003001"></auchan:i18n></div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1" id="stOrderListView">
	<form id="queryForm" class="clean_from">
	<div class="Search Bar_on" id="searchSTOrderInfos">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span><auchan:i18n id="100002013"></auchan:i18n></span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="SMiddle">
			<table class="SearchTable" id="SearchStOrderTable">
				<tr>
					<td class="ST_td1">
						<span><auchan:i18n id="104003002"></auchan:i18n></span>
					</td>
					<td>
						<input type="text" id="storeNo" name="storeNo" class="inputText w65 inputNmuber" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="4"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="104003003"></auchan:i18n></span>
					</td>
					<td>
						<input class="w85 inputText inputNmuber" id="ordNo" name="ordNo" type="text" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="10"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="104003005"></auchan:i18n></span>
					</td>
					<td>
						<div class="iconPut w65 fl_left">
							<input type="text" class="w80 inputNmuber" id='catlgId' name="catlgId"
							onblur="if(isNaN(this.value)){this.value='';return;}loadCatlgName();"
							onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="10"/>
							<div class="ListWin" onclick="selectCatlg()"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input class="w85 inputText Black" type="text" id="catlgName" name="catlgName" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="104003004"></auchan:i18n></span>
					</td>
					<td>
						<div class="iconPut w65 fl_left">
							<input type="text" class="w80 inputNmuber" id="supNo" name="supNo"
							onblur="if(isNaN(this.value)){this.value='';return;}loadSupName();"
							onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="10"/>
							<div class="ListWin" onclick="selectSup()"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input class="w85 inputText Black" type="text" id="supName" name="supName" />
					</td>
				</tr>

				<tr>
					<td style="line-height: 20px;">
						<span style="line-height: 15px;"><auchan:i18n id="104003006"></auchan:i18n></span>
					</td>
					<td>
						<input type="text" id="ordDateBegin"
						name="ordDateBegin" class="Wdate w65" 
						onclick="WdatePicker({ isShowClear: false, readOnly: true,onpicking:function(dp){stOrderStartDateQuery(dp);}})" />
						&nbsp;-
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input type="text" class="Wdate w65" id="ordDateEnd" name="ordDateEnd" 
						onclick="WdatePicker({ isShowClear: false, readOnly: true,onpicking:function(dp){stOrderEndDateQuery(dp);}})" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="104003007"></auchan:i18n></span>
					</td>
					<td>
						<input type="text" class="Wdate w65" id="planRecptDateBegin" name="planRecptDateBegin" 
						onclick="WdatePicker({ isShowClear: false, readOnly: true,onpicking:function(dp){stOrderPlanRecptStartDateQuery(dp);}})" />
						&nbsp;-
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input type="text" class="Wdate w65" id="planRecptDateEnd" name="planRecptDateEnd" 
						onclick="WdatePicker({ isShowClear: false, readOnly: true,onpicking:function(dp){stOrderPlanRecptEndDateQuery(dp);}})" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="104003008"></auchan:i18n></span>
					</td>
					<td>
						<auchan:select mdgroup="ORDERS_ORD_STTUS" _class="w85" id="ordSttus" name="ordSttus"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="104003009"></auchan:i18n></span>
					</td>
					<td>
						<input class="w85 inputText inputNmuber" type="text" id="recptNo" name="recptNo" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="10"/>
					</td>
				</tr>
				<tr>
					<td style="line-height: 20px;">
						<span style="line-height: 15px;"><auchan:i18n id="104003010"></auchan:i18n></span>
					</td>
					<td>
						<input type="text" class="Wdate w65" id="realRecptDateBegin" name="realRecptDateBegin" 
						onclick="WdatePicker({ isShowClear: false, readOnly: true,onpicking:function(dp){stOrderRealRecptStartDateQuery(dp);}  })" />
						&nbsp;-
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input type="text" class="Wdate w65" id="realRecptDateEnd" name="realRecptDateEnd" 
						onclick="WdatePicker({ isShowClear: false, readOnly: true,onpicking:function(dp){stOrderRealRecptEndDateQuery(dp);}  })" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="104003011"></auchan:i18n></span>
					</td>
					<td>
						<input class="w65 inputText inputNmuber" type="text" id="totOrdAmntFrom" name="totOrdAmntFrom" />
						&nbsp;元-
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input class="w65 inputText inputNmuber" type="text" id="planOrdAmntTo" name="planOrdAmntTo" />
						&nbsp;元
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
	<div class="Content" style="width: 74%;" id="orderStlist"></div>
	</form>
</div>

<div class="CTitle" id="stOrderDetailTag" style="display:none;">
	<div class="tags1_left"></div>
	<div class="tagsM" onclick="closeSTOrderDetail()"><auchan:i18n id="104003001"></auchan:i18n></div>
	<div class="tags tags_right_on"></div>
	<div class="tagsM_q  tagsM_on"><auchan:i18n id="104004001"></auchan:i18n></div>
	<div class="tags3_close_on">
		<div class="tags_close" onclick="closeSTOrderDetail()"></div>
	</div>
</div>
<div class="Container-1" id="stOrderDetailView" style="display:none;">
</div>