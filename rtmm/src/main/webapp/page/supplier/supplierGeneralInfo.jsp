<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/supplier/supplierCommon.js" charset="gbk" type="text/javascript"></script>
<script src="${ctx}/shared/js/supplier/supplierGeneralInfo.js" charset="gbk" type="text/javascript"></script>
<style type="text/css">
.t_div2,.t_div3,.t_div4 {
	background: #eeeeee;
}

.t_div1 {
	height: 240px;
}

.t_div2 {
	height: 50px;
	margin-top: 2px;
}

.t_div3 {
	height: 185px;
	margin-top: 2px;
}

.t_div4 {
	height: 58px;
	margin-top: 2px;
}

.t_div1_1,.t_div1_2,.t_div3_1,.t_div3_2 {
	width: 50%;
	height: 100%;
	float: left;
}

.cmt1 {
	width: 80px;
	height: 20px;
	float: left;
	text-align: center;
	cursor: pointer;
	margin-left: 10px;
	line-height: 20px;
}

.cmt2 {
	width: 16px;
	height: 16px;
	float: right;
	margin-top: 4px;
	margin-right: 8px;
	cursor: pointer;
}

.cmt3 {
	width: 140px;
	height: 30px;
	float: right;
}

.cmt32 {
	width: 100px;
	float: left;
	line-height: 25px;
	margin: 0;
}

.td2_1 {
	width: 150px;
	height: 20px;
	float: left;
	margin-left: 40px;
	text-align: center;
	line-height: 18px;
	margin-top: 17px;
	cursor: pointer;
}

.td2_2 {
	width: 150px;
	height: 20px;
	float: left;
	text-align: center;
	line-height: 18px;
	margin-top: 17px;
	margin-left: 5px;
	cursor: pointer;
}

.td2_3 {
	width: 85px;
	height: 20px;
	float: left;
	text-align: center;
	line-height: 18px;
	margin-top: 17px;
	margin-left: 5px;
	cursor: pointer;
}

.td2_4 {
	width: 16px;
	height: 21px;
	float: right;
	margin-top: 15px;
	margin-right: 15px;
	cursor: pointer;
}

.td2_5 {
	width: 16px;
	height: 21px;
	float: right;
	margin-top: 15px;
}
/*.td2_6 {
            height:30px;width:80px;float:right;border:1px solid #666666;background-color:#fff;margin-top:15px;
            margin-right:10px;cursor:pointer;text-align:center;line-height:28px;
        }*/
.t_div4 input,.t_div4 span {
	margin-top: 15px;
}

.schedule {
	height: 80px;
}

.schedule div {
	height: 25px;
}

.schedule .icondiv2 {
	margin: 6px auto auto 2px;
	cursor: pointer;
}

.week {
	width: 51%;
	float: left;
}

.week div {
	height: 15px;
	width: 15px;
	float: left;
	margin: 5px auto auto 2px;
	cursor: pointer;
}

.week20 div {
	border: 1px solid #F9F9F9;
}

.week21 div {
	border: #999999 solid 1px;
}

.wtitle {
	width: 35%;
	float: left;
}

.icondiv11 {
	width: 20%;
	float: left;
	color: #999999;
}

.icondiv11 input {
	width: 72%;
}

.icondiv12 {
	width: 28%;
	float: left;
	margin-left: 3px;
	color: #999999;
}

.icondiv12 input {
	width: 82%;
		background: #fff;
}

.tb_line {
	border-bottom: 1px solid #999999;
}
/*input对齐*/
.w91_s232 {
	/* width: 91%;
	width /*\**/: 92% \9;
	*width: 92%; */
		background: #fff;
}

.twoinput22 {
	/* width: 10%;
	float: left; */
		background: #fff;
}

.twoinput23 {
	/* width: 26.5%;
	float: left; */
	background: #fff;
}

.twoinput25 {
	/* width: 14.5%;
	float: left; */
	background: #fff;
}

.twoinput26 {
	/* width: 16%;
	float: left; */
		background: #fff;
}

.twoinput27 {
	/* width: 25%;
	float: left; */
		background: #fff;
}

.twoinput28 {
	/* width: 21%;
	width /*\**/: 21.5% \9;
	*width: 21.5%;
	float: left; */
		background: #fff;
}

.cmt1:hover {
	background: #99cc66;
	color: #fff;
}
</style>
<script type="text/javascript">
    $('.tagsM').die('click');
	$(function() {
		//新增按钮
		<auchan:operauth ifAnyGrantedCode="111311996">
			$('#Tools11').removeClass('Tools11_disable').addClass('Tools11').bind('click', function() {
				$.post(ctx + '/supplierAudit/createSupplier',{'action':'create'},function(data){
					$("#content").html(data);
				},'html');
			});
		</auchan:operauth>
		
		//重置按钮
		$('#Tools20').removeClass('Tools20_disable').addClass('Tools20').unbind('click').bind('click', function() {
			$.post(ctx + '/supplier/generalSearch',function(data){
				$("#content").html(data);
			},'html');
		});
		
		//修改按钮
		<auchan:operauth ifAnyGrantedCode="111311996">
			var tool12 = $('#Tools12');
			$(tool12).toggleClass('Tools12_disable').toggleClass('Tools12');
			$(tool12).unbind('click').bind('click',function() {
				$.ajax({
					type : "post",
					async : false,
					url : ctx + "/supplierAudit/checkSupplierModifiable",
					dataType : "json",
					data : {
						'supNo' : '${supNo}'
					},
					success : function(data) {
						if (data.status!='success') {
							top.jWarningAlert(data.message);
						} else {
							$.post(ctx + '/supplierAudit/updateSupplierBySupNo?supNo=${supNo}&action=update',function(data){
								$("#content").html(data);
							},'html');
						}
					}
				});
			});
		</auchan:operauth>
		
		//上一页
		if('${page}'!='1' && '${page}'!=''){
			$("#Tools17").toggleClass('Tools17_disable').toggleClass('Tools17').unbind('click').bind('click',function() {
				var page = parseInt('${page}')-1;
				$.post(ctx + '/supplier/changeGeneralSearchPage',{'page':page},function(data){
					$("#content").html(data);
				},'html');
			});
		}

		//下一页
		if('${page}'!='${total}'){
			$("#Tools19").toggleClass('Tools19_disable').toggleClass('Tools19').unbind('click').bind('click',function() {
				var page = parseInt('${page}')+1;
				$.post(ctx + '/supplier/changeGeneralSearchPage',{'page':page},function(data){
					$("#content").html(data);
				},'html');
			});
		}
		//最后一页
		if('${page}'!='${total}' && eval('${total}') > eval('${page}')){
			$("#Tools18").toggleClass('Tools18_disable').toggleClass('Tools18').unbind('click').bind('click',function() {
				$.post(ctx + '/supplier/changeGeneralSearchPage',{'page':'${total}'},function(data){
					$("#content").html(data);
				},'html');
			});
		}

		//第一页
		if('${page}'!='1' && '${page}'!=''){
			$("#Tools16").toggleClass('Tools16_disable').toggleClass('Tools16').unbind('click').bind('click',function() {
				$.post(ctx + '/supplier/changeGeneralSearchPage',{'page':1},function(data){
					$("#content").html(data);
				},'html');
			});
		}

		//返回列表
		$('#Tools21').toggleClass('Tools21_disable').toggleClass('Tools21').unbind('click').bind('click',function() {
			$.post(ctx + '/supplier/supplierList',function(data){
				$("#content").html(data);
			},'html');
		});
		
		//厂商总览(tab)
		$('#cs_tags1').unbind('click').bind('click', function() {
			if('${supNo}' != ''){
				$.post(ctx + "/supplier/getSupplierGeneralInfo?supNo=${supNo}",function(data){
					$("#content").html(data);
				},'html');
			}
		});
		
		//厂商财务信息(tab)
		if('${supNo}' != ''){
			$('#cs_tags2').unbind('click').bind('click', function() {
				$.post(ctx + "/supplier/getSupPaymentInfo?supNo=${supNo}&comNo=${comNo}",function(data){
					$("#content").html(data);
				},'html');
			});
		}
		
		//厂商供应区域(tab)
		if('${supNo}' != ''){
			$('#cs_tags3').unbind('click').bind('click', function() {
				$.post(ctx + "/supplier/getSupplierAreaInfo?supNo=${supNo}&comNo=${comNo}",function(data){
					$("#content").html(data);
				},'html');
			});
		}
		
	});
	
	var addressInfo = new supplierCommon.AddressInfo(
			'${supplier.addressVO.addrId}', '${supplier.addressVO.provName}',
			'${supplier.addressVO.cityName}',
			'${supplier.addressVO.detllAddr}',
			'${supplier.addressVO.postCode}', '${supplier.addressVO.areaCode}',
			'${supplier.addressVO.cntctName}', '${supplier.addressVO.phoneNo}',
			'', '${supplier.addressVO.faxNo}', '${supplier.addressVO.moblNo}',
			'${supplier.addressVO.emailAddr}', true,false);

	var viewModel = new supplierGeneralInfo.ViewModel(
			'${supplier.supNo}',
			'${supplier.status}',
			'${supplier.supComVO.comNo}',
			'${supplier.supComVO.comName}',
			'${supplier.supComVO.comGrpVO.comgrpNo}',
			'${supplier.supComVO.comGrpVO.comgrpName}',
			'${supplier.supComVO.unifmNo}',
			'${supplier.supType}',
			'${supplier.dlvryMethd}',
			'${supplier.buyMethd}',
			'${supplier.txtSup}',
			'${supplier.cntrtType}',
			"<fmt:formatDate value='${supplier.validEndDate}' pattern='yyyy-MM-dd'/>",
			'${supplier.ordAccptMethd}', '${supplier.firstOrdQty}',
			'${supplier.scmLvl}','${supplier.ordDiscInd}','${totApAmt}','${supplier.elecInvInd}',addressInfo);
	ko.applyBindings(viewModel);
	//默认加载所有处课信息
	viewModel.storeChange();    
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">

	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div id="cs_tags1" class="tagsM tagsM_on"><!-- 厂商总览 --><auchan:i18n id="102006001"/></div>
	<div class="tags tags_left_on"></div>

	<!--中间-->
	<div id="cs_tags2" class="tagsM"><!-- 厂商财务信息 --><auchan:i18n id="102007001"/></div>
	<div class="tags"></div>

	<!--最后一个-->
	<div id="cs_tags3" class="tagsM"><!-- 厂商供应区域 --><auchan:i18n id="102008001"/></div>
	<div class="tags tags3_r_off"></div>
</div>
<div class="Container-1">
	<div class="Content" style="width: 99%;">
		<!--width:74%;-->
		<div class="CInfo">
			<div style="float: left;" class="w25" >
				<div style="width: 30px; height: 20px; float: left; line-height: 20px;"><!-- 店号 --><auchan:i18n id="102006002"/></div>
				<select class="w65" name="storeChangeSelect" data-bind="value:storeNo,event:{change:storeChange}">
					<c:forEach items="${storeList}" var="store">
						<option value="${store.storeNo}">${store.storeNo}-${store.storeName}</option>
					</c:forEach>
				</select>
			</div>
			<c:if test="${total>0}">
				 <span><!-- 项 --><auchan:i18n id="100000012"/></span>
	             <span>${total}</span>
	             <span>/</span>
	             <span>${page}</span>
	             <span><!-- 第 --><auchan:i18n id="100000013"/></span>
             </c:if>
             <span>|</span>
             <span>${supplier.chngBy}</span>
             <span><!-- 修改人 --><auchan:i18n id="102009008"/></span>
             <span><fmt:formatDate value='${supplier.chngDate}' pattern='yyyy-MM-dd'/></span>
             <span><!-- 修改日期 --><auchan:i18n id="102009007"/></span>
             <span>${supplier.creatBy}</span>
             <span><!-- 建档人 --><auchan:i18n id="102009006"/></span>
             <span><fmt:formatDate value='${supplier.creatDate}' pattern='yyyy-MM-dd'/></span>
             <span><!-- 创建日期 --><auchan:i18n id="102009005"/></span> 
		</div>
		<div class="line" style="width: 100%"></div>
		<!--539-->
		<div class="t_div1">
			<div class="CM t_div1_1">
				<div class="CM-bar" style="height: 240px">
					<div><!-- 基本信息 --><auchan:i18n id="102006063"/></div>
				</div>
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td style="width: 25%;">
								<span><!-- 采购厂编 --><auchan:i18n id="102006003"/></span>
							</td>
							<td>
								<input type="text" class="inputText twoInput1" data-bind="value:supNo" readonly="readonly"/>
								<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 厂商状态 --><auchan:i18n id="102006004"/></span>
								<auchan:select  mdgroup="SUPPLIER_STATUS" _class="select1 Black" dataBind="value:status" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 公司 --><auchan:i18n id="102006005"/></span>
							</td>
							<td>
								<input type="text" class="inputText twoInput1" data-bind="value:comNo" readonly="readonly"/>
								<span style="float: left;">&nbsp;&nbsp;<!-- 税号 --><auchan:i18n id="102006075"/></span>
								<input type="text" class="inputText" data-bind="value:unifmNo" readonly="readonly" style="width:180px;" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 厂商名称 --><auchan:i18n id="102006006"/></span>
							</td>
							<td>
								
								<input type="text" class="inputText twoInput2" data-bind="value:comName" readonly="readonly" style="width:90%"/>
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 厂商种类 --><auchan:i18n id="102006007"/></span>
							</td>
							<td>
								<auchan:select  mdgroup="SUPPLIER_SUP_TYPE" _class="select1 Black" dataBind="value:supType" style="float: left;width:35%" />
								<span style="float: left;margin-left:2px;">&nbsp;&nbsp;&nbsp;&nbsp;<!-- 供货方式 --><auchan:i18n id="102006008"/></span>
								<auchan:select  mdgroup="SUPPLIER_DLVRY_METHD" _class="select2 Black" dataBind="value:dlvryMethd" style="float:left;margin-left:3px;width:40%" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 采购方式 --><auchan:i18n id="102006009"/></span>
							</td>
							<td>
								<!-- <select disabled="disabled" style="width:60%"
									data-bind="value:buyMethd,options:buyMethdList,optionsText: function(item) { return item.optionsValue},optionsValue: function(item) { return item.optionsText}">
								</select> -->
								<auchan:select mdgroup="SUPPLIER_BUY_METHD" _class="select2 Black" dataBind="value:buyMethd" style="float: left;width: 120px;" />
								<span style="float: left;margin-left:10px">&nbsp;&nbsp;&nbsp;&nbsp;<!-- TXT 厂编 --><auchan:i18n id="102006010"/></span>
								<input type="text" class="inputText twoInput2" data-bind="value:txtSup" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 合同标准 --><auchan:i18n id="102006011"/></span>
							</td>
							<td>
								<auchan:select  mdgroup="SUPPLIER_CONTRT_TYPE" _class="select2 Black" dataBind="value:cntrtType" style="float:left" />
								<span style="float: left;margin-left:63px">&nbsp;&nbsp;&nbsp;&nbsp;<!-- 失效日期 --><auchan:i18n id="102006012"/></span>
								<input type="text" class="inputText twoInput2" data-bind="value:validEndDate" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 合约课别 --><auchan:i18n id="102006013"/></span>
							</td>
							<td>
								<input type="text" class="inputText" style="width: 78%" readonly="readonly" value="${catalogNameStr}" />
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="t_div1_2">
				<div class="CM" style="height: 158px;">
					<div class="CM-bar">
						<div><!-- 联系方式 --><auchan:i18n id="102006065"/></div>
					</div>
					<div class="CM-div">
						<table class="CM_table">
							<tr>
								<td style="width: 20%;">
									<span><!-- 地址 --><auchan:i18n id="102006014"/></span>
								</td>
								<td>	
									<div class="iconPut" style="width: 20%; float: left;">
										<input type="text" style="width: 72%;"
											data-bind="value:addressInfo().provName" readonly="readonly" />
										<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
									</div>
									<div class="iconPut"
										style="width: 30%; float: left; margin-left: 3px;">
										<input type="text" style="width: 80%;"
											data-bind="value:addressInfo().cityName" readonly="readonly"/>
										<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
									</div>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>
									<input type="text" class="inputText w91" data-bind="value:addressInfo().detailAddr" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 邮政 --><auchan:i18n id="102006015"/></span>
								</td>
								<td>
									<input type="text" class="inputText twoinput25" readonly="readonly" data-bind="value:addressInfo().postCode" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
									<input type="text" class="inputText twoinput25" readonly="readonly" data-bind="value:addressInfo().cntctName" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
									<input type="text" class="inputText twoinput22" readonly="readonly" data-bind="value:addressInfo().areaCode" />
									<span style="float: left; margin: 0;">-</span>
									<input type="text" class="inputText twoinput26" readonly="readonly" data-bind="value:addressInfo().faxNo" />
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
								</td>
								<td>
									<input type="text" class="inputText twoinput22" readonly="readonly" data-bind="value:addressInfo().areaCode" />
									<span style="float: left; margin: 0;">-</span>
									<input type="text" class="inputText twoinput26" readonly="readonly" data-bind="value:addressInfo().phoneNo" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/>&nbsp;</span>
									<input type="text" class="inputText twoinput27" readonly="readonly" data-bind="value:addressInfo().moblNo" style="width:22%"/>
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/>&nbsp;</span>
									<input type="text" class="inputText twoinput27" readonly="readonly" data-bind="value:addressInfo().emailAddr" style="width:22%" />
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="CM" style="height: 80px; margin-top: 2px;">
					<div class="CM-bar" style="height: 80px">
						<div><!-- 额外信息 --><auchan:i18n id="102006064"/></div>
					</div>
					<div class="CM-div">
						<table class="CM_table">
							<tr>
								<td class="w20">
									<span><!-- 订单发送方式 --><auchan:i18n id="102006021"/></span>
								</td>
								<td>
									<auchan:select  mdgroup="SUPPLIER_ORDR_ACCPT_METHD" _class="select1 Black" dataBind="value:ordAccptMethd" 
										style="float:left;width:79px;"/>
									<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 首订单量 --><auchan:i18n id="102006022"/></span>
									<input style="float: left;" type="text" class="inputText twoInput2" data-bind="value:firstOrdQty" readonly="readonly" style="width:50px" />
									<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 订单折让 --><auchan:i18n id="102006023"/></span>
									<input type="checkbox" style="margin-top:6px;" data-bind="checked:ordDiscIde" disabled="disabled"/>
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 网上对账级别 --><auchan:i18n id="102006024"/></span>
								</td>
								<td>
									<auchan:select  mdgroup="SUPPLIER_SCM_LEVEL" _class="select1 Black" dataBind="value:scmLvl"  style="float:left"/>
									<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 总应付余额 --><auchan:i18n id="102006025"/></span>
									<input type="text" class="inputText twoInput2" data-bind="value:totApAmt" readonly="readonly" style="width:75px"/>
									<span style="float: left;">&nbsp;&nbsp;元</span>
									<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 电子发票 --><auchan:i18n id="102006026"/></span>
									<input type="checkbox" style="margin-top:6px;" data-bind="checked:elecInvInd" disabled="disabled"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="t_div2 CM">
			<div data-bind="foreach: storeSecInfoList">
				<div class="td2_1" data-bind="event:{click:clicCatlgName},css:visible()==true?'GreenBg':''">
					<input type="hidden" data-bind="value:catlgId">
					<span data-bind="text:catlgId"></span>
					-
					<span data-bind="text:catlgName"></span>
				</div>
			</div>
			<auchan:operauth ifAnyGrantedCode="111311996">
				<c:if test="${supNo!=null && supNo != ''}">
					<div class="Tools11 td2_4" title="新增课别" data-bind="event:{click:$root.addStoreSecInfo}"></div>
					<div class="Line-1 td2_5"></div>
				</c:if>
			</auchan:operauth>
		</div>
		<div data-bind="foreach: storeSecInfoList">
			<div class="t_div3" data-bind="visible:visible">
				<div class="CM t_div3_1">
					<div class="CM-bar">
						<div><!-- 订单信息 --><auchan:i18n id="102006066"/></div>
					</div>
					<div class="CM-div">
						<table class="CM_table">
							<tr>
								<td>
									<span><!-- 采购范围 --><auchan:i18n id="102006027"/></span>
								</td>
								<td colspan="2">
									<input type="text" class="inputText twoInput1" data-bind="value:ordScope" readonly="readonly" />
									<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 备注 --><auchan:i18n id="102006028"/></span>
									<input type="text" class="inputText twoInput2" data-bind="value:buyrMemo" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 门店课别状态 --><auchan:i18n id="102006029"/></span>
								</td>
								<td colspan="2">
									<auchan:select  mdgroup="SUP_STORE_SEC_INFO_STATUS" _class="select1 Black" dataBind="value:cataStatus"  style="float:left;width: 100px;"/>
									<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 新店折扣 --><auchan:i18n id="102006030"/></span>
									<input type="text" class="inputText twoInput1" data-bind="value:newStDiscDays" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<td class="w25">
									<span><!-- 最低订购(MOC) --><auchan:i18n id="102006031"/></span>
								</td>
								<td class="w15">
									<input type="text" class="inputText w70" data-bind="value:minOrdAmt" readonly="readonly"/>&nbsp;<!-- 元 --><auchan:i18n id="102006032"/>
								</td>
								<td class="w50" rowspan="3">
									<div class="schedule">
										<div style="height: 25px;">
											<div class="wtitle">&nbsp;</div>
											<div class="week week20">
												<div>一</div>
												<div>二</div>
												<div>三</div>
												<div>四</div>
												<div>五</div>
												<div>六</div>
												<div>日</div>
											</div>
										</div>
										<div style="height: 1px; background: #999999; overflow: hidden; width: 85%;"></div>
										<div style="height: 25px;">
											<div class="wtitle">
												<span><!-- OPL订货行程 --><auchan:i18n id="102006034"/></span>
											</div>
											<input type="hidden" data-bind="value:oplSched">
											<div class="week week21">
												<div data-bind="css:oplSched().mon()=='1'?'weekon':''"></div>
												<div data-bind="css:oplSched().tue()=='1'?'weekon':''"></div>
												<div data-bind="css:oplSched().wed()=='1'?'weekon':''"></div>
												<div data-bind="css:oplSched().thu()=='1'?'weekon':''"></div>
												<div data-bind="css:oplSched().fri()=='1'?'weekon':''"></div>
												<div data-bind="css:oplSched().sat()=='1'?'weekon':''"></div>
												<div data-bind="css:oplSched().sun()=='1'?'weekon':''"></div>
											</div>
										</div>
										<div style="height: 25px;">
											<div class="wtitle">
												<span><!-- 送货行程 --><auchan:i18n id="102006036"/></span>
											</div>
											<input type="hidden" data-bind="value:dlvrySched">
											<div class="week week21">
												<div data-bind="css:dlvrySched().mon()=='1'?'weekon':''"></div>
												<div data-bind="css:dlvrySched().tue()=='1'?'weekon':''"></div>
												<div data-bind="css:dlvrySched().wed()=='1'?'weekon':''"></div>
												<div data-bind="css:dlvrySched().thu()=='1'?'weekon':''"></div>
												<div data-bind="css:dlvrySched().fri()=='1'?'weekon':''"></div>
												<div data-bind="css:dlvrySched().sat()=='1'?'weekon':''"></div>
												<div data-bind="css:dlvrySched().sun()=='1'?'weekon':''"></div>
											</div>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 可否退货 --><auchan:i18n id="102006033"/></span>
								</td>
								<td>
									<auchan:select  mdgroup="SUP_STORE_SEC_INFO_RTN_ALLOW" _class="select1 Black" dataBind="value:rtnAllow"  style="width: 100px;"/>
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 准备天数 --><auchan:i18n id="102006035"/></span>
								</td>
								<td>
									<input type="text" class="inputText w70" data-bind="value:leadTime" readonly="readonly" />&nbsp;天
								</td>
							</tr>
							
						</table>
					</div>
				</div>
				<div class="CM t_div3_2">
					<div class="CM-bar">
						<div><!-- 订货退货地址 --><auchan:i18n id="102006068"/></div>
					</div>
					<div class="CM-div">
						<table class="CM_table">
							<tr class="tb_line">
								<td colspan="2" style="line-height: 18px;">
									<div class="cmt1 GreenBg" data-bind="event:{click:clickAddress},css:showAddressIndex()=='0'?'GreenBg':''" >
										<input type="hidden" value="0"><!-- 订货地址 --><auchan:i18n id="102006054"/>
									</div>
									<div class="cmt1" data-bind="event:{click:clickAddress},css:showAddressIndex()=='1'?'GreenBg':''" >
										<input type="hidden" value="1"><!-- 退货地址 --><auchan:i18n id="102006055"/>
									</div>
								</td>
							</tr>
							<!-- 订货地址 -->
							<tr data-bind="visible:supOrdAddr().visible">
								<td style="width: 20%;">
									<span><!-- 地址 --><auchan:i18n id="102006014"/></span>
								</td>
								<td>
									<div class="iconPut" style="width: 20%; float: left;">
										<input type="text" style="width: 72%;"
											data-bind="value:supOrdAddr().provName" readonly="readonly" />
										<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
									</div>
									<div class="iconPut"
										style="width: 30%; float: left; margin-left: 3px;">
										<input type="text" style="width: 62%;"
											data-bind="value:supOrdAddr().cityName" readonly="readonly"/>
										<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
									</div>
								</td>
							</tr>
							<tr data-bind="visible:supOrdAddr().visible">
								<td>&nbsp;</td>
								<td>
									<input type="text" class="inputText w91" data-bind="value:supOrdAddr().detailAddr" readonly="readonly" />
								</td>
							</tr>
							<tr data-bind="visible:supOrdAddr().visible">
								<td>
									<span><!-- 邮政 --><auchan:i18n id="102006015"/></span>
								</td>
								<td>
									<input type="text" class="inputText twoinput25" data-bind="value:supOrdAddr().postCode" readonly="readonly" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
									<input type="text" class="inputText twoinput25" data-bind="value:supOrdAddr().cntctName" readonly="readonly" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
									<input type="text" class="inputText twoinput22" data-bind="value:supOrdAddr().faxAreaCode" readonly="readonly" />
									<span style="float: left; margin: 0;">-</span>
									<input type="text" class="inputText twoinput26" data-bind="value:supOrdAddr().faxNo" readonly="readonly" />
								</td>
							</tr>
							<tr data-bind="visible:supOrdAddr().visible">
								<td>
									<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
								</td>
								<td>
									<input type="text" class="inputText twoinput22" data-bind="value:supOrdAddr().areaCode" readonly="readonly" />
									<span style="float: left; margin: 0;">-</span>
									<input type="text" class="inputText twoinput26" data-bind="value:supOrdAddr().phoneNo" readonly="readonly" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/>&nbsp;</span>
									<input type="text" class="inputText twoinput27" data-bind="value:supOrdAddr().moblNo" readonly="readonly" style="width:22%"/>
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/>&nbsp;</span>
									<input type="text" class="inputText twoinput27" data-bind="value:supOrdAddr().emailAddr" readonly="readonly" style="width:22%" />
								</td>
							</tr>
							<!-- 退货地址 -->
							<tr data-bind="visible:supRtnAddr().visible">
								<td style="width: 20%;">
									<span><!-- 地址 --><auchan:i18n id="102006014"/></span>
								</td>
								<td>
									<div class="iconPut" style="width: 20%; float: left;">
										<input type="text" style="width: 72%;"
											data-bind="value:supRtnAddr().provName" readonly="readonly" />
										<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
									</div>
									<div class="iconPut"
										style="width: 30%; float: left; margin-left: 3px;">
										<input type="text" style="width: 62%;"
											data-bind="value:supRtnAddr().cityName" readonly="readonly"/>
										<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
									</div>
								</td>
							</tr>
							<tr data-bind="visible:supRtnAddr().visible">
								<td>&nbsp;</td>
								<td>
									<input type="text" class="inputText w91" data-bind="value:supRtnAddr().detailAddr" readonly="readonly" />
								</td>
							</tr>
							<tr data-bind="visible:supRtnAddr().visible">
								<td>
									<span><!-- 邮政 --><auchan:i18n id="102006015"/></span>
								</td>
								<td>
									<input type="text" class="inputText twoinput25" data-bind="value:supRtnAddr().postCode" readonly="readonly" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
									<input type="text" class="inputText twoinput25" data-bind="value:supRtnAddr().cntctName" readonly="readonly" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
									<input type="text" class="inputText twoinput22" data-bind="value:supRtnAddr().faxAreaCode" readonly="readonly" />
									<span style="float: left; margin: 0;">-</span>
									<input type="text" class="inputText twoinput26" data-bind="value:supRtnAddr().faxNo" readonly="readonly" />
								</td>
							</tr>
							<tr data-bind="visible:supRtnAddr().visible">
								<td>
									<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
								</td>
								<td>
									<input type="text" class="inputText twoinput22" data-bind="value:supRtnAddr().areaCode" readonly="readonly" />
									<span style="float: left; margin: 0;">-</span>
									<input type="text" class="inputText twoinput26" data-bind="value:supRtnAddr().phoneNo" readonly="readonly" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/>&nbsp;</span>
									<input type="text" class="inputText twoinput27" data-bind="value:supRtnAddr().moblNo" readonly="readonly" style="width:22%"/>
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/>&nbsp;</span>
									<input type="text" class="inputText twoinput27" data-bind="value:supRtnAddr().emailAddr" readonly="readonly" style="width:22%" />
								</td>
							</tr>
							
						</table>
					</div>
				</div>
			</div>
			<div class="CM t_div4" data-bind="visible:visible">
				<div class="CM-bar">
					<div><!-- 折扣 --><auchan:i18n id="102006067"/></div>
				</div>
				<span style="margin-left: 20px;"><!-- 应付余额 --><auchan:i18n id="102006037"/>&nbsp;&nbsp;</span>
				<input type="text" class="inputText w7" data-bind="value:apAmt" readonly="readonly" />
				<span><!-- 元 --><auchan:i18n id="102006032"/></span>
				<span>&nbsp;&nbsp;<!-- 付款状态 --><auchan:i18n id="102006038"/>&nbsp;&nbsp;</span>
				<auchan:select  mdgroup="SUP_STORE_SEC_INFO_PAY_STTUS" _class="select1 Black" dataBind="value:paySttus" />
				<span>&nbsp;&nbsp;<!-- 进价折扣 --><auchan:i18n id="102006039"/>&nbsp;&nbsp;</span>
				<input type="text" class="inputText w7" data-bind="value:bpDisc" readonly="readonly" />
				<span> %</span>
				<span>&nbsp;&nbsp;<!-- 发票折扣 --><auchan:i18n id="102006040"/>&nbsp;&nbsp;</span>
				<input type="text" class="inputText w7" data-bind="value:invDisc" readonly="readonly" />
				<span> %</span>
				<span>&nbsp;&nbsp;<!-- 其他折扣 --><auchan:i18n id="102006041"/>&nbsp;&nbsp;</span>
				<input type="text" class="inputText w7" data-bind="value:othDisc" readonly="readonly" />
				<span> %</span>
				<span>&nbsp;&nbsp;<!-- 折扣备注 --><auchan:i18n id="102006042"/>&nbsp;&nbsp;</span>
				<input type="text" class="inputText w10" data-bind="value:discMemo" readonly="readonly" />
			</div>
		</div>
	</div>
</div>