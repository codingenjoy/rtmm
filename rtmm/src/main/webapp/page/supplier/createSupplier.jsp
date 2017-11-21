<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/create_Supplier341.css" />
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/supplier/supplierCommon.js" charset="gbk" type="text/javascript"></script>
<script src="${ctx}/shared/js/supplier/supplierCreateBaseInfo.js" charset="gbk" type="text/javascript"></script>
<style type="text/css">
	.CM_table span {
		line-height: normal;
	}
	.div_left,.div_middle,.div_right{
		width: 33%;
		float: left;
		height: 100%
	}
	
</style>

<script type="text/javascript">
	//页面元素值是否变化
	var elementChange  = false;
	
	$(function() {
		
		<c:if test="${action == 'create' && (comNo != null && comNo != undefind && comNo != '')}">
			confirmChooseSupCom('${comNo}');
		</c:if>
		<c:if test="${action == 'create'}">
			$('.CInfo').css("background-image","url(${ctx}/shared/themes/${theme}/images/a341.jpg)");
	   	</c:if>
	   	<c:if test="${action == 'update'}">
	   		$('.CInfo').css("background-image","url(${ctx}/shared/themes/${theme}/images/s341.jpg)");
	   	</c:if>
		
		//按钮(下一步)
		var tool25 = $('#Tools25');
		$(tool25).removeClass('Tools25_disable').addClass('Tools25');
		$(tool25).unbind('click').bind('click',function() {
			sep2();
		});

		$('.div_middle').unbind('click').bind('click',function() {
			sep2();
		});

		$('.div_right').unbind('click').bind('click',function() {
			sep3();
		});

		//第二步
		function sep2(){
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages(true);
				return;
			}
			if(elementChange){
				top.jAlert('warning','页面还有信息未保存，请先点击保存后，再点击下一步','提示消息');
			}else{
				if('${action}' == 'update'){
					viewModel.save('nextSetp');
				}
				var param = {'supNo':viewModel.supNo(),'taskId':viewModel.taskId(),'comNo':viewModel.comNo(),'action':viewModel.action(),dlvryMethd:viewModel.dlvryMethd()};
				$.post(ctx+'/supplierAudit/createSupPayment',param,function(data){
					$("#content").html(data);
				},'html');
			}
		}

		//第三步
		function sep3(){
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages(true);
				return;
			}
			if(elementChange){
				top.jAlert('warning','页面还有信息未保存，请先点击保存后，再点击','提示消息');
			}else{
				var param = {'supNo':viewModel.supNo(),'taskId':viewModel.taskId(),'comNo':viewModel.comNo(),'action':viewModel.action(),dlvryMethd:viewModel.dlvryMethd()};
				$.post(ctx+'/supplierAudit/createSupStoreSecInfo',param,function(data){
					$("#content").html(data);
				},'html');
			}
		}

		//按钮(保存)
		$("#Tools2").attr('class', "Tools2").unbind('click').bind("click", function() {
			viewModel.save();
			elementChange = false;
		});
		
		$('.f_div').bind('mousedown', function() { 
			elementChange = true;
		});

	});

	function confirmChooseSupCom(comNo, comName, grpNo, grpName) {
		if(comNo == "" && comNo != null){
			return;
		}
		//根据comNo查询其注册地址填充到厂商联系方式中
		$.post("${ctx}/supplier/company/getSupCompanyInfo",{comNo:comNo}, function(data){
			if(data.supCompany.comNo){
				
				viewModel.comNo(comNo);
				viewModel.comName(data.supCompany.comName);
				viewModel.grpNo(data.supCompany.grpNo);
				viewModel.grpName(data.supCompany.grpName);
				var address = data.supCompany.comRegstrAddress;
				if(address){
					if(address.provName){
						viewModel.addressInfo().provName(address.provName);
					}
					if(address.cityName){
						viewModel.addressInfo().cityName(address.cityName);
					}
					if(address.detllAddr){
						viewModel.addressInfo().detailAddr(address.detllAddr);
					}
					if(address.postCode){
						viewModel.addressInfo().postCode(address.postCode);
					}
					if(address.areaCode){
						viewModel.addressInfo().areaCode(address.areaCode);
					}
					if(address.conctName){
						viewModel.addressInfo().cntctName(address.conctName);
					}
					if(address.phoneNo){
						viewModel.addressInfo().phoneNo(address.phoneNo);
					}
					if(address.faxAreaCode){
						viewModel.addressInfo().faxAreaCode(address.faxAreaCode);
					}
					if(address.faxNo){
						viewModel.addressInfo().faxNo(address.faxNo);
					}
					if(address.moblNo){
						viewModel.addressInfo().moblNo(address.moblNo);
					}
					if(address.emailAddr){
						viewModel.addressInfo().emailAddr(address.emailAddr);
					}
					viewModel.errors = ko.validation.group(viewModel);
					viewModel.errors.showAllMessages(false);
				}
			}else{
				<auchan:operauth ifAnyGrantedCode="111211996"> 
					top.jConfirm(comNo+'公司不存在,<br>确定后将跳转到创建公司页面,<br/>取消后可重新输入公司编号','提示消息',function(ret){
						if(ret){
							showContent(ctx+'/supplier/company/createSupCompany');
						}
					});
				</auchan:operauth>
				<auchan:operauth ifNotGrantedCode="111211996"> 
					top.jAlert('warning',comNo+'公司不存在','提示消息');
				</auchan:operauth>
				viewModel.comNo('');
			}
		});
	}

	$("#comNo").keydown(function(e){ 
		if(e.keyCode == 13){ 
			
			confirmChooseSupCom(this.value);
        	return false;
		} 
	}); 

	function confirmChooseCityAndProv(cityId, cityName, provId, provName) {
		closePopupWin();
		$(viewModel.tmpVal()).parent().find('input').attr('value',cityName).trigger('change');
		$(viewModel.tmpVal()).parent().prev().find('input').attr('value',provName).trigger('change');
	}

	var addressInfo = new supplierCommon.AddressInfo(
			'${supplier.addressVO.addrId}', '${supplier.addressVO.provName}',
			'${supplier.addressVO.cityName}',
			'${supplier.addressVO.detllAddr}',
			'${supplier.addressVO.postCode}', '${supplier.addressVO.areaCode}',
			'${supplier.addressVO.cntctName}', '${supplier.addressVO.phoneNo}',
			'', '${supplier.addressVO.faxNo}', '${supplier.addressVO.moblNo}',
			'${supplier.addressVO.emailAddr}', true);

	var viewModel = new supplierCreateBaseInfo.ViewModel(
			'${action}',
			'${supplier.taskId}',
			'${supNo}',
			'${supplier.status}',
			'${supplier.supComVO.comNo}',
			'${supplier.supComVO.comName}',
			'${supplier.supComVO.comGrpVO.comgrpNo}',
			'${supplier.supComVO.comGrpVO.comgrpName}',
			'${supplier.supType}',
			'${supplier.dlvryMethd}',
			'${supplier.buyMethd}',
			'${supplier.txtSup}',
			'${supplier.cntrtType}',
			"<fmt:formatDate value='${supplier.validEndDate}' pattern='yyyy-MM-dd'/>",
			'${supplier.ordAccptMethd}', '${supplier.firstOrdQty}',
			'${supplier.scmLvl}','${supplier.elecInvInd}','${supplier.ordDiscInd}', addressInfo);
	ko.applyBindings(viewModel);
	viewModel.changeSupType('${supplier.buyMethd}');
	//默认不显示错误消息
	viewModel.errors = ko.validation.group(viewModel);
	viewModel.errors.showAllMessages(false);
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
  	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on" style="">
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
		<!-- <div class="CInfo"></div> -->
		<div class="CInfo">
			<div class="div_left"></div>
			<div class="div_middle"></div>
			<div class="div_right"></div>
        </div>
		<!--539-->
		<div class="f_div">
			<div class="CM f_div1">
				<div class="CM-bar">
					<div><!-- 基本信息 --><auchan:i18n id="102006063"/></div>
				</div>
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td style="width: 25%;">
								<span><!-- 采购厂编 --><auchan:i18n id="102006003"/></span>
							</td>
							<td>
								<input type="text" class="inputText Black div1" data-bind="value:supNo" readonly="readonly" />
								<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 厂商状态 --><auchan:i18n id="102006004"/></span>
								<auchan:select mdgroup="SUPPLIER_STATUS" _class="select1 Black" dataBind="value:status,validationElement:status" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>*<!-- 公司 --><auchan:i18n id="102006049"/></span>
							</td>
							<td>
								<div class="iconPut" style="width: 26%; float: left;">
									<input id="comNo" type="text" style="width: 80%" data-bind="value:comNo,validationElement:comNo" onchange="confirmChooseSupCom(this.value)"/>
									<div class="ListWin" data-bind="event:{click:supplierCommon.selectCompany}"></div>
								</div>
								<input type="text" class="inputText Black div2" data-bind="value:comName" style="width:58%" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span>集团</span>
							</td>
							<td>
								<input type="text" class="inputText Black div11" data-bind="value:grpNo" readonly="readonly" />
								<input type="text" class="inputText div2 Black" data-bind="value:grpName" readonly="readonly" style="width:64%"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>*<!-- 厂商种类 --><auchan:i18n id="102006007"/></span>
							</td>
							<td>
								<auchan:select mdgroup="SUPPLIER_SUP_TYPE" _class="select2" ignoreValue="11,12" dataBind="value:supType,event:{change:changeSupType},validationElement:supType,attr:{'disabled':isEdit()}" />
								<span style="float: left; margin: 3px;">&nbsp;&nbsp;*<!-- 供货方式 --><auchan:i18n id="102006008"/>&nbsp;</span>
								<auchan:select mdgroup="SUPPLIER_DLVRY_METHD" _class="select1" dataBind="value:dlvryMethd,validationElement:dlvryMethd,attr:{'disabled':isEdit()}" ignoreValue="3"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>*<!-- 采购方式 --><auchan:i18n id="102006009"/></span>
							</td>
							<td>
								<select id="buyMethdHidden" class="select2" data-bind="options: buyMethdList, optionsCaption: '请选择', optionsText: 'optionsText', optionsValue: 'optionsValue', value:buyMethd,validationElement:buyMethd,event:{change:changeBuyMethd},attr:{'disabled':isEdit()}" style="float:left;display: none;" ></select>
								<select id="selectHidden" class="select2" style="float:left"><option>请选择</option></select>
								<span style="float: left; margin-right: 0;">&nbsp;&nbsp;&nbsp;TXT 厂编&nbsp;</span>
								<input type="text" class="inputText div2" data-bind="value:txtSup" maxlength="5" />
							</td>
						</tr>
						<tr>
							<td>
								<span>*<!-- 合同标准 --><auchan:i18n id="102006011"/></span>
							</td>
							<td>
								<auchan:select mdgroup="SUPPLIER_CONTRT_TYPE" _class="select2" dataBind="value:cntrtType,validationElement:cntrtType,attr:{'disabled':isEdit()}" />
								<span style="float: left; margin: 3px;">&nbsp;&nbsp;&nbsp;<!-- 失效日期 --><auchan:i18n id="102006012"/>&nbsp;</span>
								<input data-bind="value:validEndDate" class="Wdate" type="text" onClick="WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change')},isShowClear:false,readOnly:true})" style="width:105px;">
							</td>
						</tr>
<!-- 						<tr>
							<td>
								<span>合约课别</span>
							</td>
							<td>
								<input type="text" class="inputText Black w91_s232" />
							</td>
						</tr> -->
					</table>
				</div>
			</div>
			<div class="CM f_div2">
				<div class="f_div21">
					<div class="CM-bar">
						<div><!-- 联系方式 --><auchan:i18n id="102006065"/></div>
					</div>
					<div class="CM-div">
						<table class="CM_table">
							<tr>
								<td style="width: 20%;">
									<span>*<auchan:i18n id="102006014"/></span>
								</td>
								<td>
									<div class="iconPut" style="width: 20%; float: left;">
										<input type="text" style="width: 72%;"
											data-bind="value:addressInfo().provName, validationElement:addressInfo().provName" readonly="readonly" />
										<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
									</div>
									<div class="iconPut"
										style="width: 30%; float: left; margin-left: 3px;">
										<input type="text" style="width: 62%;"
											data-bind="value:addressInfo().cityName, validationElement:addressInfo().cityName" readonly="readonly"/>
										<div class="ListWin" data-bind="event:{click:addressInfo().openCityAndProvWindow}"></div>
										<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
									</div>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>
									<input type="text" class="inputText w91_s232" data-bind="value:addressInfo().detailAddr, validationElement:addressInfo().detailAddr" maxlength="30"/>
								</td>
							</tr>
							<tr>
								<td>
									<span>邮编</span>
								</td>
								<td>
									<input type="text" class="inputText twoinput25" data-bind="value:addressInfo().postCode,validationElement:addressInfo().postCode" maxlength="6" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
									<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
									<input type="text" class="inputText twoinput25" data-bind="value:addressInfo().cntctName" maxlength="10" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
									<input type="text" class="inputText twoinput22" data-bind="value:addressInfo().areaCode,validationElement:addressInfo().areaCode" maxlength="4" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
									<span style="float: left; margin: 0;">-</span>
									<input type="text" class="inputText twoinput26" data-bind="value:addressInfo().faxNo,validationElement:addressInfo().faxNo" maxlength="8" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
								</td>
								<td>
									<input type="text" class="inputText twoinput22" data-bind="value:addressInfo().areaCode,validationElement:addressInfo().areaCode" maxlength="4" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
									<span style="float: left; margin: 0;">-</span>
									<input type="text" class="inputText twoinput26" data-bind="value:addressInfo().phoneNo,validationElement:addressInfo().phoneNo" maxlength="8" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/>&nbsp;</span>
									<input type="text" class="inputText twoinput27" data-bind="value:addressInfo().moblNo,validationElement:addressInfo().moblNo" maxlength="11" style="width:22%" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
									<span style="float: left; margin: 0;">&nbsp;&nbsp;邮箱&nbsp;</span>
									<input type="text" class="inputText twoinput28" data-bind="value:addressInfo().emailAddr,validationElement:addressInfo().emailAddr" maxlength="20" style="width:22%"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="f_div22">
					<div class="CM-bar">
						<div><!-- 额外信息 --><auchan:i18n id="102006064"/></div>
					</div>
					<div class="CM-div">
						<table class="CM_table">
							<tr>
								<td style="width: 20%;">
									<span><!-- 订单发送方式 --><auchan:i18n id="102006021"/></span>
								</td>
								<td>
									<auchan:select mdgroup="SUPPLIER_ORDR_ACCPT_METHD" _class="select1" dataBind="value:ordAccptMethd" style="float:left;width:79px;"/>
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 首订单量 --><auchan:i18n id="102006022"/>&nbsp;</span>
									<input type="text" data-bind="value:firstOrdQty,validationElement:firstOrdQty" class="inputText div1" maxlength="6">
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 订单折让 --><auchan:i18n id="102006023"/>&nbsp;</span>
									<input type="checkbox"  data-bind="checked:ordDiscInd" style="margin-top: 3px;"/>
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 网上对账级别 --><auchan:i18n id="102006024"/></span>
								</td>
								<td>
									<auchan:select mdgroup="SUPPLIER_SCM_LEVEL" _class="select1" dataBind="value:scmLvl" style="float:left;width:66px;"/>
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电子发票 --><auchan:i18n id="102006026"/>&nbsp;</span>
									<input type="checkbox" data-bind="checked:elecInvInd" style="margin-top: 3px;float:left"/>
									
								</td>
							</tr>
							
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>