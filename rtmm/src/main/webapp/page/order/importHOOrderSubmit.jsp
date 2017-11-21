<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script>
	if ('${success}' == 0){
        top.jWarningAlert('${errorMsg}');
	}
	else{
		top.jSuccessAlert('订单已汇入');
	}
	$("#Tools2").unbind("click").removeClass("Tools2").addClass("Tools2_disable");
	function orderDetail(ordNo) {
		var param = {
			'ordNo' : ordNo
		};
		var tagsHtml = '<div class="tags1_left"></div>'
				+ '<div class="tagsM" id="hoOrderListTag">总部订单信息</div>'
				+ '<div class="tags"></div>'
				+ '<div class="tagsM" id="resultListTag">导入总部订单</div>'
				+ '<div class="tags tags_right_on"></div>'
				+ '<div class="tagsM_q  tagsM_on" id="orderDetailTag">导入总部订单详情</div>'
				+ '<div class="tags3_close_on">'
				+ '<div class="tags_close"></div>' + '</div>';
				
		$('.CTitle').html(tagsHtml);
		$('#resultList').hide(); 
		$.post('${ctx}/order/importOrderDetail',param,function(data){
			$("#importOrderDetail").html(data);
			$("#importOrderDetail").show();
		},'html');
		

	}
	
</script>
	<div class="Content" id="resultList">
		<div class="ig">
			<div class="icol_text w12_5">本次导入生成订单总数</div>
			<div class="icol_text">
				<input type="text" class="inputText w20" value="${total }" readonly="readonly" />
				&nbsp;&nbsp;张&nbsp;
			</div>
		</div>
		<div class="htable_div">
			<table>
				<thead>
					<tr>
						<td><div class="t_cols" style="width: 85px;">
								订单号码
								<!--<div style="display:inline-block;width:10px;height:20px;"></div>-->
							</div></td>
						<td><div class="t_cols" style="width: 300px;">厂商</div></td>
						<td><div class="t_cols" style="width: 150px;">课别</div></td>
						<td><div class="t_cols" style="width: 100px;">订单日期</div></td>
						<td><div class="t_cols" style="width: 100px;">预订收货日</div></td>
						<td><div class="t_cols" style="width: 140px;">订单状态</div></td>
						<td><div class="t_cols" style="width: 140px;">进价折扣</div></td>

						<td><div style="width: 16px;">&nbsp;</div></td>
					</tr>
				</thead>
			</table>
		</div>
		<div class="btable_div" style="height: 469px;">
			<table class="single_tb w100">
				<c:forEach items="${orderList}" var="order">
					<!--multi_tb为多选 width:1001px;-->
					<tr ondblclick="orderDetail('${order.ordNo }')">
						<td style="width: 86px;" id="ordNo">${order.ordNo }</td>
						<td style="width: 301px;">${order.supNo }-${order.comName }</td>
						<td style="width: 151px;">${order.sectionNo }-${order.catlgName }</td>
						<td style="width: 101px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${order.ordDate }" /></td>
						<td style="width: 101px;">${order.planRecptDate }</td>
						<td style="width: 141px;"><auchan:getDictValue code="${order.ordSttus}" mdgroup="ORDERS_ORD_STTUS"></auchan:getDictValue></td>
						<td style="width: 141px;">${order.bpDisc }%</td>
						<td style="width: auto">&nbsp;</td>
					</tr>
				</c:forEach>
			</table>   
		</div>
	</div>
	<div class="Content" id="importOrderDetail" style="display:none;">
	</div>

