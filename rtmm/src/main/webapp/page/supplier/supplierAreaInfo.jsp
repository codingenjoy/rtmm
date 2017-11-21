<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<style type="text/css">
.fx_div1 {
	height: 60px;
}

.fx_div2 {
	height: 465px;
	margin-top: 2px;
}

.fx_div21 {
	height: 20px;
}

.fx_div21_1 {
	height: 20px;
	width: 80px;
	text-align: center;
	cursor: pointer;
	margin-left: 20px;
	float: left;
}

.fx_div21_2 {
	height: 20px;
	width: 80px;
	text-align: center;
	cursor: pointer;
	margin-left: 5px;
	float: left;
}

.fx_div21_3 {
	height: 20px;
	width: 80px;
	text-align: center;
	cursor: pointer;
	margin-left: 5px;
	float: left;
}

.fx_div22 {
	margin-top: 10px;
	margin-right: 10px;
	width: 96%;
	float: right;
	height: 416px;
	border-top: 1px solid #808080;
}

.fx22_1 {
	width: 35.4%;
	height: 100%;
	float: left;
	height: 30px;
	padding-left: 10px;
	line-height: 30px;
	background: #eeeeee;
}

.fx221_2 {
	height: 350px;
	overflow-y: auto;
	overflow-x: hidden;
	background: #fff;
	border: 1px solid #808080;
}

.tree-icon {
	display: none;
}
</style>
<script type="text/javascript">
	$(function() {
		$(".tagsM").die("click");
		$('#cs_tags1').unbind('click').bind('click',function() {
			$.post(ctx + "/supplier/getSupplierGeneralInfo?supNo=${supNo}",function(data){
				$("#content").html(data);
			},'html');
		});
	
		$('#cs_tags2').unbind('click').bind('click',function() {
			$.post(ctx + "/supplier/getSupPaymentInfo?supNo=${supNo}&comNo=${comNo}",function(data){
				$("#content").html(data);
			},'html');
		});
	
		$('#cs_tags3').unbind('click').bind('click',function() {
			$.post(ctx+ "/supplier/getSupplierAreaInfo?supNo=${supNo}&comNo=${comNo}",function(data){
				$("#content").html(data);
			},'html');
		});
	
		loadArea();
	});
	
	function loadArea() {
		var param = getSearchParam("1");
		if(param.catlgId==''){
			return;
		}
		$('#dg').datagrid({
			url : ctx + '/supplier/getSupplierSectionStore',
			pagination : false,
			singleSelect : true,
			queryParams : param ,
			columns : [ [
					{
						field : 'area',
						title : '<auchan:i18n id="102008008"/>',//'所属区域',
						sortable : true,
						align : 'left',
						halign : 'center',
						formatter : function(val, rec) {
							return rec.regnName.split('[|]')[1];
						},
						width : '100'
						
					},
					{
						field : 'provName',
						title : '<auchan:i18n id="102008009"/>',//'所属省份',
						align : 'left',
						halign : 'center',
						formatter : function(val, rec) {
							return rec.regnName.split('[|]')[2];
						},
						width : '100'
					},
					{
						field : 'regnName',
						title : '<auchan:i18n id="102008010"/>',//'所属城市',
						align : 'left',
						halign : 'center',
						formatter : function(val, rec) {
							return rec.regnName.split('[|]')[3];
						},
						width : '100'
					},
					{
						field : 'storeNo',
						title : '<auchan:i18n id="102008011"/>',//'分店',
						align : 'right',
						halign : 'center',
						formatter : function(val, rec) {
							return rec.storeNo + "&nbsp;&nbsp;";
						},
						width : '70'
					},
					{
						field : 'storeName',
						title : '<auchan:i18n id="102008012"/>',//'分店名称',
						align : 'left',
						halign : 'center',
						formatter : function(val, rec) {
							return rec.storeName;
						},
						width : '240'
					},
					{
						field : 'status',
						title : '<auchan:i18n id="102008013"/>',//'状态',
						align : 'left',
						halign : 'center',
						formatter : function(val, rec) {
							if (rec.status && rec.status != null) {
								return getDictValue('SUP_STORE_SEC_INFO_STATUS',rec.status);
							}else{
								return '';
							}
							
						},
						width : '80'
					},
					{
						field : 'paySttus',
						title : '<auchan:i18n id="102006038"/>',//'付款状态',
						align : 'left',
						halign : 'center',
						formatter : function(val, rec) {
							if (rec.paySttus && rec.paySttus != null) {
								return getDictValue('SUP_STORE_SEC_INFO_PAY_STTUS',rec.paySttus);
							}else{
								return '';
							}
							
						},
						width : '100'
					} ,
					{
						field : 'rtnAllow',
						title : '<auchan:i18n id="102008015"/>',//'可否退货',
						align : 'left',
						halign : 'center',
						formatter : function(val, rec) {
							
							if (rec.rtnAllow !=undefined && rec.rtnAllow != null) {
								return getDictValue('SUP_STORE_SEC_INFO_RTN_ALLOW',rec.rtnAllow);
							}else{
								return "&nbsp;";
							}
							
						},
						width : '100'
					} ,
					{
						field : 'apAmt ',
						title : '<auchan:i18n id="102006037"/>',//'应付余额',
						align : 'left',
						halign : 'center',
						formatter : function(val, rec) {
							return rec.apAmt;
						},
						width : '100'
					} ] ],
			onClickRow : function(rowIndex, rowData) {
	
			}
		});
	}

	function getSearchParam(bizType) {
		var obj = $('input[name="bizType"][value="'+bizType+'"]');
		$(obj).parent().parent().find('.GreenBg').removeClass('GreenBg');
		$(obj).parent().addClass('GreenBg');
		var queryParam = {
			supNo : '${supNo}',
			catlgId : $('#catlgId').val(),
			bizType : bizType
		};
		return queryParam;
	}
	
	$('.fx_div21>div').unbind('click').bind('click',function(){
		$(this).parent().find('.GreenBg').removeClass('GreenBg');
		$(this).addClass('GreenBg');
		var bizType = $(this).find('input[name="bizType"]').val();
		$('#dg').datagrid('load', getSearchParam(bizType));
		
	});
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div id="cs_tags1" class="tagsM"><!-- 厂商总览 --><auchan:i18n id="102006001"/></div>
	<div class="tags"></div>

	<!--中间-->
	<div id="cs_tags2" class="tagsM"><!-- 厂商财务信息 --><auchan:i18n id="102007001"/></div>
	<div class="tags tags_right_on"></div>

	<!--最后一个-->
	<div id="cs_tags3" class="tagsM tagsM_on"><!-- 厂商供应区域 --><auchan:i18n id="102008001"/></div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content" style="width: 99%;">
		<!--width:74%;-->
		<!-- <div class="CInfo">
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
		</div> -->
		<div class="line" style="width: 100%"></div>
		<!--539-->

		<div class="CM fx_div1">
			<div class="CM-bar" style="height: 60px">
				<div><!-- 厂编 --><auchan:i18n id="102010002"/></div>
			</div>
			<div class="CM-div">
			<table class="CM_table">
				<tr>
					<td class="w10">
						<span><!-- 采购厂编 --><auchan:i18n id="102006003"/></span>
					</td>
					<td class="w10">
						<input type="text" class="inputText w100" readonly="readonly" value="${supNo}"/>
					</td>
					<td class="w20">
						<span><!-- 公司名称 --><auchan:i18n id="102006050"/></span>
					</td>
					<td class="w30">
						<input type="text" class="inputText w80" readonly="readonly" value="${comName}"/>
					</td>
					<td class="w10">
						<span><!-- 课别 --><auchan:i18n id="102008004"/></span>
					</td>
					<td class="w60">
						<select id="catlgId" class="w85" onchange="loadArea()">
							<c:forEach items="${cataList}" var="cata">
								<option value="${cata.catlgId}">${cata.catlgId}-${cata.catlgName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>
			</div>
		</div>
		<div class="CM fx_div2">
			<div class="CM-bar" style="height: 465px">
				<div>业态和区域</div>
			</div>
			<div class="fx_div21">
				<div class="fx_div21_3"><input type="hidden" name="bizType" value="1"><!-- 大卖场 --><auchan:i18n id="102006072"/></div>
				<div class="fx_div21_2"><input type="hidden" name="bizType" value="8"><!-- 加工中心 --><auchan:i18n id="102006073"/></div>
				<div class="fx_div21_1"><input type="hidden" name="bizType" value="7"><!-- 物流中心 --><auchan:i18n id="102008007"/></div>
			</div>
			<div class="fx_div22">
				<table id="dg" style="height:420px;width:990px;"></table>
			</div>
		</div>
	</div>
</div>