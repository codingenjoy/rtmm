<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<script type="text/javascript">
$('.cluster_tr').unbind().bind("dblclick",function(){
	selectCluster($(this));
});


$(function(){
	if($('#clstrId').val()!=''){
		$('.cluster_tr[clusterId="'+$('#clstrId').val()+'"]').addClass('btable_checked');
	}
	
	$('#clusterNameInput').keydown(function (e) {
        if (e.keyCode == 13) {
        	pageQuery();
        }
    });
});
</script>

<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize"
	value="${page.pageSize }" />

<div class="">
	<div class="search_tb_p" style="height: 383px;">
		<div class="htable_div">
			<table>
				<thead>
					<tr>
						<td><div class="t_cols align_center" style="width: 60px;">系列编号</div></td>
						<td><div class="t_cols" style="width: 290px;">系列名称</div></td>
						<td><div class="t_cols" style="width: 145px;">系列类型</div></td>
						<td><div class="t_cols" style="width: 105px;">商品同价</div></td>
						<td><div style="width: 16px;">&nbsp;</div></td>
					</tr>
				</thead>
			</table>
		</div>
		<div class="btable_div" style="height: 280px;">
			<table class="single_tb w100">
				<!--multi_tb为多选 width:1001px;-->
				<c:forEach items="${page.result }" var="item_cluster">
					<tr class='cluster_tr' clusterId="${item_cluster.clstrId}"
						clusterName="${item_cluster.clstrName}"
						clusterType="${item_cluster.clstrType}"
						clusterbatchPriceChngInd="${item_cluster.batchPriceChngInd}">
						<td style="text-align: right; width: 60px;">${item_cluster.clstrId}&nbsp;&nbsp;</td>
						<td align="left" style="width: 269px; padding-left: 5px;">${item_cluster.clstrName}</td>
						<td align="center" style="width: 145px; padding-left: 5px;"><auchan:getDictValue
								code="${item_cluster.clstrType}"
								mdgroup="ITEM_CLUSTER_CLSTR_TYPE"></auchan:getDictValue></td>
						<td align="center" style="width: 105px; padding-left: 5px;"><auchan:getDictValue
								code="${item_cluster.batchPriceChngInd}"
								mdgroup="ITEM_CLUSTER_BATCH_PRICE_CHNG_IND"></auchan:getDictValue></td>
						<td><div style="width: 16px; padding-left: 5px;">&nbsp;</div></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
		<div class="Panel_footer">
			<div onclick="selectCluster($('tr.btable_checked'))"
				class="PanelBtn1">确定</div>
			<div onclick="closePopupWinTwo()" class="PanelBtn2">取消</div>
		</div>
	</div>
</div>

