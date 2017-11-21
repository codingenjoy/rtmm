<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<html> 
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" rel="Stylesheet" />
<%-- <link type="text/css" href="${ctx}/shared/themes/${theme}/css/welcome.css" rel="Stylesheet" /> --%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/common.js" type="text/javascript"></script>
<%@ include file="/page/commons/loadding.jsp"%>
<%@ include file="/page/commons/jquery-alerts.jsp"%>
<%@ include file="/page/commons/datepick.jsp"%>
<%@ include file="/page/commons/knockout.jsp" %>
<%@ include file="/page/commons/zWindow.jsp"%>
<script src="${ctx}/shared/js/parameter/staff.js" type="text/javascript"></script>
<script type="text/javascript">
	var staffId = '${staffId}';
	var viewModel = new ViewModel();
	function saveStaffForm() {
		viewModel.save();
	}

	$(function() {
		buildStaffPage(staffId);
		
		// 點兩下進入的瀏覽介面沒有編輯功能
		if ('${action}'== 'view'){
			ko.bindingHandlers['readonly'] = {
					init: function (element, valueAccessor ){
						element.readOnly = true;
					}
			};
			$('select').attr('disabled','disabled');
			$('.Panel_footer').remove();
			$('#addJobFun').remove();
			$('#removeExtraJob').remove();
		}
		
		ko.applyBindings(viewModel);
	});
</script>
<style>
body {
	background: #f9f9f9;
}

.outer {
	width: 100%;
	height: 400px;
	overflow-y: scroll;
	margin-top: 10px;
}

.Panel_footer {
	width: 1031px;
}

.PanelBtn {
	display: table;
}

</style>
</head>
<body>
	<div class="outer">
		<table class="CM_table CM w100" style="margin-top: 0px;">
			<tr>
				<td class="w10">
					<span>*用户名</span>
				</td>
				<td>
					<select class="w20 fl_left" data-bind="value:userNamePrefix,event:{blur:$root.userNamePrefixBlur},attr:{'disabled':isEdit()}">
						<option value="">请选择</option>
						<option value="E">Auchan中国员工(E)</option>
						<option value="V">外部Partner(V)</option>
						<option value="T">台湾大润发(T)</option>
						<option value="R">中国大润发(R)</option>
					</select>
					&nbsp;&nbsp;
					<input maxlength="11" type="text" class="inputText username"
						data-bind="value:userName,validationElement:userName,event:{blur:$root.userNameBlur},attr:{'disabled':isEdit()}" />
					<font color="red" data-bind="validationMessage:userName">&nbsp;</font>
				</td>
			</tr>
			<tr>
				<td>
					<span>*姓名</span>
				</td>
				<td>
					<input type="text" maxlength="20" class="inputText w20" data-bind="value:fullName,validationElement:fullName,readonly:readonly" />
				</td>
			</tr>
			<tr>
				<td>
					<span>英文姓名</span>
				</td>
				<td>
					<input type="text" maxlength="20" class="inputText w20" data-bind="value:englishName,readonly:readonly" />
				</td>
			</tr>
			<tr data-bind="style:{display:isEdit()==true?'none':''}">
				<td>
					<span>*创建初始密码</span>
				</td>
				<td>
					<input type="text" class="inputText w20" data-bind="value:initial" readonly="readonly" />
					（默认值为工号后六位）
				</td>
			</tr>
			<tr>
				<td>
					<span>用户状态</span>
				</td>
				<td>
					<select class="w15 fl_left" data-bind="value:status,validationElement:status">
						<option value="1">1- 正常</option>
						<option value="0">0- 无效</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<span>邮箱</span>
				</td>
				<td>
					<input class="inputText w20" data-bind="value:email,validationElement:email,readonly:readonly" />
				</td>
			</tr>
			<tr data-bind="style: {display:$root.showValidate()?'':'none'}">

				<td>
					<span>*有效期至</span>
				</td>
				<td>
					<input data-bind="value:validDate,validationElement:validDate" class="Wdate" type="text"
						onclick="
						<c:if test="${action !='view' }">
						WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change');},isShowClear:false,readOnly:true})
						</c:if>">


					<c:if test="${action !='view' }">
						<%--
				WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change');},isShowClear:false,readOnly:true})
				--%>
					</c:if>
					<!-- 						<div class="fl_left w70">
							&nbsp;&nbsp;邮箱&nbsp;<input class="inputText w25" data-bind="value:email" />
						</div> -->
				</td>
			</tr>
			<tr>
				<td>
					<span>基本职位</span>
				</td>
				<td rowspan="2">
					<table class="CM_table w95">
						<tr style="text-align: center; border-bottom: 1px solid #cccccc;">
							<td style="width: 3%"></td>
							<td style="width: 19%">*店号</td>
							<td style="width: 19%">*部门</td>
							<td style="width: 19%">*职位</td>
							<td style="width: 12%;">&nbsp;</td>
							<td style="width: 12%;">&nbsp;</td>
						</tr>
						<tbody data-bind="foreach: mainJobFunList">
							<tr>
								<td></td>
								<td>
									<select data-bind="value:storeNo,validationElement:storeNo,event:{change:$root.listUserJobFun,change:clearMainDeptJob}" class="w95">
										<option value="">请选择</option>
										<c:forEach items="${stores}" var="store">
											<option value="${store.storeNo}">${store.storeName}</option>
										</c:forEach>
									</select>
								</td>
								<td>
									<div class="iconPut w95"
										data-bind="
									<c:if test="${action !='view' }">
									event:{click:chooseDept,change:clearMainJob}
									</c:if>">
										<input class="w85" type="hidden" data-bind="value:deptId" readonly="readonly" />
										<input class="w85" type="text" data-bind="value:deptName,validationElement:deptName" readonly="readonly" />
										<div class="ListWin"></div>
									</div>
								</td>
								<td>
									<div class="iconPut w95" data-bind="
								<c:if test="${action !='view' }">
								event:{click:chooseJobFun}
								</c:if>">
										<input class="w85" type="hidden" data-bind="value:jobId" />
										<input class="w85" type="text" data-bind="value:jobName,validationElement:jobName" readonly="readonly" />
										<div class="ListWin"></div>
									</div>
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<font color="red" id="mainJobFunMsg">&nbsp;</font>
				</td>
			</tr>
			<tr data-bind='visible: extJobFunList().length > 0'>
				<td valign="top">
					<span>额外职位</span>
				</td>
				<td rowspan="2">
					<table class="CM_table w95">
						<tr style="text-align: center; border-bottom: 1px solid #cccccc;">
							<td style="width: 3%"></td>
							<td style="width: 19%">*店号</td>
							<td style="width: 19%">*部门</td>
							<td style="width: 19%">*职位</td>
							<td style="width: 12%">*生效日期</td>
							<td style="width: 12%">*失效日期</td>
						</tr>
						<tbody data-bind="foreach: extJobFunList">
							<tr>
								<td>
									<div id="removeExtraJob" class="Icon-size2 Tools10 fl_left" data-bind='event:{click:$root.removeJobFun}'></div>
								</td>
								<td>
									<select data-bind="value:storeNo,validationElement:storeNo,event:{change:$root.listUserJobFun,change:clearExtAfterStoreMsg}" class="w95">
										<option value="">请选择</option>
										<c:forEach items="${stores}" var="store">
											<option value="${store.storeNo}">${store.storeName}</option>
										</c:forEach>
									</select>
								</td>
								<td>
									<div class="iconPut w95"
										data-bind="
									<c:if test="${action !='view' }">
									event:{click:chooseDept,change:clearExtAfterDeptMsg}
									</c:if>">
										<input class="w85" type="hidden" data-bind="value:deptId" readonly="readonly" />
										<input class="w85" type="text" data-bind="value:deptName,validationElement:deptName" readonly="readonly" />
										<div class="ListWin"></div>
									</div>
								</td>
								<td>
									<div class="iconPut w95"
										data-bind="
									<c:if test="${action !='view' }">event:{click:chooseJobFun,change:clearExtAfterJobMsg}
								</c:if>">
										<input class="w85" type="hidden" data-bind="value:jobId" />
										<input class="w85" type="text" data-bind="value:jobName,validationElement:jobName" readonly="readonly" />
										<div class="ListWin"></div>
									</div>
								</td>
								<td>
									<input data-bind="value:vaildFrom,validationElement:vaildFrom" class="Wdate" type="text" readonly="readonly"
										onclick="
								<c:if test="${action !='view' }">
								WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change');},isShowClear:false,readOnly:true})
								</c:if>">
								</td>
								<td>
									<input data-bind="value:vaildUntil,validationElement:vaildUntil" class="Wdate" type="text" readonly="readonly"
										onclick="
								<c:if test="${action !='view' }">
								WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change');},isShowClear:false,readOnly:true})
								</c:if>">
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td rowspan="2">
					<table class="CM_table w95">
						<tr style="text-align: center; border-bottom: 1px solid #cccccc;">
							<td style="width: 3%"></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<!--  
								<td>
									<input type="checkbox" />
								</td>
								-->
							<td>
								<!-- <div class="Icon-size2 Tools10_disable fl_left" data-bind='event:{click:

$root.removeJobFun}'></div>
									<div class="Line-1 Icon-size2 fl_left"></div> -->
								<div id="addJobFun" class="Tools11 Icon-size2 fl_left" data-bind='event:{click:$root.addJobFun}'></div>
							</td>
						</tr>
					</table>

				</td>
			</tr>
			<tr>
				<td></td>
			</tr>
		</table>
	</div>
	<div class="Panel_footer">

		<span class="PanelBtn1" onclick="saveStaffForm()">确定</span>
		<span class="PanelBtn2" onclick="cancel()">取消</span>

	</div>
	<div style="clear: both;"></div>
</body>
</html>