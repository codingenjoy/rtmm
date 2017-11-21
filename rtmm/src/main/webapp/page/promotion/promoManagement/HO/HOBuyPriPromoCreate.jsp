<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/loading/loading.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/common.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/loading/loading.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/promotion/promotionCreate.js?t=10009" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

<script type="text/javascript">
	$(function() {
		
		top.grid_layer_close();
		//保存创建总部进价促销
		$("#Tools2").attr('class', "Icon-size1 Tools2").bind("click",saveCreateProm);
		var promType = "${promType }";
		$("#promType").val(promType);
		var updatePromNo = "${updatePromNo }";
		var updateUnitType = "${updateUnitType }";
		var updatePromUnitNo = "${updatePromUnitNo }";
		if (promType == "update") {
			updatePromPriceMess(promType,updatePromNo,updateUnitType,updatePromUnitNo);
		}
		$("#promCodeMess_div .item").die('click');
		nullInputCheck();
		inputToInputIntNumber();
	});
	
	function loadCatagryByObj(obj){
		var sectionNo = $.trim($(obj).val());
		if(sectionNo && sectionNo!=$(obj).attr('prev')){
			pr_searchSectionMess(sectionNo);
		}
		$(obj).attr('prev',sectionNo);
	}

	// 关闭创建进价促销
	function closeCreateProm() {
		var parmStr = '${parm}' || null;
		var parmObj = {};
		parmObj = JSON.parse(parmStr);
		var parm="";
		if(parmObj){
			parmObj.subjName = encodeURI(parmObj.subjName);
		 parm = JSON.stringify(parmObj);
		}
		window.location.href = ctx + "/prom/nondm/ho/HOBuyPriPromo?parm=" + parm;
	}
</script>
<style type="text/css">
     .psi1 {
         width:15px;
     }
     .psi2 {
         width:106px;
     }
     .psi3 {
         width:73px;
     }
     .psi7{
     	width:194px;
     }
     .psi4 {
        width:89px;
     }
     .psi5 ,.psi6 {
         width:87px;
     }
     .psi1,
     .psi2,
     .psi3,
     .psi4,
     .psi5,
     .psi6,
     .pso1,.pso2 ,.pso3,.pso4 {
         text-align:center;overflow:hidden;
     }
     .pso1 {
         width:159px;
     }
     .pso2 {
         width:147px;
     }	
     .pso3 {
         width:430px;
     }
     .pso4 {
         width:119px;
     }
     /*overwrite*/
     .item,.ig,.item_next {
         height:25px;padding-top:3px;
     }
     .iconPut {
         background:#fff;
     }
     .fl_left {margin-right:3px;
     }
     .lineToolbar {
         margin-top:0;
     }
     .Panel_footer {
	    background: none repeat scroll 0 0 #f9f9f9;
	    height: 40px;
	    overflow: hidden;
	    text-align:center;
	    position:absolute;
	    left:0;
	    bottom:0;
	    width:100%;
	}
	.pstb_del {
	margin-left: 35px;
}
</style>

<%@ include file="/page/commons/toolbar.jsp"%>

<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<!--最后一个-->
	<div class="tagsM">总部进价促销</div>
	<div class="tags tags3 tags_right_on"></div>
	<!--一定不要忘了tag3-->
	<!--add-->
	<div class="tagsM_q  tagsM_on" id="promHOPrice">创建新总部进价促销</div>
	<div class="tags3_close_on">
		<div class="tags_close" onclick="closeCreateProm()"></div>
	</div>
</div>
 <div class="Container-1">
     <div class="Content">
         <div class="CM" style="height:90px;">
              <div class="inner_half">
                     <div class="CM-bar"><div>促销期数</div></div>
                     <div class="CM-div">
                         <div class="ig_top20">
                             <div class="icol_text w14"><span>促销期数</span></div>
                             <input id="promNo" type="text" class="inputText w20 Black" readonly="readonly" />
                         </div>
                         <div class="ig">
                             <div class="icol_text w14"><span>*主题</span></div>
                             <input id="subjName" type="text" class="inputText w50 mustInput" onkeyup="checkSubjName()" onfocus="{$(this).attr('title','');$(this).removeClass('errorInput');}" />(提示：最多输入15个字)
                             <input id="promSubjId" type="hidden" class="inputText w50" />
                         </div>
                     </div>
                 </div>
              <div class="inner_half">
                   <div class="CM-div">
                       <div class="ig_top20">
                           <div class="icol_text w14"><span>*采购期间</span></div>
                           <input id="buyBeginDate" name="buyBeginDate" onchange="clearExistsItemStoreMap(this)" preval="" type="text" class="Wdate w20 mustInput" onfocus="{$(this).removeClass('errorInput');}" onclick="WdatePicker({onpicked:function(){<c:if test="${not empty promType }">if(checkPromBuyStartDate($(this))){return false;}</c:if>if(this.value>$dp.$('buyEndDate').value){$dp.$('buyEndDate').value='';$dp.$('buyEndDate').focus();}},isShowClear:false,readOnly:true,lang:'${calendarL}',minDate:'${minDate}'})"/>&nbsp;-&nbsp;
                           <c:choose>
                           <c:when test="${promType == 'update' }">
                               <c:if test="${buyBegin==1}">
                                  <input id="buyEndDate" name="buyEndDate" onchange="clearExistsItemStoreMap(this)" preval="" type="text" class="Wdate w20 mustInput" onfocus="{$(this).removeClass('errorInput');}" onclick="WdatePicker({onpicked:function(){<c:if test="${not empty promType }">if(checkPromBuyEndDate($(this))){return false;}</c:if>if(this.value<$dp.$('buyBeginDate').value){$dp.$('buyBeginDate').value='';$dp.$('buyBeginDate').focus();}},isShowClear:false,readOnly:true,lang:'${calendarL}',minDate:'${nowDate}'})"/>
                               </c:if>
                               <c:if test="${buyBegin!=1}">
                                <input id="buyEndDate" name="buyEndDate" onchange="clearExistsItemStoreMap(this)" preval="" type="text" class="Wdate w20 mustInput" onfocus="{$(this).removeClass('errorInput');}" onclick="WdatePicker({onpicked:function(){<c:if test="${not empty promType }">if(checkPromBuyEndDate($(this))){return false;}</c:if>if(this.value<$dp.$('buyBeginDate').value){$dp.$('buyBeginDate').value='';$dp.$('buyBeginDate').focus();}},isShowClear:false,readOnly:true,lang:'${calendarL}',minDate:'#F{$dp.$D(\'buyBeginDate\')}'})"/>
                               </c:if>
                           </c:when>
                           <c:otherwise>
                              <input id="buyEndDate" name="buyEndDate" onchange="clearExistsItemStoreMap(this)" preval="" type="text" class="Wdate w20 mustInput" onfocus="{$(this).removeClass('errorInput');}" onclick="WdatePicker({onpicked:function(){<c:if test="${not empty promType }">if(checkPromBuyEndDate($(this))){return false;}</c:if>if(this.value<$dp.$('buyBeginDate').value){$dp.$('buyBeginDate').value='';$dp.$('buyBeginDate').focus();}},isShowClear:false,readOnly:true,lang:'${calendarL}',minDate:'#F{$dp.$D(\'buyBeginDate\')}'})"/>
                           </c:otherwise>
                           </c:choose>
                       </div>
                       <div class="ig">
                            <div class="icol_text w14"><span>*课别</span></div>
							<c:choose>
								<c:when test="${promType == 'update' }">
									<input id="catlgId" name="catlgId" class="w15 fl_left inputText Black mustInput count_text" type="text" readonly="readonly" />
									<input id="catlgName" name="catlgName" type="text" class="inputText w25 Black" readonly="readonly" />
								</c:when>
								<c:otherwise>
									<div class="iconPut w15 fl_left">
										<input id="catlgId" name="catlgId" class="w70 mustInput Black count_text" type="text" onfocus="{$(this).attr('title','');$(this).removeClass('errorInput');}" value="${catlg.catlgId }" readonly="readonly" />
										<div class="ListWin" style="cursor:auto;"></div>
									</div>
									<input id="catlgName" name="catlgName" type="text" class="inputText w25 Black" readonly="readonly" value="${catlg.catlgName}" />
								</c:otherwise>
							</c:choose>
                         </div>
                     </div>
              </div>      
         </div>
         <div class="CM" style="height:180px;margin-top:2px;">
             <div class="CM-bar"><div>促销代号信息</div></div>
             <div class="CM-div">
                 <div class="pro_store_item">
                     <!-- <div class="top15">
	                     <span class="pso1">代号类别</span><span class="pso2">代号</span>
	                     <span class="pso3">名称</span><span class="pso4">促销进价(元)</span>
	                     <span class="pso5">备注</span>
                     </div> -->
                     <table>
                     	<tr>
                     		<td><div class="pso1">代号类别</div></td>
                     		<td><div class="pso2">代号</div></td>
                     		<td><div class="pso3">名称</div></td>
                     		<td><div class="pso4">促销进价(元)</div></td>
                     	</tr>
                     </table>
                     <div id="promCodeMess_div" class="pro_store_tb_edit w100">
                     </div>
                     <div class="ig_top10">
                         <div id="addPromCodeMess_div" class="first_ztdb createNewBar fl_left" onMouseUp="addPromCodeMess(this)"></div>
                         <div class="lineToolbar fl_left"></div>
                         <div id="copyBar_div" class="copyBar fl_left" onclick="showPasteWin(this)"></div>
                     </div>
                 </div>
             </div>
         </div>
         <div class="CM" style="height:296px;margin-top:2px;">
             <div class="CM-bar"><div>促销商品门店信息</div></div>
             <div class="CM-div">
                 <div class="pro_store_item">
                     <div class="pro_store_item1">
                         <div class="top15">所选商品</div>
                         <div class="pro_store_items" style="height:75%;">
                         </div>
                         <div class="ig_top10"><div id="showDeleteItems" unitTypeValue="" unitNoValue="" class="createNewBar_off" onclick="addSelectedItem(this)" ></div></div>
                     </div>
                     <div class="pro_store_item2">
                         <!-- <div class="top15">
                             <span class="psi1">门店</span><span class="psi2">厂商</span>
                             <span class="psi3">商品状态</span><span class="psi4">正常进价(元)</span>
                             <span class="psi5">促销进价(元)</span>
                         </div> -->
                         <table>
	                     	<tr>
	                     		<td><div class="psi1">&nbsp;</div></td>
	                     		<td><div class="psi2">门店</div></td>
	                     		<td><div class="psi3">厂商</div></td>
	                     		<td><div class="psi7">&nbsp;</div></td>
	                     		<td><div class="psi4">商品状态</div></td>
	                     		<td><div class="psi5">正常进价(元)</div></td>
	                     		<td><div class="psi6">促销进价(元)</div></td>
	                     	</tr>
	                     </table>
                         <div class="fu_div">
                             <input id="updatePriceAll" type="text" class="inputText w12_5" onkeyup="inputToInputDoubleNumber(this,event)" style="margin-left: 565px;" value="" />
                         </div>
                         <div id="promItemStoreMess_div" class="pro_store_tb" style="height:65%;">
                         	 <div class="top5"></div>
                         </div>
                         <div class="top10">
                             <input class="fl_left top3 isCheckAllsProm" type="checkbox" disabled="disabled" />
                             <div class="deleteBar_off fl_left deleteCheckedsProm" checkUnitType="" checkItemNo="" checkPromNo="" ></div>
                             <div class="lineToolbar fl_left"></div>
                             <div class="createNewBar_off fl_left" id="promItemStore_div" checkUnitType="" checkItemNo="" checkPromNo="" onclick="addStoreSupMess(this)"></div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </div>
 </div>
 
 <div style="display:none">
	<div id="addPromCode_div">
		<div class="item addPromCode_div item_on" >
			<form onSubmit="return false;">
				<auchan:select mdgroup="PROM_UNIT_BY_ST_UNIT_TYPE" _class="w15 first_ztdb fl_left selectOnchang" iscaption="0" name="unitType" />
				<div class="iconPut w15 fl_left">
					<input name="promUnitNo" class="w85 promUnitNoClick" onkeyup="inputToInputIntNumber(this);" type="text" />
					<div class="ListWin showUnitWin searchPromCodeMess"></div>
				</div>
				<input type="text" class="inputText w45 fl_left Black promUnitName" readonly="readonly" />
				<input type="text" class="inputText w12_5 fl_left promBuyPrices" onkeyup="inputToInputDoubleNumber(this,event)" />
				<!-- <input name="memo" type="text" class="inputText w25 fl_left" /> -->
				<div class="pstb_del delPromUnitNo"></div>
			</form>
		</div>
	</div>
</div>
<div id="itemStoreInfoModel" class="Panel" style="display: none">
	<div class="ig">
	<form onSubmit="return false;">
	    <input type="checkbox" class="fl_left ck isChecksProm">
	    <input type="hidden" value="" name="unitType">
	    <input type="hidden" value="" name="promUnitNo">
	    <input type="hidden" value="" name="itemNo">
	    <input type="hidden" value="" name="storeNo">
	    <input type="text" value="" class="inputText w15 fl_left Black" readonly="readonly" name="storeName">
	    <input type="text" value="" readonly="readonly" class="w10 fl_left inputText" name="promSupNo">
	    <input type="text" value="" readonly="readonly" class="inputText w28 fl_left Black" name="comName">
	    <input type="text" value="" readonly="readonly" class="inputText w12_5 fl_left Black" name="statusName">
	    <input type="text" value="" class="inputText w12_5 fl_left Black" readonly="readonly" name="normBuyPrice">
	    <input type="text" value="" onkeyup="inputToInputDoubleNumber(this,event);" buyPriceLimit="" buywhen="" onfocus="{$(this).removeClass('errorInput');$(this).attr('title','');}" class="inputText w12_5 fl_left errorInput" name="promBuyPrice">
	    <input type="hidden" value="" name="normSellPrice">
	    <input type="hidden" value="" name="itemName">
	    <input type="hidden" value="" name="buyPriceLimit">
    	<input type="hidden" value="" name="buyWhen">
	    <input type="hidden" value="" name="checkOrders">
	    <input type="hidden" value="" name="batchPriceChngInd">
	</form>
	</div>
</div>

<div id="promItemInfoModel" class="Panel" style="display: none">
	<div class="item item_on" checkOrders="">
		<span itemNameValue="" itemNoValue="" unitNoValue="" unitTypeValue="" pbpValue="" class="pstb_1 promItemStoreClick"></span>
	</div>
</div>
<div id="promItemInfoModel2" class="Panel" style="display: none">
	<div class="item" checkOrders="">
		<span itemNameValue="" itemNoValue="" unitNoValue="" unitTypeValue="" pbpValue="" class="pstb_1 promItemStoreClick"></span><span class="pstb_del2 delItemSupMess" ></span>
	</div>
</div>
<input type="hidden" id="promType" value="${promType }" ></input>
<input type="hidden" id="checkUpdate" ></input>
<input type="hidden" id="prom_str_hidden" ></input>
<input type="hidden" id="promNo_str_hidden" ></input>
<input type="hidden" id="unitType_str_hidden" ></input>
<input type="hidden" id="nowDate_hidden" value="${nowDate}"></input>

