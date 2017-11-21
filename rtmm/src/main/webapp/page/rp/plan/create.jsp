<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/js/freezenColums/f.css" rel="Stylesheet" />
<script type="text/javascript" src="${ctx}/shared/js/rp/plan/common/prototype_rowBasedCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/rp/plan/common/prototype_PlanItemStoreCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/rp/plan/common/prototype_PlanItemSecondCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/rp/plan/common/prototype_PlanItemFirstCanvas.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/rp/plan/common/prototype_PlanHandler.js" charset="utf-8"></script>

<script type="text/javascript" src="${ctx}/shared/js/rp/plan/page.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/rp/plan/validate.js" charset="utf-8"></script>
<script type="text/javascript">
    $(function () {
        $(".m_cols_body ,.f_cols_body").delegate("tr","mouseover",function () {
            var index = $(this).attr("_index");
            var $tr = $("." + index);
            $tr.addClass("tr_hover");
        });
        $(".m_cols_body ,.f_cols_body").delegate("tr","mouseout",function () {
            var index = $(this).attr("_index");
            var $tr = $("." + index);
            $tr.removeClass("tr_hover");
        });
        $(".m_cols_body ,.f_cols_body").delegate("tr","click",function () {
            var index = $(this).attr("_index");
            var $tr = $("." + index);

            $tr.parents(".m_cols_body").find(".tr_click_on").removeClass("tr_click_on");
            $tr.parents(".f_cols_body").find(".tr_click_on").removeClass("tr_click_on");

            $tr.toggleClass("tr_click_on");
        });

        $(".order6_edit").scroll(function () {
            var left = $(this).scrollLeft();
            //alert(left);
            $(".m_cols_head").scrollLeft(left);
        });
        $(".f_cols_body").scroll(function () {
            var top = $(this).scrollTop();
            //alert(left);f_cols_body
            $(".order6_edit").scrollTop(top);
        });
        //RP DM 设置名称主题
        setRdmTopic();
    });
    
    function setRdmTopic(){
        var rpDMstr = $("#crRdmNo").val();
        var rmBeginDate = $("#crRdmNo option:selected").attr("dmBeginDate");
        var rmEndDate = $("#crRdmNo option:selected").attr("dmEndDate");
        $("#crRdmBeginDate").val(rmBeginDate);
        $("#crRdmEndDate").val(rmEndDate);
        $("#crRdmTopic").val(rpDMstr);
    }
</script>
<style type="text/css">

        .sp_icon1 {
            margin-left:8px;
        }
        .cm_table2 {
            height: 110px;
            border-top:0;
        }
        .cks {
            margin-top:6px;float:left;
        }
        .w2x {
            width:35.2%;width:35.5%\9;
        }
    
</style>

<%@ include file="../detail_top.jsp" %>
<!-- 保留计划基本信息  -->
<%@ include file="plans/basicInfo.jsp" %>

<!-- 商品列表  -->
<%@ include file="plans/itemArea.jsp" %>

<!-- 门店商品数量  -->
<%@ include file="plans/itemAndStoreArea.jsp" %>


<!-- 以下是各区块的DOM模板定义 -->
<div id="itemFirstTemplate" style="display: none;">
	<%@ include file="template/itemFirstTemplate.jsp"%>
</div>

<div id="itemSecondTemplate" style="display: none">
	<%@ include file="template/itemSecondTemplate.jsp"%>
</div>
<div id="itemStoreTemplate" style="display: none">
	<%@ include file="template/itemStoreTemplate.jsp"%>
</div>


