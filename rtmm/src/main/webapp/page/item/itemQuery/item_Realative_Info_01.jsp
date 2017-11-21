<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
._w120 {
	width: 120px;
}

._w80 {
	width: 80px;
}

.iq {
	margin-left: 3px;
	background: #ccc;
}
</style>
<script type="text/javascript">
	$(function(){
		$("input").attr("readonly", "readonly");
	});	
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize"value="${page.pageSize }" />
<div style="height: 150px; margin-top: 2px;" class="CM">
	<div class="CM-bar">
		<div>子货号</div>
	</div>
	<c:set var="subItem" value="${page.result[0]}"></c:set>
	<div class="CM-div">
		<div class="inner_half">
			<div class="ig" style="margin-top: 15px;">
				<div class="msg_txt">子货号</div>
				<div class="iconPut fl_left w20">
					<input type="text" class="w75" value="${subItem.itemNo}"/>
					<div class="ListWin"></div>
				</div>
				<input class="inputText iq Black" type="text" value="${subItem.itemName}"/>
			</div>
			<div class="ig">
				<div class="msg_txt">英文名称</div>
				<input type="text" class="inputText w50 Black" value="${subItem.itemEnName}"/>
			</div>
			<div class="ig">
				<div class="msg_txt">销售单位</div>
				<span class="jksp">1&nbsp;</span> 
				<input class="inputText iq" type="text" style="width: 10%;" 
					<c:if test="${subItem.sellUnit != null}">
                       	value="<auchan:getDictValue code="${subItem.sellUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>"
                    </c:if>						
				 /> 
				<span class="jksp">&nbsp;=&nbsp;</span> 
				<input class="inputText iq w10" type="text" value="${subItem.numOfPackUnit}" readonly="readonly" /> 
				<input class="inputText iq w10" type="text" 
					<c:if test="${subItem.packUnit != null}">
						value="<auchan:getDictValue code="${subItem.packUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>" 
					</c:if>					
				readonly="readonly" />
				<span class="fl_left">&nbsp;x&nbsp;</span> 
				<input class="inputText iq w10" type="text" value="${subItem.baseVol}" readonly="readonly" /> 
				<input class="inputText iq w10" type="text" value="${subItem.baseVolUnit}" 
					<c:if test="${subItem.baseVolUnit != null}">
						value="<auchan:getDictValue code="${subItem.baseVolUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>" 
					</c:if>						
				readonly="readonly" />
			</div>
			<div class="ig">
				<div class="msg_txt">包含数量</div>
					<input class="inputText w120" type="text" value="${subItem.cntdQty}"/>
			</div>
		</div>
		<div class="inner_half">
			<div class="ig" style="margin-top: 15px;">
				<div class="msg_txt">商品状态</div>
				<input type="text" class="inputText w20 Black"
					<c:if test="${subItem.status != null}">
                          	value="<auchan:getDictValue code="${subItem.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>"
                       </c:if>							
				 />
			</div>
			<div class="ig">
				<div class="msg_txt">厂商</div>
				<div class="iconPut fl_left w20 Black">
					<input type="text" class="w75 Black" value="${subItem.majorSupNo}"/>
					<div class="ListWin"></div>
				</div>
				<input class="inputText iq Black" type="text" style="width: 55%;" value="${subItem.majorSupName}"/>
			</div>
			<div class="ig">
				<div class="msg_txt">进价</div>
				<input class="w20 inputText Black" type="text" value="${subItem.stdBuyPrice}"/> 
				<span>元&nbsp;&nbsp;&nbsp;进价税率&nbsp;</span>
				<input class="w10 inputText Black" type="text" value="${subItem.buyVatNo}"/> 
				<span>-</span> 
				<input class="w10 inputText Black" type="text" value="${subItem.buyVatVal}"/>
				<span>&nbsp;%</span>
			</div>
			<div class="ig">
				<div class="msg_txt">售价</div>
				<input class="w20 inputText Black" type="text" value="${subItem.stdSellPrice}"/> 
				<span>元&nbsp;&nbsp;&nbsp;售价税率&nbsp;</span>
				<input class="w10 inputText Black" type="text" value="${subItem.sellVatNo}"/> 
				<span>-</span> 
				<input class="w10 inputText Black" type="text" value="${subItem.sellVatVal}"/>
				<span>&nbsp;%</span>
			</div>
		</div>

	</div>
</div>


