<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<script type="text/javascript" src="${ctx}/shared/js/rp/plan/import/import.js"></script>

<div class="Content">
	<div>
		<!-- 導入頁面上方的選項 -->
		<%@ include file="top.jsp"%>
		<!-- 導入結果的統計訊息 -->
		<%-- <%@ include file="summary.jsp"%> --%>
		<!-- 導入結果的內容顯示  -->
		<div class="Content detail" id="detailDiv" style="width: 99%;">
			<%@ include file="content.jsp"%>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function() {
		$('.detail').hide();

		$(window).unload(function() {
			//0.清理资源;
			p.destroy();
		});
	});
</script>