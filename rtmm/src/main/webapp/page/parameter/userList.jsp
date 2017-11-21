<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="Point_L">
	<!--px没有样式，可以随便取-->
	<div class="px"></div>
</div>
<div class="Point_R">
	<form id="queryFrom">
		<div class="Point_R1">
			<span style="margin-left: 0px;" id="menu_power">用户列表</span>
		</div>
		<div class="Point_R2" id="useList">
			<div class="Point_R1">
				<label class="fl_left" style="margin-top: 5px; ! important; margin-top: 7px;">
					<input type="checkbox" name="showAll" id="showAll" onclick="pageQuery()"/>
				</label>
				<span class="fl_left">显示当前及以下级别用户</span>
				<label class="fl_left" style="margin-top: 7px; margin-left: 10px;">
					<input type="checkbox" name="showValid" id="showValid" onclick="pageQuery()"/>
				</label>
				<span class="fl_left">仅显示有效用户</span>
				<div class="search_p">
					<input type="text" class="w87 fl_left" style="margin-top: 2px;" id="userName" placeholder="请输入姓名进行查询">
					<div id="reload" class="Icon-size2 Tools6" style="float: right; margin-right: 2px;"></div>
					<input type="hidden" id="storeNo" />
					<input type="hidden" id="deptNo" />
				</div>
			</div>
			<div id="user_content"></div>
		</div>
	</form>
</div>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		//回车触发查询
		$("#userName").keydown(function(e) {
			if (e.keyCode == 13) {
				pageQuery();
				return false;
			}
		});
		$("#reload").bind("click", function() {
			pageQuery();
		});
		
		$("#Tools12").removeClass("Tools12").addClass("Tools12_disable").unbind('click');
	});
</script>