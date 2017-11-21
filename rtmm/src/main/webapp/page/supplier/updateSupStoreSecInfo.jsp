<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/create_Supplier343.css" />
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<script type="text/javascript">
	$('.tagsM').die('click');

	function showAreaDetail(obj){
		$(obj).parent().parent().find(".list_ex2").hide();
	}
	//添加下传区域信息(确定后回调函数)
	function confirmSelectArea(list){
		closePopupWin();
		var storeNo = joinObject(list,'storeNo',',');
		var storeName = joinObject(list,'storeName',',');
		var groupId = new Date().format('yyyyMMddhhmmssSSS');
		var index = 0;
		$.each(viewModel.cataInfoList(),function(i,item){
			if(item.catlgId() == viewModel.catlgId()){
				var storeOraderInfoListNo = viewModel.cataInfoList()[i].storeOrderInfoList().length;
				if (storeOraderInfoListNo != 0) {
					var oplSched = "";
					var oplSchecList = viewModel.cataInfoList()[i].storeOrderInfoList()[storeOraderInfoListNo-1].oplSchedWeekList();
					var dlvrySched = "";
					var dlvrySchedList = viewModel.cataInfoList()[i].storeOrderInfoList()[storeOraderInfoListNo-1].dlvrySchedWeekList();
					$.each(oplSchecList,function(i, val){
						oplSched = oplSched + oplSchecList[i].value();
					});
					$.each(dlvrySchedList,function(i, val){
						dlvrySched = dlvrySched + dlvrySchedList[i].value();
					});
					viewModel.cataInfoList()[i].storeOrderInfoList.push(new supplierCreateStoreSecInfo.StoreOrderInfo(groupId,storeNo,storeName,
							viewModel.cataInfoList()[i].storeOrderInfoList()[storeOraderInfoListNo-1].cataStatus(),
							viewModel.cataInfoList()[i].storeOrderInfoList()[storeOraderInfoListNo-1].minOrdAmt(),
							viewModel.cataInfoList()[i].storeOrderInfoList()[storeOraderInfoListNo-1].rtnAllow(),
							viewModel.cataInfoList()[i].storeOrderInfoList()[storeOraderInfoListNo-1].leadTime(),
							oplSched,
							dlvrySched,
							'',
							'',
							viewModel.cataInfoList()[i].storeOrderInfoList()[storeOraderInfoListNo-1].supAddressList(),
							viewModel.cataInfoList()[i].storeOrderInfoList()[storeOraderInfoListNo-1].relatedAddress(),
							storeOraderInfoListNo,
							false,
							''));
				} else {
					viewModel.cataInfoList()[i].storeOrderInfoList.push(new supplierCreateStoreSecInfo.StoreOrderInfo(groupId,storeNo,storeName,'','','','','','','','','',false,storeOraderInfoListNo,false,''));
				}
				index = viewModel.cataInfoList()[i].storeOrderInfoList().length-1;
			}
		});
		//模拟点击下传区域
		$($('input[name="switchStoreGroup"]')[index]).parent().trigger('click');
	}
	
	//选择定退货地址(确定后回调函数)
	function confirmChooseSupAddress(addrId){
		closePopupWin();
		$(viewModel.tmpVal()).find('input').attr('value',addrId).trigger('change');
		//清空临时变量的值 
		viewModel.tmpVal('');
	}

	//选择课别(确定后回调函数)
	function confirmChooseSection(id,name){	
		closePopupWin();
		//当前处课已经选中过了，则跳过
		var exists = false;
		$.each(viewModel.cataInfoList(),function(index,item){
			if(item.catlgId == id){
				exists = true;
				return false;
			}
		});
		if(exists){
			return;
		}
		
		var visible = false;
		if(viewModel.cataInfoList().length==0){
			visible =  true;
		}
		viewModel.cataInfoList.push(new supplierCreateStoreSecInfo.CataInfo(id,name,'','','',[],visible));
		
		$('input[name=catlgId][value='+id+']').parent().parent().find('.GreenBg').removeClass('GreenBg');
		$('input[name=catlgId][value='+id+']').parent().trigger('click');
		
		var index = viewModel.cataInfoList().length-1;
		viewModel.cataInfoList()[index].chooseDownLoadArea();
	}

	var viewModel = new supplierCreateStoreSecInfo.ViewModel('${supNo}','${taskId}','${comNo}','${action}','${from}','${dlvryMethd}');
	ko.applyBindings(viewModel);

	if('${action}'=='create'){
		//默认调出选择课界面(创建)
		$($('.Tools11')[0]).trigger('click');
	}else{
		viewModel.initCataInfoList();
		//默认设置第一个课选中(修改)
		$($('.td2_1')[0]).trigger('click');
	}

	//从总览界面过来的时候，不显示上一步
	if('${from}'!='generalInfo'){
		var param = {'supNo':viewModel.supNo(),'taskId':viewModel.taskId(),'comNo':viewModel.comNo(),'action':viewModel.action(),dlvryMethd:viewModel.dlvryMethd()};
		$('#Tools24').removeClass('Tools24_disable').addClass('Tools24').bind('click', function() {
			showContent(ctx + '/supplierAudit/createSupPayment',param);
		});
	}
	
	$("#Tools2").attr('class', "Tools2").bind("click", function() {
		viewModel.save();
	});
	
	$('#selectSection').bind("click",function(){
		// 添加课的时候，先验证表单(填写完整后才允许添加新的课)
		viewModel.errors = ko.validation.group(viewModel);
		if (!viewModel.isValid()) {
			viewModel.errors.showAllMessages();
			return;
		}
		supplierCommon.selectDivision('1');
	});
	
</script>
<style type="text/css">
	.cmt1:hover {
		background: #99cc66;
		color: #fff;
	}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<c:if test="${from != 'generalInfo'}">
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
</c:if>
<c:if test="${from == 'generalInfo'}">
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left"></div>
	<div class="tagsM tagsM"><!-- 厂商总览 --><auchan:i18n id="102006001"/></div>
	<div class="tags tags_left"></div>

	<!--中间-->
	<div class="tagsM"><!-- 厂商财务信息 --><auchan:i18n id="102007001"/></div>
	<div class="tags"></div>

	<!--最后一个-->
	<div class="tagsM"><!-- 厂商供应区域 --><auchan:i18n id="102008001"/></div>
	<div class="tags tags3 tags_right_on"></div>
	
	<div class="tagsM tagsM_on">新增厂商门店课别信息</div>
	<div class="tags tags3_r_on"></div>
</div>
</c:if>
<div class="Container-1">
	<div class="Content" style="width: 99%;">
		<!--width:74%;-->
		<c:if test="${from != 'generalInfo'}">
			<!-- 修改的时候，从总览界面新增门店课别信息 -->
			<div class="CInfo">
		        <span class="s343_on">
		        	<c:if test="${action == 'create'}">
		        		创建厂商门店课别信息
		        	</c:if>
		        	<c:if test="${action == 'update'}">
		        		修改厂商门店课别信息
		        	</c:if>
		        </span>
		        <span class="s342">
		        	<c:if test="${action == 'create'}">
		        		<!-- 创建厂商财务信息 -->
		        		<auchan:i18n id="102006045"/>
		        	</c:if>
		        	<c:if test="${action == 'update'}">
		        		修改厂商财务信息
		        	</c:if>
		        </span>
		        <span class="s341">
		        	<c:if test="${action == 'create'}">
		        		<!-- 创建厂商基本信息 -->
		        		<auchan:i18n id="102006044"/>
		        	</c:if>
		        	<c:if test="${action == 'update'}">
		        		修改厂商基本信息
		        	</c:if>
		        </span>
	        </div>
	    </c:if>
	    <c:if test="${from == 'generalInfo'}">
	    	<div>
	            <span><!-- 采购厂编 --><auchan:i18n id="102006003"/>&nbsp;</span>
	            <input type="text" class="inputText w10 Black" value="${supNo}" readonly="readonly">
	            <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 公司编号 --><auchan:i18n id="102006049"/>&nbsp;</span>
	            <input type="text" class="inputText w7 Black" value="${comNo}" readonly="readonly"><span>&nbsp;</span>
	            <input type="text" class="inputText w15 Black"  value="${comName}" readonly="readonly">
            </div>
	    </c:if>
		<!--539-->
		<div class="t_div2 CM">
			<div data-bind="foreach: cataInfoList">
				<div class="td2_1" data-bind='event:{click:switchSection}'>
					<input type="hidden" name="catlgId" data-bind="value:catlgId"/>
					<span data-bind="text:catlgId"></span>-
					<span data-bind="text:cataName"></span>
				</div>
			</div>
			<c:if test="${action == 'create'}">
	        	<div class="Tools11 Icon-size2 fl_left" id="selectSection" title="新增" style="float: right; margin-top: 13px; margin-right: 15px;"></div>
	        </c:if>
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
							<div class="list_ex0" data-bind="event:{click:switchStoreGroup}">
								<input type="hidden" name="switchStoreGroup"/>
								<div class="list_ex1">
									<div class="ssuo list_ex11 Icon-size1" onclick="showAreaDetail(this)"></div>
									<div class="longText list_ex12" data-bind="text:storeName"></div>
									<div class="Icon-size2 Tools12 list_ex13"></div>
									<div class="list_ex14 Icon-size2 Tools10" data-bind="event:{click:delStoreGroupInfo}"></div>
								</div>
							    <div class="list_ex2">
									<textarea class="list_ex21"></textarea>
								</div>
							</div>
							</div>
						</div>
						<div style="height: 30px; width: 85%; margin: 0 auto;">
							<div class="Icon-size2 Tools11 fl_left" data-bind="event:{click:chooseDownLoadArea}"></div>
							<span class="fl_left" style="line-height: 20px;">&nbsp;&nbsp;新增下传区域</span>
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
										<select data-bind="value:cataStatus">
											<option value=""><auchan:i18n id="100000009"/></option> 
											<c:if test="${action == 'create'}">
											<option value="0">0-未生效</option>
											</c:if>
											<option value="1">1-正常</option>
											<option value="2">2-禁止下单</option>
											<option value="8">8-进入删除</option>
											<c:if test="${action == 'create'}">
											<option value="9">9-删除</option>
											</c:if>
										</select>
									</td>
									<td></td>
								</tr>
								<tr>
									<td class="w25">
										<span><c:if test="${action == 'create'}">*</c:if><!-- 最低订购(MOC) --><auchan:i18n id="102006031"/></span>
									</td>
									<td class="w15">
										<input type="text" class="inputText w78" data-bind="value:minOrdAmt,validationElement:minOrdAmt" maxlength="10"/>
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
												<div class="week week21" data-bind="foreach:oplSchedWeekList,validationElement:oplSchedWeekList">
													<div data-bind="css:css,event:{click:weekClick}"></div>
												</div>
												<input type="checkbox" data-bind="checked:oplSchedCheckAll" style="margin-top: 7px;">
												<!--<div class="icondiv2 Rect2Close"></div>-->
											</div>
											<div style="height: 25px;">
												<div class="wtitle">
													<span><c:if test="${action == 'create'}">*</c:if><!-- 送货行程 --><auchan:i18n id="102006036"/></span>
												</div>
												<div class="week week21" data-bind="foreach:dlvrySchedWeekList,validationElement:dlvrySchedWeekList">
													<div data-bind="css:css,event:{click:weekClick}"></div>
												</div>
												<input type="checkbox" data-bind="checked:dlvrySchedCheckAll" style="margin-top: 7px;">
												<!--<div class="icondiv2 Rect2Close"></div>-->
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<span><c:if test="${action == 'create'}">*</c:if><!-- 准备天数 --><auchan:i18n id="102006035"/></span>
									</td>
									<td>
										<input type="text" class="inputText w78" data-bind="value:leadTime,validationElement:leadTime" maxlength="3"/>
										天
									</td>
								</tr>
								<tr>
									<td>
										<span><c:if test="${action == 'create'}">*</c:if><!-- 可否退货 --><auchan:i18n id="102006033"/></span>
									</td>
									<td>
										<auchan:select mdgroup="SUP_STORE_SEC_INFO_RTN_ALLOW" _class="w87" dataBind="value:rtnAllow,validationElement:rtnAllow" />
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
										<div class="cmt1" data-bind="event:{click:clickSupAddress}"><input type="hidden" value="0"><!-- 订货地址 --><auchan:i18n id="102006054"/></div>
										<div class="cmt1" data-bind="event:{click:clickSupAddress}"><input type="hidden" value="1"><!-- 退货地址 --><auchan:i18n id="102006055"/></div>
										<div class="ListWin cmt2" data-bind="event:{click:chooseSupAddress}">
											<input type="text" data-bind="value:selectAddressId,event:{change:fillingSupAddress}" style="display: none">
										</div>
										<div class="cmt3">
											<div style="width: 20px; height: 30px; float: left;">
												<input type="checkbox" style="margin-top: 6px; *margin-top: 3px;" data-bind="checked:relatedAddress,event: {change: relatedAddressChange}" />
												&nbsp;
											</div>
											<div class="Line-1 td2_5" style="margin-top: 2px;"></div>
											<div class="cmt32">订货退货地址关联</div>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="height: 10px; overflow: hidden;">
										<div class="line"></div>
									</td>
								</tr>
								<tbody data-bind="foreach:supAddressList">
								<tr data-bind="visible:visible">
									<td style="width: 20%;">
										<span><!-- 地址 --><auchan:i18n id="102006014"/><input type="hidden" data-bind="value:addrId"></span>
									</td>
									<td>
										<div class="iconPut" style="width: 20%; float: left;">
											<input type="text" style="width: 72%;"
												data-bind="value:provName,validationElement:provName" readonly="readonly" />
											<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
										</div>
										<div class="iconPut"
											style="width: 30%; float: left; margin-left: 3px;">
											<input type="text" style="width: 62%;"
												data-bind="value:cityName,validationElement:cityName" readonly="readonly"/>
											<div style="color: #999999;"><!-- 市 --><auchan:i18n id="100000010"/></div>
										</div>
									</td>
								</tr>
								<tr data-bind="visible:visible">
									<td>&nbsp;</td>
									<td>
										<input type="text" class="inputText w91_s232" data-bind="value:detailAddr,validationElement:detailAddr" readonly="readonly"/>
									</td>
								</tr>
								<tr data-bind="visible:visible">
									<td>
										<span>邮编</span>
									</td>
									<td>
										<input type="text" class="inputText twoinput25" data-bind="value:postCode,validationElement:postCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/>&nbsp;</span>
										<input type="text" class="inputText twoinput25" data-bind="value:cntctName" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<!-- 传真 --><auchan:i18n id="102006017"/>&nbsp;</span>
										<input type="text" class="inputText twoinput22" data-bind="value:areaCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">-</span>
										<input type="text" class="inputText twoinput23" data-bind="value:faxNo" readonly="readonly"/>
									</td>
								</tr>
								<tr data-bind="visible:visible">
									<td>
										<span><!-- 固话 --><auchan:i18n id="102006018"/></span>
									</td>
									<td>
										<input type="text" class="inputText twoinput22" data-bind="value:areaCode,validationElement:areaCode" readonly="readonly"/>
										<span style="float: left; margin: 0;">-</span>
										<input type="text" class="inputText twoinput26" data-bind="value:phoneNo,validationElement:phoneNo" readonly="readonly"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 移动 --><auchan:i18n id="102006019"/></span>
										<input type="text" class="inputText twoinput27" data-bind="value:moblNo,validationElement:moblNo" readonly="readonly" style="width:20%"/>
										<span style="float: left; margin: 0;">&nbsp;&nbsp;<!-- 电邮 --><auchan:i18n id="102006020"/></span>
										<input type="text" class="inputText twoinput28" data-bind="value:emailAddr,validationElement:emailAddr" readonly="readonly" style="width:28%"/>
									</td>
								</tr>
								</tbody>
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