<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<%-- <script type="text/javascript" src="${ctx}/shared/js/contract/acctGroupMain.js"></script> --%>
<script type="text/javascript">
	$(function() {
		$("#Tools11").attr('class', "Tools11").unbind('click').bind(
				"click",
				function() {
					openPopupWin(600, 500,
							'/supplier/contract/acctGroup/create');
				});

		$('#Tools1').attr('class', 'Icon-size1 Tools1 B-id').bind('click',
				function() {
					DispOrHid('B-id');
					gridbar_B();
				});
		DispOrHid('B-id');
		searchFormSubmit();
	});

	function searchFormSubmit() {
		if (!searchValidata())
			return;
		$("#pageNo").val(1);
		$("#pageSize").val(20);
		pageQuery();
		$("#Tools12").attr('class', "Tools12_disable");
		$("#acclist").empty();
	}
	function searchValidata() {
		var grpAcctSeqNo = $.trim($("input[name='grpAcctSeqNo']").val());
		var grpAcctId = $.trim($("input[name='grpAcctId']").val());
		var validataInfo = true;
		if (grpAcctSeqNo != '' && !isNumber(grpAcctSeqNo)) {
			$("input[name='grpAcctSeqNo']").addClass("errorInput");
			$("input[name='grpAcctSeqNo']").attr("title", "请输入正确的序号(数字)");
			$("input[name='grpAcctSeqNo']").attr("value", "");
			validataInfo = false;
		}
		if (grpAcctId != '' && !isNumber(grpAcctId)) {
			$("input[name='grpAcctId']").addClass("errorInput");
			$("input[name='grpAcctId']").attr("title", "请输入正确的科目组编号(数字)");
			$("input[name='grpAcctId']").attr("value", "");
			validataInfo = false;
		}
		return validataInfo;
	}

	//翻页信息
	function pageQuery() {
		var param = $("#searchForm").serialize();
		$.post(ctx + '/supplier/contract/acctGroup/search', param, function(
				data) {
			$("#acct_grp_content").empty();
			$("#acct_grp_content").html(data);
		}, 'html');
	};

	function onclickRow(grpAcctId) {
		$("#Tools12").attr('class', "Tools12").unbind('click').bind(
				"click",
				function() {
					openPopupWin(600, 500,
							'/supplier/contract/acctGroup/update?grpAcctId='+grpAcctId);
				});
		
		$.post(ctx + '/supplier/contract/acctGroup/getExtInfo', {
			'grpAcctId' : grpAcctId
		}, function(data) {
			$("#acct_grp_ext_info").empty();
			$("#acct_grp_ext_info").html(data);
		}, 'html');
	}
</script>
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">赞助科目组</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	
		<div class="Search Bar_on">
			<!-- Bar_on-->
			<%@ include file="/page/contract/acctGroup/left.jsp"%>
		</div>
		<div class="Content" style="width: 74%;">
			<div id="acct_grp_content">
				<%@ include file="/page/contract/acctGroup/list.jsp"%>
			</div>
			<div id="acct_grp_ext_info">
				<%@ include file="/page/contract/acctGroup/listExtInfo.jsp"%>
			</div>
		</div>
	
</div>