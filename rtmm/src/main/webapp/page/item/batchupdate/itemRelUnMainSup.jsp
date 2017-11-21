
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css"
	rel="Stylesheet" />
<style type="text/css">
.Table_Panel {
	height: 550px;
	overflow: hidden;
}

.CM_p {
	height: 280px;
	width: 595px;
	margin: 20px 2px 0px 20px;
}

.t2,.t3 {
	height: 240px;
	overflow-x: hidden;
	overflow-y: auto;
	float: left;
	background: #fff;
	margin-top: 20px;
	border: 1px solid #808080;
}

.t2 {
	width: 328px;
	margin-left: 20px;
}

.t3 {
	width: 200px;
	margin-left: 5px;
}

.CM2 {
	background: #f9f9f9;
	width: 296px;
	height: 240px;
	float: right;
	margin-top: 3px;
}

.b {
	height: 209px;
	overflow: auto;
}

.d {
	width: 235px;
	height: 200px;
	background: #fff;
	margin: 20px auto auto 40px;
	border: 1px solid #808080;
}

.e,.f,.b {
	width: 215px;
	margin: 0 auto;
	line-height: 26px;
}

.e {
	overflow: auto;
	height: 169px;
}

.e div,.b div {
	border-top: 1px solid #fff;
	height: 28px;
	cursor: pointer;
}

.f {
	border-top: 1px solid #808080;
	height: 30px;
}

.tree-icon {
	display: none;
}

.p52_2_1 {
	float: none;
}
</style>

<div class="p52_2_1 CM">
	<div class="CM-bar">
		<div>修改项</div>
	</div>
	<div class="CM-div" style="width: 90%;" id="mdfOption">
		<div class="ig" style="margin-top: 15px;">
			<input type="checkbox" id="pmitDays" name="lmtMdfOpts"
				readonly="readonly" />&nbsp;&nbsp;允收天数
		</div>
		<div class="ig">
			<input type="checkbox" id="orderBoxNum" name="lmtMdfOpts" />&nbsp;&nbsp;订购倍数
		</div>
		<div class="ig">
			<input type="checkbox" id="boxContent" name="lmtMdfOpts" />&nbsp;&nbsp;箱含量
		</div>
		<div class="ig">
			<input type="checkbox" id="lowestPrice" name="lmtMdfOpts" />&nbsp;&nbsp;最低售价
		</div>
		<div class="ig">
			<input type="checkbox" id="ifRtnGoods" name="lmtMdfOpts" />&nbsp;&nbsp;可否退货
		</div>
		<div class="ig">
			<input type="checkbox" id="storeChgPri" name="lmtMdfOpts" />&nbsp;&nbsp;门店变价
		</div>
		<div class="ig">
			<input type="checkbox" id="DCAttr" name="lmtMdfOpts" />&nbsp;&nbsp;DC属性
		</div>
		<div class="ig">
			<input type="checkbox" id="pchaPriLimit" name="lmtMdfOpts" />&nbsp;&nbsp;买价限制
		</div>
		<div class="ig">
			<input type="checkbox" id="BNOAttr" name="lmtMdfOpts" />&nbsp;&nbsp;BNO属性
		</div>
		<div class="ig">
			<input type="checkbox" id="deliveryDays" name="lmtMdfOpts" />&nbsp;&nbsp;配送天数
		</div>
	</div>
</div>

<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="itemMulModEditor()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWinTwo()">取消</div>
	</div>
</div>
