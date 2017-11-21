
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css"
	rel="Stylesheet" />
<style type="text/css">
.Table_Panel {
	max-height: 550px;
	overflow: hidden;
	height: auto;
}

.p52_2_1 {
	min-height: 323px;
	max-height: 523px;
	height: auto;
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

.CM-div-by {
	width: 90%;
	height: 92%;
	float: left;
	overflow-y: auto;
	max-height: 490px;
}

.f_c {
	width: 80%;
	height: 20px;
	border-top: #ccc solid 1px;
	margin-left: 30px;
	color: #808080;
	float: left;
}

.CM-bar {
	height: 550px;
}

input[disabled="disabled"] {
	border: 1px solid #6c6c6c;
}
</style>
<div class="Panel_top">
	<span>选择修改项</span>
	<div class="PanelClose" onclick="closePopupWinTwo()"></div>
</div>
<div class="Table_Panel">
	<div class="p52_2_1 CM">
		<div class="CM-bar">
			<div>修改项</div>
		</div>
		<div class="CM-div-by" style="width: 90%;" id="mdfOption">
			<div class="ig" style="margin-top: 15px;">
				<input type="checkbox" name="lmtMdfOpts" value="itemName" />&nbsp;&nbsp;品名
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="itemEnName" />&nbsp;&nbsp;英文品名
			</div>
			<!-- 		<div class="ig">
			<input type="checkbox" name="lmtMdfOpts" value="catlgId" />&nbsp;&nbsp;大中小分类
		</div> -->
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="brandId" />&nbsp;&nbsp;品牌
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="itemType" />&nbsp;&nbsp;商品类别
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="validDate" />&nbsp;&nbsp;有效期间
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="itemPack" />&nbsp;&nbsp;商品包装
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="prcssType" />&nbsp;&nbsp;加工类别
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="buyPerd" />&nbsp;&nbsp;采购期限
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="barcodeLabel" />&nbsp;&nbsp;条码标签
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="sellUnit" />&nbsp;&nbsp;销售单位
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="buyWhen" />&nbsp;&nbsp;成本时点
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="txtCode" />&nbsp;&nbsp;纺织项目编号
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="orignCtrl" />&nbsp;&nbsp;产地维护
			</div>
			<div class="ig">
				<input type="checkbox" name="lmtMdfOpts" value="buyMemo" />&nbsp;&nbsp;采购备注
			</div>
		</div>
		<div class="f_c">*最多可同时选择5项修改项。</div>
	</div>
</div>
<div class="Panel_footer" style="width: inherit;">
	<div class="PanelBtn">
		<div class="PanelBtn1"
			onclick="itemBaseInfoEditor('${itemNumModStr}')">确定</div>
		<div class="PanelBtn2" onclick="closePopupWinTwo()">取消</div>
	</div>
</div>
