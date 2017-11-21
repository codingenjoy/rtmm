<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.jxc_1 .CM {
	background: #eeeeee;
}
</style>


<div class="jxc_1">
	<div class="CM jxc_x">
		<span class="item item_on " onclick="setSearchType('store');">门店进销存信息</span>
		<span class="item "  onclick="setSearchType('company');">全公司进销存信息</span>
	</div>
	<div class="CM jxc_cm">
		<div class="CM-bar">
			<div>进货</div>
		</div>
		<div class="CM-div">
			<div class="tb50">
				<div class="ig">
					<div class="msg_txt">昨日收货</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.recptTd}"/> 
					<span class="sh_line25">&nbsp;件</span>
					<div class="msg_txt2">金额</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.recptAmntTd}"/> 
					<span class="sh_line25">&nbsp;元</span>
				</div>
				<div class="ig">
					<div class="msg_txt">本月收货</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.recptCm}"/> 
					<span class="sh_line25">&nbsp;件</span>
					<div class="msg_txt2">金额</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.recptAmntCm}"/> 
					<span class="sh_line25">&nbsp;元</span>
				</div>
				<div class="ig">
					<div class="msg_txt">本年收货</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.recptCy}"/> 
					<span class="sh_line25">&nbsp;件</span>
					<div class="msg_txt2">金额</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.recptAmntCy}"/> 
					<span class="sh_line25">&nbsp;元</span>
				</div>
			</div>
			<div class="tb49">
				<div class="ig">

					<div class="msg_txt">待收</div>
					<input type="text" class="inputText w20 fl_left" readonly="readonly" value="${itemStatVO.onOrder}"/> 
					<span class="sh_line25">&nbsp;件</span>
				</div>
				<div class="ig">
					<div class="msg_txt">最近收货日</div>
					<input type="text" class="inputText w20 fl_left" readonly="readonly" 
					value="<fmt:formatDate pattern="yyyy-MM-dd" value="${itemStatVO.recptDate}" />"/>
				</div>
			</div>
		</div>
	</div>
	<div class="CM jxc_cm">
		<div class="CM-bar">
			<div>销售</div>
		</div>
		<div class="CM-div">
			<div class="tb50">
				<div class="ig">
					<div class="msg_txt">昨日销售</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.salesTd}"/> 
					<span class="sh_line25">&nbsp;件</span>
					<div class="msg_txt2">金额</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="<fmt:formatNumber value="${itemStatVO.salesAmntTd }" pattern="#0.00"/>"/> 
					<span class="sh_line25">&nbsp;元&nbsp;&nbsp;</span>
					<div class="msg_txt3">净毛利</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="<fmt:formatNumber value="${itemStatVO.NNProfAmnt }" pattern="#0.00"/>"/> 
					<span class="sh_line25">&nbsp;元</span>
				</div>
				<div class="ig">
					<div class="msg_txt">本月销售</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.salesCm}"/> 
					<span class="sh_line25">&nbsp;件</span>
					<div class="msg_txt2">金额</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="<fmt:formatNumber value="${itemStatVO.salesAmntCm }" pattern="#0.00"/>"/> 
					<span class="sh_line25">&nbsp;元&nbsp;&nbsp;</span>
					<div class="msg_txt3">净毛利</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.conForeCm}"/> 
					<span class="sh_line25">&nbsp;元</span>

				</div>
				<div class="ig">
					<div class="msg_txt">本年销售</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.salesCy}"/> 
					<span class="sh_line25">&nbsp;件</span>
					<div class="msg_txt2">金额</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="<fmt:formatNumber value="${itemStatVO.salesAmntCy }" pattern="#0.00"/>"/> 
					<span class="sh_line25">&nbsp;元&nbsp;&nbsp;</span>
					<div class="msg_txt3">净毛利</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.conForeCy}"/> 
					<span class="sh_line25">&nbsp;元</span>
				</div>
			</div>
			<div class="tb49">
				<div class="ig">

					<div class="msg_txt">净成本</div>
					<input type="text" class="inputText w20 fl_left" readonly="readonly" value="${itemStatVO.netCost}"/> 
					<span class="sh_line25">&nbsp;元&nbsp;&nbsp;&nbsp;</span>
					<div class="msg_txt3">DMS</div>
					<input type="text" class="inputText w20 fl_left" value="<fmt:formatNumber value="${itemStatVO.dms }" pattern="#0.00"/>"/> 
					<span class="sh_line25">&nbsp;件</span>
				</div>
				<div class="ig">
					<div class="msg_txt">最近销售日</div>
					<input type="text" class="inputText w20 fl_left" readonly="readonly" 
					value="<fmt:formatDate pattern="yyyy-MM-dd" value="${itemStatVO.salesDate}" />"/> 
					<span class="sh_line25">&nbsp;件&nbsp;&nbsp;&nbsp;</span>
					<div class="msg_txt3">促销DMS</div>
					<input type="text" class="inputText w20 fl_left" value="<fmt:formatNumber value="${itemStatVO.promDms }" pattern="#0.00"/>"/> 
					<span class="sh_line25">&nbsp;件</span>
				</div>
			</div>
		</div>
	</div>
	<div class="CM jxc_cm">
		<div class="CM-bar">
			<div>存货</div>
		</div>
		<div class="CM-div">
			<div class="tb50">
				<div class="ig">
					<div class="msg_txt">昨日库调</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.stockAdjTd }"/> 
					<span class="sh_line25">&nbsp;件</span>
					<div class="msg_txt2">金额</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="<fmt:formatNumber value="${itemStatVO.stockAdjAmntTd }" pattern="#0.00"/>"/> 
					<span class="sh_line25">&nbsp;元</span>
				</div>
				<div class="ig">
					<div class="msg_txt">本月库调</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.stockAdjCm }"/> 
					<span class="sh_line25">&nbsp;件</span>
					<div class="msg_txt2">金额</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="<fmt:formatNumber value="${itemStatVO.stockAdjAmntCm }" pattern="#0.00"/>"/> 
					<span class="sh_line25">&nbsp;元</span>
				</div>
				<div class="ig">
					<div class="msg_txt">本年库调</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="${itemStatVO.stockAdjCy }"/> 
					<span class="sh_line25">&nbsp;件</span>
					<div class="msg_txt2">金额</div>
					<input type="text" class="inputText w15 fl_left" readonly="readonly" value="<fmt:formatNumber value="${itemStatVO.stockAdjAmntCy }" pattern="#0.00"/>" /> 
					<span class="sh_line25">&nbsp;元</span>
				</div>
			</div>
			<div class="tb49">
				<div class="ig">
					<div class="msg_txt">昨日期末库存</div>
					<input type="text" class="inputText w20 fl_left" readonly="readonly" value="${itemStatVO.stock }"/> 
					<span class="sh_line25">&nbsp;件</span>
				</div>
				<div class="ig">
					<span class="sh_line25">=昨日期初库存(件)+昨日收货(件)-昨日销售(件)+昨日库调(件)</span>
				</div>
				<div class="ig">
					<input type="text" class="inputText jxc_p1" readonly="readonly" value="${itemStatVO.stock+itemStatVO.salesTd-itemStatVO.recptTd-itemStatVO.stockAdjTd}"/> 
					<input type="text" class="inputText jxc_p2" readonly="readonly" value="${itemStatVO.recptTd }"/> 
					<input type="text" class="inputText jxc_p3" readonly="readonly" value="${itemStatVO.salesTd }"/> 
					<input type="text" class="inputText jxc_p4" readonly="readonly" value="${itemStatVO.stockAdjTd }"/>
				</div>
			</div>
		</div>
	</div>
</div>

