<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.Panel {
	width: 400px;
}

.Table_Panel {
	height: auto;
	overflow: hidden;
	padding: 15px 20px;
}

.igs {
	line-height: 25px;
}
</style>
	<div class="Panel_top">
		<span>选择支付方式</span>
		<div class="PanelClose" onclick="closePopupWin()" ></div>
	</div>
	<div id="payMethOptnsDiv" class="Table_Panel">
		<c:forEach items="${metadata }" var="metadataVO">
			<div class="igs">
				<c:choose>
					<c:when test="${fn:contains(payMethdOptnsStr,metadataVO.code) }">
						<input type="checkbox" checked="checked" />
					</c:when>
					<c:otherwise>
						<input type="checkbox" />
					</c:otherwise>
				</c:choose>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<span payMethd="${metadataVO.code }" >${metadataVO.code }-${metadataVO.title }</span>
			</div>
		</c:forEach>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="writePayMethdOptns();" >确定</div>
			<div class="PanelBtn2" onclick="closePopupWin()" >取消</div>
		</div>
	</div>
