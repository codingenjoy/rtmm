<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="Panel">
	<div class="Panel_top">
		<span>DM促销活动详情</span>
		<div class="PanelClose" onclick="closePopupWinDetail()"></div>
	</div>
	<div class="Table_Panel">
		<div class="ig_top10">
			<div class="icol_text w30">
				<span>RP DM编号</span>
			</div>
			<input type="text" name="rdmNoCreate" value="${rpDmVO.rdmNo}" class="inputText w20 Black" readonly="readonly"  />
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>主题</span>
			</div>
			<input type="text" name="rdmTopicCreate" value="${rpDmVO.rdmTopic}" class="inputText w40"  readonly="readonly" />
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>活动开始日</span>
			</div>
			<input id="rdmBeginDateCreate" name="rdmBeginDateCreate" value="<c:if test="${rpDmVO.rdmBeginDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVO.rdmBeginDate}" /></c:if>"  class="Wdate w20" type="text" readonly="readonly" />

		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>活动结束日</span>
			</div>
			<input name="rdmEndDateCreate" value="<c:if test="${rpDmVO.rdmEndDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVO.rdmEndDate}" /></c:if>"  class="Wdate w20" type="text" readonly="readonly"  />

		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>门店最少确认天数</span>
			</div>
			<input type="text" name="stCnfrmDaysCreate" value="${rpDmVO.stCnfrmDays}" class="inputText w20 align_right"  readonly="readonly" />&nbsp;天
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>SCM备货天数</span>
			</div>
			<input type="text" name="scmPrepDaysCreate" value="${rpDmVO.scmPrepDays}" class="inputText w20 align_right" value="" onfocus="removeError(this)" onblur="checkScmPrepDays(this)" readonly="readonly" />&nbsp;天
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>门店补货提前天数</span>
			</div>
			<input type="text" name="stDlvryBefDaysCreate" value="${rpDmVO.stDlvryBefDays}" class="inputText w20 align_right" value="" onfocus="removeError(this)" onblur="checkStDlvryBefDays(this)"  readonly="readonly"/>&nbsp;天
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>创建日期</span>
			</div>
			<input value="<c:if test="${rpDmVO.creatDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVO.creatDate}" /></c:if>" type="text" class="inputText w20 Black" readonly="readonly"/>
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>创建人</span>
			</div>
			<input value="<auchan:getStuffName value="${rpDmVO.creatBy}"></auchan:getStuffName>" type="text" class="inputText w20 Black" readonly="readonly" />
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>修改日期</span>
			</div>
			<input value="<c:if test="${rpDmVO.chngDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVO.chngDate}" /></c:if>" type="text" class="inputText w20 Black" readonly="readonly"/>
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>修改人</span>
			</div>
			<input value="<auchan:getStuffName value="${rpDmVO.chngBy}"></auchan:getStuffName>" type="text" class="inputText w20 Black" readonly="readonly"/>
		</div>
		<div class="clearBoth"></div>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn" style="width: 87px">
			<div class="PanelBtn1"  onclick="closePopupWinDetail()">关闭</div>
		</div>
	</div>
	<div class="clearBoth"></div>
</div>

	
