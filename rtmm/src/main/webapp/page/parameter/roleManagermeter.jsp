<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/parameter/role.js" type="text/javascript"></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/page/role_Param11.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css" rel="Stylesheet" />
<script type="text/javascript">
	$(function() {
		$(".tbx tr:even").addClass("tr_even");
		$('.tbx tr').bind("click", function() {
			var roleId=$("#roleAuthChoice").children('.item_on').attr('id');
			if(roleId=='menuAuthority'){
				showRoleMenuAuthority($(this).find('input').val());
			}
			else if(roleId=='operAuthority'){
				showRoleOperAuthority($(this).find('input').val());
			}
			$('.tbx').find('.item_on2').removeClass('item_on2');
			$(this).addClass("item_on2");
		});
		
	    $("#roleAuthChoice .item").unbind().bind("click", function () {
	            $(this).parent().find(".item_on").removeClass("item_on");
	            $(this).addClass("item_on");
	        });	
	});
</script>
<style>
.iframe_body {
	width: auto;
	height: auto;
	overflow: hidden;
}
.Con_tb {
	width: 40% !important;
}
.Con_R {
	width: 60% !important;
}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on">角色与权限管理</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="Con_tb">
			<!-- Bar_on-->
			<div class="SearchTopx">
				<span>角色</span>
			</div>
			<div class="line" style="width: 100%;"></div>
			<div class="con_title">
				<table class="w100">
					<tbody>
						<tr>
							<td class="w5 align_center">&nbsp;</td>
							<td class="w45 align_center"
								style="border-right: 1px solid #cccccc;">角色</td>
							<td class="w50 align_center">角色描述</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="tbx">
				<jsp:include page="/page/parameter/roleShow.jsp"></jsp:include>
			</div>
			<div class="line"></div>
		</div>
		<div class="Con_R">
			<div class="Point_L">
				<!--px没有样式，可以随便取-->
			</div>
			<div class="Point_R">
				<div class="Point_R1" id="roleAuthChoice">
					<span class="item item_on" id="menuAuthority"
						style="margin-left: 0px;" onclick="menuAuthority()">菜单权限</span> <span
						class="item" id="operAuthority" onclick="operateAuthority()">操作权限</span>
					<!-- 		<span class="item">审批权限</span> -->
				</div>
				<div id="menuAuthorityDiv" class="Point_R2"></div>
				<div id="operAuthorityDiv" class="Point_R2"
					style="display: none; overflow: hidden;"></div>
				<input type="hidden" id="roleId"></input>
			</div>
		</div>
	</div>
	<div id="popupWins"></div>
</div>