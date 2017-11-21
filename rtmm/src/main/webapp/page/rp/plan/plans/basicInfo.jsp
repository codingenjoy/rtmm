<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div style="height: 150px;" class="CM">
	<div class="inner_half">
		<div class="CM-bar">
			<div>保留计划基本信息</div>
		</div>
		<div class="CM-div">
			<div class="ig_top20">
				<div class="icol_text w20">
					<span>计划号</span>
				</div>
				<input id="crRpNo" type="text" class="inputText w20  fl_left Black" readonly="readonly" ></input>
				<div class="icol_text">
					<span>&nbsp;&nbsp;&nbsp;状态</span>
				</div>
				<input id="crStatusStr" type="text" class="inputText w30 fl_left" value="<auchan:getDictValue mdgroup="RP_STATUS" code="${status }"></auchan:getDictValue>" readonly="readonly"></input>
				<input id="crStatus" type="hidden" value="${status }" ></input>
			</div>
			<div class="ig">
				<div class="icol_text w20">
					<span>RP DM</span>
				</div>
				<select id="crRdmNo" class="w30 fl_left" onchange="setThemeName(this);">
					<c:forEach items="${rpDMList }" var="rpDMVO">
						<option value="${rpDMVO.rdmTopic }" dmBeginDate='<fmt:formatDate pattern="yyyy-MM-dd" value="${rpDMVO.rdmBeginDate }"/>' dmEndDate='<fmt:formatDate pattern="yyyy-MM-dd" value="${rpDMVO.rdmEndDate }"/>' stCnfrmDays="${rpDMVO.stCnfrmDays }" scmPrepDays="${rpDMVO.scmPrepDays }">${rpDMVO.rdmNo }</option>
					</c:forEach>
				</select>
				<div class="icol_text">
					<span>&nbsp;&nbsp;&nbsp;主题</span>
				</div>
				<input id="crRdmTopic" type="text" class="inputText w30 fl_left Black" readonly="readonly" ></input>
			</div>
			<div class="ig">
				<div class="icol_text w20">
					<span>开始日期</span>
				</div>
				<input id="crRdmBeginDate" class="w20 fl_left inputText Black" type="text" readonly="readonly" name="dmBeginDate" ></input>
				<div class="icol_text">
					<span>&nbsp;&nbsp;&nbsp;结束日期</span>
				</div>
				<input id="crRdmEndDate" class="w20 fl_left inputText Black" type="text" readonly="readonly" ></input>
			</div>
			<div class="ig">
				<div class="icol_text w20">
					<span>物流中心</span>
				</div>
				<select id="crDcStoreNo" class="w20" onchange="$(this).removeClass('errorInput');$(this).attr('title','');changeCrDcStoreNo(this);">
					<option value="">请选择</option>
                 	<c:forEach items="${dcStoreList}" var="dcStore">
                 		<option value="${dcStore.storeNo }">${dcStore.storeNo }-${dcStore.storeName }</option>
                 	</c:forEach>
				</select>
			</div>
		</div>
	</div>
	<div class="inner_half">
		<div class="ig_top20">
			<span class="icol_text">课别&nbsp;</span>
			<div class="iconPut fl_left" style="width: 100px;">
				<input style="width: 80%" type="text" id="crCatlgId" onfocus="$(this).removeClass('errorInput');$(this).attr('title','');" name='catlgId' onafterpaste="this.value=this.value.replace(/\D/g,'')" onchange="changeCatlg(this)" ></input>
				<div class="ListWin" onclick="selectCatlg()"></div>
			</div>
			<div class="fl_left">&nbsp;</div>
			<input type="text" class="inputText w30 fl_left Black" id="crCatlgName" name="catlgName" readonly="readonly" ></input>
		</div>
		<div class="ig">
			<div class="icol_text">
				<span>需要门店确认</span>
			</div>
			<input type="checkbox" class="cks" checked="checked" onclick="storeConfirm(this);" ></input>
			<div class="icol_text">
				<span>&nbsp;&nbsp;&nbsp;门店确认期间</span>
			</div>
			<input id="crStCnfrmBeginDate" class="Wdate w20 fl_left" name="stBeginDate" type="text" onclick="WdatePicker({minDate:'${nowDate}',onpicking:function(dp){stBeginDateQuery(dp);}})" ></input>
			<div class="icol_text">
				<span>&nbsp;-</span>
			</div>
			<input id="crStCnfrmEndDate" class="Wdate w20 fl_left" name="stEndDate" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true,lang:'${calendarL}',minDate:'#F{$dp.$D(\'crStCnfrmBeginDate\')}',onpicking:function(dp){stEndDateQuery(dp);}})" ></input>
		</div>
		<div class="ig">
			<div class="icol_text w2x">
				<span>门店补货期间</span>
			</div>
			<input id="crStRepBeginDate" class="Wdate w20 fl_left " type="text"  name="repBeginDate" onclick="WdatePicker({ isShowClear: false, readOnly: true,onpicking:function(dp){repBeginDateQuery(dp);}})" ></input>
			<div class="icol_text">
				<span>&nbsp;-</span>
			</div>
			<input id="crStRepEndDate" class="Wdate w20 fl_left" type="text" name="repEndDate" onclick="WdatePicker({ isShowClear: false, readOnly: true,onpicking:function(dp){repEndDateQuery(dp);}})" ></input>
		</div>
		<div class="ig">
			<span class="icol_text">总金额&nbsp;</span> <input id="finalAmnt" type="text" readonly="readonly" class="inputText w30 Black" >&nbsp;元
		</div>
	</div>
</div>