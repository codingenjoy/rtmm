<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.iq {
	margin-left: 3px;
	background: #ccc;
}

.zz_info {
	width: 750px;
	margin-left: 20px;
}

.zz_2 input {
	margin-left: 3px;
}

.zz_2 input[type="checkbox"] {
	float: left;
	margin-top: 4px;
	margin-right: 3px;
	margin-left: 0px;
}

.zz_2 {
	height: 300px;
}

.sp_icon1 {
	margin-left: 9px;
}

.zz_11 {
	margin-left: 55px;
}

.zz_12 {
	margin-left: 100px;
}

.zz_13 {
	margin-left: 90px;
}

.zz_14 {
	margin-left: 55px;
}

.zz_15 {
	margin-left: 50px;
}

.zz_16 {
	margin-left: 55px;
}
</style>
<script type="text/javascript">
	$(function(){
		$("input").attr("readonly", "readonly");
	});	
</script>
<div style="height: 380px; margin-top: 2px;" class="CM">
	<div class="CM-bar">
		<div>子货号</div>
	</div>
	<div class="CM-div zz_info">
		<div class="zz_1">
			<span class="zz_11">子货号</span> <span class="zz_12">商品名称</span> <span
				class="zz_13">商品状态</span> <span class="zz_14">销售单位</span> <span
				class="zz_15">售价(元)</span> <span class="zz_16">进价(元)</span>
		</div>
		<div class="zz_2">
		<c:forEach items="${page.result}" var="subItem">
			<div class="ig canEmpty" style="margin-top: 5px; margin-left: 10px;">
				<div class="iconPut fl_left w12_5">
					<input class="w75" type="text" value="${subItem.itemNo}"/>
					<div class="ListWin"></div>
				</div>
				<input type="text" class="w25 inputText Black" value="${subItem.itemName}"/> 
				<input type="text" class="w12_5 inputText" 
						<c:if test="${subItem.status != null}">
	                          	value="<auchan:getDictValue code="${subItem.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>"
	                    </c:if>					
				/> 
				<input type="text" class="w12_5 inputText" 
						<c:if test="${subItem.sellUnit != null}">
	                       	value="<auchan:getDictValue code="${subItem.sellUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
	                    </c:if>		
				/> 
				<input type="text" class="w12_5 inputText" value="${subItem.stdSellPrice}"/> 
				<input type="text" class="w12_5 inputText" value="${subItem.stdBuyPrice}"/>
			</div>
		</c:forEach>
		</div>
		<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
	</div>
</div>
