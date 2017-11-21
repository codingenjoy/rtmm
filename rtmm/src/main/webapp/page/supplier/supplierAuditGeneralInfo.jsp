<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/sh_Supplier441.css" />
<style type="text/css">
.t_div1_1,.t_div1_2 {
	width: 50%;
	height: 100%;
	float: left;
}
.div_left,.div_right{
	width: 49%;
	float: left;
	height: 100%
}
</style>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/supplier/supplierCommon.js" charset="gbk" type="text/javascript"></script>
<script src="${ctx}/shared/js/supplier/supplierauditGeneralInfo.js" charset="gbk" type="text/javascript"></script>

<script type="text/javascript">
	var itemsSupPic= new Array();//当前单个证件下所有的证件图片信息
	var itemSupIndex=0;

	$(function() {
		
		var tool25 = $('#Tools25');
		$(tool25).toggleClass('Tools25_disable').toggleClass('Tools25');
		$(tool25).unbind('click').bind('click', function() {
			sep2();
		});

		function sep2(){
			showContent(ctx + '/supplierAudit/getSupplierAuditStoreSecInfo?taskId=${taskId}&comNo=${company.comNo}');
		}

		$('.div_right').unbind('click').bind('click',function(){
			sep2();
		});
	});
	
	// PDF导出
	 $('#Tools3').removeClass('Tools3_disable').addClass('Tools3')
	       .die().unbind().bind('click',function(){
	    	   
		 window.location.href = ctx + "/supplierAudit/downLoadPaymentPdf?taskId=${taskId}";  
	 });
	
	//公司信息
	var company = new supplierauditGeneralInfo.Company('${company.comNo}','${company.comName}',
			'${company.comEnName}','${company.unifmNo}','${company.status}','${company.comGrpVO.comgrpNo}',
			'${company.comGrpVO.comgrpName}','${company.econType}','${company.legalRpstv}','${company.bizScopeDesc}',
			"<fmt:formatDate value='${company.setupDate}' pattern='yyyy-MM-dd'/>", '${company.webSite}');
	//厂商信息
	var supplier = new supplierauditGeneralInfo.Supplier('${supplier.supNo}','${supplier.status}',
			'${supplier.supComVO.comNo}','${supplier.supComVO.comName}','', '',
			'${supplier.supComVO.unifmNo}','${supplier.supType}','${supplier.dlvryMethd}','${supplier.buyMethd}',
			'${supplier.txtSup}','${supplier.cntrtType}','<fmt:formatDate value='${supplier.validEndDate}' pattern='yyyy-MM-dd'/>','${supplier.ordAccptMethd}',
			'${supplier.firstOrdQty}','${supplier.scmLvl}','${supplier.elecInvInd}','${supplier.ordDiscInd}');

	//厂商联系方式
	var address = null;
	if('${supplier.addressVO}' != 'null'){
		address = new supplierCommon.AddressInfo('${supplier.addressVO.addrId}','${supplier.addressVO.provName}' ,
			'${supplier.addressVO.cityName}', '${supplier.addressVO.detllAddr}','${supplier.addressVO.postCode}','${supplier.addressVO.areaCode}',
			'${supplier.addressVO.cntctName}','${supplier.addressVO.phoneNo}', '','${supplier.addressVO.faxNo}','${supplier.addressVO.moblNo}',
			'${supplier.addressVO.emailAddr}');
	}else{
		address = new supplierCommon.AddressInfo();
	}
	supplier.address(address);

	//公司注册地址
	var regAddress = null;
	if('${company.comRegstrAddress}' != 'null'){
		regAddress = new supplierCommon.AddressInfo('', '${company.comRegstrAddress.provName}',
				'${company.comRegstrAddress.cityName}', '${company.comRegstrAddress.detllAddr}', '','${company.comRegstrAddress.areaCode}', '', '', '',
				'','${company.comRegstrAddress.moblNo}', '${company.comRegstrAddress.emailAddr}');
	}else{
		regAddress = new supplierCommon.AddressInfo();
	}
	company.regAddress(regAddress);

	//公司发票送达地址
	var dlvAddress = null;
	if('${company.invDlvryAddress}' != 'null'){
		dlvAddress = new supplierCommon.AddressInfo('','${company.invDlvryAddress.provName}',
				'${company.invDlvryAddress.cityName}','${company.invDlvryAddress.detllAddr}','${company.invDlvryAddress.postCode}','${company.invDlvryAddress.areaCode}',
				'${company.invDlvryAddress.cntctName}','${company.invDlvryAddress.phoneNo}', '','${company.invDlvryAddress.faxNo}','${company.invDlvryAddress.moblNo}',
				'${company.invDlvryAddress.emailAddr}');
	}else{
		dlvAddress = new supplierCommon.AddressInfo();			
	}
	company.dlvAddress(dlvAddress);

	var viewModel = new supplierauditGeneralInfo.ViewModel('${taskId}',company,supplier);
	ko.applyBindings(viewModel);
	//supplierauditGeneralInfo.buildPage();
	
	//图片展示部分
	
	
	//加载浏览图片信息
    function loadReadPicInfo(id){

    	//关闭事件(查看图片窗口)
    	$("#closeLookPic").live("click", function () {
    	    $("#"+id+"_p").css("display", "none");
    	});
    	
   	 $("#"+id+"_prev_brower").live("mouseover", function () {
   		    $(this).addClass("prev_brower_bg");
   		});
   		$("#"+id+"_prev_brower").live("mouseout", function () {
   		    $(this).removeClass("prev_brower_bg");
   		});
   		$("#"+id+"_next_brower").live("mouseover", function () {
   		    $(this).addClass("next_brower_bg");
   		});
   		$("#"+id+"_next_brower").live("mouseout", function () {
   		    $(this).removeClass("next_brower_bg");
   		});

   		$("#"+id+"_next_brower").unbind("click").bind("click", function () {
   			$("#lookComPic_pp3").empty();
   			if(typeof(itemsSupPic[itemSupIndex+1])!='undefined' || itemsSupPic[itemSupIndex+1]!=null){
   				itemSupIndex=itemSupIndex+1;
   				loadItemImgInfos(id,itemsSupPic[itemSupIndex]);
   		    	}else{
                $("#lookComPic_pp3").text("已经到最后一张了");
   	   		    	}
   		});
   		$("#"+id+"_prev_brower").unbind("click").bind("click", function () {
   			$("#lookComPic_pp3").empty();
   			if(typeof(itemsSupPic[itemSupIndex-1])!='undefined' || itemsSupPic[itemSupIndex-1]!=null){
   				itemSupIndex=itemSupIndex-1;
   				loadItemImgInfos(id,itemsSupPic[itemSupIndex]);
   		    	}else{
   		    	 $("#lookComPic_pp3").text("已经到第一张了");
   	   		    	}
   		});
   	 }

  //加载图片到层中
    function loadItemImgInfos(id,key){
    	 $("#"+id+"_pp2").empty();
        $("#"+id+"_pp2").attr("src",key);
        }

    //加载信息
    function readPhotosByLincenceId(lincenceId){
    	$("#lookComPic_pp2").empty();
    	 $("#lookComPic_pp3").empty();
		   var width_window=$(window).width();
		   var height_window=$(document).height();
				itemsSupPic=new Array(); 
				itemSupIndex=0;
		 $.ajax({
				url :'${ctx}/supplierLicenceAction/readComGroupLicenceByLicenceId?tt='
						+ new Date().getTime(),
				data : {licnceId:lincenceId},
				type : 'POST',
				success : function(response) {
					if(response!=""){
				$("#lookComPic_p").css({"display":"block","width":width_window,"height":height_window,"top":0,"left":0});							 
                 //加载方法
				loadReadPicInfo("lookComPic");
				$(response).each(function(index,item){
					  itemsSupPic.push(ufs+item.licncePicFileId); 
						});	
				$("#lookComPic_pp2").attr("src",itemsSupPic[0]);
					}				
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					top.jAlert('error', '网络超时!请稍后重试', '提示消息');
				}
			});
        };
        
        //设置所有的input不可编辑
    	$("input[type='text']").attr('readonly','readonly');  
    	//只读界面禁用下拉框(选择其他的信息)
        $("select").find("option:not(:selected)").remove();
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<!-- 1.这里加载遮罩层信息 ，图片浏览遮罩层-->
  <div id="lookComPic_p"  class="_p">
        <div id="lookComPic_p_brower" style="border:2px solid #3f9673;" class="p_brower">
      <div class="zwindow_titleBar" style="height: 40px;position:relative;"><div class="zwindow_titleButtonBar"><div id="closeLookPic" class="zwindow_action_button zwindow_close"></div></div><div class="zwindow_title titleText">浏览图片信息</div></div>
        
            <div id="lookComPic_prev_brower" class="prev_brower"></div>
            <div id="lookComPic_pp" class="pp">
                <img src="" id="lookComPic_pp2" alt="" class="pp2"/>
                <div id="lookComPic_pp3" class="pp3"></div>
            </div>
            <div id="lookComPic_next_brower" class="next_brower"></div>
        </div>
    </div>

<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
    <div id="companMess" class="tagsM tagsM_on">审核厂商信息</div>
    <div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content" style="width: 99%;overflow:hide">
		<!--width:74%;-->
		<div class="CInfo">
			<div class="div_left"></div>
			<div class="div_right"></div>
		</div>
		<!--539-->
		<div class="t_div1">
			<div class="CM t_div1_1">
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
							<input type="text" class="inputText twoInput1" data-bind="value:supplier().supNo" readonly="readonly"/>
							<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 厂商状态 --><auchan:i18n id="102006004"/></span>
							<auchan:select mdgroup="SUPPLIER_STATUS" _class="select1" dataBind="value:supplier().status"/>
						</td>
					</tr>
					<tr>
						<td>
							<span><!-- 公司 --><auchan:i18n id="102006005"/></span>
						</td>
						<td>
							<input type="text" class="inputText twoInput1" data-bind="value:supplier().comNo" readonly="readonly"/>
							<span style="float: left;">&nbsp;&nbsp;<!-- 税号 --><auchan:i18n id="102006075"/></span>
							<input type="text" class="inputText twoInput1" data-bind="value:supplier().unifmNo" readonly="readonly" style="width:180px;"/>
						</td>
					</tr>
					<tr>
						<td>
							<span><!-- 厂商名称 --><auchan:i18n id="102006006"/></span>
						</td>
						<td>
							<input type="text" class="inputText input50" data-bind="value:supplier().comName" readonly="readonly" style="width:90%"/>
						</td>
					</tr>
					<tr>
						<td>
							<span><!-- 厂商种类 --><auchan:i18n id="102006007"/></span>
						</td>
						<td>
							<auchan:select mdgroup="SUPPLIER_SUP_TYPE" _class="select1" dataBind="value:supplier().supType" style="float:left;width:180px;"/>
							<span style="float:left;">&nbsp;&nbsp;&nbsp;<!-- 供货方式 --><auchan:i18n id="102006008"/></span>
							<auchan:select mdgroup="SUPPLIER_DLVRY_METHD" _class="select2" dataBind="value:supplier().dlvryMethd" style="float: left"/>
						</td>
					</tr>
					<tr>
						<td>
							<span><!-- 采购方式 --><auchan:i18n id="102006009"/></span>
						</td>
						<td>
							<auchan:select mdgroup="SUPPLIER_BUY_METHD" _class="select2" dataBind="value:supplier().buyMethd" style="float: left;width:120px;"/>
							<span style="float: left; margin-left:49px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- TXT 厂编 --><auchan:i18n id="102006010"/></span>
							<input type="text" class="inputText twoInput2" data-bind="value:supplier().txtSup" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td>
							<span><!-- 合同标准 --><auchan:i18n id="102006011"/></span>
						</td>
						<td>
							<auchan:select mdgroup="SUPPLIER_CONTRT_TYPE" _class="select2" dataBind="value:supplier().cntrtType" style="float: left;width:120px;"/>
							<span style="float: left; margin-left:51px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 失效日期 --><auchan:i18n id="102006012"/></span>
							<input type="text" class="inputText twoInput2" data-bind="value:supplier().validEndDate" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td>
							<span><!-- 合约课别 --><auchan:i18n id="102006013"/></span>
						</td>
						<td>
							<input type="text" class="inputText" style="width: 78%" readonly="readonly" value="${catalogNameStr}"/>
						</td>
					</tr>
				</table>
				</div>
			</div>
			<div class="t_div1_2">
				<div class="CM" style="height: 150px;">
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
								<div class="iconPut icondiv11">
									<input type="text" data-bind="value:supplier().address().provName" readonly="readonly"/>
									<div><!-- 省 --><auchan:i18n id="100000010"/></div>
								</div>
								<div class="iconPut icondiv12">
									<input type="text" data-bind="value:supplier().address().cityName" readonly="readonly"/>
									<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<input type="text" class="inputText w91_s232" data-bind="value:supplier().address().detailAddr" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>邮编</span>
							</td>
							<td>
								<input type="text" class="inputText twoinput25" data-bind="value:supplier().address().postCode" readonly="readonly"/>
								<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
								<input type="text" class="inputText twoinput25" data-bind="value:supplier().address().cntctName" readonly="readonly"/>
								<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
								<input type="text" class="inputText twoinput22" data-bind="value:supplier().address().areaCode" readonly="readonly"/>
								<span style="float: left; margin: 0;">-</span>
								<input type="text" class="inputText twoinput27" data-bind="value:supplier().address().faxNo" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
							</td>
							<td>
								<input type="text" class="inputText twoinput22" data-bind="value:supplier().address().areaCode" readonly="readonly"/>
								<span style="float: left; margin: 0;">-</span>
								<input type="text" class="inputText twoinput26" data-bind="value:supplier().address().phoneNo" readonly="readonly"/>
								<span style="float: left; margin: 0;">&nbsp;&nbsp;手机&nbsp;</span>
								<input type="text" class="inputText twoinput27" data-bind="value:supplier().address().moblNo" readonly="readonly" style="width:20%"/>
								<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/>&nbsp;</span>
								<input type="text" class="inputText twoinput28" data-bind="value:supplier().address().emailAddr"  readonly="readonly" style="width:28%"/>
							</td>
						</tr>

					</table>
					</div>
				</div>
				<div class="CM" style="height: 88px; margin-top: 2px;">
					<div class="CM-bar">
						<div><!-- 额外信息 --><auchan:i18n id="102006064"/></div>
					</div>
					<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td class="w25">
								<span><!-- 订单发送方式 --><auchan:i18n id="102006021"/></span>
							</td>
							<td>
								<auchan:select mdgroup="SUPPLIER_ORDR_ACCPT_METHD" _class="select1" dataBind="value:supplier().ordAccptMethd" style="float:left"/>
								<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 首订单量 --><auchan:i18n id="102006022"/></span>
								<input type="text" class="inputText twoInput2" data-bind="value:supplier().firstOrdQty" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 网上对账级别 --><auchan:i18n id="102006024"/></span>
							</td>
							<td>
								<auchan:select mdgroup="SUPPLIER_SCM_LEVEL" _class="select1" dataBind="value:supplier().scmLvl" style="float:left"/>
								<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电子发票 --><auchan:i18n id="102006026"/>&nbsp;</span>
								<input type="checkbox" data-bind="checked:supplier().elecInvInd" style="margin-top: 6px;float:left"/>
								<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 订单折让 --><auchan:i18n id="102006023"/>&nbsp;</span>
								<input type="checkbox"  data-bind="checked:supplier().ordDiscInd" style="margin-top: 6px;"/>
							</td>
						</tr>
					</table>
					</div>
				</div>
			</div>
		</div>
		<div style="height: 297px; margin-top: 2px;">
			<div class="t_div1_2">
				<div class="CM" style="height: 160px;">
					<div class="CM-bar" style="background: #999999;">
						<div>公司信息</div>
					</div>
					<div class="CM-div">
					<table class="CM_table">

						<tr>
							<td>
								<span>公司类型</span>
							</td>
							<td>
								<auchan:select mdgroup="COMPANY_ECON_TYPE" _class="select1" dataBind="value:company().econType" style="float:left"/>
								<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;法人代表</span>
								<input type="text" class="inputText twoInput2" data-bind="value:company().legalRpstv" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 税号 --><auchan:i18n id="102006075"/></span>
							</td>
							<td>
								<input type="text" class="inputText twoInput1" data-bind="value:company().unifmNo" readonly="readonly" style="width:78%"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>成立日期</span>
							</td>
							<td>
								<input type="text" class="inputText twoInput1" data-bind="value:company().setupDate" />
								<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 状态 --><auchan:i18n id="102008013"/></span>
								<auchan:select mdgroup="COMPANY_STATUS" _class="select1" dataBind="value:company().status"/>
							</td>
						</tr>
						 <tr>
							<td class="w25">
								<span><!-- 公司注册地址 --><auchan:i18n id="102004024"/></span>
							</td>
							<td>
								<input type="text" class="inputText twoInput1 w35" data-bind="value:company().regAddress().cityName"/><br>
							</td>
						</tr> 
						<tr>
							<td class="w25">
								<span>&nbsp;</span>
							</td>
							<td>
								<input type="text" class="inputText twoInput1"  data-bind="value:company().regAddress().detailAddr" readonly="readonly" style="width:78%"/>
							</td>
						</tr> 
					</table>
					</div>
				</div>
				<div class="CM" style="height: 135px; margin-top: 2px;">
					<div class="CM-bar" style="background: #999999;">
						<div>发票送达地址</div>
					</div>
					<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td style="width: 20%;">
								<span><!-- 地址 --><auchan:i18n id="102006014"/></span>
							</td>
							<td>
								<div class="iconPut icondiv11">
									<input type="text" data-bind="value:company().dlvAddress().provName" readonly="readonly"/>
									<div><!-- 省 --><auchan:i18n id="100000010"/></div>
								</div>
								<div class="iconPut icondiv12">
									<input type="text" data-bind="value:company().dlvAddress().cityName" readonly="readonly"/>
									<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<input type="text" class="inputText w91_s232" data-bind="value:company().dlvAddress().detailAddr" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>邮编</span>
							</td>
							<td>
								<input type="text" class="inputText twoinput25" data-bind="value:company().dlvAddress().postCode" readonly="readonly"/>
								<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
								<input type="text" class="inputText twoinput25" data-bind="value:company().dlvAddress().cntctName" readonly="readonly"/>
								<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
								<input type="text" class="inputText twoinput22" data-bind="value:company().dlvAddress().areaCode" readonly="readonly"/>
								<span style="float: left; margin: 0;">-</span>
								<input type="text" class="inputText twoinput27" data-bind="value:company().dlvAddress().faxNo" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<td>
								<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
							</td>
							<td>
								<input type="text" class="inputText twoinput22" data-bind="value:company().dlvAddress().areaCode" readonly="readonly"/>
								<span style="float: left; margin: 0;">-</span>
								<input type="text" class="inputText twoinput26" data-bind="value:company().dlvAddress().phoneNo" readonly="readonly"/>
								<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/>&nbsp;</span>
								<input type="text" class="inputText twoinput27" data-bind="value:company().dlvAddress().moblNo" readonly="readonly" style="width:20%;"/>
								<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/>&nbsp;</span>
								<input type="text" class="inputText twoinput28" data-bind="value:company().dlvAddress().emailAddr"  readonly="readonly" style="width:28%;"/>
							</td>
						</tr>
					</table>
					</div>
				</div>
			</div>

			<div class="CM t_div1_1">
				<%-- <div class="CM-bar" style="background: #999999;">
					<div>公司证件</div>
				</div>
				<div class="CM-div">
					<table class="CM_table" style="width:470px; margin-left: 10px;">
						<tr><td style="height:370px;">
						<div style="height:100%;width:450px;overflow-x:auto;overflow-y:auto;">
						<table style="width:880px;">
						<tr>
							<td style="width: 180px;">证件类型</td>
							<td style="width: 180px;">证件号</td>
							<td style="width: 150px;">截止日期</td>
							<td style="width: 150px;">起始日期</td>
							<td style="width: 150px;">发证机关</td>
						</tr>
						<tr>
							<td class="line" colspan="7"></td>
						</tr>
						<tr>
							<td style="height: 230px;">
								<div style="height: 100%; overflow-x: hidden; overflow-y: hidden;">
									<table style="width: 100%; height: 55px; overflow: hidden">
										<c:forEach var="item" items="${company.comLicences}">
										<tr>
											<td style="width: 28%;">
												<auchan:select mdgroup="COM_LICENCE_LICNCE_TYPE" _class="select1" value="${item.licnceType}" disabled="disabled"/>
											</td>
											<td style="width: 35%;">
												<input type="text" style="width: 90%;" value="${item.licnceNo}" class="inputText" readonly="readonly"/>
											</td>
											<td style="width: 25%;">
												<div class="iconPut w80">
													<input type="text" style="width: 79%" value="${item.validStartDate}" readonly="readonly"/>
												</div>
											</td>
											<td style="width: 25%;">
												<div class="iconPut w80">
													<input type="text" style="width: 79%" value="${item.validEndDate}" readonly="readonly"/>
												</div>
											</td>
											<td style="width: 35%;">
												<input type="text" style="width: 90%;" value="${item.issueBy}" class="inputText" readonly="readonly"/>
											</td>
										</tr>
										</c:forEach>
									</table>
								</div>
							</td>
						</tr>	
						<tr>
							<td class="line"></td>
						</tr>
						</table>
						</div>
					</table>
				</div> --%>
			    <div class="CM-bar" style="background: #999999;">
					<div><!-- 公司证件 --><auchan:i18n id="102004035"/></div>
				</div>
				<div class="CM-div">
					<table class="CM_table" style="width: 470px; margin-left: 10px;">
						<tr>
							<td style="height: 270px;">
								<div style="height: 100%; width: 450px; overflow-x: auto; overflow-y: auto;">
									<table style="width: 880px;">
										<tr>
										    <td style="width: 18px;">&nbsp;</td>
											<td style="width: 180px;">证件类型</td>
											<td style="width: 180px;">证件号</td>
											<td style="width: 150px;">截止日期</td>
											<td style="width: 150px;">起始日期</td>
											<td style="width: 150px;">发证机关</td>
										</tr>
										<tr>
											<td class="line" colspan="7"></td>
										</tr>
										<tbody>
											<c:forEach items="${company.comLicences}" var="comLicenceVO">
												<tr>
												<td>
												<div style="height: 20px; width: 20px; border: 1px solid #999999;" onclick="readPhotosByLincenceId('${comLicenceVO.licnceId}')" class="license1"></div>
													</td>
													<td>
														<auchan:select mdgroup="COM_LICENCE_LICNCE_TYPE" style="width: 90%;" value="${comLicenceVO.licnceType }"></auchan:select>
													</td>
													<td>
														<input type="text" style="width: 90%;" class="inputText" value="${comLicenceVO.licnceNo }" />
													</td>
													<td>
														<div class="iconPut w90">
															<input type="text" style="width: 70%" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${comLicenceVO.validEndDate }"/>" />
														</div>
													</td>
													<td>
														<div class="iconPut w90">
															<input type="text" style="width: 70%" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${comLicenceVO.validStartDate }"/>" />
														</div>
													</td>
													<td>
														<div class="iconPut w90">
															<input type="text" style="width: 70%" value="${comLicenceVO.issueBy }" />
														</div>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>

								</div>
							</td>
						</tr>
						<tr>
							<td class="line"></td>
						</tr>
					</table>
					
				</div>
				
			</div>
		</div>
	</div>
</div>
