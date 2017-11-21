<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link href="${ctx}/shared/themes/${theme}/css/page/role_Param11_1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	$(function() {
		$.post(ctx + '/param/showAllRoleMenuAuthorityTreeAction', {}, function(data) {
			$('#Mytt').tree({
				checkbox : true,
				cascadeCheck : false,
				data : data
			});
		}, "json");
	});
</script>

<ul id="Mytt"></ul>