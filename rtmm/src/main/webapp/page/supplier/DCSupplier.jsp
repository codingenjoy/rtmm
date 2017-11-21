<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/calendar.css" />
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/combo.css"
	rel="Stylesheet" />
<script src="${ctx}/shared/js/supplier/DCSupplier.js" charset="gbk"
	type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",
				function() {
					DispOrHid('B-id');
					gridbar_B();
				});
		
		<auchan:operauth ifAnyGrantedCode="111322996">
			$("#Tools11").attr('class', "Icon-size1 Tools11 B-id").unbind("click").bind("click",
					function() {
						createDCSupplier();
			});
		</auchan:operauth>
		
		$(".Tools6").unbind('click').bind('click', function() {
			pageQuery(1);
		});
		$(".Tools20").unbind('click').bind('click', function() {
			clearSearch();
		});

		$("#Tools12").attr('class', "Icon-size1 Tools12_disable");
		$("#Tools12").unbind("click");
		StoreListSearch();
		pageQuery();

	});
	function closeSearch() {
		DispOrHid('C-id');
		gridbar_C();
	}
</script>

<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="102010001" /><!-- DC厂商 --></div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Search" style="display: none;">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span><auchan:i18n id="100002013" /><!-- 查询条件 --></span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle">
			<table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="ST_td1"><span><auchan:i18n id="102010002" /><!-- 厂编 --></span></td>
					<td class="ST_td2"><input id="supNoSearch" type="text"
						class="inputText w80" title="数字格式"  onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8" /></td>
				</tr>
				<tr>
					<td class="ST_td1"><span><auchan:i18n id="102010003" /><!-- 配送中心 --></span></td>
					<td><input id="storeNoSearch" value="<auchan:i18n id='100000009' />"
						data-options="editable:false,panelHeight:'auto'" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102010012" /><!-- 启用日期自 --></span></td>

					<td><input id="applyStartDateFromSearch" type="text"
						class="Wdate w80"
						onClick="WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change');},isShowClear:false,readOnly:true})" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102010013" /><!-- 至 --></span></td>

					<td><input id="applyStartDateEndSearch" type="text"
						class="Wdate w80"
						onClick="WdatePicker({onpicked:function(){$(this).trigger('change');},onclearing:function(){$(this).attr('value','').trigger('change');},isShowClear:false,readOnly:true})" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102010006" /><!-- 状态 --></span></td>
					<td><auchan:select id="lockSttusSearch" _class="w80"
							mdgroup="SUP_DC_CTRL_LOCK_STTUS"></auchan:select> <!-- 请选择 --></td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20"></div>
			<div class="Icon-size1 Tools6"></div>
		</div>
	</div>

	<div class="Content">
		<div id="dcSupplierList"></div>
	</div>
</div>
<div id="date_div"
	style="width: 160px; height: 180px; display: none; position: absolute; z-index: 9999;"></div>
