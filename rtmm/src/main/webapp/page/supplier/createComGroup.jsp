<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel1 {
	height: 70px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">
function ViewModel() {
	this.action = ko.observable("${action}");
	this.comgrpNo = ko.observable("${comgrp.comgrpNo}");
	this.comgrpName = ko.observable("${comgrp.comgrpName}").extend({
		required : {
			params : true,
			message : "请设置集团名称"
		},
		maxLength: { params: 10, message: "集团名称最大长度为20个字符或10个汉字" },
	});
	this.comgrpEnName = ko.observable("${comgrp.comgrpEnName}").extend({
		maxLength: { params: 20, message: "集团英文名称最大长度为20个字符"}
	});
	this.save = function(form, event) {
		// 验证表单
 		viewModel.errors = ko.validation.group(viewModel);
		if (!viewModel.isValid()) {
			viewModel.errors.showAllMessages();
			return;
		} 
		// 提交表单
		$.ajax({
			type : "post",
			async : false,
			url : ctx + '/supplier/group/saveComGrp',
			dataType : "json",
			data : {
				'action' : viewModel.action(),
				'comgrpNo' : viewModel.comgrpNo(),
				'comgrpName' : viewModel.comgrpName(),
				'comgrpEnName' : viewModel.comgrpEnName(),
			},
			success : function(mark){
				if (mark== true) {
					top.jAlert('success', window.v_operationSuc,window.v_messages);
					if(viewModel.action() == 'update'){
						//$('#'+viewModel.comgrpNo()).addClass('btable_checked');
						$($('.btable_checked > td').get(1)).text(viewModel.comgrpName());
						$($('.btable_checked > td').get(2)).text(viewModel.comgrpEnName());
					}else{
						pageQuery();
					}
/*                     var dg = $('#dg');
                    var row = dg.datagrid('getSelected');
                    if (row){
                        var index = dg.datagrid('getRowIndex', row);
                        dg.datagrid('updateRow',{
                            index:index,
                            row:{comgrpName:viewModel.comgrpName(),comgrpEnName:viewModel.comgrpEnName()}
                        });
                            //修改当前行被选中
                        dg.datagrid('selectRow',index);
                    } */
				} else {
					top.jAlert('error', window.v_operationFail,window.v_messages);
				}
				closePopupWin();
				//comGrpSearch();
			}
		});
	};
}
function saveComgrp(){
	viewModel.save();
}
var viewModel = new ViewModel();
ko.applyBindings(viewModel);

// 根據action 的種類調整標題
if ('${action}' == "update"){
	$('.Panel_top > span').text("修改集团");
}
</script>
<div class="Panel_top">
	<span><auchan:i18n id="102001005"></auchan:i18n></span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel1">
	<table class="CM_table">
		<tr>
			<td class="w20">
				<span>*<auchan:i18n id="102001003"></auchan:i18n></span>
			</td>
			<td>
				<input data-bind="value: comgrpName,validationElement:comgrpName"  type="text" class="inputText w80"  /> <font id="codeFont" color="red">&nbsp;</font>
			</td>
		</tr>
		<tr>
			<td>
				<span><auchan:i18n id="102001004"></auchan:i18n> </span>
			</td>
			<td>
				<input data-bind="value: comgrpEnName,validationElement:comgrpEnName" name="comgrpEnName" type="text" class="inputText w80"/> <font id="nameFont" color="red">&nbsp;</font>
			</td>
		</tr>
	</table>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="saveComgrp()"><auchan:i18n id="100000004"></auchan:i18n></div>
		<div class="PanelBtn2" onclick="closePopupWin()"><auchan:i18n id="100000003"></auchan:i18n></div>
	</div>
</div>