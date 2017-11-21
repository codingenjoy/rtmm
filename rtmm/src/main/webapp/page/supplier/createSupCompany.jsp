<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css"
	rel="Stylesheet" />
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css"
	rel="Stylesheet" />
<script src="${ctx}/shared/js/supplier/company.js" charset="UTF-8"
	type="text/javascript"></script>

<script type="text/javascript">
	var itemsCreatPic = new Array();//当前单个证件下所有的证件图片信息

	var currentImgListId = "";
	var imgsListInfos = "";
	$(function() {
		itemsCreatPic = new Array();
		$("#Tools2").attr('class', "Tools2").bind(
				"click",
				function() {
					imgsListInfos = "";//清空数据，重新加载
					//本段代码用于封装图片数据信息
					$("[name=comlicencePic]").each(
							function(index, item) {
								var id = $(this).attr("id");
								if (itemsCreatPic[id] != null) {
                                    var list= new Array();
                                    for (var i =0;i<itemsCreatPic[id].length;i++){
                                    	list.push(itemsCreatPic[id][i].replace(ufs,""));
                                        }
									imgsListInfos +=list
											+ "ZZZ";
								} else {
									imgsListInfos += "nodataZZZ";
								}
							});
					viewModel.save();
				});
		$("#closeDiv").bind("click", function() {
			wipeAddPage();
		});
		$("#comOthAddrMess").bind('click', function() {
			comOtherAddrManagement();
		});
		$('#supComMess').bind('click', function() {
			companyManagement();
		});
	});
	var viewModel = new ViewModel('${action}', '${comNo}');
	ko.applyBindings(viewModel);
	function confirmChooseComgrp(comgrpNo, comgrpName, comgrpEnName) {
		viewModel.comgrpNo($.trim(comgrpNo));
		viewModel.comgrpName(comgrpName);
		closePopupWin();
	}
	if ('${action}' != null && '${action}' == 'update') {
		buildPage('${comNo}');
	}

	//加载信息
	function createNewPhotoList(id) {
		//加载遮罩层信息
		var ht = $(document).height();
		var wd = $(document).width();
		$("#addComLicnceImg").css({
			"height" : ht,
			"width" : wd,
			"display" : "block"
		});
		//$("#baseComImginfo").load("${ctx}/supplierLicenceAction/uploadComGroupLicence");
		$.post("${ctx}/supplierLicenceAction/uploadComGroupLicence", function(
				data) {
			$("#baseComImginfo").html(data);
		}, 'html');
		currentImgListId = id;//点击事件后，封装信息，用于查询指定的信息
	};

	//关闭事件(编辑图片窗口)
	$("#closeSupEditPic").unbind("click").bind("click", function() {
		//  关闭事件后，封装信息等等
		itemsCreatPic[currentImgListId] = itemsPhotos;
		$("#baseComImginfo").empty();//清空增加图片页面
		$("#addComLicnceImg").hide();//当前层隐藏	
	});

</script>
<style type="text/css">
.my-head-td-ck,.ck,.my-head-td-ck div,.ck div {
	display: none;
}

.t_div1,.t_div2 {
	width: 50%;
	height: 539px;
	float: left;
}

.t_div1_1 {
	height: 387px;
}

.t_div1_2 {
	height: 150px;
	margin-top: 2px;
}

.t_div2_1 {
	height: 120px;
}

.t_div2_2 {
	height: 417px;
	margin-top: 2px;
}

.t2_title {
	line-height: 25px;
}

.t2_title div {
	width: 70px;
	float: left;
	margin-left: 75px;
}
/*input对齐*/
.twoinput20 {
	width: 64.3%;
	width /*\**/: 62.5% \9;
	*width: 62.5%;
	float: left;
	margin-left: 3px;
}

.twoinput21 {
	width: 30%;
	float: left;
	margin-left: 3px;
}

.twoinput22 {
	width: 10%;
	float: left;
	background: #fff;
}

.twoinput23 {
	width: 25%;
	float: left;
	background: #fff;
}

.twoinput24 {
	width: 33%;
	width /*\**/: 33% \9;
	*width: 33.3%;
	float: left;
}

.twoinput25 {
	width: 14.5%;
	float: left;
	background: #fff;
}

.twoinput26 {
	width: 16%;
	float: left;
	background: #fff;
}

.twoinput27 {
	width: 25%;
	float: left;
	background: #fff;
}

.twoinput28 {
	width: 20%;
	width /*\**/: 20.5% \9;
	*width: 20%;
	float: left;
	background: #fff;
}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<!-- 在这里加入公司证件信息遮罩层 -->

<!-- 2.图片编辑遮罩层 -->
<div id="addComLicnceImg" class='picture_layer'>
	<div
		style='width: 1032px; height: 500px; background: #fff; overflow: hidden; margin: 60px auto; border: 2px solid #3f9673;'>
		<div class="zwindow_titleBar"
			style="height: 40px; position: relative;">
			<div class="zwindow_titleButtonBar">
				<div id="closeSupEditPic"
					class="zwindow_action_button zwindow_close"></div>
			</div>
			<div class="zwindow_title titleText">新增图片信息</div>
		</div>
		<div style="height: 460px; overflow-x: hidden; overflow: hidden;"
			id="baseComImginfo"></div>

	</div>
</div>




<div class="CTitle" id="baseComTitleInfo">
	<!--第一个-->
	<div id="first" class="tags1_left"></div>
	<div id="supComMess" class="tagsM">
		<auchan:i18n id="102004001"></auchan:i18n>
	</div>
	<div id="midden" class="tags"></div>
	<!--最后一个-->
	<div id="comOthAddrMess" class="tagsM">
		<auchan:i18n id="102006068"></auchan:i18n>
	</div>
	<!-- 订货退货地址 -->
	<div id="last" class="tags tags3 tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div id="createSupCom" class="tagsM_q  tagsM_on">
		<auchan:i18n id="102004036"></auchan:i18n>
	</div>
	<div id="createLast" class="tags3_close_on">
		<div id="closeDiv" class="tags_close"></div>
	</div>
</div>


<div class="Container-1">
	<div class="Content" style="width: 99%;" id="baseCominfo">
		<!--width:74%;-->
		<div class="CInfo hide">
			<c:if test="${action == 'update' }">
				<span data-bind="text:chngBy"></span>
				<span><auchan:i18n id="100002014"></auchan:i18n></span>
				<!-- 修改人 -->
				<span data-bind="text:chngDate"></span>
				<span><auchan:i18n id="100002015"></auchan:i18n></span>
				<!-- 修改日期 -->
			</c:if>
			<!-- 			<span data-bind="text:creatBy"></span>
			<span>建档人</span> -->
			<span data-bind="text:creatDate"></span> <span><auchan:i18n
					id="100002017"></auchan:i18n></span>
			<!-- 创建日期-->
		</div>
		<div class="line" style="width: 100%"></div>
		<div class="t_div1" style="width: 50%; height: 539px; float: left;">
			<div class="CM t_div1_1">
				<div class="CM-bar">
					<div>
						<auchan:i18n id="102004033"></auchan:i18n>
					</div>
				</div>
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td style="width: 25%;"><span>*<auchan:i18n
										id="102004002"></auchan:i18n></span></td>
							<td><input type="text" class="inputText twoInput1 Black "
								data-bind="value:comNo" id="createSupComNo" readonly="readonly" /></td>
						</tr>
						<tr>
							<td><span>*<auchan:i18n id="102004008"></auchan:i18n></span></td>
							<td><input type="text" class="inputText fl_left"
								style="width: 44%"
								data-bind="value:unifmNo,validationElement:unifmNo" /> <span
								style="float: left; margin-right: 1px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态</span>
								<auchan:select mdgroup="COMPANY_STATUS" _class="Black w30"
									dataBind="value:status" disabled="disabled"></auchan:select></td>
						</tr>
						<tr>
							<td><span>*<auchan:i18n id="102004003"></auchan:i18n></span></td>
							<td><input type="text" class="inputText w94"
								data-bind="value:comName,validationElement:comName" /></td>
						</tr>
						<tr>
							<td><span><auchan:i18n id="102004004"></auchan:i18n></span></td>
							<td><input type="text" class="inputText w94"
								data-bind="value:comEnName,validationElement:comEnName" /></td>
						</tr>
						<tr>
							<td><span><auchan:i18n id="102004006"></auchan:i18n></span></td>
							<td>
								<div class="iconPut" style="width: 28%; float: left;">
									<input type="text" style="width: 80%" id="comgrpNoSearch"
										data-bind="value:comgrpNo,validationElement:comgrpNo"
										onkeyup="value=this.value.replace(/\D+/g,'')" />
									<div class="ListWin" onclick="openSupComgrpWindow()"></div>
								</div> <input type="text" class="Black inputText twoinput20"
								data-bind="value:comgrpName" />
							</td>
						</tr>
						
						<tr>
							<td><span>*<auchan:i18n id="102004007"></auchan:i18n></span></td>
							<td><auchan:select mdgroup="COMPANY_ECON_TYPE"
									style="width: 42%; float: left;"
									dataBind="value:econType,validationElement:econType"></auchan:select>
								<span style="float: left; margin-right: 2px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<auchan:i18n
										id="102004010"></auchan:i18n></span> <input type="text"
								class="inputText twoinput21 w21"
								data-bind="value:legalRpstv,validationElement:legalRpstv" /></td>
						</tr>
						<tr>
							<td><span>*<auchan:i18n id="102004012"></auchan:i18n></span></td>
							<td><input type="text" class="inputText w94"
								data-bind="value:bizScopeDesc,validationElement:bizScopeDesc" />
							</td>
						</tr>
						<tr>
							<td><span>*<auchan:i18n id="102004013"></auchan:i18n></span></td>
							<td>
								<!-- 								<div class="iconPut" style="width: 28%;">
									<input type="text" class="w80" data-bind="value:setupDate,validationElement:setupDate" />
									<div class="C_Func Calendar"></div>
								</div> --> <!-- <div style="margin:1px 0;"></div><input data-bind="value:setupDate,validationElement:setupDate"  class="easyui-datebox" style="width:135px;height:24px;"/> -->
								<input data-bind="value:setupDate,validationElement:setupDate"
								class="Wdate" type="text"
								onClick="WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change')},isShowClear:false,readOnly:true})">
							</td>
						</tr>
						<tr>
							<td><span>*<auchan:i18n id="102004009"></auchan:i18n></span></td>
							<td>
								<div class="iconPut" style="width: 20%; float: left;">
									<input type="text" style="width: 72%;"
										data-bind="value:regProvName,validationElement:regProvName"
										readonly="readonly" />
									<div style="color: #999999;">
										<auchan:i18n id="102004038"></auchan:i18n>
									</div>
									<!-- 省 -->
								</div>
								<div class="iconPut"
									style="width: 30%; float: left; margin-left: 3px;">
									<input type="text" style="width: 62%;"
										data-bind="value:regCityName,validationElement:regCityName"
										readonly="readonly" />
									<div class="ListWin" onclick="openCityAndProvWindow();"></div>
									<div style="color: #999999;">
										<auchan:i18n id="102004039"></auchan:i18n>
									</div>
									<!-- 市 -->
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><input type="text" class="inputText w94"
								data-bind="value:regDetllAddr,validationElement:regDetllAddr" /></td>
						</tr>
						<tr>
							<td><span>*<auchan:i18n id="102004014"></auchan:i18n></span></td>
							<td><input type="text" class="inputText twoinput22"
								data-bind="value:regAreaCode,validationElement:regAreaCode" />
								<span style="float: left; margin: 0;">-</span> <input
								type="text" class="inputText twoinput23"
								data-bind="value:regPhoneNo,validationElement:regPhoneNo" /> <span
								style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<auchan:i18n
										id="102004015"></auchan:i18n></span> <input type="text"
								class="inputText twoinput24"
								data-bind="value:regEmailAddr,validationElement:regEmailAddr" />
							</td>
						</tr>
						<tr>
							<td><span>*<auchan:i18n id="102004016"></auchan:i18n></span></td>
							<td><input type="text" class="inputText w94"
								data-bind="value:webSite,validationElement:webSite" /></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="CM t_div1_2">
				<div class="CM-bar">
					<div>
						<auchan:i18n id="102004017"></auchan:i18n>
					</div>
				</div>
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td style="width: 25%;"><span>*<auchan:i18n
										id="102004017"></auchan:i18n></span></td>
							<td>
								<div class="iconPut" style="width: 20%; float: left;">
									<input type="text" style="width: 72%;"
										data-bind="value:dlvProvName,validationElement:dlvProvName"
										readonly="readonly" />
									<div style="color: #999999;">
										<auchan:i18n id="102004038"></auchan:i18n>
									</div>
									<!-- 省 -->
								</div>
								<div class="iconPut"
									style="width: 30%; float: left; margin-left: 3px;">
									<input type="text" style="width: 62%;"
										data-bind="value:dlvCityName,validationElement:dlvCityName"
										readonly="readonly" />
									<div class="ListWin" onclick="openCityAndProvWindowDlv();"></div>
									<div style="color: #999999;">
										<auchan:i18n id="102004039"></auchan:i18n>
									</div>
									<!-- 市 -->
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><input type="text" class="inputText w94"
								data-bind="value:dlvDetllAddr,validationElement:dlvDetllAddr" /></td>
						</tr>
						<tr>
							<td><span><auchan:i18n id="102004018"></auchan:i18n></span></td>
							<td><input type="text" class="inputText twoinput25"
								data-bind="value:dlvPostCode,validationElement:dlvPostCode" />
								<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<auchan:i18n
										id="102004019"></auchan:i18n>&nbsp;
							</span> <input type="text" class="inputText twoinput25"
								data-bind="value:dlvCntctName,validationElement:dlvCntctName" />
								<span style="float: left; margin: 0;">&nbsp;&nbsp;&nbsp;<auchan:i18n
										id="102004020"></auchan:i18n>&nbsp;
							</span> <input type="text" class="inputText twoinput22"
								data-bind="value:dlvAreaCode,validationElement:dlvAreaCode" />
								<span style="float: left; margin: 0;">-</span> <input
								type="text" class="inputText twoinput23"
								data-bind="value:dlvFaxNo,validationElement:dlvFaxNo" /></td>
						</tr>
						<tr>
							<td><span><auchan:i18n id="102004014"></auchan:i18n></span></td>
							<td><input type="text" class="inputText twoinput22"
								data-bind="value:dlvAreaCode,validationElement:dlvAreaCode" />
								<span style="float: left; margin: 0;">-</span> <input
								type="text" class="inputText twoinput26"
								data-bind="value:dlvPhoneNo,validationElement:dlvPhoneNo" /> <span
								style="float: left; margin: 0;">&nbsp;&nbsp;<auchan:i18n
										id="102004021"></auchan:i18n></span> <input type="text"
								class="inputText twoinput27"
								data-bind="value:dlvMoblNo,validationElement:dlvMoblNo" /> <span
								style="float: left; margin: 0;">&nbsp;&nbsp;<auchan:i18n
										id="102004015"></auchan:i18n></span> <input type="text"
								class="inputText twoinput28"
								data-bind="value:dlvEmailAddr,validationElement:dlvEmailAddr" /></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class="t_div2">
			<div class="CM t_div2_1" style="height: 120px;">
				<div class="CM-bar">
					<div>
						<auchan:i18n id="102004034"></auchan:i18n>
					</div>
				</div>
				<div class="CM-div">
					<table class="CM_table">
						<tr>
							<td style="width: 25%;"><span><auchan:i18n
										id="102004025"></auchan:i18n></span></td>
							<td><input type="text" class="inputText w50"
								data-bind="value:lawNote,validationElement:lawNote" /></td>
						</tr>
						<tr>
							<td><span><auchan:i18n id="102004026"></auchan:i18n></span></td>
							<td><input type="text" class="inputText w50"
								data-bind="value:debtNote,validationElement:debtNote" /></td>
						</tr>
						<tr>
							<td><span><auchan:i18n id="102004027"></auchan:i18n></span></td>
							<td><input type="text" class="inputText w50"
								data-bind="value:credtNote,validationElement:credtNote" /></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="CM t_div2_2">
				<div class="CM-bar">
					<div>
						<auchan:i18n id="102004035"></auchan:i18n>
					</div>
				</div>
				<div class="CM-div">
					<table class="CM_table" style="width: 470px; margin-left: 10px;">
						<tr>
							<td style="height: 370px;">
								<div
									style="height: 100%; width: 450px; overflow-x: auto; overflow-y: auto;">
									<table style="width: 880px;">
										<tr>
											<td style="width: 30px;">&nbsp;</td>
											<td style="width: 40px;">&nbsp;</td>
											<td style="width: 180px;"><auchan:i18n id="102004028"></auchan:i18n></td>
											<td style="width: 180px;"><auchan:i18n id="102004029"></auchan:i18n></td>
											<td style="width: 150px;"><auchan:i18n id="102004031"></auchan:i18n></td>
											<td style="width: 150px;"><auchan:i18n id="102004030"></auchan:i18n></td>
											<td style="width: 150px;"><auchan:i18n id="102004032"></auchan:i18n></td>
										</tr>
										<tr>
											<td class="line" colspan="7"></td>
										</tr>
										<tbody data-bind="foreach: comLicencesList">
											<tr>
												<td><input type="checkbox"
													data-bind="checked:isChecked" name="licChecked" /> <!-- <input type="text" data-bind="value:licnceId" hidden="true"/> -->
												</td>

												<td><div
														style="height: 20px; width: 20px; border: 1px solid #999999;"
														class="license1" name='comlicencePic'
														data-bind="event:{click:click},attr:{id:id}"></div></td>
												<td><auchan:select mdgroup="COM_LICENCE_LICNCE_TYPE"
														style="width: 90%;"
														dataBind="value:licnceType,validationElement:licnceType"></auchan:select>
												</td>
												<td><input type="text" style="width: 90%;"
													class="inputText"
													data-bind="value:licnceNo,validationElement:licnceNo" /></td>
												<td><input
													data-bind="value:validStartDate,validationElement:validStartDate"
													class="Wdate" type="text"
													onClick="WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change')},isShowClear:false,readOnly:true})">
												</td>
												<td><input
													data-bind="value:validEndDate,validationElement:validEndDate"
													class="Wdate" type="text"
													onClick="WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change')},isShowClear:false,readOnly:true})">
												</td>
												<td><input type="text" style="width: 90%;"
													class="inputText"
													data-bind="value:issueBy,validationElement:issueBy" /></td>
											</tr>
										</tbody>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td class="line"></td>
						</tr>
						<tr>
							<td><input type="checkbox" style="float: left;"
								data-bind="checked:allChecked" id="allCheck" />
								<div class="Icon-size2 Tools10 fl_left"
									style="margin-left: 10px;"
									data-bind='event:{click:$root.removeLicFun}'></div>
								<div class="Line-1 Icon-size2 fl_left"></div>
								<div class="Tools11 Icon-size2 fl_left"
									data-bind='event:{click:$root.addLicFun}'></div></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
