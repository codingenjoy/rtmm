<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.paging .page_list {
	width: 380px;
}
</style>
<script type="text/javascript">
	if ('${errorMsg}' != '') {
		jWarningAlert('${errorMsg}');
		$("#clstrdisplay").val("");
	} else if ('${errorMsg}' == '' && '${clstrName}' != '') {
		$("#clstrdisplay").val('${clstrName}');
	}

	/* // 若是直接輸入系列號, 則需要將系列名稱顯示出來
	 if ('${clstrName}' != ''){
	 } */

	$('input:checkbox').each(function() {
		var thval = $(this).val();
		for (var j = 0; j < orderItemArr.length; j++) {
			var beforeOrderItemArr = orderItemArr[j];
			if (beforeOrderItemArr.itemNo == thval) {
				$(this).attr('checked', 'checked');
			}
		}
	});
		
	$(document).ready(function() {
		//resetCheckAll($('.btable_div'));
	});

	function clickCheckBox(self){
		if($(self).attr("checked")=="checked"){
			curItemArr.push($(self).val());
		}else{
			$.each(curItemArr,function(index,obj){
				if(obj==$(self).val()){
					curItemArr.splice(index,1);
					return true;
				}
			});
		}
	}

	function checkAll(chk) {
		$('input[name="itemNoCk"]').each(function() {
			if (chk.checked && !$(this).attr("disabled")) {
				$(this).attr("checked", true);
			} else {
				$(this).attr("checked", false);
			}
		});
	}
</script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td>
					<div class="t_cols align_center" style="width: 30px;">
						<input type="checkbox" class="checkAll" onclick="checkAll(this)" name="tck" />
					</div>
				</td>
				<td>
					<div class="t_cols" style="width: 130px;">
						货号
						<!--<div style="display:inline-block;width:10px;height:20px;"></div>-->
					</div>
				</td>
				<td>
					<div class="t_cols" style="width: 260px;">商品名称</div>
				</td>
				<td>
					<div class="t_cols" style="width: 130px;">商品状态</div>
				</td>
				<td>
					<div style="width: 16px;">&nbsp;</div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 250px;">
	<table class="single_tb w100" id="itemInfoList">
		<!--multi_tb为多选 width:1001px;-->
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr class="addSingleSup" id="${item.itemNo}">
					<td class="align_center" style="width: 30px;">
						<input type="checkbox" name="itemNoCk" value="${item.itemNo}" onclick="clickCheckBox(this)" />
					</td>
					<td style="width: 131px;">${item.itemNo}</td>
					<td style="width: 261px;">${item.itemName}</td>
					<td style="width: 131px;">
						<auchan:getDictValue code='${item.status}' mdgroup='ITEM_BASIC_STATUS' />
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet1.jsp"></jsp:include>