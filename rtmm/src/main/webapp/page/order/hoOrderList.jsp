<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
//滚动条事件
$(document).ready(function () {
    $(".btable_div").scroll(function () {
        var left = $(this).scrollLeft();
        $(".htable_div").scrollLeft(left);
    });
});

// 點選一個項目, 檢查是否有權限編輯
$("#hoOrder_tab_List tr:visible").off("click").on("click", function(){
	checkEditPrivilege();
});

</script>


<!-- 分页属性 -->
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />

<div class="htable_div">
	<table>
		<thead>
			<tr>
			<!--  	<td class="t_cols align_center" style="width: 20px;">
					<input type="checkbox" onclick="selectAllHoOrder(this)" name="hoOrderCheck">
				</td> -->
				<td>
					<div class="t_cols align_center" style="width: 20px;"><input type="checkbox" onclick="selectAllHoOrder(this)" name="hoOrderCheck"></div>
				</td>
				<td>
					<div class="t_cols" style="width: 102px;">
						<auchan:i18n id="104001002"></auchan:i18n>
						<!--<div style="display:inline-block;width:10px;height:20px;"></div>-->
					</div>
				</td>
				<td>
					<div class="t_cols" style="width: 262px;"><auchan:i18n id="104001003"></auchan:i18n></div>
				</td>
				<td>
					<div class="t_cols" style="width: 152px;"><auchan:i18n id="104001004"></auchan:i18n></div>
				</td>
				<td>
					<div class="t_cols" style="width: 102px;"><auchan:i18n id="104001005"></auchan:i18n></div>
				</td>
				<td>
					<div class="t_cols" style="width: 102px;"><auchan:i18n id="104001006"></auchan:i18n></div>
				</td>
				<td>
					<div class="t_cols" style="width: 102px;"><auchan:i18n id="104001007"></auchan:i18n></div>
				</td>
				<td>
					<div class="t_cols" style="width: 102px;"><auchan:i18n id="104001009"></auchan:i18n></div>
				</td> 
				<td>
					<div style="width: auto;">&nbsp;</div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div inputDiv" style="height: 509px;">
	<table class="single_tb w100" id="hoOrder_tab_List">
		<!--multi_tb为多选 width:1001px;-->
		<c:forEach items="${hoOrderList}" var="orderHoInfoVO">
			<tr id="orderInfo${orderHoInfoVO.ordNo}"
				ondblclick="orderDetail(this)">
				<td class="align_center" style="width: 20px;">
					<input type="checkbox" id="${orderHoInfoVO.ordNo}" name="hoOrderCheck" onclick="countChecked()">
				</td>
				<td style="width: 101px;" id="ordNo" align="right">${orderHoInfoVO.ordNo }</td>
				<td style="width: 261px;"
					title="${orderHoInfoVO.supNo}-${orderHoInfoVO.comName }">&nbsp;&nbsp;${orderHoInfoVO.supNo}-${orderHoInfoVO.comName }</td>
				<td style="width: 151px;">&nbsp;&nbsp;${orderHoInfoVO.catlgId}-${orderHoInfoVO.catlgName }</td>
				<td style="width: 101px;">
					&nbsp;&nbsp;
					<c:if test="${orderHoInfoVO.ordDate ne null}">
						<fmt:formatDate value="${orderHoInfoVO.ordDate }"
							pattern="yyyy-MM-dd" />
					</c:if>
				</td>
				<td style="width: 101px;">
					&nbsp;&nbsp;
					<c:if test="${orderHoInfoVO.planRecptDate ne null}">
						<fmt:formatDate value="${orderHoInfoVO.planRecptDate }"
							pattern="yyyy-MM-dd" />
					</c:if>
				</td>
				<!-- TODO -->
				<%-- <td style="width: 101px;">&nbsp;&nbsp;${orderHoInfoVO.ordSttus }-${orderHoInfoVO.ordSttusCNDesc }</td> --%>
				<td style="width: 101px;">&nbsp;&nbsp;<auchan:getDictValue code="${orderHoInfoVO.ordSttus}" mdgroup="ORDERS_ORD_STTUS"></auchan:getDictValue></td>
		    	<td style="width: 101px" align="right">${orderHoInfoVO.storeNum }&nbsp;</td> 
				<td style="width: auto"></td>

			</tr>
		</c:forEach>
	</table>
</div>

<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
