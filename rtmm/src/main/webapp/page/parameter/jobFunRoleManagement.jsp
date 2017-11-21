<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/role_Param21.css" />
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/parameter/jobFun.js" charset="gbk" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#Tools2").attr('class',"Tools2").unbind("click").bind("click", function() {
			doSaveJobFunRole();
		});
		$("#storeList").unbind("change").bind("change", function() {
			initDeptTree(this.value);
		});
		$('#jobFunAddRoles').unbind('click').bind("click", function() {
			join();
		});
		$('#jobFunCancelRoles').unbind('click').bind("click", function() {
			unjoin();
		});
	});
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">职位与权限管理</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="Con_tb">
			<!-- 左边部门树 -->
			<jsp:include page="/page/parameter/deptTreeView.jsp"></jsp:include>
		</div>

		<div class="Con_R">
			<!-- 右边用户列表 -->
			<jsp:include page="/page/parameter/setJobFunRole.jsp"></jsp:include>

		</div>
	</div>
</div>
