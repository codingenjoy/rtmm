<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.auchan.rtmm.common.session.SessionHelper" language="java"%>
<%@ page import="com.auchan.common.codetable.utils.CodeTableI18NUtil" language="java"%>
<%-- <iframe src="<%=CodeTableI18NUtil.getMetaData("BPM_URL", "1").getL_desc()%>/auchan-bpm/wf/delegateHome.action?thirdHandlingStaffNo=<%=SessionHelper.getCurrentStaffNo() %>&thirdAppId=rtmm" frameborder="0" scrolling="0" style="height:100%;width:100%"></iframe> --%>
<iframe id="unClaimedWFFrame" name="unClaimedWFFrame" src="/auchan-bpm/wf/delegateHome.action?thirdHandlingStaffNo=<%=SessionHelper.getCurrentStaffNo() %>&thirdAppId=rtmm&locale=${locale}" frameborder="0" scrolling="0" style="height:100%;width:100%"></iframe>