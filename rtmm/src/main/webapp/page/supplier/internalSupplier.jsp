<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<jsp:include page="/page/commons/knockout.jsp" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<script src="${ctx}/shared/js/supplier/internalSupplier.js" charset="gbk" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",
				function() {
					DispOrHid('B-id');
					gridbar_B();
				});
		$("#Tools12").unbind("click");
		
		<auchan:operauth ifAnyGrantedCode="111321996">
			$("#Tools11").attr('class', "Icon-size1 Tools11 B-id").unbind("click").bind("click",function() {
						createInternalSupplier();
			});
		</auchan:operauth>
		$(".Tools6").bind('click', function() {
			pageQuery();
		});
		$(".Tools20").bind('click', function() {
			clearSearch();
		});
	
		pageQuery();
		
	});
	function closeSearch() {
		DispOrHid('C-id');
		gridbar_C();
	}

</script>
<style type="text/css">
.my-head-td-ck,.ck,.my-head-td-ck div,.ck div {
	display: none;
}

.datagrid-body {
	overflow-x: hidden;
}

.scroll_bar {
	overflow-x: auto;
}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="102009001" /></div> <!--  内部厂商 -->
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Search" style="display: none;">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span><auchan:i18n id="100002013"/><!-- 查询条件 --></span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle">
			<table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="ST_td1"><span><auchan:i18n id="102009002"/><!-- 内部厂编 --></span></td>
					<td class="ST_td2"><input id="supNoSearch" type="text" class="inputText w80"  onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8"/></td>
				</tr>
				<tr>
					<td><span>厂商中文名称</span></td>
					<td><input id="intrnSupNameSearch" type="text" class="inputText w80" maxlength="20" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102009004"/><!-- 准备天数 --></span></td>
					<td><input id="leadTimeSearch" type="text" class="inputText w80"  onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="2"/></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102009022"/><!-- 厂商类型 --></span></td>
					<td><auchan:select id="supTypeSearch" ignoreValue="1,2,3,4,5,6,7,8" _class="w80" mdgroup="SUPPLIER_SUP_TYPE" ></auchan:select></td>
				</tr>
				<tr>
					<td><span><!-- 状态 --><auchan:i18n id="102009011"/></span></td>
					<td><auchan:select id="statusSearch" _class="w80" mdgroup="SUPPLIER_STATUS" ></auchan:select><!--  请选择--></td>
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
		<div id="intSupplierList">
		</div>
	</div>
</div>
