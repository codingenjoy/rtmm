<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<script type="text/javascript">

function addItemNo(){
		document.getElementById('contentIframe').contentWindow.addItemNoReturn($("#no").val(),$("#name").val());
}
function onClickRow(obj){
	$("#no").val($(obj).find("input[name='promNo']")[0].value);
	$("#name").val($(obj).find("input[name='promName']")[0].value);
}
function onDblClickRow(obj)
{
	document.getElementById('contentIframe').contentWindow.addItemNoReturn($("#no").val(),$("#name").val());

}
function enterIn(e){
	  var evt=e?e:(window.event?window.event:null);//兼容IE和FF
	  if (evt.keyCode==13){
	  $("#selectSeriesItem").click();
	}
	}

</script>
<style type="text/css">
.tp_store_bottom {
	margin: 15px 20px;
	height: 280px;
	border: 1px solid #e5e5e5;
}

.txi_list {
	height: 250px;
	overflow-y: auto;
	overflow-x: hidden;
}
/*overwrite*/
.cbankIcon {
	float: right;
	margin-right: 1px;
}

.item .item_gou {
	margin-top: 7px;
}

.item {
	padding-left: 15px;
	line-height: 30px;
}

.btable_div,.htable_div {
	width: 98%;
	margin-left: 1%;
}
.errorInput {
	border-color: #f00 !important;
	background-color: #FFC1C1 !important;
}
.IS_input {
	width: 95%;
	float: left;
	margin-top: 2px;
}

</style>
<form name="itemNo" id="showUnitWinFrom" onSubmit="return false;">
<div class="Panel_top">
	<span>选择代号</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto 5px auto; width: 97%; height: 100%;">
		
		<div style="height: 30px; background: #CCC;">
			 <div class="Icon-div">
                        <input type="text" onfocus="clearError()" name="itemName" onkeydown="enterIn(event);" class="IS_input" id="selectSereisItemNo"/>
                        <div class="cbankIcon" id="selectSeriesItem"></div>
             </div>
		</div>
		<div id="showUnitList" style="height: 300px">
			
		</div>
	
	</div>
</div>

<input id="no" type="hidden" />
<input id="name" type="hidden" />



</form>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1 btn" onclick="addItemNo()">确定</div>
		<div class="PanelBtn2 btn" onclick="closePopupWin()">取消</div>
	</div>
</div>
<div style="clear: both;"></div>
<script type="text/javascript">
function pageQuery() {
	var mySeriesItem=$.trim($("#selectSereisItemNo").val());
	if(mySeriesItem==""){
		$("#selectSereisItemNo").removeClass().addClass("IS_input errorInput");
		$("#selectSereisItemNo").attr("title","请注意查询条件");
		return;
	}	
	 var param = $("#showUnitWinFrom").serialize();
	 $.ajax({
			type : "post",
			data :param,
			dataType : "html",
			url: ctx + '/promotion/promotionItemStatistics/showUnitData',
			success : function(data) {
				$('#showUnitList').html(data);
			}
		});
	
}
function clearError(){
	$("#selectSereisItemNo").removeClass("errorInput");
	$("#selectSereisItemNo").attr("title","");
}
$(function(){
	//查询数据
	//pageQuery();
	//设置光标在此位置
	$("#selectSereisItemNo").focus();
     //查询事件
    $("#selectSeriesItem").click(function(){
    	var mySeriesItem=$.trim($("#selectSereisItemNo").val());
    	if(mySeriesItem!=""){
    		$("#pageNo").val(1);
    		pageQuery();
    	}else{
    		$("#selectSereisItemNo").removeClass().addClass("IS_input errorInput");
    		$("#selectSereisItemNo").attr("title","请注意查询条件");
    	}	
  	
    });
     
});
    
</script>
