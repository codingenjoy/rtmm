<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/contract/common.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/contract/common/prototype_rowBasedCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/contract/common/prototype_TempTabHandler.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/contract/common/prototype_TempTabCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/contract/common/prototype_TempTabTermAccSecondCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/contract/common/prototype_TempTabTermCanvas.js" charset="utf-8"></script>

<script type="text/javascript" src="${ctx}/shared/js/contract/template/page.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/contract/template/validate.js" charset="utf-8"></script>
<script type="text/javascript">
	$(function(){
		var createOrEdit = '${createOrEdit }';
		//createOrEdit(0表示则是创建执行，1表示修改执行)
  		if (createOrEdit == 0) {
 			$("#inUseIndSelect").find("option:not(:selected)").remove();
			$("#inUseIndSelect").addClass("Black");
		}
		if (createOrEdit == 1) {
			var inUseInd = '${templVO.inUseInd }';
			if (inUseInd == 1) {
				$("#inUseIndSelect").find("option:not(:selected)").remove();
				$("#inUseIndSelect").addClass("Black");
			}
			var jsonObject = ${jsonObject };
			//修改数据放入数组
			packageEditData(jsonObject);
		}
	})
	//TODO
</script>
<style type="text/css">
	.sp_icon1{
		margin-left: 8px;
	}
</style>
<style type="text/css">
</style>
<div class="Container-1">
	<div class="Content">
	<%@ include file="ptmpls/basicInfo.jsp"%>
	<%@ include file="ptmpls/tabsArea.jsp"%>
	<%@ include file="ptmpls/termsAndAcctsArea.jsp"%>
	</div>
</div>

<!-- 以下是各区块的DOM模板定义 -->
<%-- <div id="oneStoreLeftHeadRowTemplate" style="display: none;">
	<%@ include file="template/oneStoreLeftHeadRowTemplate.jsp"%>
</div> --%>
<div id="templateOneTabTermAcct" style="display: none;">
	<%@ include file="template/tabTermAcctTemplate.jsp"%>
</div>

<div id="templateOneTab" style="display: none">
	<%@ include file="template/tabTemplate.jsp"%>
</div>
<div id="templateOneTabTerm" style="display: none">
	<%@ include file="template/tabTermTemplate.jsp"%>
</div>
