<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<script src="${ctx}/shared/js/order/orderTemplateImport.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/workspace/report.js"></script>
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
	background: url(../images/choosed.png) 0 0 no-repeat;
	margin-left: 4px;
}

.choosed {
	display: block;
	float: left;
	width: 17px;
	height: 17px;
	background: url(../images/choosed.png) -20px 0 no-repeat;
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
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div class="tagsM" id="hoOrderListTag">总部订单信息</div>
	<div class="tags tags_right_on"></div>
	<div class="tagsM_q  tagsM_on">导入总部订单</div>
	<div class="tags3_close_on">
		<div class="tags_close"></div>
	</div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo" style="position: relative;">
			<iframe name='hidden_frame' id="hidden_frame" style="display: none"></iframe>
			<form action="${ctx}/order/importExcel2db/" method="post" enctype="multipart/form-data" target="hidden_frame" id="importForm">
				<div class="uploader" id="uploader">
					<input id="importExcel2db" name="file" type="file" size="80" style="width: 80px" onchange="upload()">
					<div class="icol_file fl_left"></div>
                    <div class="icol_text">&nbsp;上传文件</div>
				</div>
			</form>
			<div id="displayDiv" style="display: none">
				<span class="item22" id="error_import" onclick="displayInvalid()">导入错误</span>
				<span class="item22 item_on" id="right_import" onclick="displayValid()" >导入正确</span>
				<input id="totalCount" readonly="readonly" type="text" class="inputText w7 fl_right" value="0">
				<span class="icol_text">导入条目数&nbsp;</span>
			</div>
		</div>
		<div id="templateList"></div>
	</div>
</div>
<script type="text/javascript">

	$(".item22").bind("click", function () {
	    $(".item22").parent().find(".item_on").removeClass("item_on");
	    $(this).addClass("item_on");
	});
	
	$(".order_list:odd").css("background", "#f9f9f9");
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
	$(".tags_close").unbind("click").bind("click", function() {
		showContent("${ctx}/order/hoOrder");
	});

	$("#hoOrderListTag").unbind("click").bind("click", function() {
		showContent("${ctx}/order/hoOrder");
	});

	function callback(msg) {
		eval("var data = " + msg);
		if (data.status == 'success') {
			var param = {
				'processId' : data.content
			};
			$.post('${ctx}/order/getTempRecord', param, function(data) {
				$('#displayDiv').show();
				$("#templateList").html(data);
				grid_layer_close();
			});
		} else {
			grid_layer_close();
			top.jWarningAlert(data.message);
		}
	}
    
</script>
