<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/create_Supplier342.css" />
<style type="text/css">
	.f_div1,.f_div2 {
		width: 50%;
		float: left;
		height: 100%;
	}
	.div_left,.div_middle,.div_right{
		width: 33%;
		float: left;
		height: 100%
	}
</style>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/supplier/supplierCommon.js" charset="gbk" type="text/javascript"></script>
<script src="${ctx}/shared/js/supplier/supplierCreatePayment.js" charset="gbk" type="text/javascript"></script>
<script type="text/javascript">
	//页面元素值是否变化
	var elementChange  = false;

	$(function() {
		<c:if test="${action == 'create'}">
			$('.CInfo').css("background-image","url(${ctx}/shared/themes/${theme}/images/a342.jpg)");
	   	</c:if>
	   	<c:if test="${action == 'update'}">
	   		$('.CInfo').css("background-image","url(${ctx}/shared/themes/${theme}/images/s342.jpg)");
	   	</c:if>
	   	
		//下一步
		$('#Tools25').removeClass('Tools25_disable').addClass('Tools25').unbind('click').bind('click',function() {
			sep3();
		});

		//上一步
		$('#Tools24').removeClass('Tools24_disable').addClass('Tools24').unbind('click').bind('click',function() {
			sep1();
		});

		$('.div_left').unbind('click').bind('click',function() {
			
			sep1();
		});

		$('.div_right').unbind('click').bind('click',function() {
			sep3();
		});

		//第一步
		function sep1(){
			var param = {'supNo':viewModel.supNo(),'taskId':viewModel.taskId(),'comNo':viewModel.comNo(),'action':viewModel.action()};
			if(elementChange){
				top.jConfirm('页面还有信息未保存，你确定要离开本页面吗?','提示消息',function(ret){
					if(ret){
						$.post(ctx + '/supplierAudit/createSupplier',param,function(data){
							$("#content").html(data);
						},'html');
					}
				});
			}else{
				$.post(ctx + '/supplierAudit/createSupplier',param,function(data){
					$("#content").html(data);
				},'html');
			}
		}
		
		//第三步
		function sep3(){
			var param = {'supNo':viewModel.supNo(),'taskId':viewModel.taskId(),'comNo':viewModel.comNo(),'action':viewModel.action()};
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages();
				return;
			}
			if(elementChange){
				top.jAlert('warning','页面还有信息未保存，请先点击保存后，再点击下一步','提示消息');
			}else{
				$.post(ctx + '/supplierAudit/createSupStoreSecInfo',param,function(data){
					$("#content").html(data);
				},'html');
			}
		}
		
		$("#Tools2").attr('class', "Tools2").bind("click", function() {
			viewModel.save();
			elementChange = false;
		});

		$('.f_div').bind('mousedown', function() { 
			elementChange = true;
		});
	});

	var bankInfo = new supplierCommon.BankInfo('${supPayment.bankVO.bankId}',
			'${supPayment.bankVO.bankName}',
			'${supPayment.bankVO.bankCnapCode}',
			'${supPayment.bankBranchVO.brnchBankId}',
			'${supPayment.bankBranchVO.brnchBankName}',
			'${supPayment.bankBranchVO.brnchBankId}',
			'${supPayment.bankAcctNo}');
	var viewModel = new supplierCreatePayment.ViewModel('${action}', '${supNo}','${taskId}',
			'${supCompany.comNo}', '${supCompany.comEnName}',
			'${supCompany.comName}', '${supPayment.payMethd}',
			'${supPayment.payPerd}', '${supPayment.frontPay}',
			'${supPayment.rtnMail}', '${supPayment.autoMatch}',
			'${supPayment.asignType}', '${supPayment.manulGui}', bankInfo);
	ko.applyBindings(viewModel);
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">
		<c:if test="${action == 'create'}">
       		创建厂商
       	</c:if>
       	<c:if test="${action == 'update'}">
       		修改厂商
       	</c:if>
	</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content" style="width: 99%;">
		<!--width:74%;-->
		<div class="CInfo">
	        <div class="div_left"></div>
			<div class="div_middle"></div>
			<div class="div_right"></div>
        </div>
		<!--539-->
		<div class="f_div">
			<div class="CM f_div1">
				<div class="CM-bar" style="height:360px;">
					<div><!-- 付款方式 --><auchan:i18n id="102006069"/></div>
				</div>
				<div class="CM-div" style="height:360px;">
					<table class="CM_table">
						<tr>
							<td style="width: 25%;">
								<span><!-- 采购厂编 --><auchan:i18n id="102006003"/></span>
							</td>
							<td>
								<input type="text" class="inputText w25 Black" data-bind="value:supNo" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 公司名称 --><auchan:i18n id="102006050"/></span>
							</td>
							<td>
								<input type="text" class="inputText w72_s342 Black" data-bind="value:comName" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 公司英文名 --><auchan:i18n id="102006051"/></span>
							</td>
							<td>
								<input type="text" class="inputText w72_s342 Black" data-bind="value:comEnName" readonly="readonly" />
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
								<auchan:select mdgroup="SUP_PAYMENT_FRONT_PAY" _class="w35" dataBind="value:frontPay" />
							</td>
						</tr>
						<tr>
							<td>
								<span>付款天数</span>
							</td>
							<td>
								<input type="text" class="inputText w25" data-bind="value:payPerd,validationElement:payPerd" maxlength="2" />&nbsp;天
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
								<input type="text" class="inputText w25 Black" data-bind="value:autoMatch,validationElement:autoMatch" maxlength="1" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>债权状态</span>
							</td>
							<td>
								<input type="text" class="inputText w25 Black" data-bind="value:asignType,validationElement:asignType" maxlength="1" readonly="readonly" />
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
						<!-- <tr>
							<td>
								<span>电子发票</span>
							</td>
							<td>
								<input type="checkbox" data-bind="checked:elecInvInd" disabled="disabled" />
							</td>
						</tr> -->
					</table>
				</div>
			</div>
			<div class="CM f_div2">
				<div class="CM-bar" style="height:360px;">
					<div>银行信息</div>
				</div>
				<div class="CM-div" style="height:360px;">
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
								<input type="text" class="inputText w72_s342 Black" data-bind="value:bankInfo().bankAcctNo" maxlength="15" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>大额支付号</span>
							</td>
							<td>
								<input type="text" class="inputText w72_s342 Black" data-bind="value:bankInfo().cnapCode" readonly="readonly" />
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>