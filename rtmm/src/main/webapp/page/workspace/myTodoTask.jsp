<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.auchan.rtmm.common.session.SessionHelper" language="java"%>
<%@ page import="com.auchan.common.codetable.utils.CodeTableI18NUtil" language="java"%>
<iframe id="allProcessWFFrame" name="allProcessWFFrame" src="/auchan-bpm/wf/claimedHome.action?thirdHandlingStaffNo=<%=SessionHelper.getCurrentStaffNo() %>&thirdAppId=rtmm&locale=${locale}" frameborder="0" scrolling="0" style="height:100%;width:100%"></iframe>