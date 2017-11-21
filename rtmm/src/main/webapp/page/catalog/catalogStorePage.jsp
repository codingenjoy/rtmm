<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/catalog/storeManagement.js" type="text/javascript"></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" rel="Stylesheet" />
<style type="text/css">
    .my-head-td-ck,.ck,.my-head-td-ck div,.ck div{
        display : none;
    }
    .datagrid-body{
    	overflow-x:hidden;
    }
    .scroll_bar{overflow-x:auto;}
    .my-head-td-storeNo div {
         border-right:1px solid #ccc;
    }
    
    .datagrid-cell {
		border-right:1px solid #fff;
	}
    .my-head-td-storeName div {
        border-right:1px solid #ccc;
    }
    .my-head-td-statusTitle div {
        border-right:1px solid #ccc;
    }
    .my-head-td-lvlTiltle div {
        border-right:1px solid #ccc;
    }
    .my-head-td-comTitle div {
        border-right:1px solid #ccc;
    }
    .my-head-td-openDate div { 
        border-right:1px solid #ccc;
    }
    .my-head-td-bizTitle div { 
        border-right:1px solid #ccc;
    }
    .my-head-td-regnName div { 
    }
</style>
<script type="text/javascript">
	$(document).ready(
			function() {
				$("#Tools22").attr('class', "Icon-size1 Tools22_disable").bind("click",
						function() {
							$("#pageNo").val($('.pagination-num')[0].value);
							$("#rowNo").val($(".pagination-page-list").val());
							countPage();
							storeDetailed();
						});
 				$("#Tools21").attr('class', "Icon-size1 Tools21_disable").bind("click",
						function() {
							storeMessage();
						}); 
				$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind(
						"click", function() {
							DispOrHid('B-id');
							gridbar_B();
							//store();
						});
				storeSearch("storeAll");
			});
	function closeSearch(){
		DispOrHid('C-id');
		gridbar_C();
		//store();
	}
	function storeShow(){
		storeSearch('search');
		//store();
	}
	
	function countPage(){
		var pageNo = $("#pageNo").val();
		var rowNo = $("#rowNo").val();
		var selectRowNo = $("#selectRowNo").val();
		$("#currentRow").val((eval(pageNo)-1)*eval(rowNo)+eval(selectRowNo));
	}

</script>

<div id="storeList">
	<div class="Container-1">
		<div class="Search" style="display: none;" >
			<!-- Bar_on-->
			<div class="SearchTop">
				<span>查询条件</span>
				<div class="Icon-size1 CircleClose C-id" onclick="closeSearch()"></div>
			</div>
			<div class="line"></div>
			<div class="SMiddle">
				<form action="" id="queryForm">
				<table class="SearchTable">
					<tr>
						<td class="w35">
							<span>分店店号</span>
						</td>
						<td>
							<input id="storeNo" name="storeNo" type="text" class="inputText w80" maxlength="6"/>
						</td>
					</tr>
					<tr>
						<td>
							<span>分店名称</span>
						</td>
						<td>
							<input id="storeName" name="storeName" type="text" class="inputText w80" />
						</td>
					</tr>
					<tr>
						<td>
							<span>分店状态</span>
						</td>
						<td>
						<auchan:select mdgroup="STORE_STATUS" _class="w80" id="status" name="status"/>
<%-- 							<select id="status" name="status" class="w80">
								<option value="">请选择</option>
								<c:forEach items="${statusList }" var="st">
								s	<option value="${st.code }">${st.title }</option>
								</c:forEach>
							</select> --%>
						</td>
					</tr>
					<tr>
						<td>
							<span>分店业态</span>
						</td>
						<td>
						<auchan:select mdgroup="STORE_BIZ_TYPE" _class="w80" id="bizType" name="bizType"/>
		<%-- 					<select id="bizType" name="bizType" class="w80">
								<option value="">请选择</option>
								<c:forEach items="${bizList }" var="biz">
									<option value="${biz.code }">${biz.title }</option>
								</c:forEach>
							</select> --%>
						</td>
					</tr>
					<tr>
						<td>
							<span>分店等级</span>
						</td>
						<td>
							<auchan:select mdgroup="REGION_NODE_DEVLP_GRD" _class="w80" id="lvlNo" name="lvlNo" />
						</td>
					</tr>

					<tr>
						<td>
							<span>开业时间</span>
						</td>
						<td>
<!-- 							<div id="idxx" class="iconPut w80">
								<input type="text" id="openDate" name="openDate" class="w85" readonly="readonly"/>
								<div class="C_Func Calendar"></div>
							</div> -->
							<!-- <div style="margin:1px 0;"></div><input id="openDate" name="openDate" class="easyui-datebox" style="width:135px;" onclick="clickData()"/> -->
							<input id="setupDate" id="openDate" name="openDate" class="Wdate" style="width:135px;" type="text" onClick="WdatePicker({isShowClear:false,readOnly:true})" >
						</td>
					</tr>
					<tr>
						<td>
							<span>公司</span>
						</td>
						<td>
							<div class="iconPut" style="width: 55%; float: left;">
								<input id="companyCode" name="comNo" class="combo-arrow-hover" type="text" style="width: 75%" readonly="readonly" />
								<div class="ListWin" onclick="openCompanyWindow()"></div>
							</div>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input id="companName" type="text" class="Black inputText w80" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td>
							<span>区域/城市</span>
						</td>
						<td>
							<div class="iconPut" style="width: 35%; float: left;">
								<input id="regnNo" name="regnNo" type="text" style="width: 65%" readonly="readonly" />
								<div class="ListWin" onclick="openCityWindow()"></div>
							</div>
							<input id="regnName" type="text" class="Black inputText twoInput2 w50" readonly="readonly" />
						</td>
					</tr>
				</table>
				</form>
			</div>
			<div class="line"></div>
			<div class="SearchFooter">
				<div class="Icon-size1 Tools20" onclick="cleanSearch()"></div>
				<div class="Icon-size1 Tools6" onclick="storeShow()"></div>
			</div>
		</div>

		<div class="Content">
			<table id="dg" style="height:570px;"></table>
		</div>
	</div>
</div>
<div id="storeDetailed">
</div>
<input type="hidden" id="pageNo" />
<input type="hidden" id="rowNo" />
<input type="hidden" id="selectRowNo" />
<input type="hidden" id="currentRow" />
