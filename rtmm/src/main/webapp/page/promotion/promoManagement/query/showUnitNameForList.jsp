<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
                                  
<div class="innerTb">
		<c:if test="${not empty List}">
				<c:forEach items="${List}" var="unit" varStatus="unitNum">
					<c:choose>
						<c:when test="${unit.promUnitNo ==unitNo}">
							<div class="w30 innerTb_data" title="${unit.promUnitNo }-${unit.unitName}"><c:if test="${unit.unitType != 0 }"><div class="Icon-size1"></div></c:if><font color='red'>${unit.promUnitNo }-${unit.unitName}</font></div>
						</c:when>
						<c:otherwise>
							<div class="w30 innerTb_data" title="${unit.promUnitNo }-${unit.unitName}"><c:if test="${unit.unitType != 0 }"><div class="Icon-size1"></div></c:if>${unit.promUnitNo }-${unit.unitName}</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
		</c:if>
  </div>

