<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ include file="/page/commons/knockout.jsp"%>
<style type="text/css">
         .t_div1,.t_div2 {
            width:50%;height:539px;float:left;
        }
        
        .t_div1_1 {
            height:360px;
        }
        .t_div1_2 {
            height:177px;margin-top:2px;
        }
        /*.t_div2_1 {
            height:120px;
        }*/
        .t_div2_2 {
            height:539px;margin-top:2px;
        }
        .t2_title {
            line-height:25px;
        }
        .t2_title div {
            width:70px;float:left;margin-left:75px;
        }
        .com1 {
            height:100%;overflow-x:hidden;overflow-y:scroll;
        }
        .com1_tb {
            width:100%;height:55px;
        }
        .com_lis {
            height:20px;width:20px;border:1px dashed #999999;
        }
        .icondiv11 {
            width:20%;float:left;background:#cccccc;color:#999999;
        }
            .icondiv11 input {
                width:72%;
                background:#cccccc;
            }
        .icondiv12 {
            width:28%;float:left; margin-left:3px;background:#cccccc;color:#999999;
        }
            .icondiv12 input {
                width:82%;
                background:#cccccc;
            }
            .w91_s232 {
            width:91%;width/*\**/:92%\9;*width:92%;background:#cccccc;
        }

        .icondiv11_2 {
            width:20%;float:left;color:#999999;
        }
            .icondiv11_2 input {
                width:72%;
            }
        .icondiv12_2 {
            width:28%;float:left; margin-left:3px;color:#999999;
        }
            .icondiv12_2 input {
                width:82%;
            }
            .w91_s232_2 {
            width:91%;width/*\**/:92%\9;*width:92%;
        }
</style>
<script type="text/javascript">
	var viewModel = new ViewModel();
	ko.applyBindings(viewModel);
	var temporaryTr = null;
	$(function(){
		temporaryTr = $("#addTableName tr:last");
	});

	//添加行数
	function addTr(){
		var newTr = null;
		var oldTr = $("#addTableName tr:last");
		if (oldTr.length < 1) {
			newTr =$(temporaryTr).clone();
			temporaryTr.after(newTr);
		} else {
        	newTr =$(oldTr).clone();
	        oldTr.after(newTr);
		}
	}

	//删除所选中的行数
	function deleteTr(){
		var addTableName = $("#addTableName tr");
		$.each(addTableName,function(i,val){
			var checkedValue = $($(addTableName[i]).find('input')[0]).attr('checked');
			if (checkedValue == "checked") {
				addTableName[i].remove();
			} else {
				return;
			}
		});
		$("#selectAllId").attr('checked',null);
	}

	//选择所有checkbox
	function selectAll(){
		var addTableName = $("#addTableName tr");
		var selectAllId = $("#selectAllId").attr('checked');
		$.each(addTableName,function(i,val){
			if (selectAllId == "checked") {
				$($(addTableName[i]).find('input')[0]).attr('checked','checked');
			} else {
				$($(addTableName[i]).find('input')[0]).attr('checked',null);				
				}
		});
	}
</script>
<div class="Container-1">
	<div class="Content" style="width: 99%;">
		<!--width:74%;-->
		<div class="CInfo">
			<span>项</span>
			<span>10，000</span>
			<span>/</span>
			<span>1</span>
			<span>第</span>
			<span>|</span>
			<span>张三</span>
			<span>修改人</span>
			<span>2014-03-03</span>
			<span>修改日期</span>
			<span>李四</span>
			<span>建档人</span>
			<span>2014-02-02</span>
			<span>创建日期</span>
		</div>
		<div class="line" style="width: 100%"></div>
		<form id="baseMessageForm">
		<div class="t_div1" style="width: 50%; height: 539px; float: left;">
			<div class="CM t_div1_1">
				<div class="CM-bar">
					<div>
						基本信息
					</div>
				</div>
					<table class="CM_table">
						<tr>
							<td style="width: 25%;">
								<span>*公司编号</span>
							</td>
							<td>
								<input id="firmNumber" name="compNo" data-bind="value:viewModel.compNo" type="text" class="inputText twoInput1" value="" />
							</td>
						</tr>
						<tr>
							<td>
								<span>*公司名称</span>
							</td>
							<td>
								<input id="firmName" name="compName" data-bind="value:viewModel.compName" type="text" class="inputText" style="width: 50%" />
							</td>
						</tr>
						<tr>
							<td>
								<span>公司英文名</span>
							</td>
							<td>
								<input id="firmEnglishName" name="compNameEn" data-bind="value:viewModel.compNameEn" type="text" class="inputText" style="width: 50%" />
							</td>
						</tr>
						<tr>
							<td>
								<span>*公司类型</span>
							</td>
							<td>
								<select id="firmType" name="firmType" data-bind="options: companyType, optionsCaption: '请选择', optionsText: 'name', value:viewModel.firmType" style="width: 28%; float: left;">
								</select>
								<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;状态</span>
								<select id="condition" name="status" data-bind="options: statusSelect, optionsCaption: '请选择', optionsText: 'name', value:viewModel.status" style="width: 28%; float: left;">
								</select>
							</td>
						</tr>


						<tr>
							<td>
								<span>法人代表</span>
							</td>
							<td>
								<input id="corporative" name="legalRepr" data-bind="value:viewModel.legalRepr" type="text" class="inputText" style="width: 40%" />
							</td>
						</tr>

						<tr>
							<td>
								<span>*经营范围</span>
							</td>
							<td>
								<input id="prosecution" name="prosecution" data-bind="value:viewModel.prosecution" type="text" class="inputText" style="width: 50%" />
							</td>
						</tr>
						<tr>
							<td>
								<span>*成立日期</span>
							</td>
							<td>
<!-- 							<div class="iconPut" style="width: 28%;">
									<input id="establishDate" name="setupDateBegin" data-bind="value:viewModel.setupDateBegin" type="text" class="w80" />
									<div class="C_Func Calendar"></div>
								</div> -->
								<div style="margin:1px 0;"></div><input id="establishDate" name="setupDateBegin" data-bind="value:viewModel.setupDateBegin"  class="easyui-datebox" style="width:135px;"/>
							</td>
						</tr>
						<tr>
							<td style="width: 20%;">
								<span>*公司注册地址</span>
							</td>
							<td>
                                        <div class="iconPut" style="width:20%;float:left;">
                                        	<input type="text" style="width:72%;"/>
                                            <div style="color:#999999;">省</div></div>
                                        <div class="iconPut" style="width:28%;float:left; margin-left:3px;">
                                            <input type="text" style="width:62%;"/>
                                            <div style="color:#999999;">市</div><div class="ListWin"></div></div>
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<input id="address1" name="address1" data-bind="value:viewModel.address1" type="text" class="inputText w91_s232_2" />
							</td>
						</tr>
						<tr>
							<td>
								<span>*电话号码</span>
							</td>
							<td>
								<input type="text" class="inputText twoInput1" 
									style="width: 10%" 
									maxlength="4"
									onkeypress="if(event.keyCode < 48 || event.keyCode >57) event.returnValue = false;" />
								<span style="float: left; margin: 0;">-</span>
								<input type="text" class="inputText twoInput1" maxlength="8" onkeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"/>
								<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电子邮箱</span>
								<input id="email" name="email" data-bind="value:viewModel.email" type="text" class="Black inputText twoInput2" />
							</td>
						</tr>
						<tr>
							<td>
								<span>*网址</span>
							</td>
							<td>
								<input id="internetSite" name="website" data-bind="value:viewModel.website" type="text" class="inputText" style="width: 40%" />
							</td>
						</tr>
					</table>
			</div>


			<div class="CM t_div1_2">
				<div class="CM-bar">
					<div>
						发票送达地址
					</div>
				</div>
					<table class="CM_table">
						<tr>
							<td style="width: 25%;">
								<span>*发票送达地址</span>
							</td>
							<td>
                                        <div class="iconPut" style="width:20%;float:left;"><input type="text" style="width:72%;"/>
                                            <div style="color:#999999;">省</div></div>
                                        <div class="iconPut" style="width:28%;float:left; margin-left:3px;">
                                            <input type="text" style="width:62%;"/><div style="color:#999999;">市</div><div class="ListWin"></div></div>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
							<td>
								<input id="address" name="address" data-bind="value:viewModel.address" type="text" class="inputText w91_s232_2" />
							</td>
						</tr>
						<tr>
							<td>
								<span>邮政编码</span>
							</td>
							<td>
								<input id="postalNumber" name="postCode" data-bind="value:viewModel.postCode" type="text" class="inputText twoInput1" />
								<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<!-- 联系人 --><auchan:i18n id="102006016"/></span>
								<input id="contactPeople" name="contactPeople" data-bind="value:viewModel.contactPeople" type="text" class="Black inputText twoInput2" />
							</td>
						</tr>
						<tr>
							<td>
								<span>电话号码</span>
							</td>
							<td>
								<input type="text" class="inputText twoInput1" 
									name="areaCode"
									data-bind="value:viewModel.areaCode" 
									style="width: 10%" 
									maxlength="4"
									onkeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;" />
								<span style="float: left; margin: 0;">-</span>
								<input type="text" name="phoneNo1" data-bind="value:viewModel.phoneNo1" class="inputText twoInput1" maxlength="8" onkeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"/>
								<span style="float: left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;移动电话</span>
								<input id="mobileNumber" name="phoneNo2" data-bind="value:viewModel.phoneNo2" type="text" class="Black inputText twoInput2" maxlength="11" onkeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;"/>
							</td>
						</tr>
						<tr>
							<td>
								<span>传真号码</span>
							</td>
							<td>
								<input type="text" name="faxNo1" data-bind="value:viewModel.faxNo1" class="inputText twoInput1" style="width: 10%" maxlength="4"
									onkeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;" />
								<span style="float: left; margin: 0;">-</span>
								<input type="text" name="faxNo2" data-bind="value:viewModel.faxNo2" class="inputText twoInput1" maxlength="8"
									onkeypress="if (event.keyCode < 48 || event.keyCode > 57) event.returnValue = false;" />
							</td>
						</tr>
					</table>
			</div>

		</div>
		<div class="t_div2">

			<div class="CM t_div2_2">
				<div class="CM-bar">
					<div>
						公司证件
					</div>
				</div>
					<table class="CM_table" style="width: 92%; margin-left: 10px;">
						<tr>
							<td>
								<div class="t2_title">
									<div>
										证件类型
									</div>
									<div>
										证件号
									</div>
									<div>
										截止日期
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td class="line"></td>
						</tr>
							<tr>
								<td style="height: 460px;">
									<div class="com1">
										<table id="addTableName" class="com1_tb">
											<tbody data-bild="foreach: credentials" >
												<tr>
													<td style="width: 5%;">
														<input name="checkboxName" type="checkbox" data-bild=""/>
													</td>
													<td style="width: 7%;">
														<div class="com_lis"></div>
													</td>
													<!--class="license1"-->
													<td style="width: 28%;">
														<select id="certificateType" name="certificateType" data-bild="options: credentialsName,optionCaption: '身份证',value: chosencredentialsNo" class="w90">
															<option></option>
														</select>
													</td>
													<td style="width: 35%;">
														<input id="certificateNum" name="certificateNum" data-bild="value: credentialsNo" type="text" class="inputText w90" />
													</td>
													<td style="width: 25%;">
														<div class="iconPut w80">
															<input id="deadline" name="deadline" data-bild="value: asOfData" type="text" style="width: 79%" />
															<div class="C_Func Calendar"></div>
														</div>
													</td>
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
							<td>
								<input id="selectAllId" type="checkbox" style="float: left;" onclick="selectAll()" />
								<div style="height: 21px; width: 16px; float: left; margin-left: 10px;" class="Tools10" onclick="deleteTr()"></div>
								<div style="height: 21px; width: 16px; float: left;" class="Line-1"></div>
								<div style="height: 21px; width: 16px; float: left;" class="Tools11" data-bild="click:viewModel.addTr"></div>
							</td>
						</tr>
					</table>
			</div>
		</div>
		</form>
	</div>
</div>
