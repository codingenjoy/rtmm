<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
._w120 {
	width: 120px;
}
._w80 {
	width: 80px;
}
.license2:hover {
	background-position: -3px -19px;
}
</style>

<div style="height: 300px;">
	<div class="tb50">
		<div style="height: 180px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>陈列信息</div>
			</div>
			<div class="CM-div">
				<div class="ig" style="margin-top: 15px;">
					<div class="msg_txt">陈列等级</div>
					<div class="iconPut iq fl_left" style="width: 13%;">
						<input type="text" style="width: 60%" value="${itemRealStoreSaleCtrlVO.displyLvl}"/>
						<div class="ListWin"></div>
					</div>
					<input class="inputText iq Black" type="text" style="width: 20%;" value="<c:if test="${itemRealStoreSaleCtrlVO.displyLvl != null }"><auchan:getDictValue code="${itemRealStoreSaleCtrlVO.displyLvl}" mdgroup="ITEM_REAL_STORE_SALE_CTRL_DISPLY_LVL"></auchan:getDictValue></c:if>"/>
				</div>
				<div style="height: 120px;">
					<div class="tb50">
						<div class="ig">
							<div class="msg_txt" style="width: 36%;">首排面量</div>
							<input class="w44 inputText" value="${itemRealStoreSaleCtrlVO.width}"/>
						</div>
						<div class="ig">
							<div class="msg_txt" style="width: 36%;">层数</div>
							<input class="w44 inputText" value="${itemRealStoreSaleCtrlVO.layer}"/>
						</div>
						<div class="ig">
							<div class="msg_txt" style="width: 36%;">深度</div>
							<input class="w44 inputText" value="${itemRealStoreSaleCtrlVO.depth}" />
						</div>
						<div class="ig">
							<div class="msg_txt" style="width: 36%;">排面容量</div>
							<input class="w44 inputText" value="${itemRealStoreSaleCtrlVO.width*itemRealStoreSaleCtrlVO.layer*itemRealStoreSaleCtrlVO.depth}"/>
						</div>
					</div>
					<div class="tb49">
						<div class="ig">
							<div class="msg_txt" style="width: 36%;">最小首排面量(y)</div>
							<input class="w44 inputText" value="${itemRealStoreSaleCtrlVO.minWidth}"/>
						</div>
						<div class="ig">
							<div class="msg_txt" style="width: 36%;">最小层数(x)</div>
							<input class="w44 inputText" value="${itemRealStoreSaleCtrlVO.minLayer}"/>
						</div>
						<div class="ig">
							<div class="msg_txt" style="width: 36%;">最小深度(z)</div>
							<input class="w44 inputText" value="${itemRealStoreSaleCtrlVO.minDepth}"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div style="height: 118px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>货架卡信息</div>
			</div>
			<div class="CM-div">
				<div class="ig" style="margin-top: 15px;">
					<div class="msg_txt">货架卡</div>
					<!-- <select class="w23"><option></option></select> -->
					<input type="text" class="inputText w15" value="<c:if test="${itemRealStoreSaleCtrlVO.railcard != null }"><auchan:getDictValue code="${itemRealStoreSaleCtrlVO.railcard}" mdgroup="ITEM_REAL_STORE_SALE_CTRL_RAILCARD"></auchan:getDictValue></c:if>"/>
					<span>&nbsp;&nbsp;&nbsp;下架临保天数&nbsp;</span>
					<input type="text" class="inputText w15" value="${itemRealStoreSaleCtrlVO.offShelfDays}"/>&nbsp;天
				</div>
				<div class="ig">
					<div class="msg_txt">列印序号</div>
					<input type="text" class="inputText w15" value="${itemRealStoreSaleCtrlVO.printSeq}"/>
					<span>&nbsp;&nbsp;&nbsp;销售保存条件&nbsp;</span>
                    <input type="text" class="inputText w23" value="${itemRealStoreSaleCtrlVO.shelfKeepCond}"/>
				</div>
				<div class="ig">
					<div class="msg_txt">货架卡列印张数</div>
					<input type="text" class="inputText w15" value="${itemRealStoreSaleCtrlVO.numRailcard}"/>
					<span>&nbsp;&nbsp;&nbsp;收货保存条件&nbsp;</span>
                    <input type="text" class="inputText w23" value="${itemRealStoreSaleCtrlVO.stockKeepCond}"/>
				</div>
			</div>
		</div>
	</div>
	<div class="tb50">
		<div style="height: 300px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>磅秤机信息</div>
			</div>
			<div class="CM-div">
				<div class="ig" style="margin-top: 15px;">
					<div class="msg_txt">磅秤机品名</div>
					<div style="float: left; width: 110px;">
						<input type="text" class="inputText w95" value="${itemRealStoreSaleCtrlVO.scaleName}"/>
					</div>
				</div>
				<div style="height: 60px;">
					<div class="msg_txt">
						<div>磅秤机备注</div>
					</div>
					<textarea class="w70 txtarea" rows="2">${itemRealStoreSaleCtrlVO.scaleMemo}</textarea>
				</div>
				<div class="ig">
					<div class="msg_txt">磅秤机变价</div>
					<!-- <select class="w20"><option></option></select>  -->
					<input class="w20 inputText" type="text" value="<c:if test="${itemRealStoreSaleCtrlVO.scaleUpdtSpInd != null }"><auchan:getDictValue code="${itemRealStoreSaleCtrlVO.scaleUpdtSpInd}" mdgroup="ITEM_REAL_STORE_SALE_CTRL_SCALE_UPDT_SP_IND"></auchan:getDictValue></c:if>"/>
					<span>&nbsp;&nbsp;&nbsp;磅秤机标签类型&nbsp;</span>
					<!-- <select class="w20"><option></option></select> -->
					<input class="w20 inputText" type="text" value="<c:if test="${itemRealStoreSaleCtrlVO.scaleLabelType != null }"><auchan:getDictValue code="${itemRealStoreSaleCtrlVO.scaleLabelType}" mdgroup="ITEM_REAL_STORE_SALE_CTRL_SCALE_LABEL_TYPE"></auchan:getDictValue></c:if>"/>
				</div>
				<div class="ig">
					<div class="msg_txt">下传包装机</div>
					<!-- <select class="w20"><option></option></select>  -->
					<input class="w20 inputText" type="text" value="<c:if test="${itemRealStoreSaleCtrlVO.dwnldToPackgMach != null }"><auchan:getDictValue code="${itemRealStoreSaleCtrlVO.dwnldToPackgMach}" mdgroup="ITEM_REAL_STORE_SALE_CTRL_DWNLD_TO_PACKG_MACH"></auchan:getDictValue></c:if>"/>
					<span>&nbsp;&nbsp;&nbsp;追溯码&nbsp;</span>
					<!-- <select class="w20"><option></option></select> -->
					<input class="w20 inputText" type="text" value="<c:if test="${itemRealStoreSaleCtrlVO.qltyTraceType != null }"><auchan:getDictValue code="${itemRealStoreSaleCtrlVO.qltyTraceType}" mdgroup="ITEM_REAL_STORE_SALE_CTRL_QLTY_TRACE_TYPE"></auchan:getDictValue></c:if>"/>
				</div>
				<div class="ig">
					<div class="msg_txt">去皮</div>
					<input class="w20 inputText" type="text" value="${itemRealStoreSaleCtrlVO.scalePeelWght}"/> 
					<span>&nbsp;g</span>
				</div>
			</div>
		</div>
	</div>
</div>
