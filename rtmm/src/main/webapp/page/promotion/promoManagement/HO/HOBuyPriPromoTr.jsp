<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/tld/auchan" prefix="auchan"%>
<tr class="trSpecial" style="height: auto;">
	<!-- Bar_off -->
	<td class="align_center" style="width: 30px;"></td>
	<td colspan="6" class="Black" style="white-space: normal;">
           <div class="innerTb">
	           <c:if test="${not empty List }">
	           		<c:forEach items="${List }" var="HOPricVO" varStatus="num">
	                  <div class="w30 innerTb_data ${HOPricVO.promUnitNo }" title="${HOPricVO.promUnitNo }-${HOPricVO.unitName }" >${HOPricVO.promUnitNo }-${HOPricVO.unitName }<c:if test="${HOPricVO.unitType != 0 }"><div class="Icon-size1"></div></c:if></div>
					</c:forEach>
	           </c:if>
           </div>
	</td>
	<td class="temp">&nbsp;</td>
</tr>

