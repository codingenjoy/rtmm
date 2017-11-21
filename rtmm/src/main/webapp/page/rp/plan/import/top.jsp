<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css"> 
.CInfo span {
 line-height:none;
}
.item22 {
	display: inline-block;
	float: left;
	padding: 3px 20px;
	margin-left: 5px;
	margin-top: 1px;
	cursor: pointer;
}

.CInfo .fl_right {
	margin-right: 5px;
	margin-top: 5px;
}

.tr_click_on .Icon-size1 {
	display: block;
	/* background: url(../images/choosed.png) 0 0 no-repeat; */ 
	margin-left: 4px;
}

.choosed {
	display: block;
	float: left;
	width: 17px;
	height: 17px;
	/* background: url(../images/choosed.png) -20px 0 no-repeat; */
	margin-left: 4px;
	margin-top: 3px;
}

/**/
.frozen_div {
	height: 465px;
	width: 100%;
	margin-top: 2px;
	border-bottom: 1px solid #ccc;
	overflow: hidden;
	background: #f9f9f9;
}
/*frozen table*/
.m_cols_head div,.f_cols_head div {
	border-right: 1px solid #ccc;
}

.frozen_cols {
	height: 100%;
	width: 760px;
}

.move_cols {
	height: 100%; /* equals #frozen_cols.height */
	width: 271px;
}

.f_cols_head,.m_cols_head {
	height: 31px;
	border-bottom: 1px solid #ccc;
}

.f_cols_body,.m_cols_body {
	height: 435px;
}

.uploader {
	position: relative;
	display: inline-block;
	overflow: hidden;
	cursor: default;
	padding: 0;
	float: left;
}

.filename {
	float: left;
	display: inline-block;
	outline: 0 none;
	height: 20px;
	line-height: 20px;
	width: 180px;
	margin: 0;
	padding: 0;
	overflow: hidden;
	cursor: default;
	border: 1px solid;
	border-right: 0;
	text-overflow: ellipsis;
	white-space: nowrap;
	background: #f5f5f5;
	border-color: #ccc;
}

input[type=file] {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	border: 0;
	padding: 0;
	margin: 0;
	height: 20px;
	cursor: pointer;
	filter: alpha(opacity = 0);
	-moz-opacity: 0;
	-khtml-opacity: 0;
	opacity: 0;
}
</style>

<div class="CInfo" style="position: relative; height:37px;">
	<iframe name='hidden_frame' id="hidden_frame" style="display: none"></iframe>
	<form action="${ctx}/rp/plan/importExcel2db/" method="post" enctype="multipart/form-data" target="hidden_frame" id="importForm">
		<div class="uploader" id="uploader">
			<input id="importExcel2db" name="file" type="file" size="80" style="width: 80px" onchange="upload()">
			<div class="icol_file fl_left"></div>
			<div class="icol_text">&nbsp;上传文件</div>
		</div>
	</form>
	<div id="resultTab" style="display: none">
		<span class="item22" id="error_import" onclick="displayInvalid()">导入错误</span> <span class="item22 item_on" id="right_import"
			onclick="displayValid()">导入正确</span>
		<input id="totalCount" readonly="readonly" type="text" class="inputText w7 fl_right" value="${totalCount}">
		<span class="icol_text">导入条目数&nbsp;</span>
	</div>
</div>

<script type="text/javascript">

$(".item22").bind("click", function () {
    $(".item22").parent().find(".item_on").removeClass("item_on");
    $(this).addClass("item_on");
});

function upload() {
	//验证文件是否为xlsx
	var fname = document.getElementById("importExcel2db").value;
	if (".xlsx" != fname.substring(fname.lastIndexOf("."))) {
		top.jWarningAlert("上传格式有误");
		return;
	}
	grid_layer_open();
	$('#importForm').submit();
	document.getElementById('uploader').innerHTML = document.getElementById('uploader').innerHTML;
}

function callback(msg) {
	eval("var data = " + msg);
	if (data.status == 'success') {
		var param = {
			'processId' : data.content
		};
		
		$.post('${ctx}/rp/plan/getTempRecord', param, function(data) {
			$('#resultTab').show();
			$("#detailDiv").html(data);
			grid_layer_close();
		}); 
		grid_layer_close();
		
	} else {
		grid_layer_close();
		top.jWarningAlert(data.message);
	}
}

</script>
