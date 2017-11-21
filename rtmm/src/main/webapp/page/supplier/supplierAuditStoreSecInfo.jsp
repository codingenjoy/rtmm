<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/sh_Supplier442.css" />
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/supplier/supplierCommon.js" charset="gbk" type="text/javascript"></script>
<script src="${ctx}/shared/js/supplier/supplierCreateStoreSecInfo.js" charset="gbk" type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<script type="text/javascript">
	$('.tagsM').die('click');
	$(function() {
		var tool24 = $('#Tools24');
		$(tool24).toggleClass('Tools24_disable').toggleClass('Tools24');
		$(tool24).unbind('click').bind('click', function() {
			sep1();
		});

		function sep1(){
			showContent(ctx + '/supplierAudit/getSupplierAuditGeneralInfo?taskId=${taskId}');
		}

		$('.div_left').unbind('click').bind('click',function(){
			sep1();
		});
		
		$('#Tools3').removeClass('Tools3_disable').addClass('Tools3').die().unbind().bind('click',function(){
			window.location.href = ctx + "/supplierAudit/downLoadSupplierPdf?taskId=${taskId}";  
		});

		//检查该任务是否可以被提交
		var canEdit = true;
		if('${taskId}'!=''){
			$.ajax({
				type : "post",
				url : ctx + '/workspace/task/checkSupplierCanEdit',
				async : false,
				dataType : "json",
				data : {
					'taskId' : '${taskId}'
				},
				success : function(data) {
					canEdit = data;
				}
			});
		}
		if(canEdit){
			var tools26 = $('#Tools26');
			$(tools26).removeClass('Tools26_disable').addClass('Tools26');
			$(tools26).unbind('click').bind('click',function() {
				top.jConfirm('你确定要提交信息进行审核吗?','提示消息',function(ret){
					if(ret){
						$.ajax({
							type : "post",
							url : ctx+'/workspace/task/doSubmitTask2Audit',
							async :false,
							dataType : "json",
							data : {'taskId':'${taskId}'},
							success : function(data) {
								if(data.status=='success'){
									top.jAlert('success', '提交成功','提示消息');
								}else{
									top.jAlert('warning', data.message,'提示消息');
								}
							}
						});
					}
				});
			});
		}

	});
	
	var viewModel = new supplierCreateStoreSecInfo.ViewModel('${supNo}','${taskId}','${comNo}','view','${from}','${dlvryMethd}');
	ko.applyBindings(viewModel);
	viewModel.initCataInfoList();
	//默认显示第一个课，第一个下传区域
	if(viewModel.cataInfoList().length>0){
		viewModel.cataInfoList()[0].visible(true);
		if(viewModel.cataInfoList()[0].storeOrderInfoList().length>0){
			viewModel.cataInfoList()[0].storeOrderInfoList()[0].visible(true);
		}
	}
	
    //设置所有的input不可编辑
	$("input[type='text']").attr('readonly','readonly');  
	//只读界面禁用下拉框(选择其他的信息)
    $("select").find("option:not(:selected)").remove();
    viewModel.errors = ko.validation.group(viewModel);
	viewModel.errors.showAllMessages(false);
</script>
<style type="text/css">
	.cmt1:hover {
		background: #99cc66;
		color: #fff;
	}
	.div_left,.div_right{
		width: 49%;
		float: left;
		height: 100%
	}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">
		审核厂商信息
	</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content" style="width: 99%;">
		<!--width:74%;-->
		<!-- 修改的时候，从总览界面新增门店课别信息 -->
		<div class="CInfo">
	        <div class="div_left"></div>
			<div class="div_right"></div>
        </div>
	   
		<!--539-->
		<div class="t_div2 CM">
			<div data-bind="foreach: cataInfoList">
				<div class="td2_1" data-bind="event:{click:switchSection},css:visible()==true?'GreenBg':''">
					<input type="hidden" name="catlgId" data-bind="value:catlgId"/>
					<span data-bind="text:catlgId"></span>-
					<span data-bind="text:catlgName"></span>
				</div>
			</div>
		</div>

		<div data-bind="foreach: cataInfoList">
			<div data-bind="visible:visible">
				<div class="CM fx_div1">
					<div class="CM-bar">
						<div>公共</div>
					</div>
					<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td class="w10">
								<span><!-- 采购范围 --><auchan:i18n id="102006027"/></span>
							</td>
							<td  class="w20">
								<input type="text" class="inputText w80" data-bind="value:ordScope" maxlength="25"/>
							</td>
							<td  class="w10">
								<span><!-- 备注 --><auchan:i18n id="102006028"/></span>
							</td>
							<td  class="w20">
								<input type="text" class="inputText w80" data-bind="value:buyrMemo" maxlength="25"/>
							</td>
							<td  class="w10">
								<span><!-- 新店折扣 --><auchan:i18n id="102006030"/></span>
							</td>
							<td  class="w20">
								<input type="text" class="inputText w20" data-bind="value:newStDiscDays,validationElement:newStDiscDays" maxlength="4"/>
							</td>
						</tr>
					</table>
					</div>
				</div>

				<div class="f_div">
					<div class="CM f_div1">
						<div class="CM-bar">
							<div>下传区域</div>
						</div>
						<div class="list_ex">
							<div data-bind="foreach: storeOrderInfoList">
							<div class="list_ex0" data-bind="event:{click:switchStoreGroup},css:visible()==true?'list_ex0_on':''">
								<input type="hidden" name="switchStoreGroup"/>
								<div class="list_ex1">
									<div class="ssuo list_ex11 Icon-size1"></div>
									<div class="longText list_ex12" data-bind="text:storeName"></div>
									<!-- <div class="Icon-size2 Tools12 list_ex13"></div>
									<div class="list_ex14 Icon-size2 Tools10" data-bind="event:{click:delStoreGroupInfo}"></div> -->
								</div>
							    <!-- <div class="list_ex2">
									<textarea class="list_ex21"></textarea>
								</div>  -->
							</div>
							</div>
						</div>
					</div>
					<div data-bind="foreach: storeOrderInfoList">
					<div class="CM f_div2" data-bind="visible:visible">
						<div class="f_div21">
							<div class="CM-bar">
								<div><!-- 订单信息 --><auchan:i18n id="102006066"/></div>
							</div>
							<div class="CM-div">
							<table class="CM_table">
								<tr>
									<td>
										<span><!-- 门店课别状态 --><auchan:i18n id="102006029"/></span>
									</td>
									<td class="w15">
										<auchan:select mdgroup="SUP_STORE_SEC_INFO_STATUS" _class="select1" dataBind="value:cataStatus"/>
									</td>
									<td>
										<c:if test="${totApAmt!=null}">
											<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 总应付余额 --><auchan:i18n id="102006025"/></span>
											<input type="text" class="inputText twoInput2 Black" value="${totApAmt}"  readonly="readonly" style="width:75px">
										</c:if>
									</td>
								</tr>
								<tr>
									<td class="w25">
										<span><c:if test="${action == 'create'}">*</c:if><!-- 最低订购(MOC) --><auchan:i18n id="102006031"/></span>
									</td>
									<td class="w15">
										<input type="text" class="inputText w75" data-bind="value:minOrdAmt,validationElement:minOrdAmt" maxlength="10"/>
										元
									</td>
									<td class="w50" rowspan="3">
										<div class="schedule">
											<div style="height: 25px;">
												<div class="wtitle">&nbsp;</div>
												<div class="week week20" style="width:51%">
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
													<span><c:if test="${action == 'create'}">*</c:if><!-- OPL订货行程 --><auchan:i18n id="102006034"/></span>
												</div>
												<div class="week week21" data-bind="">
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
													<span><c:if test="${action == 'create'}">*</c:if><!-- 送货行程 --><auchan:i18n id="102006036"/></span>
												</div>
												<div class="week week21" data-bind="">
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
										<span><c:if test="${action == 'create'}">*</c:if><!-- 准备天数 --><auchan:i18n id="102006035"/></span>
									</td>
									<td>
										<input type="text" class="inputText w75" data-bind="value:leadTime,validationElement:leadTime" maxlength="3"/>
										天
									</td>
								</tr>
								<tr>
									<td>
										<span><c:if test="${action == 'create'}">*</c:if><!-- 可否退货 --><auchan:i18n id="102006033"/></span>
									</td>
									<td>
										<auchan:select mdgroup="SUP_STORE_SEC_INFO_RTN_ALLOW" _class="w78" dataBind="value:rtnAllow,validationElement:rtnAllow" />
									</td>
								</tr>
							</table>
							</div>
						</div>
						<div class="f_div22">
							<div class="CM-bar">
								<div><!-- 订货退货地址 --><auchan:i18n id="102002010"/></div>
							</div>
							<div class="CM-div">
							<table class="CM_table">
								<tr>
									<td colspan="2" style="line-height: 18px;">
										<div class="cmt1" data-bind="event:{click:clickAddress},css:showAddressIndex()=='0'?'GreenBg':''">
											<input type="hidden" value="0"><!-- 订货地址 --><auchan:i18n id="102006054"/>
										</div>
										<div class="cmt1" data-bind="event:{click:clickAddress},css:showAddressIndex()=='1'?'GreenBg':''">
											<input type="hidden" value="1"><!-- 退货地址 --><auchan:i18n id="102006055"/>
										</div>
										
									</td>
								</tr>
								<tr>
									<td colspan="2" style="height: 10px; overflow: hidden;">
										<div class="line"></div>
									</td>
								</tr>
								<!-- 订货地址 -->
								<tr data-bind="visible:supOrdAddr().visible">
									<td style="width: 20%;">
										<span><!-- 地址 --><auchan:i18n id="102006014"/><input type="hidden" data-bind="value:supOrdAddr().addrId"></span>
									</td>
									<td>
										<div class="iconPut" style="width: 20%; float: left;">
											<input type="text" style="width: 72%;"
												data-bind="value:supOrdAddr().provName,validationElement:supOrdAddr().provName" readonly="readonly" />
											<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
										</div>
										<div class="iconPut"
											style="width: 30%; float: left; margin-left: 3px;">
											<input type="text" style="width: 62%;"
												data-bind="value:supOrdAddr().cityName,validationElement:supOrdAddr().cityName" readonly="readonly"/>
											<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
										</div>
									</td>
								</tr>
								<tr data-bind="visible:supOrdAddr().visible">
									<td>&nbsp;</td>
									<td>
										<input type="text" class="inputText w91_s232" data-bind="value:supOrdAddr().detailAddr,validationElement:supOrdAddr().detailAddr" readonly="readonly"/>
									</td>
								</tr>
								<tr data-bind="visible:supOrdAddr().visible">
									<td>
										<span>邮编</span>
									</td>
									<td>
										<input type="text" class="inputText twoinput25" data-bind="value:supOrdAddr().postCode,validationElement:supOrdAddr().postCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
										<input type="text" class="inputText twoinput25" data-bind="value:supOrdAddr().cntctName" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
										<input type="text" class="inputText twoinput22" data-bind="value:supOrdAddr().areaCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">-</span>
										<input type="text" class="inputText twoinput23" data-bind="value:supOrdAddr().faxNo" readonly="readonly"/>
									</td>
								</tr>
								<tr data-bind="visible:supOrdAddr().visible">
									<td>
										<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
									</td>
									<td>
										<input type="text" class="inputText twoinput22" data-bind="value:supOrdAddr().areaCode,validationElement:supOrdAddr().areaCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">-</span>
										<input type="text" class="inputText twoinput26" data-bind="value:supOrdAddr().phoneNo,validationElement:supOrdAddr().phoneNo" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/></span>
										<input type="text" class="inputText twoinput27" data-bind="value:supOrdAddr().moblNo,validationElement:supOrdAddr().moblNo" readonly="readonly" style="width:20%"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/></span>
										<input type="text" class="inputText twoinput28" data-bind="value:supOrdAddr().emailAddr,validationElement:supOrdAddr().emailAddr" readonly="readonly" style="width:28%"/>
									</td>
								</tr>
								<!-- 退货地址 -->
								<tr data-bind="visible:supRtnAddr().visible">
									<td style="width: 20%;">
										<span><!-- 地址 --><auchan:i18n id="102006014"/><input type="hidden" data-bind="value:supRtnAddr().addrId"></span>
									</td>
									<td>
										<div class="iconPut" style="width: 20%; float: left;">
											<input type="text" style="width: 72%;"
												data-bind="value:supRtnAddr().provName,validationElement:supRtnAddr().provName" readonly="readonly" />
											<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
										</div>
										<div class="iconPut"
											style="width: 30%; float: left; margin-left: 3px;">
											<input type="text" style="width: 62%;"
												data-bind="value:supRtnAddr().cityName,validationElement:supRtnAddr().cityName" readonly="readonly"/>
											<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
										</div>
									</td>
								</tr>
								<tr data-bind="visible:supRtnAddr().visible">
									<td>&nbsp;</td>
									<td>
										<input type="text" class="inputText w91_s232" data-bind="value:supRtnAddr().detailAddr,validationElement:supRtnAddr().detailAddr" readonly="readonly"/>
									</td>
								</tr>
								<tr data-bind="visible:supRtnAddr().visible">
									<td>
										<span>邮编</span>
									</td>
									<td>
										<input type="text" class="inputText twoinput25" data-bind="value:supRtnAddr().postCode,validationElement:supRtnAddr().postCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
										<input type="text" class="inputText twoinput25" data-bind="value:supRtnAddr().cntctName" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
										<input type="text" class="inputText twoinput22" data-bind="value:supRtnAddr().areaCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">-</span>
										<input type="text" class="inputText twoinput23" data-bind="value:supRtnAddr().faxNo" readonly="readonly"/>
									</td>
								</tr>
								<tr data-bind="visible:supRtnAddr().visible">
									<td>
										<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
									</td>
									<td>
										<input type="text" class="inputText twoinput22" data-bind="value:supRtnAddr().areaCode,validationElement:supRtnAddr().areaCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">-</span>
										<input type="text" class="inputText twoinput26" data-bind="value:supRtnAddr().phoneNo,validationElement:supRtnAddr().phoneNo" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/></span>
										<input type="text" class="inputText twoinput27" data-bind="value:supRtnAddr().moblNo,validationElement:supRtnAddr().moblNo" readonly="readonly" style="width:20%"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/></span>
										<input type="text" class="inputText twoinput28" data-bind="value:supRtnAddr().emailAddr,validationElement:supRtnAddr().emailAddr" readonly="readonly" style="width:28%"/>
									</td>
								</tr>
							</table>
							</div>
						</div>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>