<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
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
		if('${msg}'=='noDataFound'){
			top.jAlert('warning','<auchan:i18n id="100001019"/>','<auchan:i18n id="100000001"/>');
		}
		
		//新增按钮
		<auchan:operauth ifAnyGrantedCode="111311996">
			$('#Tools11').removeClass('Tools11_disable').addClass('Tools11').unbind('click').bind('click', function() {
				$.post(ctx + '/supplierAudit/createSupplier',{'action':'create'},function(data){
					$("#content").html(data);
				},'html');
				
			});
		</auchan:operauth>
		
		//查询按钮 
		$('#Tools6').toggleClass('Tools6_disable').toggleClass('Tools6').bind('click',function() {
			search();
		});
		
		//返回列表
		$('#Tools21').toggleClass('Tools21_disable').toggleClass('Tools21').bind('click',function() {
			$.post(ctx + '/supplier/supplierList',getParam(),function(data){
				$("#content").html(data);
			},'html');
		});
	});

	function search(){
		var param = {
			'supNo' : $('#supNo').val(),
			'status': $('#status').val(),
			'comNo' : $('#comNo').val(),
			'comName' : $('#comName').val(),
			'supType' :$('#supType').val(),
			'dlvryMethd' : $('#dlvryMethd').val(),
			'buyMethd' : $('#buyMethd').val(),
			'cntrtType' : $('#cntrtType').val()
		};
		$.post(ctx + '/supplier/doGeneralSearch',param,function(data){
			$("#content").html(data);
		},'html');
	}
	
	function selectCompany() {
		openPopupWin(650, 505,'/commons/window/chooseSupCom');
	}
	
	function confirmChooseSupCom(comNo, comName, grpNo, grpName) {
		if(comNo == "" && comNo != null){
			return;
		}
		//根据comNo查询其注册地址填充到厂商联系方式中
		$.post("${ctx}/supplier/company/getSupCompanyInfo",{comNo:comNo}, function(data){
			
			if(data.supCompany.comNo){
				
				$('#comNo').attr("value",comNo);
				$('#comName').attr("value",data.supCompany.comName);
				$('#unifmNo').attr("value",data.supCompany.unifmNo);
			}else{
				top.jAlert('warning',comNo+'公司不存在，请确认后重新输入','提示消息');
				$('#comNo').attr("value",'');
			}
		});
	}

	$("#comNo").keydown(function(e){ 
		if(e.keyCode == 13){ 
			confirmChooseSupCom(this.value);
			search();
        	return false;
		} 
	});

	$("#supNo").keydown(function(e){ 
		if(e.keyCode == 13){ 
			search();
        	return false;
		} 
	});
	
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
			<div style="float: left;" class="w25">
				<div style="width: 30px; height: 20px; float: left; line-height: 20px;"><!-- 店号 --><auchan:i18n id="102006002"/></div>
				<select class="w65" name="storeNo">
					<c:forEach items="${storeList}" var="store">
						<option value="${store.storeNo}">${store.storeNo}-${store.storeName}</option>
					</c:forEach>
				</select>
			</div>
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
								<input type="text" class="inputText twoInput1" id="supNo" maxlength="8" onkeyup="value=this.value.replace(/\D+/g,'')"/>
								<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 厂商状态 --><auchan:i18n id="102006004"/></span>
								<auchan:select id="status" mdgroup="SUPPLIER_STATUS" _class="select1" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 公司 --><auchan:i18n id="102006005"/></span>
							</td>
							<td>
								<div class="iconPut" style="width: 26%; float: left;">
									<input type="text" style="width: 80%" id="comNo" onchange="confirmChooseSupCom(this.value)"/>
									<div class="ListWin" onclick="selectCompany()"></div>
								</div>
								<span style="float: left;">&nbsp;&nbsp;<!-- 税号 --><auchan:i18n id="102006075"/></span>
								<input type="text" class="inputText Black" id="unifmNo" readonly="readonly" style="width:180px;" />
								
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 厂商名称 --><auchan:i18n id="102006006"/></span>
							</td>
							<td>
								<input type="text" class="inputText twoInput2 Black" id="comName" readonly="readonly" style="width:90%"/>
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 厂商种类 --><auchan:i18n id="102006007"/></span>
							</td>
							<td>
								<auchan:select id="supType" mdgroup="SUPPLIER_SUP_TYPE" _class="select1" style="float: left;width:35%" ignoreValue="11,12" />
								<span style="float: left;margin-left:2px;">&nbsp;&nbsp;&nbsp;&nbsp;<!--供货方式 --><auchan:i18n id="102006008"/></span>
								<auchan:select id="dlvryMethd" mdgroup="SUPPLIER_DLVRY_METHD" _class="select2" style="float:left;margin-left:3px;width:40%"/>
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 采购方式 --><auchan:i18n id="102006009"/></span>
							</td>
							<td>
								<auchan:select mdgroup="SUPPLIER_BUY_METHD" _class="select2" id="buyMethd" style="float: left;width: 120px;" />
								<span style="float: left;margin-left:10px">&nbsp;&nbsp;&nbsp;&nbsp;<!-- TXT 厂编 --><auchan:i18n id="102006010"/></span>
								<input type="text" class="inputText twoInput2 Black" data-bind="value:txtSup" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 合同标准 --><auchan:i18n id="102006011"/></span>
							</td>
							<td>
								<auchan:select name="selectName" mdgroup="SUPPLIER_CONTRT_TYPE" _class="select2" id="cntrtType" style="float:left" />
								<span style="float: left;margin-left:63px">&nbsp;&nbsp;&nbsp;&nbsp;<!-- 失效日期 --><auchan:i18n id="102006012"/></span>
								<input type="text" class="inputText twoInput2 Black" id="validEndDate" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 合约课别 --><auchan:i18n id="102006013"/></span>
							</td>
							<td>
								<input type="text" class="inputText Black" style="width: 78%" readonly="readonly" />
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
										<input type="text" style="width: 72%;" readonly="readonly" class="Black" />
										<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
									</div>
									<div class="iconPut"
										style="width: 30%; float: left; margin-left: 3px;">
										<input type="text" style="width: 80%;" readonly="readonly" class="Black"/>
										<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
									</div>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>
									<input type="text" class="inputText w91 Black" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 邮政 --><auchan:i18n id="102006015"/></span>
								</td>
								<td>
									<input type="text" class="inputText twoinput25 Black" readonly="readonly" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
									<input type="text" class="inputText twoinput25 Black" readonly="readonly" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
									<input type="text" class="inputText twoinput22 Black" readonly="readonly" />
									<span style="float: left; margin: 0;">-</span>
									<input type="text" class="inputText twoinput26 Black" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
								</td>
								<td>
									<input type="text" class="inputText twoinput22 Black" readonly="readonly" />
									<span style="float: left; margin: 0;">-</span>
									<input type="text" class="inputText twoinput26 Black" readonly="readonly" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/>&nbsp;</span>
									<input type="text" class="inputText twoinput27 Black" readonly="readonly" style="width:22%" />
									<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/>&nbsp;</span>
									<input type="text" class="inputText twoinput27 Black" readonly="readonly" style="width:22%" />
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="CM" style="height: 80px; margin-top: 2px;">
					<div class="CM-bar"  style="height: 80px">
						<div><!-- 额外信息 --><auchan:i18n id="102006064"/></div>
					</div>
					<div class="CM-div">
						<table class="CM_table">
							<tr>
								<td class="w20">
									<span><!-- 订单发送方式 --><auchan:i18n id="102006021"/></span>
								</td>
								<td>
									<auchan:select name="selectName" mdgroup="SUPPLIER_ORDR_ACCPT_METHD" _class="select1 Black"  disabled="disabled"
										style="float:left" />
									<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 首订单量 --><auchan:i18n id="102006022"/></span>
									<input type="text" class="inputText twoInput2 Black" readonly="readonly" />
									<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 订单折让 --><auchan:i18n id="102006023"/></span>
									<input type="checkbox" style="margin-top:6px;" data-bind="checked:ordDiscIde" disabled="disabled"/>
								</td>
							</tr>
							<tr>
								<td>
									<span><!-- 网上对账级别 --><auchan:i18n id="102006024"/></span>
								</td>
								<td>
									<auchan:select name="selectName" mdgroup="SUPPLIER_SCM_LEVEL" _class="select1 Black" disabled="disabled" style="float:left" />
									<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 总应付余额 --><auchan:i18n id="102006025"/></span>
									<input type="text" class="inputText twoInput2 Black" readonly="readonly"  style="width:75px"/>
									<span style="float: left;">&nbsp;&nbsp;<!-- 元 --><auchan:i18n id="102006032"/></span>
									<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 电子发票 --><auchan:i18n id="102006026"/></span>
									<input type="checkbox" style="margin-top:6px;" data-bind="checked:elecInvInd" disabled="disabled"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
