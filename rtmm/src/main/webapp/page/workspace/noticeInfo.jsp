<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/calendar.css" rel="Stylesheet" />
<jsp:include page="/page/commons/knockout.jsp" />
<script>
	function ViewModel() {
		var self = this;
		self.id = ko.observable('${nvo.id}');
		self.title = ko.observable('${nvo.title}');
		self.content = ko.observable('${nvo.content}');
		self.createBy = ko.observable('${nvo.createBy}');
		self.createDate = ko.observable('${nvo.createDate}');
	}
	var viewModel = new ViewModel();
	ko.applyBindings(viewModel);
	
	function goBack(){
		showContent(ctx+'/workspace/noticeList');
	}
</script>
<style type="text/css">
.Table_Panel {
	height: 299px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}

.iconPut {
	height: 22px;
	border: 1px solid #999;
}

.twoinput23 {
	width: 25%;
	float: left;
}

.twoinput22 {
	width: 10%;
	float: left;
}
.CM_table td{
	text-align: left;
}
</style>
<div style="width:600px;hegith:400px;">
	<div class="Table_Panel">
		<table class="CM_table">
			<tr>
				<td class="w20">
					<span>主题</span>
				</td>
				<td class="w12">
					<div data-bind="text:viewModel.title"></div>
				</td>
			</tr>
			<tr>
				<td>
					<span>内容</span>
				</td>
				<td>
					<div data-bind="text:viewModel.content"></div>
				</td>
			</tr>
			<tr>
				<td><span>创建人</span></td>
				<td>
					<div data-bind="text:viewModel.createBy"></div>
				</td>
			</tr>
			<tr>
				<td>
					<span>创建时间</span>
				</td>
				<td>
					<div data-bind="text:viewModel.createDate"></div>
				</td>
			</tr>
		</table>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn2" onclick="goBack()">返回</div>
		</div>
	</div>
</div>

