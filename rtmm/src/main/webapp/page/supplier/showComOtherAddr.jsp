<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
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
var viewModel = new ViewModel();
ko.applyBindings(viewModel);
$(function() {
	$(".PanelBtn1").bind("click",function(){
		
		viewModel.save();
	});
});
</script>
    <div class="Panel_top">
        <span>创建新地址</span>
        <div class="PanelClose" onclick="closePopupWin()"></div>
    </div>
    <div class="Table_Panel">
        <table class="CM_table">
            <tr>
                <td class="w35"><span>*编号</span></td>
                <td><input type="text" class="inputText w35" /></td>
            </tr>
            <tr>
                <td><span>*地址类型</span></td>
                <td>
                	<select class="w35" data-bind="value: viewModel.addrType">
             		    <option value=""></option>
                   		<option value="1">订单地址</option>
                   		<option value="2">退货地址</option>
                   		<option value="3">订单及退货地址</option>
                	</select>
                </td>
            </tr>
            <tr>
                <td><span>*省份城市</span></td>
                <td><input type="text" class="inputText w35" data-bind="value: viewModel.provName"/></td>
            </tr>
            <tr>
                <td><span></span></td>
                <td><div class="iconPut w35">
                <input type="text" style="width:84%" data-bind="value: viewModel.cityName"/><div class="ListWin"></div> </div></td>
            </tr>
            <tr>
                <td><span>*<!-- 地址 --><auchan:i18n id="102006014"/></span></td>
                <td><input type="text" class="inputText w50" data-bind="value: viewModel.detllAddr"/></td>
            </tr>
            <tr>
                <td><span>*<!-- 联系人 --><auchan:i18n id="102006016"/></span></td>
                <td><input type="text" class="inputText w35" data-bind="value: viewModel.cntctName"/></td>
            </tr>
            <tr>
                <td><span>*邮编</span></td>
                <td><input type="text" class="inputText w35" data-bind="value: viewModel.postCode"/></td>
            </tr>
            <tr>
                <td><span><!-- 移动电话 --><auchan:i18n id="102005009"/></span></td>
                <td><input type="text" class="inputText w35" data-bind="value: viewModel.moblNo"/></td>
            </tr>
            <tr>
                <td><span>*固定电话</span></td>
                <td><input type="text" class="inputText w35" data-bind="value: viewModel.phoneNo"/></td>
            </tr>
            <tr>
                <td><span><!-- 传真号码 --><auchan:i18n id="102006017"/></span></td>
                <td><input type="text" class="inputText w35" data-bind="value: viewModel.faxNo"/></td>
            </tr>
            <tr>
                <td><span>电子邮箱</span></td>
                <td><input type="text" class="inputText w35" data-bind="value: viewModel.emailAddr"/></td>
            </tr>
        </table>
    </div>
    <div class="Panel_footer">
        <div class="PanelBtn">
            <div class="PanelBtn1" >保存</div>
            <div class="PanelBtn2" onclick="closePopupWin()">取消</div>
        </div>
    </div>
