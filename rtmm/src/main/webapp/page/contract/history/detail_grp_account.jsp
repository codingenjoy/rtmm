<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="contract jbtk">
	<div class="CM" style="height: 100%">
		<div class="CM-bar"></div>
		<div class="CM-div">
			<table class="tkhead">
				<tbody>
					<tr>
						<td style="width: 55px;">编号</td>
						<td style="width: 155px;">科目名称</td>
						<td style="width: 105px;">英文名称</td>
						<td style="width: 105px;">支付方式</td>
						<c:choose>
							<c:when test="${tabType=='1'}">
								<td style="width: 105px;">扣款(元/%)</td>
								<td style="width: 33px;"></td>
								<td style="width: 105px;">扣款频率</td>
							</c:when>
							<c:when test="${tabType=='2'}">
								<td style="width: 55px;">关联厂商</td>
								<td style="width: 205px;">厂商名称</td>
								<td style="width: 105px;">达到(元/%)</td>
								<td style="width: 105px;">扣款(元/%)</td>
							</c:when>
							<c:when test="${tabType=='3'}">
								<td style="width: 105px;">期间始</td>
								<td style="width: 105px;">期间末</td>
								<td style="width: 105px;">扣款(元/%)</td>
								<td style="width: 105px;">扣款状态</td>
							</c:when>
						</c:choose>

					</tr>
				</tbody>
			</table>
			<div class="tkbody">
				<c:forEach items="${listGrpAccount}" var="grpAccount">
					<div class="ig">
						<input type="text" class="inputText fl_left align_right" style="width: 50px;" readonly="readonly" value="${grpAccount.grpAcctId}">
						<input type="text" class="inputText fl_left" style="width: 150px;" readonly="readonly" value="${grpAccount.grpAcctName}">
						<input type="text" class="inputText fl_left" style="width: 100px;" readonly="readonly" value="${grpAccount.grpAcctAbbr}">
						<input type="text" class="inputText fl_left" style="width: 100px;" readonly="readonly"
							value="<auchan:getDictValue code='${grpAccount.payMethd}' mdgroup='CONTRACT_DETL_PAY_METHD' />">
						<c:choose>
							<c:when test="${tabType=='1'}">
								<input type="text" class="inputText fl_left align_right" style="width: 100px;" readonly="readonly" value="${grpAccount.dedctVal}">
								<c:choose>
									<c:when test="${grpAccount.dedctValType=='A'}">
										<input type="text" class="inputText fl_left" style="width: 30px;" readonly="readonly" value="元">
									</c:when>
									<c:when test="${grpAccount.dedctValType=='P'}">
										<input type="text" class="inputText fl_left" style="width: 30px;" readonly="readonly" value="%">
									</c:when>
									<c:otherwise>
										<input type="text" class="inputText fl_left" style="width: 30px;" readonly="readonly" value="">
									</c:otherwise>
								</c:choose>
								<input type="text" class="inputText fl_left" style="width: 100px;" readonly="readonly"
									value="<auchan:getDictValue code='${grpAccount.dedctFreq}' mdgroup='CONTRIBUTION_GRP_ACCOUNT_DEDCT_FREQ' />">
							</c:when>
							<c:when test="${tabType=='2'}">
								<input type="text" class="inputText fl_left align_right" style="width: 50px;" readonly="readonly" value="${grpAccount.linkMainSupNo}">
								<input type="text" class="inputText fl_left" style="width: 200px;" readonly="readonly" title="${grpAccount.supName}" value="${grpAccount.supName}">
								<input type="text" class="inputText fl_left align_right" style="width: 75px;" readonly="readonly" value="<fmt:formatNumber value='${grpAccount.condVal}' type='number' pattern='##########'/>">
								<c:choose>
									<c:when test="${grpAccount.condValType=='A'}">
										<input type="text" class="inputText fl_left" style="width: 30px;" readonly="readonly" value="元">
									</c:when>
									<c:when test="${grpAccount.condValType=='P'}">
										<input type="text" class="inputText fl_left" style="width: 30px;" readonly="readonly" value="%">
									</c:when>
									<c:otherwise>
										<input type="text" class="inputText fl_left" style="width: 30px;" readonly="readonly" value="">
									</c:otherwise>
								</c:choose>
								<input type="text" class="inputText fl_left align_right" style="width: 75px;" readonly="readonly" value="<fmt:formatNumber value='${grpAccount.dedctVal}' type='number' pattern='##########'/>">
								<c:choose>
									<c:when test="${grpAccount.dedctValType=='A'}">
										<input type="text" class="inputText fl_left" style="width: 30px;" readonly="readonly" value="元">
									</c:when>
									<c:when test="${grpAccount.dedctValType=='P'}">
										<input type="text" class="inputText fl_left" style="width: 30px;" readonly="readonly" value="%">
									</c:when>
								</c:choose>
							</c:when>
							<c:when test="${tabType=='3'}">
								<input type="text" class="inputText fl_left" style="width: 100px;" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${grpAccount.beginDate}"/>'>
								<input type="text" class="inputText fl_left" style="width: 100px;" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${grpAccount.endDate}"/>'>
								<input type="text" class="inputText fl_left align_right" style="width: 75px;" readonly="readonly" value="<fmt:formatNumber value='${grpAccount.dedctVal}' type='number' pattern='##########'/>">
								<c:choose>
									<c:when test="${grpAccount.dedctValType=='A'}">
										<input type="text" class="inputText fl_left" style="width: 30px;" readonly="readonly" value="元">
									</c:when>
									<c:when test="${grpAccount.dedctValType=='P'}">
										<input type="text" class="inputText fl_left" style="width: 30px;" readonly="readonly" value="%">
									</c:when>
								</c:choose>
								<input type="text" class="inputText fl_left" style="width: 100px;" readonly="readonly" value="<auchan:getDictValue code='${grpAccount.dedctSttus}' mdgroup='CONTRACT_DETL_DEDCT_STTUS' />" >
							</c:when>
						</c:choose>
					</div>
				</c:forEach>
			</div>

		</div>
	</div>

</div>