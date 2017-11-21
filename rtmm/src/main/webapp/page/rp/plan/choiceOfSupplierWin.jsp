<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		//inputToInputIntNumber();
	});
	function selectIncident(obj){
		var checkElem = obj.children[0].children[0];
		$("#rpSupplierDiv table input[type=checkbox]").attr("checked",false);
		checkElem.checked = true;
	}
	//回车事件
	function acctEnterTheEvent(){
		e = event ? event :(window.event ? window.event : null); 
		if(e.keyCode==13){
			//执行的方法 
			var pageNo = $("#rpSupplierDiv #planItemPage .click_block").text();
			var pageSize = $("#rpSupplierDiv #planItemPage select").val();
			planPageQuery(pageNo,pageSize);
		}
	}
	//回调查询函数
	function planPageQuery(pageNo,pageSize){
		var comName = $.trim($("#comName").val());
		if (comName == "请输入货号进行查询"){
			comName = '';
		}
		//获取课别
		var catlgId = $.trim($("#crCatlgId").val());
		var param = $('#planItemFrom').serialize();
		var itemNo = $("#itemListFirstDivArea .tr_click_on").get(0).children[0].children[0].children[0].value;
		param = joinPostParam(param, 'pageNo', pageNo || 1);
		param = joinPostParam(param, 'pageSize', pageSize || 10);
		param = joinPostParam(param, 'comName', comName || '');
		param = joinPostParam(param, 'catlgId', catlgId || '');
		param = joinPostParam(param, 'itemNo', itemNo || '');
		$.ajax({
			type : 'post',
			url : ctx + "/rp/plan/choiceSupplierList",
			data : param,
			success : function(data){
				$("#rpSupplierDiv").html(data);
			}
		});
	}

	function getCheckedSuppler(){
		var supplier = {};
		var checkElem = $("#rpSupplierDiv table :checked");
		if (checkElem) {
			var supNo = $(checkElem).parent().next().text();
			var comName = $(checkElem).parent().next().next().text();
			supplier.supNo = supNo;
			supplier.comName = comName;
		}
		return supplier;
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
	<span>选择厂商</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin();" ></div>
</div>
<div class="Table_Panel">
		<div style="margin: 15px auto 0px auto; width: 97%; height: 100%;">
			<div style="height: 30px; background: #CCC;">
				<form id="planItemFrom" action="">
					<div class="Icon-div">
						<input id="comName" type="text" class="IS_input count_text" placeholder="请输入公司名称进行查询" onfocus="$(this).attr('title','');$(this).removeClass('errorInput');" onkeydown="acctEnterTheEvent();" />
						<div class="cbankIcon" onclick="planPageQuery();" ></div>
						<input type="hidden" name="testValue" /> 
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
										<!-- <input id="checkBoxAll" type="checkbox" onclick="selectAllCheckedBox(this);" /> -->
									</div>
								</td>
								<td><div class="t_cols" style="width: 95px;">厂编</div></td>
								<td><div class="t_cols" style="width: 370px;">公司名称</div></td>
								<td><div style="width: 16px;">&nbsp;</div></td>
							</tr>
						</thead>
					</table>
				</div>
				<div id="rpSupplierDiv" >
					<jsp:include page="/page/rp/plan/choiceOfSupplierList.jsp" />
				</div>
			</div>
		</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="supplierAffirmOperation(getCheckedSuppler())">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin();">取消</div>
	</div>
</div>
