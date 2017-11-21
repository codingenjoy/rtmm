<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/rp/plan/plan.js"></script>
<script type="text/javascript">

    $(function () {
        $(".cm_table1").scroll(function () {
            var left = $(this).scrollLeft();
            $(".tit_tab1").scrollLeft(left);
        });
        $(".CM-div,.gyBlock").delegate(".item", "click", function () {
            var pre = "";
            var cur = $(this).attr("class");;
            $(this).parent().find(".item_on").removeClass("item_on");
            $(this).addClass("item_on");
        });
        var basicInfo = '${rpPlanVo}';
        var itemInfo = '${itemInfoData}';
        var storeInfo = '${storeInfoData}';
        var basicInfos = JSON.parse(basicInfo);
        basicInfos.rdmBeginDate = '${rdmBeginDate}';
        basicInfos.rdmEndDate='${rdmEndDate}';
        basicInfos.stCnfrmBeginDate = '${stCnfrmBeginDate}';
    	basicInfos.stCnfrmEndDate = '${stCnfrmEndDate}';
    	basicInfos.stRepBeginDate = '${stRepBeginDate}';
    	basicInfos.stRepEndDate = '${stRepEndDate}';
        initBasicInfo(basicInfos);
        initItemStoreInfo(itemInfo,storeInfo);
        
        // 所有 input 都改成 readonly
        $("#detailDiv input").attr("readonly", "readonly");
    });
</script>
<style type="text/css">
.cm_table2 {
	height: 150px;
}

.cm_table1 .item {
	width: 115%;
}

.iconPut1,.os_listk .sp_icon4 {
	margin-left: 30px;
}

.tit_tab1 {
	width: 100%;
	overflow: hidden;
}

.os_listk {
	height: 180px;
	margin-top: 2px;
}

.cks {
	margin-top: 6px;
	float: left;
}

.w2x {
	width: 35.2%;
	width: 35.5% \9;
}
</style>
<%-- 		<input type="hidden" id="pageSize" value="${page.pageSize}" name="pageSize"/>
		<input type="hidden" id="pageNo" value="${page.pageNo}" name="pageNo"/>
		<input type="hidden" id="totalCount" value="${page.totalCount}" name="totalCount"/> --%>
		<%-- <%@ include file="template/detail_top.jsp" %> --%>
		<!-- 保留计划基本信息  -->
		<%@ include file="../plans/dbasicInfo.jsp" %>

		<!-- 商品列表  -->
		<%@ include file="../plans/ditemArea.jsp" %>

		<!-- 门店商品数量  -->
		<%@ include file="../plans/ditemAndStoreArea.jsp" %>

		<!-- 以下是各区块的DOM模板定义 -->
		<div id="itemFirstTemplate" style="display: none;">
			<%@ include file="../template/itemFirstTemplateDetail.jsp"%>
		</div>

		<div id="itemStoreTemplate" style="display: none">
			<%@ include file="../template/itemStoreTemplateDetail.jsp"%>
		</div> 
