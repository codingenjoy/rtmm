<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">

.SubList_w a:hover {
	background: #2a7d0d;
	color: #fff;
}

.SubList_w ol a:hover {
	background: #559f47;
	color: #fff;
}
</style>
<script type="text/javascript">
	$(function(){
		$(".father_li").bind("click", function() {
			$(this).next("ol").toggle();
			$(this).find("span").first().toggleClass("L1_Yes_ss_w");
			$(this).find("span").first().toggleClass("L1_Yes_w");
			if($(this).next("ol").css('display')=='none'){
				sup_sections($(this).find("input").val(),$(this));
			}
		});
		
		$(".SubList_w ol a").bind("click", function() {
			$(this).toggleClass("item_on");
		});
				
	});
	

	function sup_sections(code,obj) {
		$.ajax({
			type : 'post',
			async: false,
			url : ctx + '/supplier/suppilerSectionAction',
			data : {
				divisionId : code
			},
			success : function(data) {
				$(obj).next("ol").find('li').remove();
				$.each(data, function(i, val) {
					$(obj).next("ol").append('<li onclick="confirmChooseDivsion('+val.id+')"><span class="L2_No"></span> <span class="SubText_w">'+val.name+'</span></li>');
				});

			}
		});
	}
</script>
<div class="Panel_top">
	<span>选择处课信息</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div style="height: 360px; overflow-y: auto;">
	<c:forEach items="${divisionList }" var="division">
		<ol class="SubList_w">
			<li>
				<a class="father_li"><span class="L1_Yes_ss_w"></span>
					<span class="SubText_w">${division.name}<input type="hidden" value="${division.id}">
					</span></a>
				<ol style="display: block;" id="${division.id}">
				</ol>
			</li>
		</ol>
	</c:forEach>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1">保存</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>
