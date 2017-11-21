<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%@ include file="/page/commons/taglibs.jsp" %>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/loading/loading.css" />
<script type="text/javascript" src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js?t=1111" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/loading/loading.js?t=101001" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/common.js?t=1" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/promotionCreate.js?t=1002101" charset="utf-8"></script>
<script type="text/javascript">
	$(function() {
		var parames = $.trim('${parm }');
		if (parames) {
			var parObj = JSON.parse(parames);
			//查询列表赋值
			$("#promNo").val(parObj.promNo);
			$("#subjName").val(parObj.subjName);
			if (parObj.catlgId) {
				$("#catlgId").val(parObj.catlgId);
				pr_searchSectionMess(parObj.catlgId);
			}
			if (parObj.unitType) {
				$("#unitType").val(parObj.unitType);
				if (parObj.unitNo) {
					$("#unitNo").val(parObj.unitNo);
					pr_searchPromUnitName(parObj.unitNo,parObj.unitType);
				}
			}
			
			$("#buyBeginDateStart").val(parObj.buyBeginDateStart);
			$("#buyBeginDateEnd").val(parObj.buyBeginDateEnd);
			
			$("#buyEndDateStart").val(parObj.buyEndDateStart);
			$("#buyEndDateEnd").val(parObj.buyEndDateEnd);
		}
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click", function() {
			if ($(this).hasClass("Tools1_disable")) {
				return ;
			}
  			if ($(this).parent().hasClass("Tools1Parent_bg")) {
				$(this).attr("class","Icon-size1 Tools1 B-id");
				$(this).parent().removeClass("Tools1Parent_bg");
			} else {
				$(this).attr("class","Icon-size1 Tools1 B-id Tools1_on");
				$(this).parent().addClass("Tools1Parent_bg");
			}
  			$("input[name='catlgName']").addClass("Black");
  			$("#unitName").addClass("Black");
			DispOrHid('B-id');
		});
		$("#Tools21").parent().addClass("ToolsBg");
		$("#Tools21").attr('class','Icon-size1 Tools21_on Tools21').unbind().bind("click",function() {
			$("input").removeAttr("readonly");
			if ($(this).parent().hasClass("ToolsBg")) {
				return ;
			}
			pageQuery();
			$("#Tools22").parent().removeClass("ToolsBg");
			$("#Tools22").attr('class','Icon-size1 Tools22_disable');
	 		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id");
	 		$("#Tools11").attr('class', "Icon-size1 Tools11");
	 		$("#Tools21").parent().addClass("ToolsBg");
			$("#Tools21").attr('class','Icon-size1 Tools21_on Tools21');
		});
		//新增按钮
		$("#Tools11").attr('class', "Icon-size1 Tools11").unbind().bind("click", function() {
			if ($(this).hasClass("Tools11_disable")) {
				return ;
			}
			top.grid_layer_open();
			var parameter = {};
			parameter.promNo = $.trim($("#promNo").val());
			var str = encodeURI($.trim($("#subjName").val()));
			parameter.subjName = encodeURI(encodeURI($.trim($("#subjName").val())));
			//parameter.subjName = $.trim($("#subjName").val());
			parameter.catlgId = $.trim($("#catlgId").val());
			parameter.unitType = $.trim($("#unitType").val());
			parameter.unitNo = $.trim($("#unitNo").val());
			parameter.unitName = encodeURI(encodeURI($.trim($("#unitName").val())));
			
			parameter.buyBeginDateStart = $.trim($("#buyBeginDateStart").val());
			parameter.buyBeginDateEnd = $.trim($("#buyBeginDateEnd").val());
			
			parameter.buyEndDateStart = $.trim($("#buyEndDateStart").val());
			parameter.buyEndDateEnd = $.trim($("#buyEndDateEnd").val());
			var parm = JSON.stringify(parameter);
			window.location.href = ctx + "/prom/nondm/ho/createPromotionPage?parm=" + parm;
		});
		$(".pricPromTr_click").die("click");
		$(".pricPromTr_click").live("click", function() {
			var updatePromNo = $.trim($(this).children('td').eq(1).html());
			var buyBeginDate = new Date($.trim($(this).children('td').eq(4).html()).replace(/\-/g,"\/"));
			var buyEndDate = new Date($.trim($(this).children('td').eq(5).html()).replace(/\-/g,"\/"));
			var buyBeginDateStr=$.trim($(this).children('td').eq(4).html());
			var buyEndDateStr=$.trim($(this).children('td').eq(5).html());
			var nowDate = new Date("${nowDate }".replace(/\-/g,"\/"));
			$("#updatePromNo").val(updatePromNo);

			if (buyEndDate.getTime() < nowDate.getTime()) {
				$("#Tools12").attr('class', "Icon-size1 Tools12_disable").unbind("click");
				$("#Tools10").attr('class', "Icon-size1 Tools10_disable").unbind("click");
			} else {
				$("#Tools12").attr('class', "Icon-size1 Tools12").unbind("click").bind("click", function() {
					var updatePromNo = $("#updatePromNo").val();
					var parameter = {};
					parameter.promNo = $.trim($("#promNo").val());
					parameter.subjName = encodeURI(encodeURI($.trim($("#subjName").val())));
					
					parameter.catlgId = $.trim($("#catlgId").val());
					parameter.unitType = $.trim($("#unitType").val());
					
					parameter.buyBeginDateStart = $.trim($("#buyBeginDateStart").val());
					parameter.buyBeginDateEnd = $.trim($("#buyBeginDateEnd").val());
					
					parameter.buyEndDateStart = $.trim($("#buyEndDateStart").val());
					parameter.buyEndDateEnd = $.trim($("#buyEndDateEnd").val());
					var parm = JSON.stringify(parameter);
					window.location.href = ctx + "/prom/nondm/ho/createPromotionPage?updatePromNo="+updatePromNo+"&promType=update&buyBeginDate="+buyBeginDateStr+"&buyEndDate="+buyEndDateStr + "&parm=" + parm;
				});
			}
			if (buyBeginDate.getTime() > nowDate.getTime()) {
				$("#Tools10").attr('class', "Icon-size1 Tools10").unbind("click").bind("click", function() {
					deletePromotionMessage(updatePromNo);
				});
			} else {
				$("#Tools10").attr('class', "Icon-size1 Tools10_disable").unbind("click");
			}
			$("#Tools22").attr('class', "Icon-size1 Tools22").unbind("click").bind("click",function() {
				if ($(this).parent().hasClass("ToolsBg")) {
					return ;
				}
				if ($(this).hasClass("Tools22_disable")) {
					return ;
				}
				//top.grid_layer_open();
				onDblClickRow();
			});
		});
		pageQuery();
	});
	//查询进价促销列表
	/* function pageQuery(index){ */
    function pageQuery(){
    	$("#listData_div").html('');
    	$(".CTitle").html($("#promotionList").html());
    	$(".htable_div").show();
    	var dmPromNo = $.trim($("#promNo").val());
		if (!IsNum(dmPromNo)) {
			$("#promNo").val('');
			return ;
		}
		if($("#pageSizeHidden").val()==""){
			if ($("#pageSize").size()==0) {
				$("#pageSizeHidden").val(20);
			} 
		}
		$("#Tools1").attr('class', "Icon-size1 Tools1");
		$("#Tools11").attr('class', "Icon-size1 Tools11");
		$("#Tools12").attr('class', "Icon-size1 Tools12_disable").unbind("click");
		$("#Tools22").attr('class', "Icon-size1 Tools22_disable").unbind("click");
		$("#Tools22").parent().removeClass("ToolsBg");
		$("#Tools21").parent().addClass("ToolsBg");
		$("#Tools21").attr('class','Icon-size1 Tools21_on Tools21');
		
		var pricProm_form = $("#pricProm_form").serialize();
		$.post(ctx + '/prom/nondm/ho/searchPromotionMessage',pricProm_form, function(data) {
			if ($.trim(data) == "error") {
				top.jAlert('warning', '数据已显示完!', '提示消息');
			} else {
				$("#listData_div").html(data);
			}
		});
	}
	function clearPriceProm(){
		$(".reset").val('');
	}
    
 	

	//课别弹出框
	function showCatlog(){
		top.openPopupWin(602,180,'/prom/nondm/art/showCatlgWin');
	}
	
	
	function addCatlgReturn(catlgId,catlgName){
	  if(catlgId&&catlgName){
		$("input[name='catlgId']").val(catlgId);
		$("input[name='catlgName']").val(catlgName);
		$("#catlgId").removeClass("errorInput");
		$("#catlgId").attr("title", "");
	  }
	  top.closePopupWin();
	}
	//手动输入课别
	$("#catlgId").die("blur").live("blur",function(){
        var sectionNo = $.trim($(this).val());
        /*if (sectionNo == $(this).attr("prevl")) {
			return false;
		} */
		
		if(!isNumber(sectionNo)&&sectionNo){
			top.jAlert('warning', '输入课别有误',"提示消息");
			$("#catlgId").val('');
			$("input[name='catlgName']").val('');
			return;
		}
		//$(this).attr("prevl",sectionNo);
		if(sectionNo){
			pr_searchSectionMess(sectionNo);
		} else {
			$("input[name='catlgName']").val('');
		}
	});
	function isNumber(param) {
		var reg = new RegExp("^[0-9]*$");
		if ($.trim(param) == '') {
			return true;
		}
		if (!reg.test(param)) {
			return false;
		} else {
			return true;
		}
	}
	
    $("#catlgId").die("keydown").live("keydown",function(e){
		var sectionNo = $.trim($(this).val());
		$(this).attr("prevl",sectionNo);
		var event = e || window.event;
		var e = event || arguments.callee.caller.arguments[0];
		if (e.keyCode == 13) {
			if(sectionNo){
				$("#catlgId").blur();
				//pr_searchSectionMess(sectionNo);
				$("#pageNo").val(1);
				pageQuery();
			} else {
				$("input[name='catlgName']").val('');
			}
		}
	}); 

	//手动输入代号
	$("#unitNo").die("blur").live("blur",function(){
		var unitNo = $.trim($(this).val());
		/* $(this).attr('prev',unitNo);
		if(unitNo == $(this).attr('prev')){
			return ;
		} */
		if(unitNo==""){
			return;
		}
		var unitType = $.trim($("#unitType").val());
		if (unitType != "") {
			if(unitNo){
				if (!isNumber(unitNo)) {
					top.jAlert('warning', '输入代号有误', '提示消息');
					$("#unitNo").val('');
					$("#unitName").val('');
					return;
				}
				pr_searchPromUnitName(unitNo,unitType);
			} else {
				$("#unitNo").val('');
				$("#unitName").val('');
			}			
		} else {
			$("#unitNo").val('');
			$("#unitName").val('');
			top.jAlert('warning', '请选择代号类别!', '提示消息');
			return ;
		}
		

	});
	$("#unitNo").die("keydown").live("keydown",function(){
		var unitNo = $.trim($(this).val());
		$(this).attr('prev',unitNo);
		var unitType = $.trim($("#unitType").val());
		var event = e || window.event;
		var e = event || arguments.callee.caller.arguments[0];
		if (e.keyCode == 13) {
			if (unitType != "") {
				if(unitNo){
					//pr_searchPromUnitName(unitNo,unitType);
					$("#unitNo").blur();
					$("#pageNo").val(1);
					pageQuery();
				} else {
					$("#unitName").val('');
				}
			} else {
				top.jAlert('warning', '请选择代号类别!', '提示消息');
				return ;
			}
		}
	}); 
	
 	$(".Tools20").die("click").live("click",function(){
		$(".reset").val('');
	});
 	
 	function onDblClickRow() {
 		//DispOrHid('C-id');
 		if ($("#Tools1").parent().hasClass("Tools1Parent_bg")) {
 			DispOrHid('C-id');
 			$("#Tools1").parent().removeClass("Tools1Parent_bg");
			//$(".CircleClose").click();
 		}
 		//top.grid_layer_open(); 		
 		var updatePromNo = $("#updatePromNo").val();
 		//window.location.href = ctx + "/prom/nondm/ho/detailPromotionMessage?paramArray=" + paramArray + "&promNo=" + updatePromNo;
 		$.ajax({
 			type : 'post',
 			url : ctx + '/prom/nondm/ho/detailPromotionMessage',
 			data : {
 				promNo : updatePromNo
 			},
 			success : function(data){
 				$(".htable_div").hide();
 				$("#listData_div").html(data);
 			}
 		});
 	}
 
 	function searchPromListBack(){
 		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id");
 		$("#Tools11").attr('class', "Icon-size1 Tools11");
		$("#Tools22").parent().removeClass("ToolsBg");
		$("#Tools22").attr('class','Icon-size1 Tools22_disable');
		$("#Tools10").attr('class','Icon-size1 Tools10_disable');
		$("#Tools21").parent().addClass("ToolsBg");
		$("#Tools21").attr('class','Icon-size1 Tools21_on Tools21');
 		pageQuery();
		$("input[name='catlgName']").addClass("Black");
 		$("#unitName").addClass("Black");
		$("input").removeAttr("readonly");
 	}
 	
 	function clearEndInput()
	{
		$(this).blur();
	}
	function dateChange(obj){
		obj.value='';
	}
	$("#searchPromotionItem").die("keydown").live("keydown",function(event){
 		var evt=event?event:(window.event?window.event:null);//兼容IE和FF
        if(evt.keyCode == 13){
		  $("#pageNo").val(1);
		  pageQuery();
		}
	});
</script>
</head>
<body>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">总部进价促销</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<form id="pricProm_form" action="">
		<div class="Search Bar_off" id="searchPromotionItem">
			<div class="SearchTop">
				<span>查询条件</span>
				<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
			</div>
				<div class="SMiddle">
					<table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="ST_td1">
								<span>促销期数</span>
							</td>
							<td>
								<input id="promNo" name="promNo" maxlength="12" onkeyup="inputNumbers(this)" class="w65 inputText reset" type="text" />
							</td>
						</tr>
						<tr>
							<td>
								<span>主题</span>
							</td>
							<td>
								<input id="subjName" name="subjName" class="w85 inputText reset" type="text" />
							</td>
						</tr>
						<tr>
							<td>
								<span>课别</span>
							</td>
							<td>
								<div class="iconPut w65 fl_left">
									<input id="catlgId" name="catlgId" type="text" class="w80 reset" />
									<div class="ListWin" onclick="showCatlog()"></div>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<span>&nbsp;</span>
							</td>
							<td>
								<input name="catlgName" class="w85 inputText Black reset" type="text" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span>代号类别</span>
							</td>
							<td>
								<auchan:select mdgroup="PROM_UNIT_BY_ST_UNIT_TYPE" _class="w85 reset" onchange="{$(this).attr('title','');$(this).removeClass('errorInput');}" id="unitType" name="unitType" />
							</td>
						</tr>
						<tr>
							<td>
								<span>代号</span>
							</td>
							<td>
								<div class="iconPut w65 fl_left">
									<input id="unitNo" name="unitNo" type="text" class="w80 reset" />
									<div class="ListWin searchShowUnitWin"></div>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<span>&nbsp;</span>
							</td>
							<td>
								<input id="unitName" class="w85 inputText Black reset" type="text" readonly="readonly" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="span_right">
									采购起始
									<br />
									期间
								</span>
							</td>
							<td>
								<input id="buyBeginDateStart" name="buyBeginDateStart" type="text" class="Wdate w65 reset" onchange="dateChange(buyBeginDateEnd)" onclick="WdatePicker({onpicked:clearEndInput, isShowClear: false, readOnly: true,lang:'${calendarL}' })" />
								&nbsp;-
							</td>
						</tr>
						<tr>
							<td>
								<span>&nbsp;</span>
							</td>
							<td>
								<input id="buyBeginDateEnd" name="buyBeginDateEnd" type="text" class="Wdate w65 reset" onclick="WdatePicker({ isShowClear: false, readOnly: true,lang:'${calendarL}',minDate:'#F{$dp.$D(\'buyBeginDateStart\')}'})" />
							</td>
						</tr>
						<tr>
							<td>
								<span class="span_right">
									采购结束
									<br />
									期间
								</span>
							</td>
							<td>
								<input id="buyEndDateStart" name="buyEndDateStart" type="text" value="${nowDate }" class="Wdate w65 reset" onchange="dateChange(buyEndDateEnd)" onclick="WdatePicker({onpicked:clearEndInput, isShowClear: false, readOnly: true,lang:'${calendarL}' })" />
								&nbsp;-
							</td>
						</tr>
						<tr>
							<td>
								<span>&nbsp;</span>
							</td>
							<td>
								<input id="buyEndDateEnd" name="buyEndDateEnd" type="text" class="Wdate w65 reset" onclick="WdatePicker({ isShowClear: false, readOnly: true,lang:'${calendarL}',minDate:'#F{$dp.$D(\'buyEndDateStart\')}'})" />
							</td>
						</tr>
					</table>
				</div>
				<div class="line"></div>
				<div class="SearchFooter">
					<div class="Icon-size1 Tools20" onclick="clearPriceProm()"></div>
					<div class="Icon-size1 Tools6" onclick="pageQuery()"></div>
				</div>
			</div>
			<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
			<input type="hidden" name="pageSize" id="pageSizeHidden" />
		</form>
	<div id="promManage_div" class="Content">
	<div class="htable_div">
	<table>
	   <thead>
	       <tr>
	           <td><div class="t_cols align_center" style="width:30px;">&nbsp;</div></td>
	           <td><div class="t_cols" style="width:120px;">促销期数</div></td>
	           <td><div class="t_cols" style="width:280px;">主题</div></td>
	           <td><div class="t_cols" style="width:190px;">课别</div></td>
	           <td><div class="t_cols" style="width:120px;">采购起始日期</div></td>
	           <td><div class="t_cols" style="width:120px;">采购结束日期</div></td>
	           <td><div class="t_cols" style="width:80px;">促销天数</div></td>
	           <td><div style="width:85px;">&nbsp;</div></td>
	       </tr>
	   </thead>
	</table>
    </div>
    <div id="listData_div"></div>
	
	</div>
</div>
<input type="hidden" id="updatePromNo" ></input>
<div id="promotionList" style="display: none">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">总部进价促销</div>
	<div class="tags tags3_r_on"></div>
</div>
<div id="promotionDetail" style="display: none">
	<!--第一个-->
	<div class="tags1_left "></div>
	<div class="tagsM " id="ovreviewTab">总部进价促销</div>
	<div class="tags tags_right_on"></div>
	<!--最后一个-->
	<div class="tagsM tagsM_on">总部进价促销详情</div>
	<div class="tags3_close_on">
		<div class="tags_close" onclick="searchPromListBack()"></div>
	</div>
</div>
</body>
</html>