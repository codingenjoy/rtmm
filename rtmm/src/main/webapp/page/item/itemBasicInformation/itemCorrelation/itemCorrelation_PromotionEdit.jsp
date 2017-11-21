<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	$(function(){
		sonFullItemBasicinfo();
		/*query the item message according by the itemNo 
		  in the input box.*/
 		  $("#sonItemNo").unbind('blur').bind('blur',function(){
 			    itemCorrePacAndPromoQuery();
		  });
			$('#sonItemNo').keydown(function(e) {
				if (e.keyCode == 13) {
					$("#sonItemName").focus();
					itemCorrePacAndPromoQuery();
					return false;
				}
			});
	});
</script>
<style>
.bz_info {
margin-top: 1px;
}
.bz_1 {
margin-right: 29px;
}
.w12_5 {
width:12.5% !important;
}
</style>
<div style="height: 150px; margin-top: 2px;" class="CM">
	<div class="CM-bar">
		<div>子货号</div>
	</div>
	<div class="CM-div">
		<div class="inner_half">
			<div class="ig" style="margin-top: 15px;">
				<div class="msg_txt">子货号</div>
				<div class="iconPut fl_left w20">
					<input type="text" id="sonItemNo" class="w75"/>
					<div class="ListWin" onclick="sonItemCorrelationFullArticleSelect()"></div>
				</div>
				<input class="inputText iq Black" id="sonItemName" type="text" readonly="readonly" />
			</div>
			<div class="ig">
				<div class="msg_txt">英文名称</div>
				<input type="text" id="sonItemEnName" maxlength="30" class="inputText w50 Black" readonly="readonly" />
			</div>
			<div class="bz_info">
				<div>
					<span class="bz_1">计量单位</span> <span class="bz_2">单位含量（容量）</span>
					<span class="bz_3">包装单位</span> <span class="bz_4">包装计数</span>
				</div>
			</div>
			<div class="ig">
				<div class="msg_txt">销售单位</div>
				<span class="jksp">1&nbsp;</span> 
				<input class="inputText iq" id="sonSellUnit" type="text" style="width: 10%;" value="组" readonly="readonly" /> 
				<span class="jksp">&nbsp;=&nbsp;</span> 
				<input class="inputText iq w10" id="sonNumOfPackUnit" type="text" value="" readonly="readonly" /> 
				<input class="inputText iq w10" id="sonPackUnit" type="text" value="" readonly="readonly" />
				<span class="fl_left">&nbsp;x&nbsp;</span> 
				<input class="inputText iq w12_5 " id="sonBaseVol" type="text" value="" readonly="readonly" /> 
				<input class="inputText iq w12_5 " id="sonBaseVolUnit" type="text" value="" readonly="readonly" />
			</div>
		</div>
		<div class="inner_half">
			<div class="ig" style="margin-top: 15px;">
				<div class="msg_txt">商品状态</div>
				<input type="text" id="sonStatus" class="inputText w20 Black" readonly="readonly" />
			</div>
			<div class="ig">
				<div class="msg_txt">厂商</div>
				<div class="iconPut fl_left w20 Black">
					<input type="text" id="sonMajorSupNo" class="w75 Black" readonly="readonly" />
					<div class="ListWin"></div>
				</div>
				<input class="inputText iq Black" id="sonMajorSupName" type="text" style="width: 55%;" readonly="readonly" />
			</div>
			<div class="ig">
				<div class="msg_txt">进价</div>
				<input class="w20 inputText Black" id="sonStdBuyPrice" type="text" readonly="readonly" /> 
				<span>元&nbsp;&nbsp;&nbsp;进价税率&nbsp;</span>
				<input class="w10 inputText Black" id="sonBuyVatNo" type="text" readonly="readonly" /> 
				<span>-</span> 
				<input class="w10 inputText Black" id="sonBuyVatVal" type="text" readonly="readonly" />
				<span>&nbsp;%</span>
			</div>
			<div class="ig">
				<div class="msg_txt">售价</div>
				<input class="w20 inputText Black" id="sonStdSellPrice" type="text" readonly="readonly" /> 
				<span>元&nbsp;&nbsp;&nbsp;售价税率&nbsp;</span>
				<input class="w10 inputText Black" id="sonSellVatNo" type="text" readonly="readonly" /> 
				<span>-</span> 
				<input class="w10 inputText Black" id="sonSellVatVal" type="text" readonly="readonly" />
				<span>&nbsp;%</span>
			</div>
		</div>
	</div>
</div>
