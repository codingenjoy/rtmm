<!-- DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<div class="frozen_div">
		<div class="frozen_cols">
			<div class="f_cols_head">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td><div style="width: 30px;">&nbsp;</div></td>
						<td><div style="width:128px;"><auchan:i18n id="106001026"></auchan:i18n></div></td>
					</tr>
					<tr style="border-top: 1px solid #ccc;" class="bk2">
						<td><div style="width: 30px;">&nbsp;</div></td>
						<td><div style="width: 128px;">&nbsp;</div></td>
					</tr>
				</table>
			</div>
			<div class="f_cols_body">
				<c:if test="${ not empty page.result}">
					<table cellpadding="0" cellspacing="0">
						<c:forEach items="${page.result}" var="analysis" varStatus="num">
							<tr class="tr${num.index}" _index="${ num.index}" >
								<td style="width: 32px;">
								<c:choose>
									<c:when test="${ not empty analysis.weatherCode}" >
										<div class="weather${analysis.weatherCode }" title="<auchan:getDictValue mdgroup='day_Wther_Code' code='${analysis.weatherCode}' showType="2"></auchan:getDictValue>" ></div>
									</c:when>	
								</c:choose>
								<!-- <div class="antd_icon"></div> -->
								</td>
								<td><div style="width: 128px;">${ analysis.storeName}</div></td>
							</tr>
						</c:forEach>
						<tr style="background: none;">
							<td><div>&nbsp;</div></td>
							<td><div>&nbsp;</div></td>
						</tr>
					</table>
				</c:if>
			</div>
		</div>
		<div class="move_cols">
			<div class="m_cols_head">
				<table cellpadding="0" cellspacing="0">
					<tr>
                        <td colspan="4"><div><auchan:i18n id="106001017"></auchan:i18n></div></td>
                        <td colspan="3"><div><auchan:i18n id="106001018"></auchan:i18n></div></td>
                        <td colspan="3"><div><auchan:i18n id="106001019"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001024"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001013"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001015"></auchan:i18n></div></td>
                        <td><div style="width:90px;">&nbsp;</div></td>
                    </tr>
                    <tr style="border-top:1px solid #ccc;"  class="bk2">
                        <td><div style="width:90px;"><auchan:i18n id="106001020"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001021"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001022"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001023"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001020"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001021"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001022"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001020"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001021"></auchan:i18n></div></td>
                        <td><div style="width:90px;"><auchan:i18n id="106001022"></auchan:i18n></div></td>
                        <td><div style="width:90px;">&nbsp;</div></td>
                        <td><div style="width:90px;">&nbsp;</div></td>
                        <td><div style="width:90px;">&nbsp;</div></td>
                        <td><div style="width:90px;">&nbsp;</div></td>
                    </tr>
				</table>
			</div>
			<div class="m_cols_body">
				<c:if test="${ not empty page.result}">
					<table cellpadding="0" cellspacing="0">
						<c:forEach items="${page.result}" var="analysisData" varStatus="num1">
							<tr class="tr${num1.index}" _index="${num1.index}">
								<td><div style="width: 91px;"><fmt:formatNumber value="${analysisData.totSalesAmnt }" pattern="#.##" minFractionDigits="2"/></div></td>
								<td><div style="width: 91px;"><fmt:formatNumber value="${analysisData.totMarginRate }" pattern="#.##" minFractionDigits="2"/></div></td>
								<td><div style="width: 91px;"><fmt:formatNumber value="${analysisData.totMarginAmnt }" pattern="#.##" minFractionDigits="2"/></div></td>
								<td><div style="width: 91px;"><fmt:formatNumber value="${analysisData.promSalesRate }" pattern="#.##" minFractionDigits="2"/></div></td>
								<td><div style="width: 91px;"><fmt:formatNumber value="${analysisData.normSalesAmnt }" pattern="#.##" minFractionDigits="2"/></div></td>
								<td><div style="width: 91px;"><fmt:formatNumber value="${analysisData.normMarginRate }" pattern="#.##" minFractionDigits="2"/></div></td>
								<td><div style="width: 91px;"><fmt:formatNumber value="${analysisData.normMarginAmnt }" pattern="#.##" minFractionDigits="2"/></div></td>
								<td><div style="width: 91px;"><fmt:formatNumber value="${analysisData.promSalesAmnt }" pattern="#.##" minFractionDigits="2"/></div></td>
								<td><div style="width: 91px;"><fmt:formatNumber value="${analysisData.promMarginRate }" pattern="#.##" minFractionDigits="2"/></div></td>
								<td><div style="width: 91px;"><fmt:formatNumber value="${analysisData.promMarginAmnt }" pattern="#.##" minFractionDigits="2"/></div></td>
								<td><div style="width: 91px;"><c:if test="${empty analysisData.nbrTimes}">0</c:if><c:if test="${not empty analysisData.nbrTimes}"><fmt:formatNumber value="${analysisData.nbrTimes }" pattern="#.##" minFractionDigits="2"/></c:if></div></td>
								<td><div style="width: 91px;"><c:if test="${empty analysisData.nbrVisit}">0</c:if><c:if test="${not empty analysisData.nbrVisit}"><fmt:formatNumber value="${analysisData.nbrVisit }" pattern="#.##" minFractionDigits="2"/></c:if></div></td>
								<td><div style="width: 91px;"><c:if test="${empty analysisData.avgBasket}">0.0</c:if><c:if test="${not empty analysisData.avgBasket}"><fmt:formatNumber value="${analysisData.avgBasket }" pattern="#.##" minFractionDigits="2"/></c:if></div></td>
							</tr>
						</c:forEach>
						
					</table>
				</c:if>
				 <c:if test="${empty page.result}">
			      	<table cellpadding="0" cellspacing="0" style="width:100%"><!--multi_tb为多选 width:1001px;-->
				         <tr class="tr0">
				         	<td colspan="11" class="align_center">对不起，所选日期尚无业绩信息，请选择其他日期进行查询，谢谢！</td>
				         </tr>
				    </table>
			      </c:if>
			</div>
		</div>
	</div>
	<%-- <jsp:include page="/page/commons/pageSet.jsp"></jsp:include> --%>
	<script type="text/javascript">
    $(".m_cols_body").scroll(function () {
        var ys_top = $(this).scrollTop();
        var xs_left = $(this).scrollLeft();

        var xm_left = $(".m_cols_head").scrollLeft();

        var yf_top = $(".f_cols_body").scrollTop();

        if (xs_left != undefined) {

            $(".m_cols_head").scrollLeft(xs_left);
        }
        if (ys_top != undefined) {

            $(".f_cols_body").scrollTop(ys_top);
        }

    });
    $(".m_cols_body tr,.f_cols_body tr").mouseover(function () {
        var index = $(this).attr("_index");
        var $tr = $(".tr" + index);
        $tr.addClass("tr_hover");
    });
    $(".m_cols_body tr,.f_cols_body tr").mouseout(function () {
        var index = $(this).attr("_index");
        var $tr = $(".tr" + index);
        $tr.removeClass("tr_hover");
    });
    $(".m_cols_body tr,.f_cols_body tr").click(function () {

        var index = $(this).attr("_index");
        var $tr = $(".tr" + index);

        $tr.parents(".m_cols_body").find(".tr_click_on").removeClass("tr_click_on");
        $tr.parents(".f_cols_body").find(".tr_click_on").removeClass("tr_click_on");

        $tr.toggleClass("tr_click_on");
    });
	</script>