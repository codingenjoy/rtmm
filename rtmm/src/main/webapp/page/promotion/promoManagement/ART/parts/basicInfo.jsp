<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div class="CM" style="height: 130px;">
	<div class="inner_half">
		<div class="CM-bar">
			<div>促销期数基本信息</div>
		</div>
		<div class="CM-div">
			<div class="ig_top20">
				<div class="icol_text w14 ">
					<span>促销期数</span>
				</div>
				<input type="text" class="inputText w20 Black" readonly="readonly"
					<%-- value="${ARTPromNo }" --%> name="promNo" id="promNo" maxlength="30" />
			</div>
			<div class="ig">
				<div class="icol_text w14">
					<span>*主题</span>
				</div>
				<input type="text" class="inputText w50 subjName"
					onkeyup="checkSubjName()" name="subjName" id="subjName"
					maxlength="30" />(最多输入15个字)
			</div>
			<div class="ig">
				<div class="icol_text w14">
					<span>采购期间</span>
				</div>
				<input type="hidden" id = "oBuyBeginDate"  />
				<input type="hidden" id = "oBuyEndDate" />
				<input type="text" id="buyTimeStart" name="buyBeginDate"
					ttype="buy" class="Wdate w20"  sType="buystart"
					onFocus="WdatePicker({onpicked:callOnAnyDateChanged,isShowClear: false, readOnly: true,lang:'${calendarL}',dateFormat:'yy-MM-dd',minDate:'%y-%M-\#{%d+2}'})" />&nbsp;-&nbsp;
					
					<input 
					type="text" id="buyTimeEnd" name="buyEndDate" ttype="buy" sType="buyend" 
					class="Wdate w20"
					onFocus="WdatePicker({onpicked:callOnAnyDateChanged,isShowClear: false, readOnly: true,lang:'${calendarL}',dateFormat:'yy-MM-dd',minDate:'%y-%M-\#{%d+2}'})" />
			</div>
		</div>
	</div>
	<div class="inner_half">
		<div class="CM-div">
			<div class="ig_top20">
				<div class="icol_text w14">
					<span>促销期间</span>
				</div>
				<input type="hidden" id = "oSellBeginDate" />
				<input type="hidden" id = "oSellEndDate"/>
				<input type="text" id="promTimeStart" name="promBeginDate"
					class="Wdate w20 " ttype="prom" sType="promstart"  
					onFocus="WdatePicker({onpicked:callOnAnyDateChanged,isShowClear: false, readOnly: true,lang:'${calendarL}',dateFormat:'yy-MM-dd',minDate:'%y-%M-\#{%d+2}'})" />&nbsp;-&nbsp;<input
					type="text" id="promTimeEnd" name="promEndDate" class="Wdate w20"
					ttype="prom" sType="promend" 
					onFocus="WdatePicker({onpicked:callOnAnyDateChanged,isShowClear: false, readOnly: true,lang:'${calendarL}',dateFormat:'yy-MM-dd',minDate:'%y-%M-\#{%d+2}'})" />
			</div>
			<div class="ig">
				<div class="icol_text w14">
					<span>*课别</span>
				</div>
				<div class="iconPut w15 fl_left">
					<input type="text" class="w70 catlgId Black" name="catlgId"
						id="CatlgId" readonly="readonly" value="${catlg.catlgId }" />
					<div class="ListWin showCatlgWin"></div>
				</div>
				<input type="text" class="inputText w23 Black" id="CatlgName"
					readonly="readonly" value="${catlg.catlgName}" />
			</div>
			<div class="ig">
				<div class="icol_text w14">
					<span>促销类型</span>
				</div>
				<input type="text" id="promTypeValue" class="inputText w23 Black"
					readonly="readonly" /> <input type="hidden" id="promType"
					name="pricePromType" />
			</div>
		</div>
	</div>
</div>