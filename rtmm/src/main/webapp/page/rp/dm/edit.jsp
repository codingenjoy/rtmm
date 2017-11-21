<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="Panel">
	<div class="Panel_top">
		<span>修改DM促销活动</span>
		<div class="PanelClose" onclick="closePopupWin()"></div>
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
			<input type="text" name="rdmTopicCreate" value="${rpDmVO.rdmTopic}" class="inputText w40" onfocus="removeError(this)" onblur="checkRdmTopic(this)" />
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>活动开始日</span>
			</div>
			<input id="rdmBeginDateCreate" name="rdmBeginDateCreate" value="<c:if test="${rpDmVO.rdmBeginDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVO.rdmBeginDate}" /></c:if>"   type="text" 
				 onfocus="removeError(this)" onblur="checkRdmBeginDate(this)" 
				<c:if test="${isUse eq 0}">onclick="WdatePicker({onpicked:function(){if(this.value>$dp.$('rdmEndDateCreate').value){$dp.$('rdmEndDateCreate').value='';$dp.$('rdmEndDateCreate').focus();}},isShowClear: false, readOnly: true })" class="Wdate w20"</c:if>
				<c:if test="${isUse eq 1}">class="Wdate w20 Black" readonly="readonly"</c:if>
				/>

		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>活动结束日</span>
			</div>
			<input name="rdmEndDateCreate" id="rdmEndDateCreate" value="<c:if test="${rpDmVO.rdmEndDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVO.rdmEndDate}" /></c:if>"  type="text"
					onfocus="removeError(this)" onblur="checkRdmEndDate(this)"  
					<c:if test="${isUse eq 0}">onclick="WdatePicker({onpicked:function(){if(this.value>$dp.$('rdmEndDateCreate').value){$dp.$('rdmEndDateCreate').value='';$dp.$('rdmEndDateCreate').focus();}},isShowClear: false, readOnly: true,minDate:'#F{$dp.$D(\'rdmBeginDateCreate\')}' })" class="Wdate w20"</c:if>
					<c:if test="${isUse eq 1}">class="Wdate w20 Black"  readonly="readonly"</c:if>
				/>
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>门店最少确认天数</span>
			</div>
			<input type="text"  name="stCnfrmDaysCreate" value="${rpDmVO.stCnfrmDays}" 
			<c:if test="${isUse eq 0}"> class="inputText w20 align_right" </c:if> 
			<c:if test="${isUse eq 1}"> class="inputText w20 align_right Black" readonly="readonly"</c:if>
			  onfocus="removeError(this)" onblur="checkStCnfrmDays(this)" maxlength="2" />&nbsp;天
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>SCM备货天数</span>
			</div>
			<input type="text" name="scmPrepDaysCreate" value="${rpDmVO.scmPrepDays}"
			 <c:if test="${isUse eq 0}"> class="inputText w20 align_right" </c:if> 
			<c:if test="${isUse eq 1}"> class="inputText w20 align_right Black" readonly="readonly"</c:if>
			  onfocus="removeError(this)" onblur="checkScmPrepDays(this)" maxlength="2" />&nbsp;天
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>门店补货提前天数</span>
			</div>
			<input type="text" name="stDlvryBefDaysCreate" value="${rpDmVO.stDlvryBefDays}"
			 <c:if test="${isUse eq 0}"> class="inputText w20 align_right" </c:if> 
			<c:if test="${isUse eq 1}"> class="inputText w20 align_right Black" readonly="readonly"</c:if>
			   onfocus="removeError(this)" onblur="checkStDlvryBefDays(this)" maxlength="2"/>&nbsp;天
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>创建日期</span>
			</div>
			<input name="creatDateCreate" value="<c:if test="${rpDmVO.creatDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVO.creatDate}" /></c:if>" type="text" class="inputText w20 Black" readonly="readonly"/>
		</div>
		<div class="ig">
			<div class="icol_text w30">
				<span>创建人</span>
			</div>
			<input name="creatByCreate" value="${rpDmVO.creatBy}" type="hidden" class="inputText w20 Black" readonly="readonly" />
			<input name="creatByName" value="<auchan:getStuffName value="${rpDmVO.creatBy}"></auchan:getStuffName>" type="text" class="inputText w20 Black" readonly="readonly" />
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
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="save('edit')">确定</div>
			<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
		</div>
	</div>
	<div class="clearBoth"></div>
</div>
