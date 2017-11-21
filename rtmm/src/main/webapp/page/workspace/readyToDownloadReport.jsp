<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/js/freezenColums/f.css" rel="Stylesheet" />
<script type="text/javascript" src="${ctx}/shared/js/freezenColums/f.js"></script>
<%@ include file="/page/commons/datepick.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/workspace/report.js"></script>
<link type="text/css" href="${ctx}/shared/js/My97DatePicker/skin/default/datepicker.css" rel="Stylesheet" />
<style type="text/css">
/*frozen table*/
.wh_auto {
	border-right: 0;
}

.move_cols {
	height: 530px;
	width: 100%;
	margin-top: 2px;
}

.f_cols_head,.m_cols_head {
	background: #eee;
}

.f_cols_body,.m_cols_body {
	height: 499px;
	border-bottom: 1px solid #ccc;
	overflow-y: scroll;
	overflow-x: hidden;
}

.download {
	height: 30px;
}

.tb1104 tr:hover {
	background: #99cc66;
	color: #fff;
}

.f_cols_head div, .m_cols_head div{
    border-right:1px solid #ccc;
}
</style>
<script type="text/javascript">
 $(function(){
	 $("#Tools1").removeClass("Tools1_disable").addClass("Tools1").
	 unbind("click").bind("click",function(){
		 DispOrHid('B-id');
	 });
 });
 function pageQuery(){
		var pageNo = $('#pageNo').val()||'1';
		var pageSize = $('#pageSize').val()||'20';
		$.ajax({
			type : "post",
			data : {
				pageNo : pageNo,
				pageSize : pageSize
			},
			dataType : "html",
			url : ctx + "/workspace/reportMgt/readyToDownloadReport",
			success : function(data) {
				$('#content').html(data);
			}
		});
}
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">未下载报表</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Search B Bar_off">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span>查询条件</span>
			<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle">
			<table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td><span>报表名称</span></td>
					<td><input type="text" class="inputText w88" /></td>
				</tr>
				<tr>
					<td><span>运行开始时间</span></td>
					<td><input type="text" class="inputText w88" /></td>
				</tr>
				<tr>
					<td><span>运行结束时间</span></td>
					<td><input type="text" class="inputText w88" /></td>
				</tr>
				<tr>
					<td><span>上次运行时间段</span></td>
					<td><input type="text" class="inputText w88" /></td>
				</tr>
				<tr>
					<td><span>预估结束时间</span></td>
					<td><input type="text" class="inputText w88" /></td>
				</tr>
				<tr>
					<td><span>状态</span></td>
					<td><input type="text" class="inputText w88" /></td>
				</tr>
				<tr>
					<td><span>操作</span></td>
					<td><input type="text" class="inputText w88" /></td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20"></div>
			<div class="Icon-size1 Tools6"></div>
		</div>
	</div>
	<div class="Content">
		<div class="move_cols">
			<div class="m_cols_head">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td><div style="width: 30px;">&nbsp;</div></td>
						<td><div style="width: 320px;">报表名称</div></td>
						<td><div style="width: 130px;">运行开始时间</div></td>
						<td><div style="width: 130px;">运行结束时间</div></td>
						<td><div style="width: 130px;">上次运行时间段</div></td>
						<td><div style="width: 130px;">预估结束时间</div></td>
						<td><div style="width: 85px;">状态</div></td>
						<td><div style="width: 50px;">操作</div></td>
						<td><div class="wh_100">&nbsp;</div></td>
					</tr>
				</table>
			</div>
			<!--this parts can be scrolled all the time-->
			<div class="m_cols_body">
				<c:if test="${not empty page.result }">
					<table cellpadding="0" cellspacing="0" class="single_tb tb1104">
						<c:forEach items="${page.result }" var="reportVo">
							<tr>
								<td><div style="width: 30px;">&nbsp;</div></td>
								<td><div style="width: 321px;" class="longText"
										name="reportName">${reportVo.reportId }</div></td>
								<td><div style="width: 131px;" class="longText"
										name="runStartTime">
										<c:if test="${not empty reportVo.requestStartTime }">
											<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
												value="${reportVo.requestStartTime }" />
										</c:if>
									</div></td>
								<td><div style="width: 131px;" class="longText"
										name="runEndTime">
										<c:if test="${not empty reportVo.requestEndTime }">
											<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
												value="${reportVo.requestEndTime }" />
										</c:if>
									</div></td>
								<td><div style="width: 131px;" class="longText"
										name="lastTimePhase">
										<c:if test="${not empty reportVo.lastStartTime }">
											<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
												value="${reportVo.lastStartTime }" />
										</c:if>
									</div></td>
								<td><div style="width: 131px;" class="longText"
										name="predictEndTime">
										<c:if test="${not empty reportVo.lstEndTime }">
											<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
												value="${reportVo.requestStartTime }" />
										</c:if>
									</div></td>
								<td><div style="width: 86px;" class="longText" name="state">
										<auchan:getDictValue mdgroup="REPORT_STATUS"
											code="${reportVo.status }" />
									</div></td>
								<td><div style="width: 51px; cursor: pointer"
										class="download" name="operation"
										onclick="downloadReport('${reportVo.reportId }','${reportVo.status }')"></div></td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</div>
		</div>
		<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
		<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
	</div>
</div>
