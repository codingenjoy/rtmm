<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		inputToInputIntNumber();
	});
	//checkedbox点击事件
	function onclickCheckBox(obj){
		if(obj.checked){
			var flag = true;
			var acctElem = obj.parentNode.parentNode;
			var acctNo = acctElem.cells[2].innerHTML;
			for (var i = 0; i < acctsArray.length; i++){
				var acctMap = acctsArray[i];
				if(acctMap.grpAcctNo == acctNo){
					flag = false;
					break;
				}
			}
			if (flag) {
				var acctMap = {};
				acctMap.grpAcctNo = acctNo;
				acctMap.grpAcctName = acctElem.cells[3].innerHTML;
				acctMap.grpAcctId = acctElem.cells[1].innerHTML;
				acctMap.grpAcctAbbr = acctElem.cells[5].innerHTML;
				acctsArray.push(acctMap);
			}
		}else{
			var acctElem = obj.parentNode.parentNode;
			var acctNo = acctElem.cells[2].innerHTML;
			for (var i = 0; i < acctsArray.length; i++){
				var acctMap = acctsArray[i];
				if(acctMap.grpAcctNo == acctNo){
					acctsArray.splice(i,1);
					break;
				}
			}
		}
		checkWhetherCheckedAll();
	}
	//回车事件
	function acctEnterTheEvent(){
		e = event ? event :(window.event ? window.event : null); 
		if(e.keyCode==13){
			//执行的方法 
			var pageNo = $("#grpAcctsDiv #accGroupPage .click_block").text();
			var pageSize = $("#grpAcctsDiv #accGroupPage select").val();
			templContractPageQuery(pageNo,pageSize);
		}
	}
	//检查checkbox是否全部被选择
	function checkWhetherCheckedAll(){
		var pageSizeStr = $("#grpAcctsDiv #accGroupPage select").val();
		var checkedElem = $("#grpAcctsDiv table :checked");
		if (checkedElem.length == pageSizeStr) {
			document.getElementById("checkBoxAll").checked = true;
		} else {
			document.getElementById("checkBoxAll").checked = false;
		}
	}
	//回调查询函数
	function templContractPageQuery(pageNo,pageSize){
		var grpAcctId = $.trim($("#grpAcctId").val());
		if (grpAcctId == "请输入科目组编号进行查询"){
			grpAcctId = '';
		}
		if (grpAcctId) {
			if (thisNoNum(/*string*/grpAcctId, /*int*/4)) {
				$("#grpAcctId").addClass("errorInput");
				$("#grpAcctId").attr("title","请输入4位以内数字");
				return ;
			}
		}
		var param = $('#grpAcctFrom').serialize();
		param = joinPostParam(param, 'pageNo', pageNo || 1);
		param = joinPostParam(param, 'pageSize', pageSize || 10);
		param = joinPostParam(param, 'grpAcctId', grpAcctId || '');
		$.ajax({
			type : 'post',
			url : ctx + "/supplier/contract/common/searchAcctGroupData",
			data : param,
			success : function(data){
				$("#grpAcctsDiv").html(data);
			}
		});
	}
	//checkbox全选事件
	function selectAllCheckedBox(obj){
		if (obj.checked) {
			var trArray = $("#grpAcctsDiv table tr");
			for (var i = 0; i < trArray.length; i++) {
				tdElem = trArray[i].cells[0].children[0];
				tdElem.checked = true;
				onclickCheckBox(tdElem);
			}
		} else {
			var trArray = $("#grpAcctsDiv table tr");
			for (var i = 0; i < trArray.length; i++) {
				tdElem = trArray[i].cells[0].children[0];
				tdElem.checked = false;
				onclickCheckBox(tdElem);
			}
		}
	}
	
	function thisNoNum(/*string*/val, /*int*/digit){
		var reg = new RegExp("^[0-9]{0,"+digit+"}$");
		if (reg.test(val)) {
			return false;
		} else {
			return true;
		}
	}

</script>
<style type="text/css">
    .Panel {
        width:800px;
    }
    .Table_Panel {
        height:450px;
        overflow:hidden;
    }
    .Table_Panel td{
        height:30px;
    }
    .ListIcon {
         float: left; 
         margin-top:auto; 
         margin-right:auto;
    }
</style>
<div class="Panel_top">
	<span>选择科目组</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin();" ></div>
</div>
<div class="Table_Panel">
		<div style="margin: 15px auto 0px auto; width: 97%; height: 100%;">
			<div style="height: 30px; background: #CCC;">
				<form id="grpAcctFrom" action="">
					<div class="Icon-div">
						<input id="grpAcctId" type="text" class="IS_input count_text" placeholder="请输入科目组编号进行查询" onfocus="$(this).attr('title','');$(this).removeClass('errorInput');" onkeydown="acctEnterTheEvent();" />
						<div class="cbankIcon" onclick="templContractPageQuery();" ></div>
						<input name="tabType" type="hidden" value="${tabType }" />
					</div> 
				</form>
			</div>
			<div class="search_tb_p">
				<!-- <table id="update_items" style="height:400px;"></table>-->
				<div class="htable_div">
					<table>
						<thead>
							<tr>
								<td>
									<div class="t_cols align_center" style="width: 30px;">
										<input id="checkBoxAll" type="checkbox" onclick="selectAllCheckedBox(this);" />
									</div>
								</td>
								<td><div class="t_cols" style="width: 70px;">序号</div></td>
								<td><div class="t_cols" style="width: 120px;">科目组编号</div></td>
								<td><div class="t_cols" style="width: 200px;">中文名</div></td>
								<td><div class="t_cols" style="width: 200px;">英文名</div></td>
								<td><div class="t_cols" style="width: 100px;">缩写</div></td>
								<td><div style="width: 16px;">&nbsp;</div></td>
							</tr>
						</thead>
					</table>
				</div>
				<div id="grpAcctsDiv" >
					<jsp:include page="/page/contract/choiceOfAcctGroupList.jsp" />
				</div>
			</div>
		</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="writeGrpAcctId()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin();">取消</div>
	</div>
</div>
