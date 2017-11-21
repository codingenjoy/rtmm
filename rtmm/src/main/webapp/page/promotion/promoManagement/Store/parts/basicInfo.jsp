<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div class="CM" style="height: 130px;">
			<div class="inner_half">
				<div class="CM-bar">
					<div>促销期数基本信息</div>
				</div>
				<div class="CM-div">
					<div class="ig_top20">
						<div class="icol_text w14">
							<span>促销期数</span>
						</div>
						<input type="text" readonly="readonly" class="inputText w20 Black" />
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>*主题</span>
						</div>
						<input id="subjName" name="subjName" onblur="checkSubjName()"
							type="text" class="inputText w50" maxlength="30" />(最多输入15个字)
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>促销期间</span>
						</div>
						<input type="text" ttype="prom" name="promBeginDate"
							  id="promBeginDate" class="Wdate w20"
							onclick="WdatePicker({ onpicked:getPromoType, isShowClear: false, readOnly: true ,dateFormat:'yy-mm-dd',lang:'${calendarL}',minDate:'${minDate}'})" />&nbsp;-&nbsp;<input
							type="text" ttype="prom" id="promEndDate"
							  name="promEndDate" class="Wdate w20"
							onclick="    WdatePicker({onpicked:getPromoType,  isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}',minDate:'#F{$dp.$D(\'promBeginDate\')}'})" />
					</div>
				</div>
			</div>
			<div class="inner_half">
				<div class="CM-div">
					<div class="ig_top20">
						<div class="icol_text w14">
							<span>采购期间</span>
						</div>
						<input type="text" id="buyBeginDate" ttype="buy"
							  name="buyBeginDate" class="Wdate w20"
							onclick="WdatePicker({onpicked:getPromoType,isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}',minDate:'${minDate}'})" />&nbsp;-&nbsp;<input
							type="text" ttype="buy" id="buyEndDate"
							 name="buyEndDate" class="Wdate w20"
							onclick="WdatePicker({onpicked:getPromoType, isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}',minDate:'#F{$dp.$D(\'buyBeginDate\')}'})" />
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>*课别</span>
						</div>
						<div class="iconPut w15 fl_left">
							<input type="text" id="catlgId" value="${catlg.catlgId }"
								name="catlgId" class="w70 Black" readonly="readonly" />
							<div class="ListWin showCatlgWin"></div>
						</div>
						<input type="text" id="catlgName" name="catlgName"
							value="${catlg.catlgName}" readonly="readonly"
							class="inputText w23 Black" />
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>促销类型</span>
						</div>
						<input type="hidden" name="pricePromType" id="pricePromType"
							class="inputText w23 Black" readonly="readonly" /> <input
							type="text" name="pricePromTypeName" id="pricePromTypeName"
							class="inputText w23 Black" readonly="readonly" />

					</div>
				</div>
			</div>
</div>