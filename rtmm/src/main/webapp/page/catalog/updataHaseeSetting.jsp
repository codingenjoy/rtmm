<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel2 {
	height: 200px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>

<script type="text/javascript">
	/* 	var viewModel = new ViewModel();
	 ko.applyBindings(viewModel);
	 $(function() {
	 }); */
</script>
<div class="Panel_top">
	<span>修改神舟分类目标</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="t72">
	<div class="col73"></div>
	<div class="col72">
		<span class="col_span">大分类</span>
		<div class="col_div">
			<div class="iconPut Black" style="width: 25%; float: left;">
				<input type="text" class="w75 Black" />
				<div class="ListWin"></div>
			</div>
			<input type="text" class="inputText twoInput2 Black" style="width: 60%;" />
		</div>
	</div>
	<div class="col72">
		<span class="col_span">中分类</span>
		<div class="col_div">
			<div class="iconPut Black" style="width: 25%; float: left;">
				<input type="text" class="w75 Black" />
				<div class="ListWin"></div>
			</div>
			<input type="text" class="inputText twoInput2 Black" style="width: 60%;" />
		</div>
	</div>
	<div class="col72">
		<span class="col_span">小分类</span>
		<div class="col_div">
			<div class="iconPut Black" style="width: 25%; float: left;">
				<input type="text" class="w75 Black" />
				<div class="ListWin"></div>
			</div>
			<input type="text" class="inputText twoInput2 Black" style="width: 60%;" />
		</div>
	</div>
	<div class="col72">
		<div class="title72_1">神舟目标</div>
		<div class="title72_2" style="border-bottom: 1px solid #ccc;">
			<div>&nbsp;</div>
			<div>等级1</div>
			<div>等级2</div>
			<div>等级3</div>
			<div>等级4</div>
		</div>
	</div>
	<div class="col73" style="margin-top: 5px;">
		<div class="title72_1">&nbsp;</div>
		<div class="title72_3">
			<div>定位</div>
<!-- 			<div>
				<input id="t72_1" name="dept" data-options="editable:false,panelHeight:'auto'" />
			</div>
			<div>
				<input id="t72_2" name="dept" data-options="editable:false,panelHeight:'auto'" />
			</div>
			<div>
				<input id="t72_3" name="dept" data-options="editable:false,panelHeight:'auto'" />
			</div>
			<div>
				<input id="t72_4" name="dept" data-options="editable:false,panelHeight:'auto'" />
			</div> -->
		</div>
	</div>
	<div class="col73" style="margin-top: 5px;">
		<div class="title72_1">&nbsp;</div>
		<div class="title72_3">
			<div>B</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText" />
			</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText" />
			</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText" />
			</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText" />
			</div>
		</div>
	</div>
	<div class="col73" style="margin-top: 5px;">
		<div class="title72_1">&nbsp;</div>
		<div class="title72_3">
			<div>N</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText Black" />
			</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText" />
			</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText" />
			</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText Black" />
			</div>
		</div>
	</div>
	<div class="col73" style="margin-top: 5px;">
		<div class="title72_1">&nbsp;</div>
		<div class="title72_3">
			<div>O</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText Black" />
			</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText Black" />
			</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText" />
			</div>
			<div>
				<input type="text" style="width: 45px;" class="inputText Black" />
			</div>
		</div>
	</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1">确认</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>
