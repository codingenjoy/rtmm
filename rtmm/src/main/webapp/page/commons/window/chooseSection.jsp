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
.SubText_w {
	float: left;
	display: block;
	width: 200px;
}
</style>
<script type="text/javascript">
	$(function(){
		$("#searchSectionSpan").focus();
		$(".father_li").bind("click", function() {
			$(this).find("span").first().toggleClass("L1_Yes_ss_w");
			$(this).find("span").first().toggleClass("L1_Yes_w");
			if($(this).next("ol").css('display')=='none'){
				getChildrens($(this).find("input").val(),$(this));
				$(this).next("ol").css('display','block');
			}else{
				$(this).next("ol").css('display','none');
			}
		});
		
		$(".SubList_w ol a").live("click", function () {
            $(".SubList_w ol li").find(".item_on").removeClass("item_on");
            $(this).addClass("item_on");
        });
	});

	function getChildrens(code,obj) {
		$.ajax({
			type : 'post',
			async: false,
			url : ctx + '/commons/window/getSection',
			data : {
				divisionId : code,
				status :'${status}'
			},
			success : function(data) {
				$(obj).next("ol").find('li').remove();
				$.each(data, function(i, val) {
					$(obj).next("ol").append('<li onclick="confirmChooseSection(\''
							+ val.catlgNo
							+ '\',\''+val.catlgName+'\')"><a><span class="L2_No"></span> <span class="SubText_w">'
							+ val.catlgNo+'-'+val.catlgName
							+ '</span></a></li>');
				});

			}
		});
	}
</script>
<div class="Panel_top">
	<span id="searchSectionSpan"><auchan:i18n id="102006052"></auchan:i18n></span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div style="height: 440px; overflow-y: auto;overflow-x: hidden;">
	<c:forEach items="${divisionList }" var="division">
		<ol class="SubList_w">
			<li>
				<a class="father_li"><span class="L1_Yes_ss_w"></span>
					<span class="SubText_w">${division.catlgId}-${division.catlgName}<input type="hidden" value="${division.catlgId}" />
					</span></a>
				<ol style="display:none;" id="${division.catlgId}">
				</ol>
			</li>
		</ol>
	</c:forEach>
</div>
