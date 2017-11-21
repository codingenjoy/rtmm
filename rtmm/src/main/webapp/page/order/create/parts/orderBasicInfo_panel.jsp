<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="CM" style="height: 120px;">
	<div class="inner_half">
		<div class="CM-bar">
			<div>订单基本信息</div>
		</div>
		<div class="CM-div">
			<div class="ig_top20">
				<div class="icol_text w14">
					<span>订单号码</span>
				</div>
				<input type="text" id="ordNo" readonly="readonly" class="inputText w50 Black" value="${ohivo.ordNo}"/>
				<input type="hidden" id="action" readonly="readonly" class="inputText w50 Black" value="${action}"/>
			</div>
			<div class="ig">
				<div class="icol_text w14">
					<span>*课别</span>
				</div>
				<div class="iconPut w20 fl_left">
					<input class="w80" type="text" id="catlgId" name='catlgId' value="${ohivo.catlgId}"
						onchange="changeCatlg(this)" onafterpaste="this.value=this.value.replace(/\D/g,'')" />
					<div class="ListWin" onclick="selectCatlg()"></div>
				</div>
				<input type="text" class="inputText w50 fl_left Black" id="catlgName" name="catlgName" readonly="readonly"
					value="${ohivo.catlgName}" />
			</div>
			<div class="ig">
				<div class="icol_text w14">
					<span>*厂商</span>
				</div>
				<div class="iconPut w20 fl_left">
					<input type="hidden" id="supComNo" name="supComNo" value="${supComVO.comNo}"/>
					<input type="hidden" id="supUnifmNo" name="supUnifmNo"  value="${supComVO.unifmNo}"/>
					<input type="hidden" id="supType" name="supType" value="${ohivo.supType}"/>
					<input type="text" class="w80" id="supNo" name="supNo" onchange="changeSup(this)" 
						onafterpaste="this.value=this.value.replace(/\D/g,'')" value="${ohivo.supNo}" />
					<div class="ListWin" onclick="selectSup()"></div>
				</div>
				<input type="text" class="inputText w50 fl_left Black" id="supName" name="supName" readonly="readonly" value="${ohivo.comName}"/>
			</div>
		</div>
	</div>
	<div class="inner_half">
		<div class="CM-div">
			<div class="ig_top20">
				<div class="icol_text w15">
					<span>订单日期</span>
				</div>
				<input type="text" id="orderDate" name="orderDate" value="<fmt:formatDate value="${ohivo.ordDate}" pattern="yyyy-MM-dd"/>" readonly="readonly" class="inputText w20 fl_left Black" />
				<span class="w12_5 fl_left">&nbsp;订单状态</span>
				<input type="text" name="orderStatusName" value="<auchan:getDictValue code='${ohivo.ordSttus}' mdgroup='ORDERS_ORD_STTUS' />" readonly="readonly"
					class="inputText w20 fl_left Black" />
				<input type="hidden" name="orderStatus" value="${ohivo.ordSttus}" readonly="readonly" class="inputText w20 fl_left Black" />
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>*预订收货日</span>
				</div>
				<input type="text" id="planRecptDate" name="planRecptDate" class="Wdate w20 fl_left" onclick="WdatePicker({isShowClear: false,readOnly: true, onpicking:function(dp){dateChangeConfirm(dp);} })" 
		              value="<fmt:formatDate value="${ohivo.planRecptDate}" pattern="yyyy-MM-dd"/>"/>
				<span class="w12_5 fl_left">&nbsp;进价折扣</span>
				<input type="text" id="bpDisc" name="bpDisc" class="inputText w20 fl_left Black" readonly="readonly" value="${ohivo.bpDisc}" />
				&nbsp;%
				<input type="hidden" id="invDisc" name="invDisc" value="${supDiscVO.invDisc}"/>
				<input type="hidden" id="discMemo" name="discMemo" value="${supDiscVO.discMemo}"/>
			</div>
			<div class="ig">
				<div class="icol_text w15">
					<span>采购</span>
				</div>
				<input type="text" id="buyerName" name="buyerName" value="${ohivo.buyerName}" readonly="readonly" class="inputText w20 fl_left Black" />
				<input type="hidden" id="buyer" name="buyer" value="${ohivo.buyer}" readonly="readonly" class="inputText w20 fl_left Black" />
				<span class="w12_5 fl_left">&nbsp;备注</span>
				<input type="text" name="memo" id="memo" class="inputText w30" maxlength="30" value="${ohivo.memo}"/>
			</div>
		</div>
	</div>
</div>