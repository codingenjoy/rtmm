<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<div class="htable_div top3">
		<table>
			<thead>
				<tr>
					
					<td class="w30">
						<div class="t_cols" style="width: 100px;">货号</div>
					</td>
					<td>
						<div class="t_cols" style="width: 290px;">商品名称</div>
					</td>
				
					<td>
						<div class="t_cols" style="width: 150px;">商品状态</div>
					</td>
					
				
					<td>
						<div style="width: 16px;">&nbsp;</div>
					</td>
				</tr>
			</thead>
		</table>
	</div>
	<div class="btable_div" style="height: 240px;">
		<table class="single_tb w100 table_data">
		<c:if test="${not empty page.result }">
				<c:forEach items="${page.result}" var="unitVO">
					<tr ondblclick="onDblClickRow(this);"  onclick="onClickRow(this)"  >
						<td style="width: 100px;">${unitVO.clstrId }</td>
						<input name="promNo" type="hidden" value="${unitVO.clstrId }" />
						<td style="width: 290px;">${unitVO.clstrName }</td>
						<input name="promName" type="hidden" value="${unitVO.clstrName }" />
						<td style="width: 150px;">${unitVO.statusName }</td>
						<input name="statusName" type="hidden" value="${unitVO.statusName }" />
					</tr>
				</c:forEach>
			</c:if> 
		</table>
	</div>
	<jsp:include page="/page/commons/pageSet2.jsp"></jsp:include>

