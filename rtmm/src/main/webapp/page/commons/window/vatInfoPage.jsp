<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<script type="text/javascript">
$('.vat_tr').die().live("dblclick",function(){
	selectSeTopic($(this));
});

function selectSeTopic(obj){
	var vatNo = $(obj).attr('vatNo');
	var vatVal = $(obj).attr('vatVal'); 
	var vatno = $('.currVatObj').parent().parent().find('.vatno');
	var vatval = $('.currVatObj').parent().parent().find('.vatval');
	
 	$(vatno).val($.trim(vatNo));
	$(vatval).val($.trim(vatVal)); 
 	$(vatno).removeClass('errorInput');
 	$(vatval).removeClass('errorInput');
	closePopupWin();
}

$(function(){
	if($('.currVatObj').parent().parent().find('.vatno').val()!=''){
		$('.vat_tr[vatNo="'+$('.currVatObj').parent().parent().find('.vatno').val()+'"]').addClass('btable_checked');
	}
});
</script>
<style type="text/css">
._w65 {
	width: 65px;
}

._w392 {
	width: 392px;
}

._w30 {
	width: 30px;
}

.paging .page_list {
	width: 350px;
}
</style>

<%-- <input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize"
	value="${page.pageSize }" /> --%>

<%-- <div class="">
	<div class="panel datagrid datagrid-header">
		<div class="datagrid-body" style="margin-top: 0px; height: 300px;">
			<table border="0" cellspacing="0" cellpadding="0"
				class="datagrid-htable" style="height: 39px;">
				<tbody>
					<tr class="datagrid-header-row" style="width: 371px;">
						<td class="my-head-td-comNo fl_left" style="padding-left:20px;" field="NO"
							style="width: 30px; height: 30px;">
							<div class="datagrid-cell"
								style="text-align: center; width: 30px; height: 30px;">
								<span>税号</span><span class="datagrid-sort-icon">&nbsp;</span>
							</div>
						</td>
						<td class="my-head-td-comNo" field="sqlKey"
							style="width: 175px; height: 30px;">
							<div class="datagrid-cell"
								style="text-align: center; width: 175px; height: 30px;">
								<span>税率</span><span class="datagrid-sort-icon">&nbsp;</span>
							</div>
						</td>
					</tr>
					<c:forEach items="${vatlist}" var="item_vat">
						<tr class='vat_tr'>
							<td align="left" style="padding-left:20px;">
								<div class="">${item_vat.vatNo}</div>
							</td>
							<td align="center">
								<div class="">${item_vat.vatVal}</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div> --%>

<div class="search_tb_p">
	<div class="htable_div">
		<table>
			<thead>
				<tr>
					<td><div class="t_cols" style="width: 64px;">税号</div></td>
					<td><div class="t_cols" style="width: 391px;">税率</div></td>
					<td><div style="width: 16px;">&nbsp;</div></td>
				</tr>
			</thead>
		</table>
	</div>
	<div class="btable_div" style="height: 340px;">
		<table class="single_tb w100">
			<!--multi_tb为多选 width:1001px;-->
			<c:forEach items="${vatlist}" var="item_vat">
				<tr class='vat_tr' vatNo="${item_vat.vatNo}" vatVal="${item_vat.vatVal}">
					<td class="_w65" style="text-align:right;">${item_vat.vatNo}&nbsp;&nbsp;</td>
					<td class="_w392">${item_vat.vatVal}</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="PanelBtn">
		<div onclick="selectSeTopic($('tr.btable_checked'))" class="PanelBtn1">确定</div>
		<div onclick="closePopupWin()" class="PanelBtn2">取消</div>
	</div>	
</div>
<%-- <jsp:include page="/page/commons/pageSet.jsp"></jsp:include> --%>

