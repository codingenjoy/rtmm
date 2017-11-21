<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/supplier/othrAddr.js" charset="gbk" type="text/javascript"></script>
<style type="text/css">
    .Table_Panel {
        height:350px;
        overflow:hidden;
    }
    .Table_Panel td{
        height:30px;
    }
</style>
<script type="text/javascript">
function ViewModel() {
	var self = this;
	self.action = ko.observable('${action}');
	self.addrId = ko.observable('${comOthAddressVO.addrId}');
	self.comNo = ko.observable('${comOthAddressVO.comNo}');
	self.addrType = ko.observable('${comOthAddressVO.addrType}').extend({
		required : {
			params : true,
			message : "请设置地址类型"
		}
	});
	self.provName = ko.observable('${comOthAddressVO.provName}').extend({
		required : {
			params : true,
			message : "请设置省份"
		},
		maxLength: { params: 20, message: "省份最大长度为20个字符"},
	});
	self.cityName = ko.observable('${comOthAddressVO.cityName}').extend({
		required : {
			params : true,
			message : "请设置城市"
		},
		maxLength: { params: 20, message: "城市最大长度为20个字符"},
	});
	self.detllAddr = ko.observable('${comOthAddressVO.detllAddr}').extend({
		required : {
			params : true,
			message : "请设置地址"
		},
		maxLength: { params: 60, message: "地址最大长度为60个字符"},
	});
	self.cntctName = ko.observable('${comOthAddressVO.cntctName}').extend({
/* 		required : {
			params : true,
			message : "请设置联系人"
		}, */
		maxLength: { params: 30, message: "联系人最大长度为30个字符"},
	});
	self.postCode = ko.observable('${comOthAddressVO.postCode}').extend({
/* 		required : {
			params : true,
			message : "请设置邮编"
		}, */
		number : {
			params : true,
			message : "请输入数字"
		},
		maxLength: { params: 6, message: "邮编最大长度为6个字符"},
	});
	self.moblNo = ko.observable('${comOthAddressVO.moblNo}').extend({
/* 		required : {
			params : true,
			message : "请设置移动电话"
		}, */
		number : {
			params : true,
			message : "请输入数字"
		},
		maxLength: { params: 20, message: "移动电话最大长度为20个字符"},
	});
	self.areaCode = ko.observable('${comOthAddressVO.areaCode}').extend({
/* 		required : {
			params : true,
			message : "请设置区号"
		}, */
		number : {
			params : true,
			message : "请输入数字"
		},
		maxLength: { params: 4, message: "区号最大长度为4个字符"},
	});;
	self.phoneNo = ko.observable('${comOthAddressVO.phoneNo}').extend({
		number : {
			params : true,
			message : "请输入数字"
		},
/* 		required : {
			params : true,
			message : "请设置固定电话"
		}, */
		maxLength: { params: 20, message: "固定电话最大长度为20个字符"},
	});
	self.faxNo = ko.observable('${comOthAddressVO.faxNo}').extend({
		number : {
			params : true,
			message : "请输入数字"
		},
		maxLength: { params: 20, message: "传真号码最大长度为20个字符"},
	});
	self.emailAddr = ko.observable('${comOthAddressVO.emailAddr}').extend({
		maxLength: { params: 30, message: "电子邮箱最大长度为30个字符"},
		email : {
			params : true,
			message : "Email格式不正确"
		}
	});
	self.save = function(form, event) {
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
			url : ctx + "/supplier/company/saveComOtherAddr",
			dataType : "json",
			data : {
				'action' : viewModel.action(),
				'addrId' : viewModel.addrId(),
				'comNo' : viewModel.comNo(),
				'addrType' : viewModel.addrType(),
				'provName' : viewModel.provName(),
				'cityName' : viewModel.cityName(),
				'detllAddr' : viewModel.detllAddr(),
				'cntctName' : viewModel.cntctName(),
				'postCode' : viewModel.postCode(),
				'moblNo' : viewModel.moblNo(),
				'areaCode' : viewModel.areaCode(),
				'phoneNo' : viewModel.phoneNo(),
				'faxNo' : viewModel.faxNo(),
				'emailAddr' : viewModel.emailAddr()
			},
			success : function(mark) {
				if (mark) {
					//var row = $('#dg').datagrid('getSelected');
					var row = $('.btable_checked');
					if (row && viewModel.action() == "update"){
						$($('.btable_checked > td').get(1)).text(getDictValue('COM_OTH_ADDRESS_ADDR_TYPE',viewModel.addrType()));
						$($('.btable_checked > td').get(2)).text(viewModel.cityName());
						$($('.btable_checked > td').get(3)).text(viewModel.detllAddr());
						$($('.btable_checked > td').get(4)).text(viewModel.cntctName());
						$($('.btable_checked > td').get(5)).text(viewModel.postCode());
						$($('.btable_checked > td').get(6)).text(viewModel.moblNo());
						$($('.btable_checked > td').get(7)).text(viewModel.phoneNo());
						$($('.btable_checked > td').get(8)).text(viewModel.faxNo());
						$($('.btable_checked > td').get(9)).text(viewModel.emailAddr());
						/* var index = $('#dg').datagrid('getRowIndex', row);
						$('#dg').datagrid('updateRow',
							{
							index:index,
							row:{
								addrType:viewModel.addrType(),
								provName:viewModel.provName(),
								cityName:viewModel.cityName(),
								detllAddr:viewModel.detllAddr(),
								cntctName:viewModel.cntctName(),
								postCode:viewModel.postCode(),
								moblNo:viewModel.moblNo(),
								areaCode:viewModel.areaCode(),
								phoneNo:viewModel.phoneNo(),
								faxNo:viewModel.faxNo(),
								emailAddr:viewModel.emailAddr()
							}
						});
						$('#dg').datagrid('selectRow',index); */
					}else{
						//comOtherAddrSearch();
						pageQuery();
					}
					top.jAlert('success', '操作成功','提示消息');
					closePopupWinTwo();
					
				} else {
					top.jAlert('error', '操作失败','提示消息');
				}
		}});
	};
}
var viewModel = new ViewModel();
ko.applyBindings(viewModel);
$(function() {
	$(".PanelBtn1").bind("click",function(){
		viewModel.save();
	});
});
</script>
    <div class="Panel_top">
        <span>
      		  <c:if test="${action == 'add'}">创建新地址</c:if>
      		  <c:if test="${action == 'update'}">编辑地址</c:if>
        </span>
        <div class="PanelClose" onclick="closePopupWinTwo()"></div>
    </div>
    <div class="Table_Panel">
        <table class="CM_table">
            <c:if test="${action == 'update'}">
            <tr>
                <td class="w35"><span>*编号</span></td>
                <td><input type="text" class="Black inputText w30 twoInput1" data-bind="value:addrId" readonly="readonly"/></td>
            </tr>
            </c:if>
            <tr>
                <td  class="w35"><span>*地址类型</span></td>
                <td>
                	<auchan:select dataBind="value:addrType,validationElement:addrType" _class="w35" mdgroup="COM_OTH_ADDRESS_ADDR_TYPE" ></auchan:select>
                </td>
            </tr>
            <tr>
                <td><span>*省份城市</span></td>
                <td>
             		<div class="iconPut" style="width: 20%; float: left;">
						<input type="text" style="width: 72%;" readonly="readonly"
							data-bind="value:provName,validationElement:provName" />
						<div style="color: #999999;"><!-- 省 --><auchan:i18n id="100000010"/></div>
					</div>
					<div class="iconPut" style="width: 30%; float: left; margin-left: 3px;">
						<input type="text" style="width: 62%;" data-bind="value:cityName,validationElement:cityName" readonly="readonly"/>
						<div class="ListWin" onclick="openCityAndProvWindowEdit();"></div>
						<div style="color: #999999;"><auchan:i18n id="100000011"/></div>
					</div>
                </td>
            </tr>
            <tr>
                <td><span>*<auchan:i18n id="102006014"/></span></td>
                <td><input type="text" class="inputText w90" data-bind="value:detllAddr,validationElement:detllAddr"/></td>
            </tr>
            <tr>
                <td><span><!-- 联系人 --><auchan:i18n id="102006016"/></span></td>
                <td><input type="text" class="inputText w35" data-bind="value:cntctName,validationElement:cntctName"/></td>
            </tr>
            <tr>
                <td><span>邮编</span></td>
                <td><input type="text" class="inputText w35" data-bind="value:postCode,validationElement:postCode" maxlength="6"/></td>
            </tr>
            <tr>
                <td><span><!-- 移动电话 --><auchan:i18n id="102005009"/></span></td>
                <td><input type="text" class="inputText w35" data-bind="value:moblNo,validationElement:moblNo" maxlength="11"/></td>
            </tr>
            <tr>
                <td><span>固定电话</span></td>
         		<td>
         			<input type="text" class="inputText w11" data-bind="value:areaCode,validationElement:areaCode" maxlength="4"/>
					<span style="float: none; margin: 0;">-</span> 
					<input type="text" class="inputText w35" data-bind="value:phoneNo,validationElement:phoneNo" maxlength="20"/> 
				</td>
            </tr>
            <tr>
                <td><span><!-- 传真号码 --><auchan:i18n id="102006017"/></span></td>
         		<td>
         			<input type="text" class="inputText w11" data-bind="value:areaCode,validationElement:areaCode" maxlength="4"/>
					<span style="float: none; margin: 0;">-</span> 
					<input type="text" class="inputText w35" data-bind="value:faxNo,validationElement:faxNo" maxlength="20" /> 
				</td>                
            </tr>
            <tr>
                <td><span>电子邮箱</span></td>
                <td><input type="text" class="inputText w50" data-bind="value:emailAddr,validationElement:emailAddr" maxlength="30"/></td>
            </tr>
        </table>
    </div>
    <div class="Panel_footer">
        <div class="PanelBtn">
            <div class="PanelBtn1" >保&nbsp;&nbsp;存</div>
            <div class="PanelBtn2" onclick="closePopupWinTwo()">取&nbsp;&nbsp;消</div>
        </div>
    </div>
