<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/supplier/supplierCommon.js" charset="gbk" type="text/javascript"></script>
<script src="${ctx}/shared/js/supplier/supplierCreatePayment.js" charset="gbk" type="text/javascript"></script>
<style type="text/css">
.f_div {
	height: 360px;
}

.f_div1,.f_div2 {
	width: 50%;
	float: left;
	height: 100%;
}

.w91_s232 {
	width: 91%;
	width /*\**/: 92% \9;
	*width: 92%;
}

.w72_s342 {
	width: 72.5%;
}

.div1 {
	width: 40px;
	height: 30px;
	float: left;
	line-height: 28px;
}

.div2 {
	width: 45%;
	float: left;
	margin-left: 4px;
}

.input28 {
	width: 26%;
	float: left;
}
</style>
<script type="text/javascript">
	$(function() {
		$(".tagsM").die("click");
				
		$('#cs_tags1').unbind('click').bind('click',function() {
			$.post(ctx + "/supplier/getSupplierGeneralInfo?supNo=${supNo}",function(data){
				$("#content").html(data);
			},'html');
		});

		$('#cs_tags2').unbind('click').bind('click', function() {
			$.post(ctx + "/supplier/getSupPaymentInfo?supNo=${supNo}&comNo=${comNo}",function(data){
				$("#content").html(data);
			},'html');
		});

		$('#cs_tags3').unbind('click').bind('click',function() {
			$.post(ctx + "/supplier/getSupplierAreaInfo?supNo=${supNo}&comNo=${comNo}",function(data){
				$("#content").html(data);
			},'html');
		});
	});
	var bankInfo = new supplierCommon.BankInfo(
			'${supPayment.bankVO.bankId}', '${supPayment.bankVO.bankName}',
			'${supPayment.bankVO.bankCnapCode}',
			'${supPayment.bankBranchVO.brnchBankId}',
			'${supPayment.bankBranchVO.brnchBankName}',
			'${supPayment.bankBranchVO.brnchBankId}',
			'${supPayment.bankAcctNo}');
	var viewModel = new supplierCreatePayment.ViewModel('', '${supNo}','',
			'${supCompany.comNo}', '${supCompany.comEnName}',
			'${supCompany.comName}', '${supPayment.payMethd}',
			'${supPayment.payPerd}', '${supPayment.frontPay}',
			'${supPayment.rtnMail}', '${supPayment.autoMatch}',
			'${supPayment.asignType}', '${supPayment.manulGui}', bankInfo);
	ko.applyBindings(viewModel);
	
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
    <!-- 第一个 -->
    <div class="tags1_left"></div>
    <div id="cs_tags1" class="tagsM"><!-- 厂商总览 --><auchan:i18n id="102006001"/></div>
    <div class="tags tags_right_on"></div>

    <!-- 中间 -->
    <div id="cs_tags2" class="tagsM tagsM_on"><!-- 厂商财务信息 --><auchan:i18n id="102007001"/></div>
    <div class="tags tags_left_on"></div>

   	<!--  最后一个 -->
    <div id="cs_tags3" class="tagsM"><!-- 厂商供应区域 --><auchan:i18n id="102008001"/></div>
    <div class="tags tags3_r_off"></div>

</div>
                                        
<div class="Container-1">
	<div class="Content" style="width: 99%;">
		<!--width:74%;-->
		<!-- <div class="CInfo"></div> -->
		<!--539-->
		<div class="f_div">
			<div class="CM f_div1">
				<div class="CM-bar" style="height: 360px">
					<div><!-- 付款方式 --><auchan:i18n id="102006069"/></div>
				</div>
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td style="width: 25%;">
								<span><!-- 采购厂编 --><auchan:i18n id="102006003"/></span>
							</td>
							<td>
								<input type="text" class="inputText w25" data-bind="value:supNo" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 公司名称 --><auchan:i18n id="102006050"/></span>
							</td>
							<td>
								<input type="text" class="inputText w72_s342" data-bind="value:comName" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 公司英文名 --><auchan:i18n id="102006051"/></span>
							</td>
							<td>
								<input type="text" class="inputText w72_s342" data-bind="value:comEnName" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 付款方式 --><auchan:i18n id="102006069"/></span>
							</td>
							<td>
								<auchan:select mdgroup="SUP_PAYMENT_PAY_METHD" _class="w35" dataBind="value:payMethd" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>付款批次</span>
							</td>
							<td>
								<auchan:select mdgroup="SUP_PAYMENT_FRONT_PAY" _class="w35" dataBind="value:frontPay" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>付款天数</span>
							</td>
							<td>
								<input type="text" class="inputText w25" data-bind="value:payPerd" maxlength="3" readonly="readonly"/>&nbsp;天
							</td>
						</tr>
						
						<tr>
							<td>
								<span>退货回传</span>
							</td>
							<td>
								<input type="checkbox" data-bind="checked:rtnMail" maxlength="1" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>退货过账</span>
							</td>
							<td>
								<input type="text" class="inputText w25" data-bind="value:autoMatch" maxlength="1" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>债权状态</span>
							</td>
							<td>
								<input type="text" class="inputText w25" data-bind="value:asignType" maxlength="1" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>人工销项发票开立</span>
							</td>
							<td>
								<input type="checkbox" data-bind="checked:manulGui" disabled="disabled"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="CM f_div2">
				<div class="CM-bar" style="height: 360px">
					<div><!-- 银行信息 --><auchan:i18n id="102006070"/></div>
				</div>
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td style="width: 25%;">
								<span>银行名称</span>
							</td>
							<td>
								<div class="div1">总行</div>
								<input type="text" class="inputText w72_s342 Black" data-bind="value:bankInfo().bankName" maxlength="15" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<div class="div1">分支行</div>
								<input type="text" class="inputText w72_s342 Black" data-bind="value:bankInfo().bankBranchName" maxlength="15" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>银行帐号</span>
							</td>
							<td>
								<input type="text" class="inputText w72_s342" data-bind="value:bankInfo().bankAcctNo" maxlength="15" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>大额支付号</span>
							</td>
							<td>
								<input type="text" class="inputText w72_s342" data-bind="value:bankInfo().cnapCode" readonly="readonly" />
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>