<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<div class="htable_div top3">
		<table>
			<thead>
				<tr>
					<c:if test="${unitType==0 }">
					<td class="w30">
						<div class="t_cols" style="width: 110px;">商品编号</div>
					</td>
					<td>
						<div class="t_cols" style="width: 350px;">商品名称</div>
					</td>
				
					<td>
						<div class="t_cols" style="width: 150px;">商品状态</div>
					</td>
					</c:if>
					<c:if test="${unitType!=0 }">
					<td class="w30">
						<div class="t_cols"  style="width: 150px;">系列号</div>
					</td>
					<td>
						<div class="t_cols" style="width:500px;">系列名称</div>
					</td>
					</c:if>
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
					<tr ondblclick="onDblClickRow('1','1');" onclick="onClickRow(this)">
					   <c:if test="${unitType==0 }">
						<td style="width: 101px;" align="right">${unitVO.clstrId }&nbsp;&nbsp;</td>
						<input name="promNo" type="hidden" value="${unitVO.clstrId }" />
						<td style="width: 411px;">${unitVO.clstrName }</td>
						<input name="promName" type="hidden" value="<c:out value='${unitVO.clstrName }'/>" />
						<td style="width: 151px;">${unitVO.status }-${unitVO.statusName }</td>
						<input name="statusName" type="hidden" value="${unitVO.statusName }" />
						</c:if>
						
						 <c:if test="${unitType!=0 }">
						<td style="width: 101px;" align="right">${unitVO.clstrId }&nbsp;&nbsp;</td>
						<input name="promNo" type="hidden" value="${unitVO.clstrId }" />
						<td style="width: 401px;">${unitVO.clstrName }</td>
						<input name="promName" type="hidden" value="${unitVO.clstrName }" />
						</c:if>
						
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty page.result }">
			<tr align="center">
			 <td>没有找到对应数据</td>
			</tr>
			</c:if>
		</table>
	</div>
	<jsp:include page="/page/commons/pageSet2.jsp"></jsp:include>


