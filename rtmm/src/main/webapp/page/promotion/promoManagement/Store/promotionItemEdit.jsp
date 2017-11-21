<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/js/loading/loading.css" />
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/shared/js/iframeContent.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript"
	src="${ctx}/shared/js/promotion/promotionStoreEdit.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/shared/js/common.js" charset="utf-8"></script>	
<script type="text/javascript" src="${ctx}/shared/js/loading/loading.js"
	charset="utf-8"></script>

<style type="text/css">
.hiLightInput {
	color: red;
}

.hiLightYellowInput {
	color: yellow;
}

.pro1 {
	margin-left: 60px;
}

.pro2 {
	margin-left: 90px;
}

.pro3 {
	margin-left: 120px;
}

.pro4 {
	margin-left: 85px;
}

.pro5 {
	margin-left: 45px;
}

.pro6 {
	margin-left: 40px;
}

.pro7 {
	margin-left: 40px;
}

.pro8 {
	margin-left: 40px;
}

.pro9 {
	margin-left: 45px;
}

.pso1 {
	margin-left: 45px;
}

.pso2 {
	margin-left: 65px;
}

.pso3 {
	margin-left: 130px;
}

.pso4 {
	margin-left: 120px;
}

.pso5 {
	margin-left: 125px;
}

.pso6 {
	margin-left: 35px;
}

.pso7 {
	margin-left: 40px;
}

.ws17_5 {
	width: 9%;
	*width: 17.5%;
}

.ws10 {
	width: 9%;
	*width: 10%;
}

.zt_top15 {
	height: 20px;
	width: 1300px;
	margin-top: 15px;
}

.cx_tj {
	background: #e0e0e0;
	width: 1300px;
}

.cx_tj_inner {
	width: 1200px;
	height: 26px;
	padding-top: 4px;
}
/*overwrite*/
.listIcon {
	margin: 1px 35px;
}

.pstb_del {
	margin-left: 35px;
}

.item {
	height: 25px;
	padding-top: 3px;
}

.iconPut {
	background: #fff;
}

.fl_left {
	margin-right: 3px;
}

.lineToolbar {
	margin-top: 0;
}

.pro_store_tb {
	overflow-x: auto;
}

.pro_ig {
	padding-top: 5px;
	width: 1200px;
	height: 24px;
}

.fixed_div3,.fixed_div2,.fixed_div {
	width: 12.5%;
}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<!--最后一个-->
	<div class="tagsM">门店促销信息</div>
	<div class="tags tags3 tags_right_on"></div>
	<!--add-->
	<div class="tagsM_q  tagsM_on">修改门店促销</div>
	<div class="tags3_close_on">
		<div class="tags_close" onclick="closeUpdateStoreProm('${paramArray}','${pageNoList}','${pageSizeList}')"></div>
		<input type="hidden" name="pageNo" id="pageNo" value="${pageSizeList}"/>
		<input type="hidden" name="pageSize" id="pageSize" value="${pageNoList}"/>
		<input type="hidden" name="paramArray" id="paramArray" value="${paramArray}"/>
	</div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo">
			<div class="w25 fl_left">
				<div class="cinfo_div">店号</div>
				<select disabled="disabled" id="storeNo" name="storeNo"
					class="w60 top3">
					<option value="${promSchedule.storeNo }">${promSchedule.storeNo }-${promSchedule.storeName }</option>
				</select>
			</div>
			<span>${promSchedule.chngBy }</span> <span>修改人</span> <span><fmt:formatDate
					value="${promSchedule.chngDate }" pattern="yyyy-MM-dd" /> </span> <span>修改日期</span>
			<span>${promSchedule.createBy }</span> <span>建档人</span> <span><fmt:formatDate
					value="${promSchedule.createDate }" pattern="yyyy-MM-dd" /></span> <span>创建日期</span>
		</div>
		<div class="CM" style="height: 130px;">
			<div class="inner_half">
				<div class="CM-bar">
					<div>促销期数基本信息</div>
				</div>
				<div class="CM-div">
					<div class="ig_top20">
						<div class="icol_text w14">
							<span>促销期数</span>
						</div>
						<input type="hidden" name="buyBegin" id="buyBegin"
							value="${buyBegin}" /> <input type="hidden" name="sellBegin"
							id="sellBegin" value="${sellBegin}" />
						<input type="text" id="promNo" name="promNo" readonly="readonly"
							value="${promSchedule.promNo}" class="inputText w20 Black" />
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>*主题</span>
						</div>
						<input id="subjName" name="subjName" 	<c:if test="${buyBegin==1 or sellBegin==1}">class="inputText w50 Black" readonly="readonly"</c:if>  onblur="checkSubjName()"
							value="${promSubj.subjName}" type="text" <c:if test="${buyBegin!=1 and sellBegin!=1}"> class="inputText w50"</c:if>
							maxlength="30" />(最多输入15个字) <input id="promSubjId"
							name="promSubjId" value="${promSubj.promSubjId}" type="hidden" />
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>促销期间</span>
						</div>
						<input type="hidden" id="beforePromBeginDate"
							<c:if test="${promSchedule.promBeginDate!=null }">value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promSchedule.promBeginDate}" />" </c:if>
							name="beforePromBeginDate"></input> <input type="text"
							 name="promBeginDate"
							<c:if test="${promSchedule.promBeginDate!=null }">value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promSchedule.promBeginDate}" />" </c:if>
							id="promBeginDate"  readonly="readonly"
							<c:if test="${sellBegin==1 or promSchedule.pricePromType==2}">class="Wdate w20 Black"</c:if>
							<c:if test="${sellBegin==0 and promSchedule.pricePromType!=2}"> class='Wdate w20' ttype="prom" onclick="WdatePicker({ onpicked:getPromoType,isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}',minDate:'${minPromDate}' })"</c:if> />
						&nbsp;-&nbsp; <input type="text" id="promEndDate"
							<c:if test="${promSchedule.promEndDate!=null }">value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promSchedule.promEndDate}" />" </c:if>
							 name="promEndDate" 
							ttype="prom" readonly="readonly"
							<c:if test="${sellEnd==1 or promSchedule.pricePromType==2}">class="Wdate w20 Black"</c:if>
							<c:if test="${sellEnd==0 and promSchedule.pricePromType!=2 and sellBegin!=1}"> class='Wdate w20' onclick="    WdatePicker({ onpicked:getPromoType,isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}',minDate:'#F{$dp.$D(\'promBeginDate\')}' })" </c:if>
							<c:if test="${sellEnd==0 and promSchedule.pricePromType!=2 and sellBegin==1}"> class='Wdate w20' onclick="    WdatePicker({ onpicked:getPromoType,isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}',minDate:'${nowDate}' })" </c:if>
							
							 />
					</div>
				</div>
			</div>
			<div class="inner_half">
				<div class="CM-div">
					<div class="ig_top20">
						<div class="icol_text w14">
							<span>采购期间</span>
						</div>
						<input type="hidden" id="beforeBuyBeginDate"
							name="beforeBuyBeginDate"
							<c:if test="${promSchedule.buyBeginDate!=null }">value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promSchedule.buyBeginDate}" />" </c:if>></input>
						<input type="text" id="buyBeginDate" 
							name="buyBeginDate"
							<c:if test="${promSchedule.buyBeginDate!=null }">value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promSchedule.buyBeginDate}" />" </c:if>
							 readonly="readonly"
							<c:if test="${buyBegin==1 or promSchedule.pricePromType==3}">class="Wdate w20 Black"</c:if>
							<c:if test="${buyBegin==0  and promSchedule.pricePromType!=3}"> class='Wdate w20' ttype="buy"  onclick="WdatePicker({ onpicked:getPromoType,isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}',minDate:'${minBuyDate}' })" </c:if> />
						&nbsp;-&nbsp; 
						<input type="hidden" id="beforeBuyEndDate"
							name="beforeBuyEndDate"
							<c:if test="${promSchedule.buyEndDate!=null }">value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promSchedule.buyEndDate}" />" </c:if>></input>
						<input  type="text"
							id="buyEndDate" name="buyEndDate"
							<c:if test="${promSchedule.buyEndDate!=null }">value="<fmt:formatDate pattern="yyyy-MM-dd" value="${promSchedule.buyEndDate}" />" </c:if>
							 readonly="readonly"
							<c:if test="${buyEnd==1 or promSchedule.pricePromType==3}">class="Wdate w20 Black"</c:if>
							<c:if test="${buyEnd==0 and promSchedule.pricePromType!=3 and buyBegin!=1}"> class='Wdate w20' ttype="buy"  onclick="WdatePicker({ onpicked:getPromoType,isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}',minDate:'#F{$dp.$D(\'buyBeginDate\')}' })" </c:if> 
							<c:if test="${buyEnd==0 and promSchedule.pricePromType!=3 and buyBegin==1}"> class='Wdate w20' onclick="    WdatePicker({ onpicked:getPromoType,isShowClear: false, readOnly: true,dateFormat:'yy-mm-dd',lang:'${calendarL}',minDate:'${nowDate}' })" </c:if>
							
							/>
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>课别</span>
						</div>
						<div class="iconPut w15 fl_left">
							<input type="text" id="catlgId" value="${promSchedule.catlgId }"
								readonly="readonly" name="catlgId" class="w70 Black" />
							<div class="ListWin "></div>
						</div>
						<input type="text" id="catlgName"
							value="${promSchedule.catlgName }" readonly="readonly"
							name="catlgName" class="inputText w23 Black" />
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>促销类型</span>
						</div>
						<input type="hidden" name="pricePromType" id="pricePromType"
							value="${promSchedule.pricePromType }"
							class="inputText w23 Black" readonly="readonly" /> <input
							type="text" name="pricePromTypeName" id="pricePromTypeName"
							value="${promSchedule.pricePromType }-${promSchedule.pricePromTypeName }"
							class="inputText w23 Black" readonly="readonly" />
					</div>
				</div>
			</div>
		</div>
		<div class="CM" style="height: 180px; margin-top: 2px;">
			<div class="CM-bar">
				<div>促销代号信息</div>
			</div>
			<div class="CM-div">
				<div class="pro_store_item">
					<div class="top15">
						<span class="pso1">代号类别</span> <span class="pso2">代号</span> <span
							class="pso3">名称</span>
						<!--  <span class="pso4">促销类型</span> -->
						<span class="pso5">促销进价(元)</span> <span class="pso6">促销售价</span> <span
							class="pso7">促销提示</span>
						<!--  <span class="pso7">组合促销</span> -->
					</div>
					<div id="unitNoList" class="pro_store_tb_edit">

						<c:forEach items="${promUnitByStLs}" var="unit" varStatus="step">
							<%-- <c:if test="${step.index eq 0 }">
								<div class="item item_on" id="addPromCode_div">
							</c:if> 
							<c:if test="${step.index != 0 }">
								<div class="item" id="addPromCode_div">
							</c:if>
							--%>
							<div class="item" id="addPromCode_div">
							<c:if test="${buyBegin==1 or sellBegin==1}">
								<auchan:select disabled="disabled"
									mdgroup="PROM_UNIT_BY_ST_UNIT_TYPE"
									_class="w12_5 first_ztdb fl_left Black" value="${unit.unitType }"
									name="unitType" iscaption="0" />
							</c:if>
							<c:if test="${buyBegin!=1 and sellBegin!=1}">
								<auchan:select mdgroup="PROM_UNIT_BY_ST_UNIT_TYPE"
									_class="w12_5 first_ztdb fl_left" value="${unit.unitType }"
									name="unitType" iscaption="0" onchange="unitTypeChange(this)" />
							</c:if>
							<div class="iconPut w10 fl_left">
								<input id="promUnitNo" maxlength="8"
									<c:if test="${buyBegin==1 or sellBegin==1}"> disabled="disabled" class="w75 Black"</c:if>
									value="${unit.promUnitNo }"
									onkeydown="enterInUnitNo(event,this)" onblur="promUnitNoBlur(this)" name="promUnitNo"
									 <c:if test="${buyBegin!=1 and sellBegin!=1}">  class="w75"</c:if>
									 type=" text"/> <input id="beforePromUnitNo"
									name="beforePromUnitNo" value="${unit.promUnitNo }"
									type="hidden" />
								<c:if test="${buyBegin==1 or sellBegin==1}">
									<div class="ListWin"></div>
								</c:if>
								<c:if test="${buyBegin!=1 and sellBegin!=1}">
									<div class="ListWin showUnitWin" onclick="showUnitWin(this)"></div>
								</c:if>
							</div>
							<input type="text" name="promUnitName" value="${unit.unitName }"
								readonly="readonly" class="inputText w23 fl_left Black" />

							<input type="text"
								<c:if test="${buyBegin!=1 and promSchedule.pricePromType!=3}">class="inputText w10 fl_left promBuyPriceHead"</c:if>
								<c:if test="${buyBegin==1 or promSchedule.pricePromType==3}">disabled="disabled"  class="inputText w10 fl_left Black promBuyPriceHead"</c:if> onkeyup="promPriceKeyUp(this,event)" onblur="promBuyPriceHeadBlur(this)" />
							<input type="text"
								<c:if test="${sellBegin!=1 and promSchedule.pricePromType!=2}"> class="inputText w10 fl_left promSellPriceHead"</c:if>
								<c:if test="${sellBegin==1 or promSchedule.pricePromType==2}">disabled="disabled" class="inputText w10 fl_left Black promSellPriceHead"</c:if> onkeyup="promPriceKeyUp(this,event)" onblur="promSalePriceHeadBlur(this)"/>
							<select name="promActvy" onchange="promActvyChange(this)" class="inputText w10 fl_left">
								<c:forEach items="${actvyList }" var="actvy">
									<option title="${actvy.codeName }"
										<c:if test="${actvy.metaCode==unit.promActvy}" >selected</c:if>
										value="${actvy.metaCode }">${actvy.codeName }</option>
								</c:forEach>
								<input type="text" name="promGiftHint" onchange="promGiftHintChange(this)"
								value="${unit.promGiftHint }" class="inputText w10 fl_left" />
							</select>
							<div class="pstb_del" onclick="delUnitClick(this,event)"></div>
					</div>
					</c:forEach>
				</div>
				<div class="ig_top10">
					<div class="first_ztdb createNewBar" onclick="addUnitItem()"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="CM" style="height: 220px; margin-top: 2px;">
		<div class="CM-bar">
			<div>促销商品门店信息</div>
		</div>
		<div class="CM-div">
			<div class="pro_store_item">

				<div class="zt_tit" style="overflow: hidden; width: 100%;">
					<div class="zt_top15">

						<span class="pro1">货号</span> <span class="pro2">商品名称</span> <span
							class="pro3">公司名称</span> <span class="pro4">正常进价(元)</span> <span
							class="pro5">促销进价(元)</span> <span class="pro6">正常售价(元)</span> <span
							class="pro7">促销售价(元)</span> <span class="pro8">降价幅度(%)</span> <span
							class="pro9">净毛利(%)</span>

					</div>
					<div class="cx_tj">
						<div class="cx_tj_inner">
							<input type="text"
								<c:if test="${buyBegin!=1 and promSchedule.pricePromType!=3}"> class="inputText ws17_5 promBuyPriceBody"</c:if>
								<c:if test="${buyBegin==1 or promSchedule.pricePromType==3}">disabled="disabled" class="inputText ws17_5 Black promBuyPriceBody"</c:if>
								style="margin-left: 576px; *margin-left: 575px;" onkeyup="promPriceKeyUp(this,event)"  onblur="promBuyPriceBodyBlur(this)"/> <input
								type="text"
								<c:if test="${sellBegin!=1 and promSchedule.pricePromType!=2}"> class="inputText ws10  promSellPriceBody"</c:if>
								<c:if test="${sellBegin==1 or promSchedule.pricePromType==2}">disabled="disabled" class="inputText ws10 Black promSellPriceBody"</c:if>
								style="margin-left: 111px;" onkeyup="promPriceKeyUp(this,event)"  onblur="promSalePriceBodyBlur(this)"/>
						</div>
					</div>
				</div>
				<div class="pro_store_tb" style="height: 56%; width: 100%;">
				</div>
				<div class="top5">
					<input class="fl_left top3" onclick="checkAll(this)"
						name="checkStoreItemAll" type="checkbox" />
					<div class="deleteBar fl_left" onclick="removeProstore()"></div>
					<div class="lineToolbar fl_left"></div>
					<div class="createNewBar fl_left" onclick="showDelItemDialog()" id="showDeleteItems"></div>
				</div>
				<!--</div>-->
			</div>
		</div>
	</div>

</div>
</div>

<div style="display: none" class="cloneDiv">

	<div class="item" id="addPromCode_div">
		<auchan:select mdgroup="PROM_UNIT_BY_ST_UNIT_TYPE"
			_class="w12_5 first_ztdb fl_left" name="unitType" onchange="unitTypeChange(this)" value="0"
			iscaption="0" />
		<div class="iconPut w10 fl_left">
			<input id="promUnitNo" name="promUnitNo" maxlength="8"
				onkeydown="enterInUnitNo(event,this)" onblur="promUnitNoBlur(this)" class="w75" type="text" /> <input
				id="beforePromUnitNo" name="beforePromUnitNo" type="hidden" />
			<div class="ListWin showUnitWin" onclick="showUnitWin(this)"></div>
		</div>
		<input type="text" name="promUnitName" readonly="readonly"
			class="inputText w23 fl_left Black" /> <input type="text"
			<c:if test='${promSchedule.pricePromType!=3}'>class="inputText w10 fl_left promBuyPriceHead"</c:if>
			<c:if test='${promSchedule.pricePromType==3}'>disabled='disabled' class="inputText w10 fl_left Black promBuyPriceHead"</c:if> onkeyup="promPriceKeyUp(this,event)" onblur="promBuyPriceHeadBlur(this)"/>
		<input type="text"
			<c:if test='${promSchedule.pricePromType!=2}'> class="inputText w10 fl_left promSellPriceHead"</c:if>
			<c:if test='${promSchedule.pricePromType==2}'>disabled='disabled' class="inputText w10 fl_left Black promSellPriceHead"</c:if> onkeyup="promPriceKeyUp(this,event)" onblur="promSalePriceHeadBlur(this)"/>
		<select name="promActvy" onchange="promActvyChange(this)" class="inputText w10 fl_left">
			<c:forEach items="${actvyList }" var="actvy">
				<option value="${actvy.metaCode }" title="${actvy.codeName }">${actvy.codeName }</option>
			</c:forEach>
			<input type="text" onchange="promGiftHintChange(this)" name="promGiftHint" class="inputText w10 fl_left" />
		</select>

		<div class="pstb_del" onclick="delUnitClick(this,event)"></div>

	</div>
</div>
<script type="text/javascript">
 unit=JSON.parse('${unitArr}');
 var firstDiv=$("#unitNoList").find(".item:first");
 if(firstDiv){
	 firstDiv.click();
 }
</script>