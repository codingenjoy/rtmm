<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel1 {
	height: 200px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">
	function ViewModel(parntCatlgId, catlgId,catlgNo,catlgName, catlgEnName, foodNonfood,ordDelAllowInd,status,action) {
		var self = this;
		self.parntCatlgId = ko.observable(parntCatlgId).extend({
			required : {
				params : true,
				message : "请输入处别"
			}
		});;
		self.catlgId = ko.observable(catlgId);
		self.catlgNo = ko.observable(catlgNo).extend({
			required : {
				params : true,
				message : "请输入课别"
			}
		});
		self.catlgName = ko.observable(catlgName).extend({
			required : {
				params : true,
				message : "请输入中文名称"
			}
		});
		self.catlgEnName = ko.observable(catlgEnName).extend({
			required : {
				params : true,
				message : "请输入英文名称"
			}
		});
		self.foodNonfood = ko.observable(foodNonfood||'1');
		self.ordDelAllowInd = ko.observable(ordDelAllowInd||'1');
		self.status = ko.observable(status||'1');
		self.action = ko.observable(action);
		self.isEdit = function() {
			
			if (self.action() == 'update' ) {
				return true;
			}
			else{
				return false;
			}
		};
		self.save = function(form, event) {
			
			// 验证表单
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages();
				return;
			}
			var actionUrl = '';
			if(self.action() == 'create'){
				actionUrl = '/catalog/doCreateSection';
			}else{
				actionUrl = '/catalog/doUpdateSection';
			}
			
			$('input[name="foodNonfood"]').attr('value',viewModel.foodNonfood());
			$('input[name="status"]').attr('value',viewModel.status());
			var sectionForm = $('#sectionForm').serialize();
			$.ajax({
				type : 'post',
				url : ctx + actionUrl,
				data : sectionForm,
				success : function(data) {
					if(data.status=='success'){
						top.jSuccessAlert(window.v_operationSuc,window.v_messages);
						closePopupWin();
						pageQuery();
					}else{
						top.jErrorAlert(window.v_operationFail,window.v_messages);
					}
					
				}
			});
		};
	}
	var viewModel = new ViewModel('${sectionInfoVO.parntCatlgId}','${sectionInfoVO.catlgId}','${sectionInfoVO.catlgNo}',
			'${sectionInfoVO.catlgName}','${sectionInfoVO.catlgEnName}','${sectionInfoVO.foodNonfood}',
			'${sectionInfoVO.ordDeletEnbldInd}','${sectionInfoVO.status}','${action}');
	ko.applyBindings(viewModel, document.getElementById('sectionForm'));
	
</script>
<div class="Panel_top">
	<span>
		<c:choose>
			<c:when test="${action =='create'}">
				创建课别信息
			</c:when>
			<c:otherwise>
				<auchan:i18n id="101005012"></auchan:i18n>
			</c:otherwise>
		</c:choose>
	</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel1">
	<form id="sectionForm" >
		<table class="CM_table">
			<tr>
				<td><span>*&nbsp;<auchan:i18n id="101006006"></auchan:i18n></span></td>
				<td>
					<select id="divisionCode" name="parntCatlgId" title="请选择处别" class="w25" 
					data-bind="value:parntCatlgId,validationElement:parntCatlgId,attr:{'disabled':isEdit()},css:{ Black: isEdit()}">
						<option value=''>请选择</option>
						<c:forEach items="${divisionList}" var="division">
							<option value="${division.id}">${division.code}-${division.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<span>*&nbsp;<auchan:i18n id="101006007"></auchan:i18n></span>
				</td>
				<td>
					<input name="catlgId" type="hidden" data-bind="value:catlgId">
					<input name="catlgNo" type="text" class="inputText w25" title="数字格式" maxlength="6" 
					data-bind="value:catlgNo,validationElement:catlgNo,attr:{'readonly':isEdit()},css: { Black: isEdit()}" />
				</td>
			</tr>
			<tr>
				<td>
					<span>*&nbsp;<auchan:i18n id="101004004"></auchan:i18n></span>
				</td>
				<td>
					<input name="catlgName" type="text" title="请输入中文名称" class="inputText w35" 
					data-bind="value:catlgName,validationElement:catlgName,css: { Black: isEdit()}"/>
				</td>
			</tr>
			<tr>
				<td>
					<span>*&nbsp;<auchan:i18n id="101004005"></auchan:i18n></span>
				</td>
				<td>
					<input name="catlgEnName" type="text" title="请输入英文名称" class="inputText w55" 
					data-bind="value:catlgEnName,validationElement:catlgEnName,css: { Black: isEdit()}"/>
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101004008"></auchan:i18n></span>
				</td>
				<td>
					<auchan:select  dataBind="value:foodNonfood,attr:{'disabled':isEdit()},css: { Black: isEdit()}" mdgroup="CL_SEC_CTRL_FOOD_NONFOOD" _class="w35 Black"></auchan:select>
					<input type="hidden" name="foodNonfood">
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101004009"></auchan:i18n></span>
				</td>
				<td>
					<select name="ordDelAllowInd" class="w25" data-bind="value:ordDelAllowInd">
						<option value="1">1- 可</option>
						<option value="0">0- 否</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101004010"></auchan:i18n></span>
				</td>
				<td>
					<auchan:select dataBind="value: status,attr:{'disabled':isEdit()}" mdgroup="CL_CATALOG_STATUS" _class="w35 Black" ignoreValue="0,9"></auchan:select>
					<input type="hidden" name="status">
				</td>
			</tr>
		</table>
	</form>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="viewModel.save()"><auchan:i18n id="100000004"></auchan:i18n></div>
		<div class="PanelBtn2" onclick="closePopupWin()"><auchan:i18n id="100000003"></auchan:i18n></div>
	</div>
</div>
