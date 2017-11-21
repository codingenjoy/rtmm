<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<style type="text/css">
.tempImage {
	background: none;
	height: 610px;
	overflow: hidden;	
}
</style>
<div id="leftMenu" class="LeftMenu">
	<auchan:menu id="${sid }" pid="${pid }"></auchan:menu>
</div>

<div class="Container" id="content">
	<div class="tempImage">
		<div class="img_div">
			<div class="img1"></div>
			<div class="img3">
				<div class="ch21"><img src="${ctx}/shared/themes/theme1/images/ch_2.jpg" width="100%" height="100%" border="0"/></div>
			</div>
			<div class="img2"></div>
		</div>
	</div>
	<div class="foot">
		<span>欧尚（中国）投资有限公司</span>
		<div></div>
	</div>
</div>
<script type="text/javascript">
	var pmenuid = "${pid}";
	var toUrl = "${toUrl}";
	if ($.trim(toUrl) != "") {
		showContent(toUrl);
	}
	$(window).ready(function() {
		var xxx = $(".SubList").children("li");

		xxx.each(function() {
			if ($(this).find("ol").length < 1) {
				var z = $(this).find("ol");
				$(this).find("a").find("span").first().addClass("L1_No");
			}
		});

		$(".SubList ol a").each(function() {
			$(this).find("span").first().addClass("L2_No");
		});
	});
</script>