<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/workspace/report.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$(".btable_div").scroll(function() {
		var left = $(this).scrollLeft();
		$(".htable_div").scrollLeft(left);
	});
});
 
function exportItemInfo(exportCount){
	//导出信息
		$('#Tools23').removeClass('Tools23_disable').addClass('Tools23').unbind().bind('click',function() {
	        if(exportCount>=5000){
	        	top.jAlert("warning","请缩小查询范围到5000项以下","提示信息");
	        	return false;
		    }
		   top.jAlert('success', '数据正在导出，请稍候...！', '提示消息');
		    var  params = new Object();
		    params.storeNo=$("#storeNoSearch").val()==null?"":$.trim($("#storeNoSearch").val());
		    params.itemNo=$("#itemNoSearch").val()==null?"":$.trim($("#itemNoSearch").val());
		    params.itemName=$("#itemNameSearch").val()==null?"":$.trim($("#itemNameSearch").val());
		    params.comNo=$("#majorSupNoSearch").val()==null?"":$.trim($("#majorSupNoSearch").val());
		    params.status=$("#statusSearch").val()==null?"":$.trim($("#statusSearch").val());
		    params.divNo=$("#divisionCode").val()==null?"":$.trim($("#divisionCode").val());
		    params.secNo=$("#sectionCode").val()==null?"":$.trim($("#sectionCode").val());
		    params.grpNo=$("#groupCode").val()==null?"":$.trim($("#groupCode").val());
		    params.midgrpNo=$("#midsizeCode").val()==null?"":$.trim($("#midsizeCode").val());
		    params.catlgNo=$("#catlgNo").val()==null?"":$.trim($("#catlgNo").val());
		    params.brandId=$("#brandIdSearch").val()==null?"":$.trim($("#brandIdSearch").val());
		    params.buyMethd=$("#buyMethdSearch").val()==null?"":$.trim($("#buyMethdSearch").val());
		    params.projLabel=$("#projLabelSearch").val()==null?"":$.trim($("#projLabelSearch").val());
		    params.itemType=$("#itemTypeSearch").val()==null?"":$.trim($("#itemTypeSearch").val());
		    params.prcssType=$("#prcssTypeSearch").val()==null?"":$.trim($("#prcssTypeSearch").val());
		    params.itemPack=$("#itemPackSearch").val()==null?"":$.trim($("#itemPackSearch").val());
		    params.buyPerd=$("#buyPerdSearch").val()==null?"":$.trim($("#buyPerdSearch").val());
		    params.orignCtrl=$("#orignCode").val()==null?"":$.trim($("#orignCode").val());
		    params.buyWhen=$("#buyWhenSearch").val()==null?"":$.trim($("#buyWhenSearch").val());		    
		    params.stMainSupNo=$("#mainComNameSearch").val()==null?"":$.trim($("#mainComNameSearch").val());
		    params.storeUpdtSpInd=$("#storeUpdtSpIndSearch").val()==null?"":$.trim($("#storeUpdtSpIndSearch").val());
		    params.sellAllow=$("#sellAllowSearch").val()==null?"":$.trim($("#sellAllowSearch").val());
		    params.priceTierVal=$("#priceTierValSearch").val()==null?"":$.trim($("#priceTierValSearch").val());
		    params.dcAttr=$("#dcAttrSearch").val()==null?"":$.trim($("#dcAttrSearch").val());
		    params.rtnAllow=$("#rtnAllowSearch").val()==null?"":$.trim($("#rtnAllowSearch").val());
		    params.rcvAllow=$("#rcvAllowSearch").val()==null?"":$.trim($("#rcvAllowSearch").val());
 			exportReport('sync','112111005',params);		 
		});
};
function setTools23(){

	<c:if test="${page ne null and page.totalCount gt 0}" var="itemInfoResult">
    exportItemInfo('${page.totalCount}');
	</c:if>
	<c:if test="${!itemInfoResult}">
	$('#Tools23').removeClass('Tools23').addClass('Tools23_disable').unbind('click');
	</c:if>
}
</script>

<input type="hidden" name="pageNo" id="pageNo1" value="${page.pageNo }" />
<div class="htable_div">
    <table>
    <thead>
        <tr>
            <td><div class="t_cols" style="width:60px;">货号</div></td>
            <td><div class="t_cols" style="width:120px;">品名</div></td>
            <td><div class="t_cols" style="width:120px;">主厂商</div></td>
            <td><div class="t_cols" style="width:100px;">主状态</div></td>
            <td><div class="t_cols" style="width:100px;">品牌</div></td>
            <td><div class="t_cols" style="width:100px;">处别</div></td>
            <td><div class="t_cols" style="width:80px;">课别</div></td>
            <td><div class="t_cols" style="width:80px;">系列</div></td>
            <td><div class="t_cols" style="width:100px;">大分类</div></td>
            <td><div class="t_cols" style="width:100px;">中分类</div></td>
            <td><div class="t_cols" style="width:100px;">小分类</div></td>
            <td><div class="t_cols" style="width:100px;">采购方式</div></td>
            <td><div class="t_cols" style="width:100px;">项目类型</div></td>
            <td><div class="t_cols" style="width:100px;">商品类别</div></td>
            <td><div class="t_cols" style="width:100px;">加工类别</div></td>
            <td><div class="t_cols" style="width:100px;">商品包装</div></td>
            <td><div class="t_cols" style="width:80px;">采购期限</div></td>
            <td><div class="t_cols" style="width:80px;">产地维护</div></td>
            <td><div class="t_cols" style="width:100px;">成本时点</div></td>
            <td><div class="t_cols" style="width:100px;">进价税率</div></td>
            <td><div style="width:100px;">售价税率</div></td>
            <td><div style="width:16px;">&nbsp;</div></td>
           </tr>
    </thead>
	</table>
</div>
<div class="btable_div" style="height:510px;">
    <table  class="single_tb w100">
    	<c:if test="${not empty page.result }">
    	<c:forEach items="${page.result}" var="item">
           <tr ondblclick="searchItemByItemNo(${item.itemNo});">
              <td style="width:61px;" class="align_right"><span style="margin-right:5px;">${item.itemNo}</span></td>
              <td style="width:121px;" title="${item.itemName}">${item.itemName}</td>
              <td style="width:121px;" title="${item.comNo}-${item.comName}"><c:if test="${item.comNo != null && item.comName != null}">${item.comNo}-${item.comName}</c:if></td>
              <td style="width:101px;" ><c:if test="${item.status != null}"><auchan:getDictValue code="${item.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue></c:if></td>
              <td style="width:101px;" title="${item.brandId}-${item.brandName}"><c:if test="${item.brandId != null && item.brandName != null}">${item.brandId}-${item.brandName}</c:if></td>
              <td style="width:101px;" title="${item.divNo}-${item.divName}"><c:if test="${item.divNo != null && item.divName != null}">${item.divNo}-${item.divName}</c:if></td>
              <td style="width:81px;" title="${item.secNo}-${item.secName}"><c:if test="${item.secNo != null && item.secName != null}">${item.secNo}-${item.secName}</c:if></td>
              <td style="width:81px;" title="${item.clstrId}-${item.clstrName}"><c:if test="${item.clstrId != null && item.clstrName != null}">${item.clstrId}-${item.clstrName}</c:if></td>
              <td style="width:101px;" title="${item.grpNo}-${item.grpName}"><c:if test="${item.grpNo != null && item.grpName != null}">${item.grpNo}-${item.grpName}</c:if></td>
              <td style="width:101px;" title="${item.midgrpNo}-${item.midgrpName}"><c:if test="${item.midgrpNo != null && item.midgrpName != null}">${item.midgrpNo}-${item.midgrpName}</c:if></td>
              <td style="width:101px;"><c:if test="${item.catlgNo != null && item.catlgName != null}">${item.catlgNo}-${item.catlgName}</c:if></td>
              <td style="width:101px;"><c:if test="${item.buyMethd != null }"><auchan:getDictValue code="${item.buyMethd}" mdgroup="ITEM_BASIC_BUY_METHD"></auchan:getDictValue></c:if></td>
              <td style="width:101px;"><c:if test="${item.projLabel != null }"><auchan:getDictValue code="${item.projLabel}" mdgroup="ITEM_BASIC_PROJ_LABEL"></auchan:getDictValue></c:if></td>
              <td style="width:101px;"><c:if test="${item.itemType != null }"><auchan:getDictValue code="${item.itemType}" mdgroup="ITEM_BASIC_ITEM_TYPE"></auchan:getDictValue></c:if></td>
              <td style="width:101px;"><c:if test="${item.prcssType != null }"><auchan:getDictValue code="${item.prcssType}" mdgroup="ITEM_BASIC_PRCSS_TYPE"></auchan:getDictValue></c:if></td>
              <td style="width:101px;"><c:if test="${item.itemPack != null }"><auchan:getDictValue code="${item.itemPack}" mdgroup="ITEM_BASIC_ITEM_PACK"></auchan:getDictValue></c:if></td>
              <td style="width:81px;"><c:if test="${item.buyPerd != null }"><auchan:getDictValue code="${item.buyPerd}" mdgroup="ITEM_BASIC_BUY_PERD"></auchan:getDictValue></c:if></td>
              <td style="width:81px;"><c:if test="${item.orignCtrl != null }"><auchan:getDictValue code="${item.orignCtrl}" mdgroup="ITEM_BASIC_ORIGIN_CTRL"></auchan:getDictValue></c:if></td>
              <td style="width:101px;"><c:if test="${item.buyWhen != null }"><auchan:getDictValue code="${item.buyWhen}" mdgroup="ITEM_BASIC_BUY_WHEN"></auchan:getDictValue></c:if></td>
              <td style="width:101px;"><c:if test="${item.buyVatNo !=null && item.buyVatVal != null }">${item.buyVatNo}-${item.buyVatVal}%</c:if></td>
              <td style="width:101px;"><c:if test="${item.sellVatNo !=null && item.sellVatVal != null }">${item.sellVatNo}-${item.sellVatVal}%</c:if></td>
              <td style="width:auto">&nbsp;</td>
               </tr>
    	</c:forEach>
    	</c:if>
    </table> 
</div>
<jsp:include page="/page/commons/pageSet1.jsp"></jsp:include>



