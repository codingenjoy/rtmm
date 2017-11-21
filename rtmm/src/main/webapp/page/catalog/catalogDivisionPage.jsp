<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<script src="${ctx}/shared/js/catalog/section.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {

/* 			$("#Tools12").attr('class', "Tools12_disable").unbind("click").bind("click",function() {
					editSection();
				}); */

		$("#sec_attr").bind('click', function() {
			showContent(ctx+"/catalog/sectionAttribute");
		});
		
	});
	
	function onClickRow(catlgId){
		<auchan:operauth ifAnyGrantedCode="110311002">
			$("#Tools12").removeClass("Tools12_disable").addClass("Tools12").unbind('click').bind("click",function(){
				updateSection(catlgId);
			});
		</auchan:operauth>
	}
	
</script>
<style type="text/css">
.paging .page_list{
	width: 300px;
}
</style>
<div class="CTitle">
	<!--第一个-->
	<div id="first" class="tags1_left tags1_left_on"></div>
	<div id="sec_info" class="tagsM tagsM_on"><auchan:i18n id="101004001"></auchan:i18n></div>

	<!--中间-->
	<div id="midden" class="tags tags_left_on"></div>

	<!--最后一个-->
	<div id="sec_attr" class="tagsM"><auchan:i18n id="101005001"></auchan:i18n></div>
	<div id="last" class="tags tags3_r_off"></div>

</div>
<div class="Container-1">

	<div class="Content">
		<div id="Con_Tb" class="Con_Tb" style="width: 35%; margin-top: 0px; height: 580px; float: left;">
			<jsp:include page="/page/catalog/divisionPage.jsp"></jsp:include>
		</div>
		<div class="Con_R">
			<div class="Point_L">
				<div></div>
				<div></div>
				<div id="Point_L1" class="px"></div>
				<div id="Point_L2" class="px"></div>
				<div id="Point_L3" class="px"></div>
				<div id="Point_L4" class="px"></div>
				<div id="Point_L5" class="px"></div>
				<div id="Point_L6" class="px"></div>
				<div id="Point_L9" class="px"></div>
			</div>
			<div class="Point_R">
				<div style="height: 30px; line-height: 25px;">
					<span style="float: left;"><auchan:i18n id="101004006"></auchan:i18n></span>
<!-- YH: 暫時關閉新增課別功能  
						<div id="creatSec" class="Icon-size2 Tools11" style="float: right; margin-right: 5px; margin-top: 5px;" 
						onclick="createSection()">
						</div>

-->					
				</div>
				<form id="queryFrom">
					<input type="hidden" name="divisionId" id="divisionId">
					<div id="section_content">
				</div>
				</form>
			</div>
		</div>
	</div>
</div>
