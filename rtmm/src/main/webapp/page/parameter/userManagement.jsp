<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/role_Param31.css" />
<%@ include file="/page/commons/toolbar.jsp"%>
<%@ include file="/page/commons/zWindow.jsp"%>
<div class="CTitle">
	<div id="userListTitleDiv">
		<div class="tags1_left tags1_left_on"></div>
		<div class="tagsM tagsM_on">用户管理</div>
		<div class="tags tags3_r_on"></div>
	</div>
	<div id="userFormTitleDiv" style="display: none">
		<div class="tags1_left tags1_left_on"></div>
		<div class="tagsM tagsM_on">维护用户</div>
		<div class="tags tags3_r_on">
			<div class="tagx_close"></div>
		</div>
	</div>
</div>
<div class="Container-1" id="userListDiv">
	<div class="Content">
		<div class="Con_tb">
			<!-- 左边部门树 -->
			<jsp:include page="/page/parameter/deptTreeView.jsp"></jsp:include>
		</div>
		<div class="Con_R">
			<!-- 右边用户列表 -->
			<jsp:include page="/page/parameter/userList.jsp"></jsp:include>
		</div>
	</div>
</div>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/parameter/staff.js" charset="gbk" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#Tools11").attr('class', "Tools11").unbind("click").bind("click", function() {
			createStaff();
		});
		
		$("#storeList").unbind("change").bind("change", function() {
			initDeptTree(this.value);
		});
	});
</script>