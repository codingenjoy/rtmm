<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<%@ include file="/page/commons/toolbar.jsp"%>
<script type="text/javascript">
 
 	// 让bar中的某个菜单可用(新增)
    <auchan:operauth ifAnyGrantedCode="112211996" >
	 	$('#Tools11').removeClass('Tools11_disable').addClass('Tools11').bind('click',function() {
			showContent('/series/seriesAdd');
		});
 	</auchan:operauth>
    
	//查询按钮
	$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').bind('click',
			function() {
				DispOrHid('B-id');
				gridbar_B();
			});

	$(function() {
		seriesList();
		//默认关闭查询窗口
		DispOrHid('C-id');

		$("#seriesPro").click(function() {

			if ($("#seriesPro").attr("checked") == "checked") {
				alert($("#seriesPro").attr("checked"));

			}
		});

		//为层注册一个click事件
		$("#seriesSearch").unbind().mousedown(function() {
			seriesList();

		});

		//为系列类型添加弹出层事件
		$("#searchCatlgIdBtn").unbind("click").bind("click",
				function() {
					//打开弹出层
					openPopupWin(600, 500, '/commons/window/chooseSection');
				});
		//为商品列表加入弹出层事件
		$("#searchRefItemNo").unbind("click focus").bind("click focus",
				function() {
			$("#seriesSearch").focus();
					//打开弹出层
					openPopupWin(600, 500, '/series/toSearchRefItemList');
				});
	});

	//根据弹出层回调结果信息  
	function confirmChooseSection(id, name) {
		$('#searchCatlgId').attr('value', id);
		$('#searchSectionName').attr('value', name);
		//关闭弹出层
		closePopupWin();
	}

	//根据弹出层回调结果信息
	function confirmChooseSeries(rowData) {
		$("#searchRefItemNo").val(rowData.itemNo);
		//关闭弹出层
		closePopupWin();
	}

	//加载jqyeryeasyui页面信息

	var searchClstrId = "";//系列编号	
	var searchClstrName = "";//系列编号
	var searchCatlgId = "";//课别
	var searchRefItemNo = "";//商品货号
	var searchClstrType = "";//系列类型
	var searchBatchPriceChngInd="";//商品同价

	//我的草稿箱-厂商管理列表
	function seriesList() {

		searchClstrId = $.trim($("#searchClstrId").val());//系列编号	
		searchClstrName = $.trim($("#searchClstrName").val());//系列编号
		searchCatlgId = $.trim($("#searchCatlgId").val());//课别
		searchRefItemNo = $.trim($("#searchRefItemNo").val());//商品货号
		searchClstrType = $.trim($("#searchClstrType").val());//系列类型
		searchBatchPriceChngInd=$("#searchBatchPriceChngInd").val();
		//正则表达式
		if (isNumber(searchClstrId)&&isNumber(searchCatlgId)) {
			//执行查询
			readItemSeriesInfos(1,20);
		} else {
			top.jAlert('warning', '请注意查询条件', '提示消息');
		}

	}

	//翻页信息
	function pageQuery() {
		readItemSeriesInfos($("#pageNo").val(), $("#pageSize").val());
	}
	

	//商品列表
	function readItemSeriesInfos(pageNo, pageSize) {
		$.ajax({
			url : "<c:url value='/series/readSeriesByPage'/>",
			type : "post",
			dataType : "html",
			data : {
				clstrId : searchClstrId,
				clstrName : searchClstrName,
				catlgId : searchCatlgId,
				refItemNo : searchRefItemNo,
				clstrType : searchClstrType,
				batchPriceChngInd:searchBatchPriceChngInd,
				pageNo : pageNo,
				pageSize : pageSize
			},
			success : function(data) {
				$("#seriesList").html(data);
			},
			error : function(XMLHttpRequest, textStatus,
					errorThrown) {
				//这里是ajax错误信息  
			}
		});
	}
		
	//验证信息，必须输入数字
	function isNumber(str) {
		var result = str.match(/^[0-9]{0,10}$/);
		if (result == null)
			return false;
		return true;
	}

	//选择弹出框，点确定后，需执行固定方法完成自己想要的结果(页面调用通用方法)	
	function confirmAlert(msg, width, height, title) {
		var $body = $("body");
		$body.append('<div id="alert_layer"></div>');
		var $layer = $("#alert_layer");
		var w = $(document).width();
		var h = $(document).height();
		$layer.css({
			"width" : w,
			"height" : h,
			"display" : "block"
		});

		$body
				.append('<div id=\"confirmAlert\" class=\"Panel\"><div class=\"alert_top\"><span id=\"alert_confirm_title\" class=\"alert_title\">confirm提示！</span><div id=\"alert_close\" class=\"PanelClose\"></div></div><div class=\"Table_Panel\" id=\"alert_confirm_body\"><div class=\"alert_body\"><div class=\"alert_b1 alert_comfirm \"></div><div id=\"alert_confirm_text\" class=\"alert_text\">这是一个confirm提示框！</div></div></div><div class=\"Panel_footer\"><div class=\"PanelBtn\"><div class=\"PanelBtn1\">确定</div><div class=\"cancel\">取消</div></div></div></div>');
		if (height != '' && height != undefined) {
			$("#alert_confirm_body").css("height", height);
		} else {
			height = 60;
		}
		if (width != '' && width != undefined) {
			$("#confirmAlert").css({
				"width" : width + 'px'
			});
		} else {
			width = 500;
		}
		if (msg != '' && msg != undefined) {
			$("#alert_confirm_text").html(msg);
		}
		if (title != '' && title != undefined) {
			$("#alert_confirm_title").html(title);
		}
		var win_x = ($(window).width() - width) / 2;//随着浏览器的变化而变化，而且不计算滚动条
		var win_y = ($(window).height() - (Number(height) + 60)) / 2
				+ $(window).scrollTop();
		$("#confirmAlert").css({
			"display" : "block",
			"z-index" : "10000",
			"position" : "absolute",
			"top" : win_y + 'px',
			"left" : win_x + 'px'
		});

		$(".PanelBtn1").unbind("click").bind("click", function() {
			//需要指定方法 特定函数，需指定
			executeFuction();
			$(this).parents(".Panel").remove();
			$("#alert_layer").remove();

		});
		$(".cancel,#alert_close,.btn1").unbind("click").bind("click",
				function() {
					$(this).parents(".Panel").remove();
					$("#alert_layer").remove();

				});

	}


	 //加载课别属性信息 
    function loadSecCtrl(catlgId,methodName){
    	$.ajax({
			type : 'post',
			dataType:'json',
			url : ctx + '/series/readClSecCtrlByCatlgId?tt='
					+ new Date().getTime(),
			data : {
				catlgId : catlgId				
			},
			success : function(data) {
				methodName(data);

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				//这里是ajax错误信息
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
        }

	 //清除选择项
$("#clearSearch").click(function(){
$("#SearchItemTable :input").val("");
	});
    
    
    //如果值为null 则定义为‘’
	function setNulltoEmpty(str) {
		if (str == null) {
			str = "";
		}
		return str;
	}

    //课别选项
$("#searchCatlgId").unbind("blur").blur(function(){
	$("#searchSectionName").val("");
var secNo=$("#searchCatlgId").val();

if(isNumber(secNo) && secNo!=""){
     //加载课别信息
	readCatalogInfoBySecNo(secNo,function(data){
          if(data!="" && data.length>0){
				$("#searchSectionName").val(data[0].secName);
              }
		});		
}
});


//回车事件绑定
$("#SearchItemDiv").unbind("keypress").keypress(function(event){		
	if(event!== null && event.keyCode == 13){
		$("#seriesSearch").focus();
		 $("#seriesSearch").mousedown();
		} 
}); 
	
</script>





<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="103002001"></auchan:i18n></div>
	<div class="tags tags3_r_on"></div>
</div>


<div class="Container-1">
	<div class="Search Bar_on" id="SearchItemDiv">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span><auchan:i18n id="100002013"></auchan:i18n></span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle">
			<table class="SearchTable" id="SearchItemTable">
				<tr>
					<td class="ST_td1"><span><auchan:i18n id="103002002"></auchan:i18n></span></td>
					<td><input id="searchClstrId" class="w80 inputText"
						type="text" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="103002003"></auchan:i18n></span></td>
					<td><input id="searchClstrName" class="w80 inputText"
						type="text" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="103002004"></auchan:i18n></span></td>
					<td>
					<div class="iconPut fl_left w55">
							<input class="w75" type="text" id="searchCatlgId" />
							<div class="ListWin" id="searchCatlgIdBtn"></div>
						</div>
					
				</td>
				</tr>
				<tr>
					<td><span>&nbsp;</span></td>
					<td><input type="text" id="searchSectionName" class="inputText w80 Black" readonly="readonly" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="103002005"></auchan:i18n></span></td>
					<td><input id="searchRefItemNo" class="w80 inputText" readonly="readonly"/></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="103002007"></auchan:i18n></span></td>
					<td><auchan:select id="searchClstrType"
							mdgroup="ITEM_CLUSTER_CLSTR_TYPE" _class="w80"
							/></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="103002008"></auchan:i18n></span></td>
					<td><auchan:select id="searchBatchPriceChngInd"
							mdgroup="ITEM_CLUSTER_BATCH_PRICE_CHNG_IND" _class="w80"
							/></td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20" id="clearSearch"></div>
			<div class="Icon-size1 Tools6" id="seriesSearch"></div>
		</div>
	</div>
	<div class="Content" id="seriesList">
		<!-- <table id="seriesList" style="height: 570px;"></table> -->
	</div>
	<div class="Content" id="seriesDetail" style="display: none;">
		<!-- <table id="seriesList" style="height: 570px;"></table> -->
	</div>
</div>
