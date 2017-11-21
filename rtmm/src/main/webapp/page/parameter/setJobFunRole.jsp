<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/page/role_Param21.css" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<div class="Point_L">
	<!--px没有样式，可以随便取-->
	<div></div>
	<div></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
	<div class="px"></div>
</div>
<div class="Point_R">
	<div class="PRP_Left"></div>
	<div class="Point_R1">
		<span style="margin-left: 0px;">职位与角色</span>
	</div>
	<div class="Point_R2">
		<div class="pr21">
			<div class="pr_title">职位列表</div>
			<div class="pr_list" style="width: 93%;" id="jobFunList"></div>
		</div>
		<div class="pr_place"></div>
		<div class="pr22">
			<div class="pr_title">已关联角色</div>
			<div class="pr_list" id="selectRoleList"></div>
		</div>
		<div class="pr23">
			<div class="pr23_1">
				<div class="pr_btn1" id="jobFunAddRoles">&lt;&nbsp;关&nbsp;&nbsp;&nbsp;联</div>
				<div class="pr_btn2" id="jobFunCancelRoles">取&nbsp;&nbsp;&nbsp;消&nbsp;&gt;</div>
			</div>
		</div>
		<div class="pr24">
			<div class="pr_title">未关联角色</div>
			<div class="pr_list" id="unSelectRoleList"></div>
		</div>

	</div>
</div>

