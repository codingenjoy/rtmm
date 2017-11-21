<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.SubList_w ol a:hover {
	background: #559f47;
	color: #fff;
}

.SubList_w ol {
	background: #fff;
}
</style>
<script type="text/javascript">
	$(function() {
		$(".father_li").bind("click", function() {
			$(this).find("span").first().toggleClass("L1_Yes_ss_w");
			$(this).find("span").first().toggleClass("L1_Yes_w");
			if ($(this).next("ol").css('display') == 'none') {
				getChildrenss($(this).find("span").text(), $(this).find("input").val(), $(this));
				$(this).next("ol").css('display', 'block');
			} else {
				$(this).next("ol").css('display', 'none');
			}
		});

		$(".SubList_w ol a").live("click", function () {
            $(".SubList_w ol li").find(".item_on").removeClass("item_on");
            $(this).addClass("item_on");
        });

	});

	function getChildrenss(codeName, code, obj) {
		$.ajax({
			type : 'post',
			async : false,
			url : ctx + '/commons/window/getCity',
			data : {
				regnNo : code
			},
			success : function(data) {
				$(obj).next("ol").find('li').remove();
				$.each(data,function(i, val) {
					$(obj).next("ol").append('<li onclick="${callback}(\''
						+ val.assrtId
						+ '\',\''+val.regnName
						+ '\',\''+code
						+ '\',\''+codeName+'\')"><a><span class="L2_No"></span> <span class="SubText_w">'
						+ val.regnName
						+ '</span></a></li>');
				});
		
			}
		});
	}
</script>
<div class="Panel_top">
	<span>选择区域/城市</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div style="height: 350px; overflow-y: auto;overflow-x: hidden;">
	<c:forEach items="${provinceList}" var="province">										
		<ol class="SubList_w">
			<li>
				<a class="father_li"><span class="L1_Yes_ss_w"></span>
					<span class="SubText_w" >${province.regnName}</span>
					<input type="hidden" value="${province.assrtId}" /></a>
				<ol style="display: none;" id="${division.id}">
				</ol>
			</li>
		</ol>
	</c:forEach>
</div>
