<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(function(){
	$(".btable_div").scroll(function () {
	    var left = $(this).scrollLeft();
	    //alert(left);
	    $(".htable_div").scrollLeft(left);
	});
	
})
</script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td>
					<div class="t_cols align_center" style="width: 5px;">&nbsp;</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">序号</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">科目组编号</div>
				</td>
				<td>
					<div class="t_cols" style="width: 100px;">中文名称</div>
				</td>
				<td>
					<div class="t_cols" style="width: 100px;">英文名称</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">缩写</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">状态</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">扣款单位</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">扣款周期</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">目标单位</div>
				</td>
				<td>
					<div class="t_cols" style="width: 90px;">是否关联主厂商</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">递增条件</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">使用范围</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">组别</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">扣款计算方式</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">费用类型</div>
				</td>
				<td>
					<div style="width: 16px;">&nbsp;</div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 380px;">
	<table class="single_tb w100">
		<c:forEach items="${page.result}" var="grpAccount">
			<!--multi_tb为多选 width:1001px;-->
			<tr onclick="onclickRow('${grpAccount.grpAcctId}')">
				<td class="align_center" style="width: 5px;"></td>
				<td style="width: 81px;" align="right" title="">${grpAccount.grpAcctSeqNo}&nbsp;</td>
				<td style="width: 81px;" align="right">${grpAccount.grpAcctId}&nbsp;</td>
				<td style="width: 101px;" title="${grpAccount.grpAcctName}">${grpAccount.grpAcctName}</td>
				<td style="width: 101px;" title="${grpAccount.grpAcctEnName}">${grpAccount.grpAcctEnName}</td>
				<td style="width: 81px;">${grpAccount.grpAcctAbbr}</td>
				<td style="width: 81px;"><auchan:getDictValue code='${grpAccount.status}' mdgroup='CONTRIBUTION_GRP_ACCOUNT_STATUS' /></td>
				    <c:choose>
						<c:when test="${grpAccount.dedctValType=='A'}">
							<td style="width: 81px;">A-金额&nbsp;</td>
						</c:when>
						<c:when test="${grpAccount.dedctValType=='P'}">
							<td style="width: 81px;">P-百分比&nbsp;</td>
						</c:when>
						<c:otherwise>
						<td style="width: 81px;" title="A,P-金额和百分比">A,P-金额和百分比&nbsp;</td>
						</c:otherwise>
					</c:choose>
				<td style="width: 81px;"><auchan:getDictValue code='${grpAccount.dedctFreq}' mdgroup='CONTRIBUTION_GRP_ACCOUNT_DEDCT_FREQ' /></td>
				     <c:choose>
						<c:when test="${grpAccount.condValType=='A'}">
							<td style="width: 81px;">A-金额&nbsp;</td>
						</c:when>
						<c:when test="${grpAccount.condValType=='P'}">
							<td style="width: 81px;">P-百分比&nbsp;</td>
						</c:when>
						<c:when test="${grpAccount.condValType=='A,P'}">
							<td style="width: 81px;" title="A,P-金额和百分比">A,P-金额和百分比&nbsp;</td>
						</c:when>
						<c:otherwise>
						   <td style="width: 81px;" align="right"></td>
						</c:otherwise>
					</c:choose> 
				<td style="width: 91px;"><c:choose>
						<c:when test="${grpAccount.linkMainSupInd=='1'}">
							1-是
						</c:when>
						<c:when test="${grpAccount.linkMainSupInd=='0'}">
							0-否
						</c:when>
					</c:choose></td>
				<td style="width: 81px;"><c:choose>
						<c:when test="${grpAccount.degeeCondInd=='1'}">
							1-是
						</c:when>
						<c:when test="${grpAccount.degeeCondInd=='0'}">
							0-否
						</c:when>
					</c:choose></td>
				<td style="width: 81px;"><auchan:getDictValue code='${grpAccount.usedForType}' mdgroup='CONTRIBUTION_GRP_ACCOUNT_USED_FOR_TYPE' /></td>
				<td style="width: 81px;">${grpAccount.grpGrpAbbr}&nbsp;</td>
				<td style="width: 81px;"><auchan:getDictValue code='${grpAccount.calcBy}' mdgroup='CONTRIBUTION_GRP_ACCOUNT_CALC_BY' /></td>
				<td style="width: 81px;"><auchan:getDictValue code='${grpAccount.feeType}' mdgroup='CONTRIBUTION_GRP_ACCOUNT_FEE_TYPE' /></td>
				<%-- <td style="width: 81px;"><auchan:getDictValue code='${grpAccount.invTitle}' mdgroup='CONTRACT_TMPL_INV_TITLE' /></td> --%>
				<td style="width: auto">&nbsp;</td>
			</tr>
		</c:forEach>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>

