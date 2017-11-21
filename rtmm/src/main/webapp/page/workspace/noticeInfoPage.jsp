<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@page import="com.auchan.rtmm.common.session.SessionHelper"%>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/noticeInfoPage.css" />
<!-- start:"用户操作手册",置顶显示 -->
<%
	String helpUrl = "/help/RTStore Manual.pdf";
	Integer storeNo = SessionHelper.getCurrentStoreNo();
	if (storeNo == 0)
		helpUrl = "/help/RTHO Manual.pdf";
%>
<div class="notice_each">
	<div class="notice_banner">
		<div class="notice_title">系统帮助</div>
		<div class="f_r r_btn_hide" id="toHide">缩小</div>
		<span class="f_r" style="padding: 5px 10px 0px 10px; color: grey;">|</span>
		<div class="f_r r_btn">
		</div>
	</div>
	<div class="notice_content">
		<span>
			<a href="#" onclick="window.open('<%= helpUrl%>')">RTMM用户操作手册</a>
		</span>
	</div>
</div>
<!-- "用户操作手册"，end: -->

<c:if test="${empty page.result }">
沒有公告
</c:if>
<c:if test="${not empty page.result }">
	<div class="notice">
		<c:forEach items="${page.result }" var="notice">
			<div class="notice_each" id='N${notice.id}'>
				<div class="notice_banner">
					<div class="notice_title">${notice.title}</div>
					<div class="f_r r_btn_hide" id="toHide">缩小</div>
					<span class="f_r" style="padding: 5px 10px 0px 10px; color: grey;">|</span>
					<div class="f_r r_btn">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${notice.createDate}" />
					</div>
				</div>
				<div class="notice_content">${notice.content}</div>
			</div>
		</c:forEach>
	</div>

	<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
</c:if>
<script>

function openLink(obj){
	var url = $(obj).attr('value');
	window.open(url,'new window', 'width=500,height=500');
}

</script>