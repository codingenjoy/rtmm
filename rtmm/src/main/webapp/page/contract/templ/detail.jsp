<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript"
	src="${ctx}/shared/js/contract/template/template.js"></script>
<script type="text/javascript">
	$(function(){
		changeTab($('.cm_table .item').first());
		$('.cm_table .item').first().addClass('item_on');
		$('.cm_table2 .item').first().addClass('item_on');
	})
</script>
<div class="CInfo">
	<span><auchan:getStuffName value="${tmplVO.chngBy}"/></span> <span>修改人</span> <span><fmt:formatDate value="${tmplVO.chngDate}" pattern="yyyy-MM-dd"/></span>
	<span>修改日期</span> <span><auchan:getStuffName value="${tmplVO.creatBy }"/></span> <span>建档人</span> <span><fmt:formatDate value="${tmplVO.creatDate}" pattern="yyyy-MM-dd"/></span>
	<span>创建日期</span>
</div>
<div style="height: 60px;" class="CM">
	<div class="CM-bar">
		<div>货号</div>
	</div>
	<div class="CM-div">
		<div class="hh_item">
			<div class="icol_text w7">
				<span>模板编号</span>
			</div>
			<input class="inputText w10 Black fl_left" type="text" value="${tmplVO.tmplId}" readonly="readonly"/>

			<div class="icol_text w7">
				<span>使用状态</span>
			</div>
 				<input class="inputText w7 Black  fl_left" readonly="readonly" type="text" value="<auchan:getDictValue mdgroup="CONTRACT_TMPL_IN_USE_IND" code="${tmplVO.inUseInd}"/>"/>
 			</div>
	</div>
</div>
<div style="height: 195px; margin-top: 2px;" class="CM">
	<div class="CM-bar">
		<div>页签</div>
	</div>
	<div class="CM-div">
		<div class="contract_cm">
			<table cellpadding="0" cellspacing="0" class="align_center">
				<tr>
					<td><div style="width: 30px;"></div></td>
					<td><div style="width: 53px;">序号</div></td>
					<td><div style="width: 313px;">中文名</div></td>
					<td><div style="width: 313px;">英文名</div></td>
					<td><div style="width: 203px;">类型</div></td>
				</tr>
			</table>
			<div class="cm_table cm_table1">
				<c:forEach items="${tmplVO.tabList}" var="tabList" varStatus="num">
						<div class="item" readonly="readonly" onclick="changeTab(this)">
							<input type="text" class="inputText fl_left" style="width: 50px; margin-left: 30px;" value="${num.index+1}" readonly="readonly"/>
				    		<input type="text" class="inputText fl_left" style="width: 310px;" value="${tabList.tabName}" readonly="readonly"/>
				    		<input type="text" class="inputText fl_left" style="width: 310px;" value="${tabList.tabEnName}" readonly="readonly"/>
				    		<input type="text" class="inputText fl_left" style="width: 200px;" readonly="readonly" value="<auchan:getDictValue mdgroup="CONTRACT_TMPL_TAB_TAB_TYPE" code="${tabList.tabType}"/>"/>
							<input name="tabId" type="hidden" value="${tabList.tabId}">
						</div>
				</c:forEach>	
			</div>
		</div>
	</div>
</div>
<div style="height: 275px; margin-top: 2px;" class="CM">
	<div class="CM-bar">
		<div>条款与科目组</div>
	</div>
	<div class="CM-div">
		<div class="contract_cm contract_cmx">
			<div class="contract_cm1">
				<table cellpadding="0" cellspacing="0" class="align_center">
					<tr>
						<td><div style="width: 30px;"></div></td>
						<td><div style="width: 53px;">序号</div></td>
						<td><div style="width: 113px;">中文名</div></td>
						<td><div style="width: 163px;">英文名</div></td>
						<td><div style="width: 108px;">支付方式</div></td>
						<td><div style="width: 63px;">固定条款</div></td>
						<td><div style="width: 63px;">纸版页数</div></td>
					</tr>
				</table>
				<div class="cm_table2">
					<%@ include file="/page/contract/templ/detailTerm.jsp"%>
				</div>
			</div>
			<div class="contract_cm2"></div>
			<div class="contract_cm3">
				<table cellpadding="0" cellspacing="0" class="align_center">
					<tr>
						<td><div style="width: 30px;"></div></td>
						<td><div style="width: 53px;">序号</div></td>
						<td><div style="width: 93px;">科目组编号</div></td>
						<td><div style="width: 93px;">中文名</div></td>
					</tr>
				</table>
				<div class="cm_table3" readonly="readonly">
					<%@ include file="/page/contract/templ/detailAcc.jsp"%>
				</div>
			</div>
		</div>
	</div>
</div>
