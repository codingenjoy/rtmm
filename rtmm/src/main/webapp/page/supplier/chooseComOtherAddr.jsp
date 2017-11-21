<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
.Table_Panel {
	height: 470px;
	overflow: hidden;
}

.tpanel1 {
	margin: 15px auto;
	width: 97%;
	height: 100%;
}

.tpanel11 {
	height: 30px;
	width: 100%;
}

.SearchList {
	height: 30px;
	background-color: #f5f5f5;
	width: 98%;
	float: left;
}

.SearchList input {
	width: 97%;
	float: left;
	height: 20px;
	margin: 5px 5px;
}

.SearchList div {
	width: 16px;
	height: 21px;
	margin-top: 5px;
	float: left;
}

.add {
	width: 2%;
	height: 21px;
	float: left;
	margin-top: 5px;
	background-position: -358px -2px;
}
</style>
<script>
$(function(){
	$('#dg').datagrid({
			rownumbers : false,
			singleSelect : true,
			pagination : true,
			pageSize : 10,
			url : ctx + '/supplier/company/comOtherAddrList',
			queryParams : {
				comNo : "${comNo}",
				addrType : "${addrType}"
			},
			columns : [[{
				field : 'cityName',
				title : '省份城市',
				halign : 'center',
				width : '80'
			}, {
				field : 'detllAddr',
				title : '<auchan:i18n id="102006014"/>',
				halign : 'center',
				width : '160'
			}, {
				field : 'cntctName',
				halign : 'center',
				title : '<auchan:i18n id="102006016"/>',//'联系人',
			 	width : '80'
			}, {
				field : 'postCode',
				halign : 'center',
				halign : 'center',
				title : '邮编',
				width : '80'
			}, {
				field : 'moblNo',
				halign : 'center',
				title : '<auchan:i18n id="102005009"/>',//'移动电话',
				width : '80'
			}, {
				field : 'phoneNo',
				halign : 'center',
				title : '固定电话',
				width : '80'
			}, {
				field : 'faxNo',
				halign : 'center',
				title : '<auchan:i18n id="102006017"/>',//'传真号码',
				width : '80'
			}, {
				field : 'emailAddr',
				halign : 'center',
				title : '电子邮箱',
				width : '120'
			} ] ],
			onClickRow : function(rowIndex, rowData) {
				confirmChooseSupAddress(rowData.addrId);
			}
		});
	});
</script>
<div class="Panel" style="width: 782px;">
	<div class="Panel_top">
		<span>选择订货退货地址</span>
		<div class="PanelClose" onclick="closePopupWin()"></div>
	</div>
	<div class="Table_Panel">
		<div class="tpanel1">
<!-- 			<div class="tpanel11">
				<div class="SearchList" style="width:100%">
					<div class="iconPut" style="height:22px;width:99%;margin-left:5px;display:inline;">
					<input class="" type="text" />
					<div class="Tools6"></div>
					</div>
				</div>
				<div class="Tools11 add"></div>
			</div> -->
			<div style="height: 435px; overflow: hidden;">
				<table id="dg" style="height: 425px; width: 760px;"></table>
			</div>
		</div>

	</div>
</div>
