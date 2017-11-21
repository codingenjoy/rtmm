<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.Table_Panel {
	height: 550px;
	overflow: hidden;
}

.CM_p {
	height: 280px;
	width: 595px;
	margin: 2px auto 0px auto;
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

.hh_item2 {
	margin-top: 6px;
	height: 24px;
}
.red_bno_node{
        	color:red;
        }
</style>
<form id="newSupAreaForm" action="/item/update/addNewSupAreaGroup" onsubmit="return false;" >
	<div class="Panel" style="border: none; width:635px;">
		<div class="Panel_top">
			<span>选择下传区域</span>
			<div class="PanelClose" onclick="closePanel()"></div>
		</div>
		<div class="Table_Panel">
			<div class="ig">
				<div class="hh_item2">
					<input type="hidden" id="updataTag">
					<div class="icol_text w10">
						<span>厂商</span>
					</div>
					<div style="width: 13%;" class="iconPut iq" onclick="supplierPopup()">
						<input type="text" id="supNo" style="width: 70%" onchange="getSupAreaBySupplier()" readonly="readonly">
						<div class="ListWin"></div>
					</div>
					<input id="supName" type="text" style="width: 40%;" class="inputText iq supplierName">
					<span>BNO属性</span>
                  	<select class="w15 bnoName mustInput" name="mops" onchange="changeNodeBNOResult()" >
                  	<option value="B" selected="selected">B</option>
                	<option value="N">N</option>
                	<option value="O">O</option>
                	</select>
				</div>
			</div>
			<div class="CM_p">
				<div class="CM-bar" style="height: 280px;">
					<div>大卖场</div>
				</div>
				<div class="t2">
					<ul id="tt"></ul>
				</div>
				<div class="t3">
					<div class="b inputDiv" style="width: 180px;" id="storeDiv">
					</div>
					<div class="f" style="width: 180px;">
						<label> <input id="storeCheckAll" type="checkbox" name="n" class="checkAll"  />
						</label> <span>全选</span>
					</div>
				</div>
			</div>
			<div style="width: 595px; height: 240px; margin: 3px auto;">
				<div class="CM2" style="float: left;">
					<div class="CM-bar" style="height: 240px;">
						<div>加工中心</div>
					</div>
					<div class="d">
						<div class="e inputDiv" id="machinDiv"></div>
						<div class="f">
							<label> <input type="checkbox" name="a" class="checkAll jgCsAttr"  />
							</label> <span>全选</span>
						</div>
					</div>
				</div>
				<div class="CM2" style="margin-left: 3px; float: right;">
					<div class="CM-bar" style="height: 240px;">
						<div>物流中心</div>
					</div>
					<div class="d">
						<div class="e inputDiv" id="dcCenterDiv">
							<c:forEach items="${machiningList}" var="store">
								<div class="item4">
									<label><input type="checkbox" name="storeNo" value="${store.storeNo}"  />
									</label> <span>${store.storeName}</span>
								</div>
							</c:forEach>
						</div>
						<div class="f">
							<label><input type="checkbox" name="d" class="checkAll dcSupAttr" /> </label> <span>全选</span>
						</div>
					</div>
				</div>
			</div>

		</div>
		<div class="Panel_footer">
			<div class="PanelBtn">
				<div class="PanelBtn1" onclick="addOneSupArea()">确定</div>
				<div class="PanelBtn2" onclick="closePanel()">取消</div>
			</div>
		</div>
	</div>
</form>
<div id="" style="display: none;"></div>
<script type="text/javascript">

// 取得其小分類的BNO
$.post(ctx + "/item/create/getBnoResult","catlgId="+$('#catlgId').val(),function(data){
	bnoResult = data;
});

$(function(){

}); 
</script>