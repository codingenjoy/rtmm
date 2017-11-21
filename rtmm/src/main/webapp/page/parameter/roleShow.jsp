<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/page/role_Param11.css" rel="Stylesheet" />
<table class="w100">
	<tbody>
		<c:forEach items="${roleList }" var="vo">
			<tr>
				<td class="w10 align_center">
					&nbsp;
					<input type="hidden" value="${vo.id}" />
				</td>
				<td class="w45">${vo.name }</td>
				<td class="w45"><div class="longText" title="${vo.desc_local }">${vo.desc_local }</div></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
