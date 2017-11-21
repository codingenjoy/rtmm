<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ctx}/shared/js/controls/toolbar/toolbar.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/order/hoOrder.js" type="text/javascript"></script>
<div id="toolbar"></div>
<%-- <%@ include file="/page/commons/toolbar.jsp"%> --%>
<div class="CTitle" id="hoOrderListTag">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">
		<auchan:i18n id="104001001"></auchan:i18n>
	</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1" id="hoOrderListView">
	<form id="queryForm" class="clean_from">
		<div class="Search Bar_on" id="searchHOOrderInfos">
			<!-- Bar_on-->
			<div class="SearchTop">
				<span><auchan:i18n id="100002013"></auchan:i18n></span>
				<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
			</div>
			<div class="SMiddle">
				<table class="SearchTable" id="SearchOrderTable">
					<tr>
						<td class="ST_td1"><span><auchan:i18n id="104001002"></auchan:i18n></span></td>
						<td><input class="w65 inputText inputNmuber" type="text" id="ordNo" name="ordNo" onkeyup="this.value=this.value.replace(/\D/g,'')"
							maxlength="10" /></td>
					</tr>
					<tr>
						<td><span><auchan:i18n id="104001004"></auchan:i18n></span></td>
						<td>
							<div class="iconPut w65 fl_left">
								<input type="text" class="w80 inputNmuber" id="catlgId" name="catlgId" onblur="if(isNaN(this.value)){this.value='';return;}loadCatlgName();"
									onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="10" />
								<div class="ListWin" onclick="selectCatlg()"></div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="ST_td1"><span>&nbsp;</span></td>
						<td><input class="w85 inputText Black" type="text" id="catlgName" name="catlgName" readonly="readonly" /></td>
					</tr>
					<tr>
						<td><span><auchan:i18n id="104001003"></auchan:i18n></span></td>
						<td>
							<div class="iconPut w65 fl_left">
								<input type="text" class="w80 inputNmuber" id="supNo" onblur="if(isNaN(this.value)){this.value='';return;}loadSupName();" name="supNo"
									onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="10" />
								<div class="ListWin" onclick="selectSup()"></div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="ST_td1"><span>&nbsp;</span></td>
						<td><input class="w85 inputText Black" type="text" id="supName" name="supName" readonly="readonly" /></td>
					</tr>
					<tr>
						<td><span><auchan:i18n id="104001006"></auchan:i18n></span></td>
						<td><input type="text" class="Wdate w65" id="planRecptDateBegin" name="planRecptDateBegin"
							onclick="WdatePicker({ isShowClear: false, readOnly: true,onpicking:function(dp){hoOrderPlanRecptStartDateQuery(dp);} })" /> &nbsp;-</td>
					</tr>
					<tr>
						<td><span>&nbsp;</span></td>
						<td><input type="text" class="Wdate w65" id="planRecptDateEnd" name="planRecptDateEnd"
							onclick="WdatePicker({ isShowClear: false, readOnly: true,onpicking:function(dp){hoOrderPlanRecptEndDateQuery(dp);}})" /></td>
					</tr>
					<!-- 					<tr>
						<td class="ST_td1">
							<span>进价折扣</span>
						</td>
						<td>
							<input class="w65 inputText inputNmuber" type="text"
								id="bpDiscBegin" name="bpDiscBegin"
								onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="10" />
							&nbsp;%&nbsp;-
						</td>
					</tr>
					<tr>
						<td class="ST_td1">
							<span>&nbsp;</span>
						</td>
						<td>
							<input class="w65 inputText inputNmuber" type="text"
								id="bpDiscEnd" name="bpDiscEnd"
								onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="10" />
							&nbsp;%&nbsp;
						</td>
					</tr> -->
				</table>
			</div>
			<div class="line"></div>
			<div class="SearchFooter">
				<div class="Icon-size1 Tools20" onclick="clean_form()"></div>
				<div class="Icon-size1 Tools6" onclick="search()"></div>
			</div>

		</div>
		<div class="Content" style="width: 74%;" id="orderHOlist"></div>
	</form>
</div>
<div id="hoOrderDetailTag" class="CTitle" style="display: none;">
	<div class="tags1_left"></div>
	<div class="tagsM" id="hoOrderList">
		<auchan:i18n id="104001001" />
		<!-- 总部订单信息 -->
	</div>
	<div class="tags tags_right_on"></div>
	<div class="tagsM_q  tagsM_on">
		<auchan:i18n id="104002001" />
		<!-- 总部订单详细信息 -->
	</div>
	<div class="tags3_close_on">
		<div class="tags_close"></div>
	</div>
</div>
<div class="Container-1" id="hoOrderDetailView" style="display: none"></div>

<script type="text/javascript">

	$(function() {
		
	});

	var toolbar = new ToolBar({
		selector : "#toolbar"
	});
	bindTool1();
	DispOrHid('B-id');
	pageQuery();
	
	function search() {
		if (!validata())
			return;
		$("#pageNo").val(1);
		pageQuery();
	}

	//翻页信息
	function pageQuery() {
		var param = $("#queryForm").serialize();
		$.ajax({
			url : '${ctx}/order/hoOrderList?tt=' + new Date().getTime(),
			type : "post",
			dataType : "html",
			data : param,
			success : function(data) {
				$("#orderHOlist").empty();
				$("#orderHOlist").html(data);
			}
		});
		// 取消選取所有多選框
		$("[type=checkbox]").removeAttr("checked");
		// 計算勾選個數: 沒有則 disable delete 和 edit icon
		countChecked();
		
		// 檢查權限, enable create icon
		checkCreatePrivilege();
	}

	$("#supNo").keydown(function(e) {
		if (e.keyCode == 13) {
			loadSupName();
			search();
			return false;
		}
	});

	$("#catlgId").keydown(function(e) {
		if (e.keyCode == 13) {
			loadCatlgName();
			search();
			return false;
		}
	});

	$("#queryForm").find('input').not('#supNo').not('#catlgId').keydown(
			function(e) {
				if (e.keyCode == 13) {
					search();
					return false;
				}
			});

	function bindTool1(){
		toolbar.enable('Tools1', function() {
			DispOrHid('B-id');
			gridbar_B();
		});
	}
	
	function checkCreatePrivilege() {
		toolbar.disable('Tools11');
		<auchan:operauth ifAnyGrantedCode="113111998">
		toolbar.enable('Tools11', function() {
			var param = {
					'action' : 'create'
				};
				showContent("${ctx}/hoOrderCreateNew/hoOrderCreatePage", param);
		});
		</auchan:operauth>
	}

	function checkDeletePrivilege() {
		toolbar.disable('Tools10');
		<auchan:operauth ifAnyGrantedCode="113111998">
		toolbar.enable('Tools10', function() {
			top.jConfirm('是否要删除所选订单?', '提示消息', function(ret) {
				if (ret) {
					deleteOrder();
					return;
				} else {
					return;
				}
			});
		});
		</auchan:operauth>
	}

	function checkEditPrivilege() {
		toolbar.disable('Tools12');
		<auchan:operauth ifAnyGrantedCode="113111998">
		toolbar.enable('Tools12', function(){
			var param = {
					'ordNo' : $("#hoOrder_tab_List .btable_checked #ordNo").html(),
					'action' : 'update'
				};
				showContent("${ctx}/hoOrderCreateNew/hoOrderCreatePage", param);
		});
		</auchan:operauth>
	}	
</script>