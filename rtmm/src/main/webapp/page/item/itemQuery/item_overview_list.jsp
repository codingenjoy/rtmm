<%@ include file="/page/commons/taglibs.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/catalog/catalog.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/jquery-zwindow/js/zWindow.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/jquery-zwindow/css/default/zWindow.css" />
<script type="text/javascript">  
$(function(){
	showStoreSelect();
	showDivision();
});
function initPage(){
	$('#pageNo1').val(1);
	var pageSize = $('#pageSize1').val();
	if(pageSize){
		$('#pageSize1').val(20);
	}
}
function pageQuery1() {
	var flag = checkSearchCond();
	if(flag){
		top.jAlert('warning','请输入查询条件！','消息提示');
		return ;
	}
	var queryFrom = $("#queryFrom").serialize();
	$.ajax({
		type : "post",
		data :queryFrom,
		dataType : "html",
		url : ctx + "/item/query/getItemListByPage",
		success : function(data) {
			$('#items_content').html(data);
			setTools23();
		}
	});
}

//主厂商
function openSupWindow() {
	openPopupWin(550, 510,'/commons/window/chooseSupNo?callback=confirmChooseSupNo');
}
function confirmChooseSupNo(supNo,comName){
	/* var textShow = supNo+"-"+comName;
	$('#showSupSearch').val(textShow); */
	$('#majorSupNoSearch').val(supNo);
}
//分店厂商
function openSupStoreWindow() {
	openPopupWin(550, 510,'/commons/window/chooseSupNo?callback=confirmStoreSup');
}
function confirmStoreSup(supNo,comName){
/* 	var textShow = supNo+"-"+comName;
	$('#mainComNoSearch').val(textShow); */
	$('#mainComNameSearch').val(supNo);
}
//品牌
function openBrandWindow() {
	openPopupWin(550, 510,'/commons/window/chooseBrandNo?callback=confirmBrandNo');
}
function confirmBrandNo(brandId,brandName){
	/* var textShow = brandId+"-"+brandName;
	$('#brandNameSearch').val(textShow); */
	$('#brandIdSearch').val(brandId);
}
//设置品牌
function setBrand(){
	if($('#brandIdSearch').val() && $('#brandNameSearch').val()){
		var textShow = $('#brandIdSearch').val();+"-"+$('#brandNameSearch').val();;
		$('#brandIdSearch').val(textShow);
	}
}
function clearSearchCon(){
	$('#sectionCode').empty();
	$('#groupCode').empty();
	$('#midsizeCode').empty();
	$('#catlgNo').empty();
	$('.SearchTable').find(':input').val('');
	$('#pageNo1').val(1);
	$('#pageSize1').val(20);
}
function checkSearchCond(){
	  if($('#storeNoSearch').val()){return false;}  
	  if($('#itemNoSearch').val()){return false;}  
	  if($('#itemNameSearch').val()){return false;}  
	  if($('#majorSupNoSearch').val()){return false;}  
	  if($('#showSupSearch').val()){return false;}  
	  if($('#statusSearch').val()){return false;}  
	  if($('#divisionCode').val()){return false;}  
	  if($('#sectionCode').val()){return false;}  
	  if($('#groupCode').val()){return false;}  
	  if($('#midsizeCode').val()){return false;}  
	  if($('#catlgNo').val()){return false;}  
	  if($('#brandIdSearch').val()){return false;}  
	  if($('#brandNameSearch').val()){return false;}  
	  if($('#buyMethdSearch').val()){return false;}  
	  if($('#projLabelSearch').val()){return false;}  
	  if($('#itemTypeSearch').val()){return false;}  
	  if($('#prcssTypeSearch').val()){return false;}  
	  if($('#itemPackSearch').val()){return false;}  
	  if($('#buyPerdSearch').val()){return false;}  
	  if($('#orignCtrlSearch').val()){return false;}  
	  if($('#buyWhenSearch').val()){return false;}  
	  //if($('#mainComNoSearch').val()){return false;}  
	  if($('#mainComNameSearch').val()){return false;}  
	  if($('#storeUpdtSpIndSearch').val()){return false;}  
	  if($('#sellAllowSearch').val()){return false;}  
	  if($('#priceTierValSearch').val()){return false;}  
	  if($('#dcAttrSearch').val()){return false;}  
	  if($('#rtnAllowSearch').val()){return false;}  
	  if($('#rcvAllowSearch').val()){return false;}
	return true;
}
</script>
<%-- <%@ include file="/page/commons/toolbar.jsp"%> --%>
<div class="CTitle">
    <!--第一个-->
    <div class="tags1_left tags1_left_on"></div>
    <div class="tagsM tagsM_on">商品总览</div>
    <div class="tags tags3_r_on"></div>
</div>
<div class="Container-1" id="Container-1">
<form id="queryFrom" class="clean_from" action="">
<div class="Search"><!-- Bar_on-->
<div class="SearchTop">
    <span>查询条件</span>
    <div class="Icon-size1 CircleClose C-id" onclick="{DispOrHid('C-id');gridbar_C();}"></div>
</div>
<div class="line"></div>
<div class="SMiddle">
    <table class="SearchTable">
        <tr>
            <td class="ST_td1"><span>店号</span></td>
            <td>
            	<select id="storeNoSearch" name="storeNo" class="w80" >
	         		<%-- <option value="">请选择</option>
					<c:forEach items="${stores}" var="store">
						<option value="${store.storeNo}" title="${store.storeNo}-${store.storeName}">${store.storeNo}-${store.storeName}</option>
					</c:forEach> --%>
				</select>
            </td>
        </tr>
        <tr>
            <td><span>货号</span></td>
            <td><input id="itemNoSearch" name="itemNo" type="text" class="inputText w80" value="${serarchVO.itemNo}" 
            		   onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
            </td>
        </tr>
        <tr>
            <td><span>品名</span></td>
            <td>
                <input id="itemNameSearch" name="itemName" class="w80 inputText" type="text" value="${serarchVO.itemName}"/>
            </td>
        </tr>
        <tr>
            <td><span>主厂商</span></td>
            <td>
            	<div class="iconPut w80 fl_left">
            		<input type="text" class="w83" id="majorSupNoSearch" name="comNo" value="" 
            			   onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
                   <!-- <input id="showSupSearch" name="majorSupName" type="text" class="w83" /> -->
                   <div class="ListWin" onclick="openSupWindow();"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td><span>主状态</span></td>
            <td>
                <auchan:select id="statusSearch" name="status" mdgroup="ITEM_BASIC_STATUS" _class="w80" value="${serarchVO.status}"/>
            </td>
        </tr>
        <tr>
            <td><span>处别</span></td>
            <td>
                <select id="divisionCode" name ="divNo" onchange="divisionSelect(this)" class="w80">
							<option value=''>请选择</option>
				</select>
            </td>
        </tr>
        <tr>
            <td><span>课别</span></td>
            <td>
                <select id="sectionCode" name="secNo" class="w80" disabled="disabled" onchange="sectionSelect(this)">
				</select>
            </td>
        </tr>
        <tr>
            <td><span>大分类</span></td>
            <td>
                <select id="groupCode" name="grpNo" class="w80" disabled="disabled" onchange="groupSelect(this)">
						<!--  <option value=''>请选择</option> -->
				</select>
            </td>
        </tr>
        <tr>
            <td><span>中分类</span></td>
            <td>	
                <select id="midsizeCode" name="midgrpNo" class="w80" disabled="disabled" onchange="midgrpSelect(this)">
				</select>
            </td>
        </tr>
        <tr>
            <td><span>小分类</span></td>
            <td>
                <select id="catlgNo" name="catlgNo" class="w80" disabled="disabled" >
				</select>
            </td>
        </tr>
        <tr>
            <td><span>品牌</span></td>
            <td><div class="iconPut w80 fl_left">
                     <input id="brandIdSearch" class="w83" type="text" name="brandId"  
                     		onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
                    <!--  <input id="brandNameSearch" name="brandName" class="w83" type="text" readonly="readonly"> -->
                     <div class="ListWin" onclick="openBrandWindow();"></div>
                </div>
            </td>
        </tr>
        <tr>
            <td><span>采购方式</span></td>
            <td>
            	<auchan:select id="buyMethdSearch" name="buyMethd" mdgroup="ITEM_BASIC_BUY_METHD" _class="w80" value="${serarchVO.buyMethd}"/>
            </td>
        </tr>
        <tr>
            <td><span>项目类型</span></td>
            <td>
            	<auchan:select id="projLabelSearch" name="projLabel" mdgroup="ITEM_BASIC_PROJ_LABEL" _class="w80" value="${serarchVO.projLabel}"/>
            </td>
        </tr>
        <tr>
            <td><span>商品类别</span></td>
            <td>
            	<auchan:select id="itemTypeSearch"  name="itemType" mdgroup="ITEM_BASIC_ITEM_TYPE" _class="w80" value="${serarchVO.itemType}"/>
            </td>
        </tr>
        <tr>
            <td><span>加工类别</span></td>
            <td>
            	<auchan:select id="prcssTypeSearch" name="prcssType" mdgroup="ITEM_BASIC_PRCSS_TYPE" _class="w80" value="${serarchVO.prcssType}"/>
            </td>
        </tr>
        <tr>
            <td><span>商品包装</span></td>
            <td>
            	<auchan:select id="itemPackSearch" name="itemPack" mdgroup="ITEM_BASIC_ITEM_PACK" _class="w80" value="${serarchVO.itemPack}"/>
            </td>
        </tr>
        <tr>
            <td><span>采购期限</span></td>
            <td>
            	<auchan:select id="buyPerdSearch" name="buyPerd" mdgroup="ITEM_BASIC_BUY_PERD" _class="w80" value="${serarchVO.buyPerd}"/>
            </td>
        </tr>
        <tr>
            <td><span>产地维护</span></td>
            <td>
            	<%-- <auchan:select id="orignCode" name="orignCode" mdgroup="origin" _class="w80" value="${serarchVO.orignCode}"/> --%>
            	<auchan:select id="orignCtrlSearch" name="orignCtrl" mdgroup="ITEM_BASIC_ORIGIN_CTRL" _class="w80" value="${serarchVO.orignCtrl}"/>
            </td>
        </tr>
        <tr>
            <td><span>成本时点</span></td>
            <td>
            	<auchan:select id="buyWhenSearch" name="buyWhen" mdgroup="ITEM_BASIC_BUY_WHEN" _class="w80" value="${serarchVO.buyWhen}"/>
            </td>
        </tr>
            <tr>
                <td colspan="2">
                    <div class="align_center sp_store_off">----------&nbsp;&nbsp;分店信息&nbsp;&nbsp;----------</div>
                </td>
            </tr>
            <tr>
                <td><span>分店厂商</span></td>
                <td><div class="iconPut w80 fl_left">
                			<input id="mainComNameSearch" name="stMainSupNo" class="w83  " type="text" 
                					onkeyup="value=this.value.replace(/\D+/g,'')" maxlength="8"/>
                          <%--   <input id="mainComNoSearch" name="mainComNo" type="text" class="w83" value="${serarchVO.mainComNo}" readonly="readonly"/> --%>
                            <div class="ListWin" onclick="openSupStoreWindow();"></div>
                        </div>
                </td>
            </tr>
            <tr>
                <td><span>门店变价</span></td>
                <td>
                	<auchan:select id="storeUpdtSpIndSearch" name="storeUpdtSpInd" mdgroup="ITEM_STORE_INFO_STORE_UPDT_SP_IND" _class="w80" value="${serarchVO.storeUpdtSpInd}"/>
                </td>
            </tr>
            <tr>
                <td><span>可否销售</span></td>
                <td>
                	<auchan:select id="sellAllowSearch" name="sellAllow" mdgroup="ITEM_STORE_INFO_SELL_ALLOW" _class="w80" value="${serarchVO.sellAllow}"/>
                </td>
            </tr>
            <tr>
                <td><span>价格段</span></td>
                <td>T&nbsp;&nbsp;&nbsp;<input id="priceTierValSearch" name="priceTierVal" type="text" class="inputText w30" value="${serarchVO.priceTierVal}" onkeyup="value=this.value.replace(/\D+/g,'')"/></td>
            </tr>
            <tr>
                <td><span>DC属性</span></td>
                <td>
                	<auchan:select id="dcAttrSearch" name="dcAttr" mdgroup="ITEM_STORE_INFO_DC_ATTR" _class="w80" value="${serarchVO.dcAttr}"/>
                </td>
            </tr>
            <tr>
                <td><span>可否退货</span></td>
                <td>
                	<auchan:select id="rtnAllowSearch" name="rtnAllow" mdgroup="ITEM_STORE_INFO_RTN_ALLOW" _class="w80" value="${serarchVO.rtnAllow}"/>
                </td>
            </tr>
            <tr>
                <td><span>可否收货</span></td>
                <td>
                	<auchan:select id="rcvAllowSearch" name="rcvAllow" mdgroup="ITEM_STORE_INFO_RCV_ALLOW" _class="w80" value="${serarchVO.rcvAllow}"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="line"></div>
    <div class="SearchFooter">
        <div class="Icon-size1 Tools20" onclick="clearSearchCon();"></div>
        <div class="Icon-size1 Tools6" onclick="initPage();pageQuery1()"></div>
    </div>
</div>
<div class="Content" id="items_content" style="width:74%">
<%@ include file="/page/item/itemQuery/item_overview_list_page.jsp"%>
</div>
</form>
</div>
